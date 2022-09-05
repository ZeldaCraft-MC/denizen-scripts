vannounce:
  type: world
  debug: false
  events:
    on v|vanish command:
      - if !<player.has_permission[essentials.vanish]>:
        - stop
      - if <player.has_flag[Vanish]>:
        - flag player Vanish:!
        - announce "<&e><player.name> joined the game"
      - else:
        - flag player Vanish
        - announce "<&e><player.name> left the game"
    on player quits:
      - if <player.has_flag[Vanish]>:
        - flag player Vanish:!
        - announce "<&e><player.name> joined the game"
