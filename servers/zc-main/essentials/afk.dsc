is_afk:
  type: procedure
  debug: false
  definitions: player
  script:
    - if <[player].has_flag[afk.state]>:
      - determine <[player].flag[afk.state]>
    - determine false

toggle_afk:
  type: task
  debug: false
  definitions: state
  script:
    - if !<player.has_flag[afk]>:
      - flag <player> afk.state:false
      - flag <player> afk.time:<util.time_now>
    - flag <player> afk.location:<player.location.block>
    - if <[state]||null> == null:
      - define state <player.flag[afk.state].not>
    - if !<[state]>:
      - flag <player> afk.time:<util.time_now>
    # Only process changes beyond this
    - if <[state]> == <player.flag[afk.state]>:
      - stop
    - flag <player> afk.state:<[state]>
    - if <[state]>:
      - narrate "<&e><&chr[25CF]> <&7>You are now AFK <&e><&chr[25CF]>"
      - narrate "<&e><&chr[25CF]> <&7><player.name> is now AFK <&e><&chr[25CF]>" targets:<server.online_players.exclude[<player>]>
    - else:
      - narrate "<&a><&chr[25CF]> <&7>You are no longer AFK <&a><&chr[25CF]>"
      - narrate "<&a><&chr[25CF]> <&7><player.name> is no longer AFK <&a><&chr[25CF]>" targets:<server.online_players.exclude[<player>]>

afk_command:
  type: command
  debug: false
  description: Marks you as away-from-keyboard.
  usage: /afk (player)
  name: afk
  script:
    - if <context.args.size> > 0 && <player.has_permission[zc.afk.others]>:
      - define target <server.match_player[<context.args.get[1]>]>
      - if <[target]||null> == null:
        - narrate "<&c>Could not find a player with the name <context.args.get[1]>."
        - stop
      - run toggle_afk player:<[target]>
      - stop
    - run toggle_afk

afk_events:
  type: world
  debug: false
  events:
    on system time secondly every:1:
      - foreach <server.online_players> as:p:
        - if <[p].has_permission[zc.afk.ignore]>:
          - foreach next
        - if !<[p].has_flag[afk]> || <[p].flag[afk.location]> != <[p].location.block>:
          - run toggle_afk def:false player:<[p]>
        - else if <[p].flag[afk.time].from_now.in_minutes> > 10:
          - run toggle_afk def:true player:<[p]>
    on player clicks block flagged:afk:
      - run toggle_afk def:false
    on player chats flagged:afk:
      - run toggle_afk def:false
    on command flagged:afk:
      - if <context.command> == afk:
        - stop
      - run toggle_afk def:false
    on player quits:
      - flag <player> afk:!
