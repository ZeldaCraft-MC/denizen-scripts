mutehome_command:
  type: command
  name: mutehome
  description: used to mute specific messages in home commands
  usage: /mutehome (command name)
  debug: false
  tab completions:
    1: <list[home|delhome|sethome]>
  script:
    - choose <context.args.first>:
      - case home:
        - if <player.flag[mutehomes.home]||false>:
          - narrate "the messages that used to appear when doing /home will appear again" format:zc_home_text
          - flag player mutehomes.home:false
        - else:
          - narrate "The messages that appear when doing /home will no longer appear" format:zc_home_text
          - flag player mutehomes.home:true
      - case delhome:
        - if <player.flag[mutehomes.delhome]||false>:
          - narrate "the messages that used to appear when doing /delhome will appear again" format:zc_home_text
          - flag player mutehomes.delhome:false
        - else:
          - narrate "The messages that appear when doing /delhome will no longer appear" format:zc_home_text
          - flag player mutehomes.delhome:true
      - case sethome:
        - if <player.flag[mutehomes.sethome]||false>:
          - narrate "the messages that used to appear when doing /sethome will appear again" format:zc_home_text
          - flag player mutehomes.sethome:false
        - else:
          - narrate "The messages that appear when doing /sethome will no longer appear" format:zc_home_text
          - flag player mutehomes.sethome:true
      - default:
        - narrate "Put either home, delhome or sethome after <&a><&click[/mutehome<&sp>].type[suggest_command]>/mutehome<&end_click>" format:zc_home_text

#-----------------------------------#
#add (playername):(homename) support :check:
#-----------------------------------#
zc_home_text:
    type: format
    debug: false
    format: <&color[#009900]>Z<&color[#00CC00]>c <&color[#00FF00]>H<&color[#33FF33]>o<&color[#66FF66]>m<&color[#99FF99]>e<&color[#CCFFCC]>s <&7><&gt><&gt><&f> <[text]>

home_command:
  type: command
  name: home
  description: used to tp to a home you created with /sethome
  usage: /home (name)
  debug: false
  tab completions:
    1: <player.flag[homes].keys.if_null[<list>]>
  script:
    - if <context.args.first.contains_any_text[:]||false>:
      - if !<player.has_permission[zc.homes_admin]>:
        - narrate "You cannot perform this command." format:zc_home_text
        - stop
      - define player <server.match_offline_player[<context.args.first.before[:]>]||noone>
      - define name <context.args.first.after[:]||default>
      - define is_admin true
      - if <[player]> == noone:
        - narrate "<context.args.first.before[:]> Does not seem to be a player" format:zc_home_text
        - stop
    - else:
      - define player <player>
      - define name <context.args.first||default>
      - define is_admin false
    - if !<[player].flag[homes].keys.contains[<[name]>]||false>:
      - narrate "You cannot teleport to a home <tern[<[is_admin]>].pass[<[player].name> does].fail[you do]> not have" format:zc_home_text
      - stop
    - if !<server.worlds.contains[<[player].flag[homes.<[name]>].world.if_null[none]>]>:
      - narrate "The world this home was in has been unloaded" format:zc_home_text
      - stop
    - if <[player].flag[homes.<[name]>].world.name> == s3:
      - narrate "<&c>You cannot teleport there!" format:zc_home_text
      - stop
    - teleport <player> <[player].flag[homes.<[name]>]>
    - if <player.flag[mutehomes.home]||false>:
      - stop
    - narrate "You've been teleported to <tern[<[is_admin]>].pass[<[player].name>'s <[name]>].fail[<[name]>]>" format:zc_home_text

#----------------------------------#
#make sure trusted+ get unlimited homes and normies just one :check:
#----------------------------------#
sethome_command:
  type: command
  name: sethome
  description: used to set your home at a location you are currently at
  usage: /sethome (name)
  debug: false
  script:
    - if <player.world.name> == s3:
      - narrate "<&c>You cannot set homes here!"
      - stop
    - if <context.args.is_empty>:
      - define name default
    - else:
      - define name <context.args.first.strip_color>
    - if !<[name].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz1234567890_/-]>:
      - narrate "your names can only contain letters, numbers and dashes" format:zc_home_text
      - stop
    - if <[name].length> > 32:
      - narrate "you cannot set a name longer then 32 characters" format:zc_home_text
      - stop
    - if <player.flag[homes].size||0> > 2:
      - if !<player.has_permission[zc.homes_trusted]>:
        - if <player.flag[homes].keys.contains[<[name]>]>:
          - flag player homes.<[name]>:<player.location>
          - if <player.location.world.name> == s3_nether || <player.location.world.name> == s3:
            - flag player s3_home:<util.time_now>
          - narrate "<[name]> home has been set to your current location" format:zc_home_text
          - stop
        - narrate "You cannot set more homes." format:zc_home_text
        - narrate "To be able to set more homes apply for trusted" format:zc_home_text
        - stop
    - flag player homes.<[name]>:<player.location>
    - if <player.location.world.name> == s3_nether || <player.location.world.name> == s3:
      - flag player s3_home:<util.time_now>
    - if <player.flag[mutehomes.sethome]||false>:
      - stop
    - narrate "<[name]> home has been set to your current location" format:zc_home_text

#----------------------------------#
#add (playername):(homename) support :check:
#----------------------------------#
delhome_command:
  type: command
  name: delhome
  description: used to delete a home you created with /sethome
  usage: /delhome (name)
  debug: false
  tab completions:
    1: <player.flag[homes].keys.if_null[<list>]>
  script:
    - if <context.args.first.contains_any_text[:]||false>:
      - if !<player.has_permission[zc.homes_admin]>:
        - narrate "You do not have permission to perform this command" format:zc_home_text
        - stop
      - define player <server.match_offline_player[<context.args.first.before[:]||default>]||noone>
      - define name <context.args.first.after[:]||default>
      - define is_admin true
      - if <[player]> == noone:
        - narrate "<context.args.first.before[:]> Does not seem to be a player" format:zc_home_text
        - stop
    - else:
      - define player <player>
      - define name <context.args.first||default>
      - define is_admin false
    - if !<[player].flag[homes].keys.contains[<[name]>]>:
      - narrate "You cannot delete a home <tern[<[is_admin]>].pass[<[player].name> does].fail[you do]> not have" format:zc_home_text
      - stop
    - flag <[player]> homes.<[name]>:!
    - if <player.flag[mutehomes.home]||false>:
      - goto smartskip
    - narrate "<tern[<[is_admin]>].pass[<[player].name>'s <[name]>].fail[<[name]>]> has been removed" format:zc_home_text
    - mark smartskip
    - if <context.args.get[2]||null> == open_list:
      - execute as_player "listhomes <context.args.get[3]> <context.args.get[4]>"

#----------------------------------#
#pages instead of 1 big ass list :check:
#per world and on alphabetical order :check:
#clicking on the home tp's you there :check:
#potentially make a delete button :check:
#----------------------------------#
listhomes_command:
  type: command
  name: listhomes
  description: lists all the homes you currently have
  usage: /listhomes
  debug: false
  tab completions:
    1: <player.flag[homes].values.parse[world.name].deduplicate.if_null[<list>]>
  script:
    - if <context.args.first.contains_any_text[:]||false>:
      - if !<player.has_permission[zc.homes_admin]>:
        - narrate "You do not have permission to perform this" format:zc_home_text
        - stop
      - define is_admin true
      - define player <server.match_offline_player[<context.args.first.before[:]>]||noone>
      - if <[player]> == noone:
        - narrate "<context.args.first.before[:]> does not seem to be a player on our server. spelled it correctly?" format:zc_home_text
        - stop
      - define cur_world <context.args.first.after[:]||<player.location.world.name>>
    - else:
      - define player <player>
      - define cur_world <context.args.first||<[player].location.world.name>>
      - define is_admin false
    - if !<[player].has_flag[homes]> || <[player].flag[homes].values.parse[world].shared_contents[<server.worlds>].is_empty>:
      - narrate "You do not have any homes! Use /sethome to set a home." format:zc_home_text
      - stop
    - if !<[player].flag[homes].values.parse[world].shared_contents[<server.worlds>].parse[name].contains[<[cur_world]>]||false>:
      - define cur_world <[player].flag[homes].values.parse[world].shared_contents[<server.worlds>].get[1].name>
    - define l_homes <[player].flag[homes].filter_tag[<[filter_value].world.is[==].to[<world[<[cur_world]>]>]||false>]>
    - define max_page <[l_homes].size.div[10].round_up>
    - define page <context.args.get[2]||1>
    - define homes "<[l_homes].keys.alphanumeric.get[<element[<[page]>0].sub[9]>].to[<[page]>0].parse_tag[<&hover[Click here to delete <[parse_value]>]><&click[/delhome <tern[<[is_admin]>].pass[<[player].name>:].fail[]><[parse_value]> open_list <tern[<[is_admin]>].pass[<[player].name>:].fail[]><[cur_world]> <[page]>]><&c> <&l>✗<&c><&end_click><&end_hover> <&r><&hover[Click here to teleport to <[parse_value]>]><&click[/home <tern[<[is_admin]>].pass[<[player].name>:].fail[]><[parse_value]>]><&f><[parse_value]><&end_click><&end_hover>]>"
    - if <context.args.get[2]||1> > <[max_page]>:
      - narrate "You cannot go that high" format:zc_home_text
      - stop
    - if <context.args.get[2]||1> <= 0:
      - narrate "You cannot go that low" format:zc_home_text
      - stop
    - narrate "<&nl><&2><&lb><&f><[player].flag[homes].values.parse[world].shared_contents[<server.worlds>].parse_tag[<&hover[Click here to show your homes in <[parse_value].name>]><&click[/listhomes <tern[<[is_admin]>].pass[<[player].name>:].fail[]><[parse_value].name>]><tern[<[parse_value].name.is[==].to[<[cur_world]>]>].pass[<&a><[parse_value].name.to_titlecase>].fail[<[parse_value].name.to_titlecase>]><&end_click><&end_hover>].separated_by[<&2><&rb> <&lb><&f>]><&2><&rb>"
    - narrate <&nl><[homes].separated_by[<&nl>]>
    - if <[max_page]> <= 1:
      - narrate " "
      - stop
    - define left_ar "<&hover[Click here to go a page backwards]><&click[/listhomes <tern[<[is_admin]>].pass[<[player].name>:].fail[]><[cur_world]> <[page].sub[1]>]><&color[#04BA04]><&chr[25C0]><&end_click><&end_hover>"
    - define right_ar "<&hover[Click here to go a page forward]><&click[/listhomes <tern[<[is_admin]>].pass[<[player].name>:].fail[]><[cur_world]> <[page].add[1]>]><&color[#04BA04]><&chr[25B6]><&end_click><&end_hover>"
    - if <[page]> == 1:
      - narrate "<&nl><&color[#04BA04]><&chr[25C1]> <&r>Page <[page]>/<[max_page]> <[right_ar]><&nl>"
      - stop
    - if <[page]> == <[max_page]>:
      - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max_page]> <&color[#04BA04]><&chr[25B7]><&nl>"
      - stop
    - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max_page]> <[right_ar]><&nl>"

#-----------------------------------------#
# permissions:
# trusted: zc.homes_trusted
# admin: zc.homes_admin
#-----------------------------------------#
