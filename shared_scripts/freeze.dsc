freeze_player:
  type: task
  debug: false
  definitions: player|mode|location
  ## Usage: "- run Generic_Freeze_Task instantly def:<PlayerTag>|(freeze/unfreeze)(|<LocationTag>)"
  ## Location is required for freeze mode only-- omit for unfreeze mode.
  script:
    - choose <[mode]>:
      - case unfreeze:
        - flag <[player]> frozen:!
        - adjust <[player]> fly_speed:0.2
        - adjust <[player]> flying:false
        - adjust <[player]> fov_multiplier:0.0
        - adjust <[player]> can_fly:<[player].flag[flight_permissions]>
        - flag <[player]> flight_permissions:!
      - case freeze:
        - teleport <[player]> <[location]>
        - flag <[player]> frozen:<[location]>
        - flag <[player]> flight_permissions:<[player].can_fly>
        - adjust <[player]> can_fly:true
        - adjust <[player]> fly_speed:0.0
        - teleport <[player]> <[player].location.add[0,0.001,0]>
        - adjust <[player]> flying:true
        - adjust <[player]> fov_multiplier:0.0

freeze_lock:
  type: world
  debug: false
  events:
    on player stops flying flagged:frozen:
      - determine passively cancelled
      - wait 1t
      - adjust <player> fov_multiplier:0.0
      - teleport <player> <player.flag[frozen]>
    on player teleports bukkit_priority:lowest flagged:frozen:
      - determine cancelled
    on player right clicks entity flagged:frozen:
      - determine cancelled
    on player quits flagged:frozen:
      - run freeze_player def:<player>|unfreeze
