msg_cmd_ess:
  type: command
  name: msg
  usage: /msg (player name) (message)
  debug: false
  aliases:
  - whisper
  - t
  - tell
  description: privately messages another player
  tab completions:
    1: <server.flag[global_player_data].parse[get[name]]>
  script:
    - if <context.source_type> == command_block || <context.source_type> == command_minecart:
      - stop
    - if <context.source_type> == server:
      - if !<context.args.get[1].exists> || !<context.args.get[2].exists>:
        - announce "Usage: /msg (name) (message)" format:zc_text to_console
        - stop
      - define pn <server.flag[global_player_data].parse[get[name]].find_partial[<context.args.first>]>
      - if <[pn]> == -1:
        - announce "This player doesn't seem to be online" format:zc_text to_console
        - stop
      - define pm <server.flag[global_player_data].get[<[pn]>].get[name]>
      - define to_map <server.flag[global_player_data].filter[get[name].is[==].to[<[pm]>]].first>
      - definemap map:
          name: Console
          to_player: <[pm]>
          message: "<context.raw_args.after[ ].utf8_encode>"
      - redis id:publisher publish:global_change_msg_console message:<[pm]>
      - announce "(Me -<&gt> <[pm]>) <[map].get[message].utf8_decode>" to_console
      - if <bungee.server> == <[to_map].get[server]>:
        - narrate RECEIVE_PRIVATE_MESSAGE=<[map]> targets:<server.match_player[<[pm]>]>
        - redis id:publisher publish:global_change_msg_<server.match_player[<[pm]>].uuid> message:console
        - stop
      - else:
        - redis id:publisher publish:global_private_msg_<[to_map].get[server]> message:<[map]>
      - stop
    - if !<context.args.get[1].exists> || !<context.args.get[2].exists>:
      - narrate "Usage: /msg (name) (message)" format:zc_text
      - stop
    - if <context.args.first> == console:
      - definemap map:
          name: <player.name>
          to_player: Console
          message: "<context.raw_args.after[ ].utf8_encode>"
      - narrate SEND_PRIVATE_MESSAGE=<[map]> targets:<player>
      - redis id:publisher publish:global_change_msg_<player.uuid> message:console
      - redis id:publisher publish:global_private_console message:<[map]>
    - else:
      - define pn <server.flag[global_player_data].parse[get[name]].find_partial[<context.args.first>]>
      - if <[pn]> == -1:
        - narrate "This player doesn't seem to be online" format:zc_text
        - stop
      - define pm <server.flag[global_player_data].get[<[pn]>].get[name]>
      - define to_map <server.flag[global_player_data].filter[get[name].is[==].to[<[pm]>]].first>
      - definemap map:
          name: <player.name>
          to_player: <[pm]>
          message: "<context.raw_args.after[ ].utf8_encode>"
      - narrate SEND_PRIVATE_MESSAGE=<[map]> targets:<player>
      - redis id:publisher publish:global_change_msg_<player.uuid> message:<[pm]>
      - if <bungee.server> == <[to_map].get[server]>:
        - narrate RECEIVE_PRIVATE_MESSAGE=<[map]> targets:<server.match_player[<[pm]>]>
        - announce "(<[map].get[name]> -<&gt> <[map].get[to_player]>) <[map].get[message].utf8_decode>" to_console
        - redis id:publisher publish:global_change_msg_<server.match_player[<[pm]>].uuid> message:<player.name>
      - else:
        - redis id:publisher publish:global_private_msg_<[to_map].get[server]> message:<[map]>

reply_cmd_ess:
  type: command
  name: reply
  description: replies to the last person you messaged with
  usage: /reply (message)
  aliases:
  - r
  debug: false
  script:
    - if <context.source_type> == command_block || <context.source_type> == command_minecart:
      - stop
    - if <context.source_type> == server:
      - if !<context.args.get[1].exists>:
        - announce "You need to include a message" format:zc_text to_console
        - stop
      - if !<server.has_flag[replying_to]>:
        - announce "you are not replying to anyone" format:zc_text to_console
        - stop
      - define reply <server.flag[replying_to]>
      - if <server.flag[global_player_data].parse[get[name]].include[console]> !contains <[reply]>:
        - announce "The person you are replying to is no longer online" format:zc_text to_console
        - stop
      - define to_map <server.flag[global_player_data].filter[get[name].is[==].to[<[reply]>]].first>
      - definemap map:
          name: Console
          to_player: <[reply]>
          message: <context.raw_args.utf8_encode>
      - redis id:publisher publish:global_change_msg_console message:<[reply]>
      - announce "(Me -<&gt> <[reply]>) <[map].get[message].utf8_decode>" to_console
      - if <bungee.server> == <[to_map].get[server]>:
        - narrate RECEIVE_PRIVATE_MESSAGE=<[map]> targets:<server.match_player[<[reply]>]>
        - redis id:publisher publish:global_change_msg_<server.match_player[<[reply]>].uuid> message:console
      - else:
        - redis id:publisher publish:global_private_msg_<[to_map].get[server]> message:<[map]>
      - stop
    - if !<context.args.get[1].exists>:
      - narrate "You need to include a message" format:zc_text
      - stop
    - if !<player.has_flag[replying_to]>:
      - narrate "You are not replying to anyone" format:zc_text
      - stop
    - define reply <player.flag[replying_to]>
    - if <server.flag[global_player_data].parse[get[name]].include[console]> !contains <[reply]>:
      - narrate "The person you are replying to is no longer online" format:zc_text
      - stop
    - if <[reply]> == console:
      - definemap map:
          name: <player.name>
          to_player: Console
          message: <context.raw_args.utf8_encode>
      - narrate SEND_PRIVATE_MESSAGE=<[map]> targets:<player>
      - redis id:publisher publish:global_change_msg_<player.uuid> message:<[reply]>
      - redis id:publisher publish:global_private_console message:<[map]>
    - else:
      - define to_map <server.flag[global_player_data].filter[get[name].is[==].to[<[reply]>]].first>
      - definemap map:
          name: <player.name>
          to_player: <[reply]>
          message: <context.raw_args.utf8_encode>
      - narrate SEND_PRIVATE_MESSAGE=<[map]> targets:<player>
      - redis id:publisher publish:global_change_msg_<player.uuid> message:<[reply]>
      - if <bungee.server> == <[to_map].get[server]>:
        - narrate RECEIVE_PRIVATE_MESSAGE=<[map]> targets:<server.match_player[<[reply]>]>
        - announce "(<[map].get[name]> -<&gt> <[map].get[to_player]>) <[map].get[message].utf8_decode>" to_console
        - redis id:publisher publish:global_change_msg_<server.match_player[<[reply]>].uuid> message:<player.name>
      - else:
        - redis id:publisher publish:global_private_msg_<[to_map].get[server]> message:<[map]>
