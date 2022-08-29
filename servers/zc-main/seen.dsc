#seen_conv:
#  type: command
#  name: seenconv
#  permission: zc.sdjsalkdja
#  script:
#    - define files <server.list_files[../Essentials/userdata]>
#    - define curr_time <util.time_now>
#    - foreach <[files]>:
#      - if !<[value].contains_text[-]>:
#        - foreach next
#      - define p <player[<[value].before[.]>]||null>
#      - ~yaml load:../Essentials/userdata/<[value]> id:temp
#      - if !<yaml[temp].contains[ipAddress]>:
#        - foreach next
#      - define ip <yaml[temp].read[ipAddress].replace_text[/].replace_text[.].with[-]>
#      - if <yaml[temp].contains[timestamps.login]>:
#        - flag <[p]> ip_addresses.<[ip]>:<[curr_time].sub[<[curr_time].epoch_millis.sub[<yaml[temp].read[timestamps.login]>].div[1000].as_duration>]>
#      - else:
#        - flag <[p]> ip_addresses.<[ip]>:<[curr_time]>
#      - flag server ip_addresses.<[ip]>:->:<[p]>
#      - narrate <[loop_index]>/<[files].size>
#    - yaml unload id:temp

seen_events:
  type: world
  debug: false
  events:
    after player joins:
      - if !<player.is_online>:
        - stop
      - flag player login_time:<util.time_now>
      - define ip <player.ip_address.replace_text[/].replace_text[.].with[-]>
      - flag player ip_addresses.<[ip]>:<util.time_now>
      - if !<server.has_flag[ip_addresses.<[ip]>]> || !<server.flag[ip_addresses.<[ip]>].contains[<player>]>:
        - flag server ip_addresses.<[ip]>:->:<player>
      - if !<player.has_flag[ip_info]>:
        - ~webget https://ipinfo.io/<player.ip_address.replace_text[/]> headers:<map[Authorization=<secret[ipinfo_token]>]> save:webget_result
        - stop if:<entry[webget_result].failed>
        - define ip_info <util.parse_yaml[{"result":<entry[webget_result].result>}].get[result]>
        - flag <player> ip_info:<[ip_info]> expire:10d

seen_command:
  type: command
  name: seen
  description: Search info about a player, uuid, or ip address.
  aliases:
    - eseen
    - essentials:seen
    - essentials:eseen
  usage: /seen (name)
  debug: false
  script:
    - if <context.args.get[1]||null> == null:
      - narrate "<&7>Show information about a player with <&a>/seen (playername)"
      - if <player.has_permission[zc.ip_lookup]>:
        - narrate "<&7>You can also look an ip up with <&a>/seen (ip) <&7>or by clicking the ip in a player's seen response."
      - stop

    # IP lookup
    - if <context.args.get[1].contains_text[.]> || <context.args.get[1].contains_text[:]>:
      - if !<player.has_permission[zc.ip_lookup]>:
        - narrate "<&c>You do not have permission to do ip lookups."
        - stop
      - define ip <context.args.get[1].replace_text[.].with[-]>
      - if !<server.has_flag[ip_addresses.<[ip]>]>:
        - narrate "<&c>Nobody has logged in with the ip <context.args.get[1]>"
        - stop
      - foreach <server.flag[ip_addresses.<[ip]>]>:
        # Do a mojang api call and cache the results
        - if <[value].name||null> == null:
          - if !<server.has_flag[name_cache.<[value]>]>:
            - ~webget https://api.mojang.com/user/profiles/<[value].uuid>/names save:resp
            - if <entry[resp].failed> || <entry[resp].status> == 204:
              # Mojang is down or this player is seriously busted
              - flag server ip_addresses.<[ip]>:<-:<[value]>
              - foreach next
            - define resp_map <util.parse_yaml[{names:<entry[resp].result>}]>
            - define name <[resp_map].get[names].last.get[name]>
            - flag server name_cache.<[value]>:<[name]>
          - define url https://namemc.com/profile/<[value].uuid>
          - define hover "This user hasn't been online for quite some time, so they are missing their player data. Click to search them on namemc."
          - define playerlist:->:<&c><server.flag[name_cache.<[value]>].on_hover[<[hover]>].on_click[<[url]>].type[open_url]>
        - else:
          - define "playerlist:->:<&d><[value].name.on_hover[Click to look this player up with /seen].on_click[/seen <[value].uuid>]>"
      - narrate <empty>
      - define color <&b>
      - if <server.is_banned[<context.args.get[1]>]>:
        - define color <&c>
        - define exp_time <server.ban_info[<context.args.get[1]>].expiration_time||null>
        - if <[exp_time]> == null:
          - define exp <&c>permanently
        - else:
          - define curr_time <util.time_now>
          - define exp "until <&c><[exp_time].format[MMM d yyyy h:mm a z]> (<[exp_time].from_now.formatted> remaining)"
        - narrate "<&7>This ip is banned <[exp]><&7>."
        - narrate " <&7>Ban reason: <&f><server.ban_info[<context.args.get[1]>].reason>"
        - narrate " <&7>Banned by: <&f><server.ban_info[<context.args.get[1]>].source>"
      - narrate "<&7>Players that have logged in from <[color]><context.args.get[1]><&7>:"
      - narrate " <[playerlist].separated_by[, ]>"
      - narrate <empty>

    - else:
      # UUID lookup
      - if <context.args.get[1].contains_text[-]>:
        - define target <player[<context.args.get[1]>]||null>
        - if <[target]> == null || <[target].name> == null:
          - narrate "<&c>Could not find the player data for UUID <context.args.get[1]>."
          - stop
      # Player lookup
      - else:
        - define target <server.match_player[<context.args.get[1]>]||null>
        - if <[target]> == null:
          - define target <server.match_offline_player[<context.args.get[1]>]||null>
          - if <[target]> == null:
            - narrate "<&c>Could not find player <context.args.get[1]>."
            - stop

      - narrate <empty>
      - if <[target].is_online>:
        - define color <&a>
        - define hover "<[color]>Online since: <[target].flag[login_time].format[MMMM d yyyy - h:mm a z]>"
        - narrate "<&7>Player <[color]><[target].display_name> <&7>has been <[color]>online<&7> for <[color]><[target].flag[login_time].from_now.formatted.on_hover[<[hover]>]><&7>."
      - else:
        - define color <&c>
        - define hover "<[color]>Offline since: <[target].last_played_time.format[MMMM d yyyy - h:mm a z]>"
        - narrate "<&7>Player <[color]><[target].name> <&7>has been <[color]>offline<&7> for <[color]><[target].last_played_time.from_now.formatted.on_hover[<[hover]>]><&7>."
      - if <player.has_permission[zc.ip_lookup]>:
        - foreach <[target].flag[ip_addresses]>:
          # Fix up old broken tags stored in here
          - if <[value].object_type> != time:
            - flag <[target]> ip_addresses.<[key]>:!
            - foreach next
          - define ip <[key].replace_text[-].with[.]>
          - define hover "<&7>Last used: <[color]><[value].format[MMMM d yyyy]><n><&7>Click to do <[color]>/seen <[ip]>"
          - define "ip_addresses:->:<[color]><element[<[ip]><tern[<server.is_banned[<[ip]>]>].pass[ (banned)].fail[]>].on_hover[<[hover]>].on_click[/seen <[ip]>]>"
        - narrate " <&7><&chr[204E]> IP Address(es): <[ip_addresses].separated_by[<&7>, ]>"
      - narrate " <&7><&chr[204E]> Joined: <[color]><[target].first_played_time.format[MMMM d yyyy]>"
      - narrate " <&7><&chr[204E]> Playtime: <[color]><duration[<[target].statistic[play_one_minute].div[20]>].formatted>"
      - if <[target].is_banned>:
        - define banned_until <[target].ban_expiration_time||null>
        - narrate " <&7><&chr[204E]> Banned <tern[<[banned_until].is[!=].to[null]>].pass[until <&c><[banned_until].format[MMM d yyyy h:mm a z]> (<[banned_until].from_now.formatted> remaining)].fail[<&c>permanently]><&7>."
        - if <player.has_permission[zc.ban_lookup]>:
          - narrate " <&7><&chr[204E]> Ban reason: <&f><[target].ban_reason>"
          - narrate " <&7><&chr[204E]> Banned by: <&c><[target].ban_source>"
      - narrate <empty>
