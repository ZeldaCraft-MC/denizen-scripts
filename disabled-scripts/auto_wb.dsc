autowb_msg_task:
    type: task
    debug: false
    definitions: msg
    script:
        - define targets <server.online_players>
        - definemap map:
            uuid: <player.uuid>
            name: <player.name>
            message: <[msg]>
            prefix: <player.proc[chat_prefix]>
            suffix: <player.chat_suffix.trim.parse_color>
            display_name: <player.display_name>
            flair_style: <player.flag[flair_style].if_null[<&r>]>
        - narrate PLAYER_MESSAGE=<[map]> targets:<[targets]>
        - if <server.has_flag[server_name]>:
            - redis id:global_chat_pub publish:global_chat_<server.flag[server_name]> message:<[map]>

autowb_world:
  type: world
  debug: false
  events:
    after v command:
      - if <server.has_flag[wb_cooldown]>:
        - stop
      - flag server wb_cooldown expire:1m
      - if <context.source_type> != player:
        - stop
      - if !<player.groups.contains[moderator]>:
        - stop
      - wait 1s
      - if <player.is_vanished>:
        - stop
      - if <server.online_players.size> > 6:
        - foreach <server.online_players.exclude[<player>].random[5]> as:player:
          - if <[player].is_vanished>:
            - foreach next
          - if <[player].proc[is_afk]>:
            - foreach next
          - if <[player].has_flag[autowbon]>:
            - wait 0.<util.random.int[2].to[6]>s
            - define msg <[player].flag[autowb].parsed||wb>
            - run autowb_msg_task player:<[player]> def:<[msg]>
            - stop
      - foreach <server.online_players.exclude[<player>]> as:player:
        - if <[player].is_vanished>:
          - foreach next
        - if <[player].proc[is_afk]>:
          - foreach next
        - if <[player].has_flag[autowbon]>:
          - wait 0.<util.random.int[2].to[6]>s
          - define msg <[player].flag[autowb].parsed||wb>
          - run autowb_msg_task player:<[player]> def:<[msg]>
    after vanish command:
      - if <server.has_flag[wb_cooldown]>:
        - stop
      - flag server wb_cooldown expire:1m
      - if <context.source_type> != player:
        - stop
      - if !<player.groups.contains[moderator]>:
        - stop
      - wait 1s
      - if <player.is_vanished>:
        - stop
      - if <server.online_players.size> > 6:
        - foreach <server.online_players.exclude[<player>].random[5]> as:player:
          - if <[player].is_vanished>:
            - foreach next
          - if <[player].proc[is_afk]>:
            - foreach next
          - if <[player].has_flag[autowbon]>:
            - wait 0.<util.random.int[2].to[6]>s
            - define msg <[player].flag[autowb].parsed||wb>
            - run autowb_msg_task player:<[player]> def:<[msg]>
            - stop
      - foreach <server.online_players.exclude[<player>]> as:player:
        - if <[player].is_vanished>:
          - foreach next
        - if <[player].proc[is_afk]>:
          - foreach next
        - if <[player].has_flag[autowbon]>:
          - wait 0.<util.random.int[2].to[6]>s
          - define msg <[player].flag[autowb].parsed||wb>
          - run autowb_msg_task player:<[player]> def:<[msg]>
    on player first login:
      - flag player first_time
    on bungee player joins network:
      - ratelimit <player> 1s
      - if <player.has_flag[autowb]>:
        - if !<player.has_flag[wb_autoreset]>:
          - flag player wb_autoreset
          - narrate "The auto welcome back message input has been changed." format:zc_text
          - narrate "Type <&2><&click[/autowb option]>/autowb option<&end_click><&f> for more info" format:zc_text
          - narrate "Your auto wb message has been set to wb" format:zc_text
          - flag player autowb:wb
      - if !<player.has_flag[has_logged_in]>:
        - stop
      - wait 1.<util.random.int[1].to[9]>s
      - if <server.has_flag[wb_cooldown]>:
        - stop
      - flag server wb_cooldown expire:1m
      - if <server.online_players.size> > 6:
        - foreach <server.online_players.exclude[<player>].random[5]> as:player:
          - if <[player].is_vanished>:
            - foreach next
          - if <[player].proc[is_afk]>:
            - foreach next
          - if <[player].has_flag[autowbon]>:
            - wait 0.<util.random.int[2].to[6]>s
            - define msg <[player].flag[autowb].parsed||wb>
            - run autowb_msg_task player:<[player]> def:<[msg]>
            - stop
      - foreach <server.online_players.exclude[<player>]> as:player:
        - if <[player].is_vanished>:
          - foreach next
        - if <[player].proc[is_afk]>:
          - foreach next
        - if <[player].has_flag[autowbon]>:
          - wait 0.<util.random.int[2].to[6]>s
          - define msg <[player].flag[autowb].parsed||wb>
          - run autowb_msg_task player:<[player]> def:<[msg]>

autowb_command:
  type: command
  name: autowb
  debug: false
  description: "Let's you set an auto welcome back message"
  usage: /autowb <&lt><&a>on/<&b>option <&f>(number)/<&c>off<&gt>
  permission: zc.aura
  script:
    - choose <context.args.first||null>:
      - case on:
        - if <player.has_flag[autowbon]>:
          - narrate "Your auto message is already <&a>on" format:zc_text
          - narrate "To turn it off use <&c>off" format:zc_text
          - stop
        - if <player.has_flag[autowb]>:
          - narrate "Your auto message has succesfully been turned <&a>on" format:zc_text
          - flag player autowbon
          - stop
        - narrate "you have not set a message. It will auto display wb<&nl>" format:zc_text
        - narrate "Your auto message has succesfully been turned <&a>on" format:zc_text
        - flag player autowbon
        - stop
      - case option:
        - if <context.args.get[2].to[last]||empty> == empty:
          - narrate "<&a><&l>Zelda<&2><&l>Craft AutoWb Command"
          - narrate "You can choose between 4 options for auto welcome back messages:"
          - narrate "Type the number of what auto welcome back message you want<&nl>"
          - narrate "<&a><&click[/autowb option 1]>1. <&f>wb<&end_click>"
          - narrate "<&a><&click[/autowb option 2]>2. <&f>Welcome Back<&end_click>"
          - narrate "<&a><&click[/autowb option 3]>3. <&f>wb (player name)<&end_click>"
          - narrate "<&a><&click[/autowb option 4]>4. <&f>Welcome Back (player name)<&end_click>"
          - narrate "<&a><&click[/autowb option 5]>5. <&f>Wuz' crackalackin bro! Yo'self is playin' ZeldaCraft!<&end_click>"
          - narrate "<&a><&click[/autowb option 6]>6. <&f>weba<&end_click>"
          - narrate "<&a><&click[/autowb option 7]>7. <&f>weba (player name)<&end_click>"
          - narrate "<&nl>This command is an svip exclusive command"
        - choose <context.args.get[2]>:
          - case 1:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:wb
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - case 2:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:Welcome<&sp>Back
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - case 3:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:wb<&sp><&lt>player.name<&gt>
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - case 4:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:Welcome<&sp>Back<&sp><&lt>player.name<&gt>
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - case 5:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:Wuz'<&sp>crackalackin<&sp>bro!<&sp>Yo'self<&sp>is<&sp>playin'<&sp>ZeldaCraft!!
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - case 6:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:weba
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - case 7:
            - if <player.has_flag[autowb]>:
              - narrate "<&7>Your auto message was changed from <&r><player.flag[autowb]><&nl>" format:zc_text
            - flag player autowb:weba<&sp><&lt>player.name<&gt>
            - narrate "<&7>Your auto message is now <&r><player.flag[autowb]>" format:zc_text
          - default:
            - narrate "<&a><&l>Zelda<&2><&l>Craft AutoWb Command"
            - narrate "You can choose between 4 options for auto welcome back messages:"
            - narrate "Type the number of what auto welcome back message you want"
            - narrate "<&2><&click[/autowb option ].type[suggest_command]>/autowb option (number)<&end_click><&nl>"
            - narrate "<&a><&click[/autowb option 1]>1. <&f>wb<&end_click>"
            - narrate "<&a><&click[/autowb option 2]>2. <&f>Welcome Back<&end_click>"
            - narrate "<&a><&click[/autowb option 3]>3. <&f>wb (player name)<&end_click>"
            - narrate "<&a><&click[/autowb option 4]>4. <&f>Welcome Back (player name)<&end_click>"
            - narrate "<&a><&click[/autowb option 5]>5. <&f>Wuz' crackalackin bro! Yo'self is playin' ZeldaCraft!<&end_click>"
            - narrate "<&a><&click[/autowb option 6]>6. <&f>weba<&end_click>"
            - narrate "<&a><&click[/autowb option 7]>7. <&f>weba (player name)<&end_click>"
            - narrate "<&nl>This command is an svip exclusive command"
      - case off:
        - if <player.has_flag[autowbon]>:
          - narrate "Your auto message has succesfully been turned <&c>off" format:zc_text
          - flag player autowbon:!
        - else:
          - narrate "It seems like your auto message isn't <&a>on" format:zc_text
      - default:
        - narrate "<&a><&l>Zelda<&2><&l>Craft AutoWb Command"
        - narrate "Some people are just too lazy to type a few letters"
        - narrate "introducing <&2><&click[/autowb].type[suggest_command]>/autowb<&end_click>"
        - narrate "automatically sends a welcome back message<&nl>"
        - narrate "You can set your welcome back message with <&b>option <&f>(number)"
        - narrate "Type <&2><&click[/autowb option]>/autowb option<&end_click><&f> To see the options you have"
        - narrate "and you can toggle your auto message <&a>on <&f>/ <&c>off<&nl>"
        - narrate "This command is an svip exclusive command"
