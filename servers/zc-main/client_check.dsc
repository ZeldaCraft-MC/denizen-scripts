client_cmd:
  type: command
  debug: false
  name: client
  description: checks a players client
  usage: /client (player name)
  permission: zc.homes_admin
  tab completions:
    1: <server.online_players.parse[name]>
  script:
    - if <context.args.first||error> == error:
      - narrate "You need to put in a player name to check their client" format:zc_text
      - stop
    - if <server.match_player[<context.args.first>]||noone> == noone:
      - narrate "Are you sure <context.args.first> is a player and is online?" format:zc_text
      - stop
    - define player <server.match_player[<context.args.first>]>
    - narrate "<[player].name>'s client is: <[player].client_brand>" format:zc_text

client_world:
  type: world
  debug: false
  events:
    after player joins:
    - run client_brand_task

client_brand_task:
  type: task
  debug: false
  script:
    - define start_time <util.time_now>
    - waituntil rate:1s <player.client_brand||null> != unknown || <[start_time].from_now.in_seconds> > 15
    - if <player.is_online>:
      - narrate "<&e><player.name>'s client: <player.client_brand>" targets:<server.online_players.filter[has_permission[zc.homes_admin]]>
