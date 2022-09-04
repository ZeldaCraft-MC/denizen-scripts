#safe restart
safe_rs_c:
  type: command
  name: saferestart
  description: lets you safely restart the server
  usage: /saferestart
  permission: op
  script:
    - if <server.has_flag[saferestart]>:
      - narrate "The server is already on safe restart by <server.flag[saferestart].as_player.name>" format:zc_text
      - stop
    - flag server saferestart:<player>
    - narrate "Server will restart when its safe to restart" format:zc_text
safe_rs_w:
  type: world
  debug: false
  events:
    on system time minutely every:20:
    - if <server.has_flag[saferestart]>:
      - if <server.online_players.is_empty>:
        - run safe_rs_t
        - stop
      - if <server.online_players.size> == 1:
        - if <server.online_players> == <server.online_ops>:
          - run safe_rs_t
          - stop
        - if <server.online_players.first> == <server.flag[saferestart]>:
          - run safe_rs_t
          - stop
    on player joins:
    - if <server.has_flag[saferson]>:
      - flag server saferson:!
safe_rs_t:
  type: task
  debug: false
  script:
    - flag server saferson
    - announce "we found a safe time to restart." format:zc_text
    - announce "restarting in 10 minutes if no one joins" format:zc_text
    - wait 8m
    - if !<server.has_flag[saferson]>:
      - if <server.online_players> == <server.online_ops>:
        - goto continue1
      - else:
        - stop
    - mark continue1
    - announce "no one has joined yet. safe restarting in 2 minutes" format:zc_text
    - wait 1m
    - if !<server.has_flag[saferson]>:
      - if <server.online_players> == <server.online_ops>:
        - goto continue2
      - else:
        - stop
    - mark continue
    - announce "restarting in 1 minute. clench ur butts" format:zc_text
    - wait 1m
    - if !<server.has_flag[saferson]>:
      - if <server.online_players> == <server.online_ops>:
        - goto continue3
      - else:
        - stop
    - mark continue3
    - flag server saferson:!
    - flag server saferestart:!
    - execute as_server "denizen save"
    - execute as_server restart
