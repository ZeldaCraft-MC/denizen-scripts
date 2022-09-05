jailed_cancel_events:
  type: world
  debug: false
  events:
    after player joins flagged:nomore_jail:
      - wait 10s
      - teleport <player> <player.flag[nomore_jail]>
      - flag <player> nomore_jail:!
      - narrate "You have been unjailed!" format:zc_text
    on system time secondly:
      - foreach <server.players_flagged[jailed]> as:player:
        - define dur <[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>
        - actionbar "Time left in jail <&c><[dur]>" targets:<[player]>
        - if <[player].flag_expiration[jailed].duration_since[<util.time_now>].is_less_than_or_equal_to[1s]>:
          - define tel <[player].flag[jailed]>
          - flag <[player]> jailed:!
          - if !<[player].is_online>:
            - flag <[player]> nomore_jail:<[tel]>
          - teleport <[player]> <[tel]>
          - narrate "You have been unjailed!" format:zc_text targets:<[player]>
          - narrate "<[player].name> served his time and has been unjailed" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]]>
    on player breaks block flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player places block flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player throws egg flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player starts flying flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player drops item flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player picks up item flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player teleports flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player shoots bow flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player damages entity flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"
    on player damaged flagged:jailed:
      - determine passively cancelled
      - narrate "<&4>You cannot do that while jailed!"

jail_cmd:
  type: command
  debug: false
  name: jail
  description: puts a player into a jail for a set amount of time.
  usage: /jail (player) (jail) (time)
  permission: zc.mod
  tab completions:
    1: <server.online_players.parse[name]>
    2: <server.flag[jails].keys.alphabetical>
    3: 10s|3m|15m|2h|1d|3w|7w|1y
  script:
    - if <context.args.first||<empty>> == <empty> || <context.args.get[2]||<empty>> == <empty> || <context.args.get[3]||<empty>> == <empty>:
      - narrate "Seems like you tried to run an incomplete command?" format:zc_text
      - stop
    - if <server.match_offline_player[<context.args.first>]||error> == error:
      - narrate "<context.args.first> does not seem to be a player!" format:zc_text
      - stop
    - if !<server.flag[jails].keys.contains[<context.args.get[2]>]>:
      - narrate "<context.args.first> does not seem to be a valid jail!" format:zc_text
      - stop
    - if <duration[<context.args.get[3]>]||error> == error:
      - narrate "Seems like you put in an incorrect time." format:zc_text
      - stop
    - define player <server.match_offline_player[<context.args.first>]>
    - if <[player].is_op>:
      - narrate "<&4>You cannot jail an OP"
      - stop
    - define jail <context.args.get[2]>
    - define time <context.args.get[3]>
    - define num <[player].flag[moderate.jail].size.add[1]||1>
    - flag <[player]> moderate.jail.<[num]>.by_player:<player>
    - flag <[player]> moderate.jail.<[num]>.jail:<[jail]>
    - flag <[player]> moderate.jail.<[num]>.time_till:<[time]>
    - flag <[player]> moderate.jail.<[num]>.time_now:<util.time_now>
    - if <[player].has_flag[jailed]>:
      - teleport <[player]> <server.flag[jails.<[jail]>]>
      - define tel <[player].flag[jailed]>
      - flag <[player]> jailed:<[tel]> expire:<[time]>
      - flag <[player]> moderate.jail.<[num]>.is_change:true
      - narrate "Your jail time has been changed to <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text targets:<[player]>
      - narrate "Succesfully changed <[player].name>'s jail time to <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text
      - narrate "<[player].name>'s jail time has been changed to <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted> <&f>inside <&e><[jail]> <&f>by <player.name>" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>
    - else:
      - define tel <[player].location>
      - teleport <[player]> <server.flag[jails.<[jail]>]>
      - flag <[player]> jailed:<[tel]> expire:<[time]>
      - flag <[player]> moderate.jail.<[num]>.is_change:false
      - narrate "<&f>You have been <&4>jailed <&f>for <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text targets:<[player]>
      - narrate "<&c>You do the crime, you do the time." format:zc_text targets:<[player]>
      - narrate "Succesfully jailed <[player].name> in <&e><[jail]> <&f>for <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text
      - narrate "<player.name> has jailed <[player].name> in <&e><[jail]> <&f>for <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>

unjail_cmd:
  type: command
  debug: false
  name: unjail
  description: gets a player out of the jail.
  usage: /unjail (player)
  permission: zc.mod
  tab completions:
    1: <server.players_flagged[jailed].parse[name]>
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "Seems like you tried to run an incomplete command?" format:zc_text
      - stop
    - if <server.match_offline_player[<context.args.first>]||error> == error:
      - narrate "<context.args.first> does not seem to be a player!" format:zc_text
      - stop
    - define player <server.match_offline_player[<context.args.first>]>
    - if !<[player].has_flag[jailed]>:
      - narrate "It does not seem <[player].name> is jailed." format:zc_text
      - stop
    - define tel <[player].flag[jailed]>
    - define num <[player].flag[moderate.unjail].size.add[1]||1>
    - flag <[player]> moderate.unjail.<[num]>.by_player:<player>
    - flag <[player]> moderate.unjail.<[num]>.expire:<[player].flag_expiration[jailed]>
    - flag <[player]> moderate.unjail.<[num]>.time_now:<util.time_now>
    - flag <[player]> jailed:!
    - teleport <[player]> <[tel]>
    - narrate "You have been unjailed!" format:zc_text targets:<[player]>
    - narrate "You succesfully unjailed <[player].name>" format:zc_text
    - narrate "<player.name> unjailed <[player].name>" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>

jails_cmd:
  type: command
  debug: false
  name: jails
  description: Lists all jails.
  usage: /jails
  permission: zc.mod
  script:
    - define jails <list>
    - if <player.is_op>:
      - foreach <server.flag[jails].keys.alphabetical> as:jail:
        - define loc <server.flag[jails.<[jail]>]>
        - define hover "Click to teleport to <&a><[jail]>"
        - define hover_x "Click to delete <&c><[jail]>"
        - define jails "<[jails].include[<&click[/gotojail <[jail]>]><&hover[<[hover]>]><&f><[jail]><&end_hover><&end_click> <&f>-=- <&e><[loc].simple> <&click[/deljail <[jail]>]><&hover[<[hover_x]>]><&c>[x]<&end_hover><&end_click>]>"
    - else:
      - foreach <server.flag[jails].keys> as:jail:
        - define loc <server.flag[jails.<[jail]>]>
        - define hover "Click to teleport to <&a><[jail]>"
        - define jails "<[jails].include[<&click[/gotojail <[jail]>]><&hover[<[hover]>]><&f><[jail]><&end_hover><&end_click> <&f>-=- <&e><[loc].simple>]>"
    - narrate <&a><&l>Zelda<&2><&l>Craft Jails<&nl>
    - narrate <empty>
    - narrate <[jails].separated_by[<&nl>]><&nl>

gotojail_cmd:
  type: command
  debug: false
  name: gotojail
  description: teleports you inside a jail without being jailed
  usage: /gotojail (jail)
  permission: zc.mod
  tab completions:
    1: <server.flag[jails].keys.alphabetical>
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "Seems like you tried to run an incomplete command?" format:zc_text
      - stop
    - if !<server.flag[jails].keys.contains[<context.args.first>]>:
      - narrate "<context.args.first> does not seem to be a valid jail!" format:zc_text
      - stop
    - teleport <player> <server.flag[jails.<context.args.first>]>
    - narrate "Succesfully teleported to <&a><context.args.first>" format:zc_text

setjail_cmd:
  type: command
  debug: false
  name: setjail
  description: sets a jail at your current location with the name you gave it
  usage: /setjail (name)
  permission: op
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "Seems like you tried to run an incomplete command?" format:zc_text
      - stop
    - if <server.flag[jails].keys.contains[<context.args.first>]>:
      - narrate "<context.args.first> is already a jail. Click <&click[/deljail <context.args.first>]><&hover[Click Me!]><&c>[x]<&end_hover><&end_click><&f> to remove it" format:zc_text
      - stop
    - flag server jails.<context.args.first>:<player.location>
    - narrate "<&a><context.args.first><&f> Succesfully created at <&b><player.location.simple>" format:zc_text

deljail_cmd:
  type: command
  debug: false
  name: deljail
  description: deletes a jail
  usage: /deljail (jail)
  permission: op
  tab completions:
    1: <server.flag[jails].keys.alphabetical>
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "Seems like you tried to run an incomplete command?" format:zc_text
      - stop
    - if !<server.flag[jails].keys.contains[<context.args.first>]>:
      - narrate "<context.args.first> does not seem to be a valid jail!" format:zc_text
      - stop
    - flag server jails.<context.args.first>:!
    - narrate "<&a><context.args.first><&f> succesfully removed!" format:zc_text
