# Prints errors and stacktraces to discord
# Does not handle setting up your discord bot for you, assumes that is already done
# Author: Mergu

error_handler_conf:
  type: data
  debug: false
  data:
    bot_id: zc-info
    channel_id: 1010782332740972574
    # Shows errors that crop up in any scripts that get run
    show_script_errors: true
    # If you would like to turn off error reporting for things like the /ex command, set to false
    show_nonscript_errors: true
    # Shows full stacktraces that get thrown by any plugin
    show_stacktraces: true
    # Snip stacktraces after this many lines of output (set to <= 0 to show all)
    snip_stacktraces_at: 15
    # Show the full script that errored and the line that errored (indicated by a '>')
    # Requires the following Denizen config settings:
    # Commands.File.Allow read: true
    # Commands.File.Restrict path: ./  OR  Commands.File.Restrict path: none
    show_full_script: true

#script_with_error_example:
#  type: task
#  debug: false
#  script:
#    # this is definitely broken
#    - define foo bar
#    - define long_def <util.list_numbers_to[100]>
#    - narrate "<player.foobar>  a"
#    - ~webget test

#script_with_exception_example:
#  type: task
#  debug: false
#  script:
#    - define foo bar
#    - if true:
#      - debug exception 'This is an example'

debug_alert:
  type: world
  debug: false
  events:
    on system time hourly:
      - define debug_enabled:|:<util.scripts.filter[data_key[debug]]>
      - define debug_enabled:|:<util.scripts.filter[list_keys.contains[debug].not]>
      - if <[debug_enabled].is_empty>:
        - stop
      - define padding <[debug_enabled].highest[name.length].name.length>
      - define message "Found <[debug_enabled].size> script(s) with debug enabled<&co>"
      - define scripts <[debug_enabled].parse_tag[<[parse_value].name.pad_right[<[padding].add[5]>]>(<[parse_value].relative_filename>)].separated_by[<n>]>
      - define bot_id <script[error_handler_conf].parsed_key[data.bot_id]>
      - define channel <script[error_handler_conf].parsed_key[data.channel_id]>
      - if <[debug_enabled].size> <= 10:
        - ~discordmessage id:<[bot_id]> channel:<[channel]> <[message]>
      - else:
        - ~discordmessage id:<[bot_id]> channel:<[channel]> <[message]> attach_file_name:error.txt attach_file_text:<[scripts]>

error_handlers:
  type: world
  debug: false
  build_estimated_script:
    # Called when the show_full_script option is set to false
    - define "script_builder:->:(last command run: <[last_command]>)"
    - define script_builder:->:<context.script.name><&co>
    - define "script_builder:->:  type<&co> <context.script.container_type.to_lowercase>"
    - foreach "<context.script.to_yaml.replace_text[regex:- \^[0-9]+\^].with[-].split[<n>]>" as:line:
      - define line_command "<[line].trim.after[- ].split_args.separated_by[ ]>"
      - if <[line_command].starts_with[~]>:
        - define line_command <[line_command].after[~]>
      - if <[line_command]> == <[last_command]>:
        - define "script_builder:->:<&gt> <[line]>"
      - else:
        - define "script_builder:->:  <[line]>"
    - define estimated_script <[script_builder].separated_by[<n>]>
  build_full_script:
    - define in_script false
    - define comment_buffer <list>
    - define script_builder <list>
    - ~fileread path:<context.script.relative_filename> save:f
    - define full_file <entry[f].data.utf8_decode.replace_text[<&chr[000D]>].split[<n>].if_null[<list>]>
    - if <[full_file].is_empty>:
      - define full_script "Error reading full script. Make sure to set 'Commands.File.Allow read' to 'true' and 'Commands.File.Restrict path' to './' or 'none'"
    - else:
      - foreach <[full_file]> as:line:
        # Check if we're in the script
        - if <[line].starts_with[<context.script.name><&co>]>:
          - define in_script true
          - if !<[comment_buffer].is_empty>:
            - define script_builder:|:<[comment_buffer]>
        # If we're in the script and the script finishes, stop
        - else if <[in_script]> and <[line].substring[0,1].length> == 1 and <[line].substring[0,1]> != " ":
          - foreach stop
        # Buffer comments for display above the script
        - else if !<[in_script]> and <[line].starts_with[<&ns>]>:
          - define comment_buffer:->:<[line]>
        # Only allow a comment chain right above the script
        - else:
          - define comment_buffer <list>
        - if <[in_script]>:
          - if <context.line> == <[loop_index]>:
            - define "script_builder:->:<&gt><[line].after[ ]>"
          - else:
            - define script_builder:->:<[line]>
      - define full_script <[script_builder].separated_by[<n>]>
  show_script_error:
    - define def_map <context.queue.definition_map.exclude[_script_errors]>
    - define last_command <context.queue.last_command>
    - wait 1t
    - define error_messages <context.queue.flag[_script_errors.<[uniq]>].deduplicate>
    - flag <context.queue> _script_errors.<[uniq]>:!
    - define "output:->:ERROR in script '<context.script.name>' in queue '<context.queue.id>'"
    - define "output:->:      while executing command '<[last_command].before[ ]>' in file '<context.script.relative_filename>' on line '<context.line>'"
    - if <context.queue.player.exists>:
      - define "attachments:->:player '<context.queue.player> (<context.queue.player.name>)'"
    - if <context.queue.npc.exists>:
      - define "attachments:->:npc '<context.queue.npc> (<context.queue.npc.name>)'"
    - if <[attachments].exists>:
      - define "output:->:      with attached <[attachments].separated_by[ and ]>"
    - define output:->:<empty>
    - foreach <[error_messages]> as:error:
      - if <[loop_index]> == 1:
        - define "output:->:ERROR <[error]>"
      - else:
        - define "output:->:      <[error]>"

    - if !<[def_map].is_empty>:
      - define output:->:<empty>
      - define "output:->:=== Definitions ==="
      - define output:->:<empty>
      - foreach <[def_map]>:
        - define value <[value].as_element>
        - if <[value].length> > 100:
          - define value <[value].substring[0,100]>...
        - define "output:->:<&lt>[<[key]>]<&gt> == <[value]>"

    - if <script[error_handler_conf].parsed_key[data.show_full_script].is_truthy>:
      - define output:->:<empty>
      - define "output:->:=== Full Script ==="
      - define output:->:<empty>
      - inject <script> path:build_full_script
      - define output:->:<[full_script]>
    - else:
      - define output:->:<empty>
      - define "output:->:=== Estimated Script (avoiding fileread, may be inaccurate) ==="
      - define output:->:<empty>
      - inject <script> path:build_estimated_script
      - define output:->:<[estimated_script]>

    - if !<bungee.server.exists>:
      - define message ":warning: Scripting error occurred, see below for details (Click expand for more info)"
    - else:
      - define message ":warning: **[<bungee.server>]** Scripting error occurred, see below for details (Click expand for more info)"
    - define message "<[message]><n>:scroll: <context.script.name>: <[error_messages].first>"
    - if <context.queue.player.exists>:
      - define message "<[message]> -- Errored for <context.queue.player.name>"
    - define bot_id <script[error_handler_conf].parsed_key[data.bot_id]>
    - define channel <script[error_handler_conf].parsed_key[data.channel_id]>
    - ~discordmessage id:<[bot_id]> channel:<[channel]> <[message]> attach_file_name:error.txt attach_file_text:<[output].separated_by[<n>]>
  show_nonscript_error:
    - define last_command <context.queue.last_command>
    - wait 1t
    - define error_messages <context.queue.flag[_script_errors.<[uniq]>].deduplicate>
    - flag <context.queue> _script_errors.<[uniq]>:!
    - define message ":clipboard:"
    - if <bungee.server.exists>:
      - define message "<[message]> **[<bungee.server>]**"
    - if <context.queue.id.before[_]> == excommand:
      - define message "<[message]> Error in /ex command:<n>```"
    - else:
      - define message "<[message]> Error in non-script queue:<n>```"
    - define message "<[message]>ERROR in queue '<context.queue.id>' while executing command '<context.queue.last_command.before[ ]>'"
    - if <context.queue.player.exists>:
      - define message "<[message]> with player '<context.queue.player> (<context.queue.player.name>)'"
    - if <context.queue.npc.exists>:
      - define message "<[message]> with npc '<context.queue.npc> (<context.queue.npc.name>)'"
    - define message "<[message]><&co><n>      "
    - define message "<[message]><[error_messages].separated_by[<n>      ]>```"
    - define bot_id <script[error_handler_conf].parsed_key[data.bot_id]>
    - define channel <script[error_handler_conf].parsed_key[data.channel_id]>
    - ~discordmessage id:<[bot_id]> channel:<[channel]> <[message]>
  show_nonscript_nonqueue_error:
    - define message ":clipboard:"
    - if <bungee.server.exists>:
      - define message "<[message]> **[<bungee.server>]**"
    - define message "<[message]> ERROR: <context.message>"
    - define bot_id <script[error_handler_conf].parsed_key[data.bot_id]>
    - define channel <script[error_handler_conf].parsed_key[data.channel_id]>
    - ~discordmessage id:<[bot_id]> channel:<[channel]> <[message]>
  events:
    on server generates exception:
      - ratelimit exception_lock 5t
      - define message ":bangbang:"
      - if <bungee.server.exists>:
        - define message "<[message]> **[<bungee.server>]**"
      - define message "<[message]> SERVER GENERATED EXCEPTION -- <context.type><&co> <context.message>"

      - if <context.queue.exists>:
        - define last_command <context.queue.last_command>
        - define "output:->:ERROR in queue '<context.queue.id>' while executing command '<[last_command].before[ ]>'"
        - if <context.script.exists>:
          - define "output:->:      in script '<context.queue.script.name>' in file '<context.queue.script.relative_filename>' on line '<context.line>'"
        - if <context.queue.player.exists>:
          - define "attachments:->:with player '<context.queue.player> (<context.queue.player.name>)'"
        - if <context.queue.npc.exists>:
          - define "attachments:->:with npc '<context.queue.npc> (<context.queue.npc.name>)'"
        - if <[attachments].exists>:
          - define "output:->:      <[attachments].separated_by[ ]>"
        - define output:->:<empty>

      - define split_trace "<context.full_trace.strip_color.replace_text[[Error Continued] ].split[<n>]>"
      - define trace_limit <script[error_handler_conf].parsed_key[data.snip_stacktraces_at].if_null[15]>
      - if !<[trace_limit].is_integer>:
        - define trace_limit 15
      - if <[trace_limit]> > 0 and <[split_trace].size> > <[trace_limit]>:
        - define output:->:<[split_trace].get[1].to[<[trace_limit]>].separated_by[<n>]>
        - define "output:->:  ** Snipped <[split_trace].size.sub[<[trace_limit]>]> line(s) **"
      - else:
        - define output:->:<[split_trace].separated_by[<n>]>

      - if <context.queue.exists>:
        - define def_map <context.queue.definition_map.exclude[_script_errors]>
        - if !<[def_map].is_empty>:
          - define output:->:<empty>
          - define "output:->:=== Definitions ==="
          - define output:->:<empty>
          - foreach <[def_map]>:
            - define value <[value].as_element>
            - if <[value].length> > 100:
              - define value <[value].substring[0,100]>...
            - define "output:->:<&lt>[<[key]>]<&gt> == <[value]>"

      - if <context.script.exists>:
        - if <script[error_handler_conf].parsed_key[data.show_full_script].is_truthy>:
          - define output:->:<empty>
          - define "output:->:=== Full Script ==="
          - define output:->:<empty>
          - inject <script> path:build_full_script
          - define output:->:<[full_script]>
        - else:
          - define output:->:<empty>
          - define "output:->:=== Estimated Script (avoiding fileread, may be inaccurate) ==="
          - define output:->:<empty>
          - inject <script> path:build_estimated_script
          - define output:->:<[estimated_script]>

      - define bot_id <script[error_handler_conf].parsed_key[data.bot_id]>
      - define channel <script[error_handler_conf].parsed_key[data.channel_id]>
      - ~discordmessage id:<[bot_id]> channel:<[channel]> <[message]> attach_file_name:exception.txt attach_file_text:<[output].separated_by[<n>]>
    on script generates error:
      - if <context.script.name.if_null[null]> == <script.name>:
        - stop
      - if <context.queue.exists>:
        # Track all of the errors that happen this tick, ratelimited so only the first fires a message
        - define uniq <context.queue.id>-<context.line.if_null[0]>-<context.queue.player.if_null[null]>-<context.queue.npc.if_null[null]>
        - define uniq <[uniq].utf8_encode>
        # Queue flags make definitions
        - flag <context.queue> _script_errors.<[uniq]>:->:<context.message.strip_color>
        - ratelimit <[uniq]> 1t
      - if !<context.queue.exists>:
        - if <script[error_handler_conf].parsed_key[data.show_nonscript_errors].is_truthy>:
          - inject <script> path:show_nonscript_nonqueue_error
      - else if !<context.script.exists>:
        - if <script[error_handler_conf].parsed_key[data.show_nonscript_errors].is_truthy>:
          - inject <script> path:show_nonscript_error
      - else if <script[error_handler_conf].parsed_key[data.show_script_errors].is_truthy>:
        - inject <script> path:show_script_error
