mythicmobs_spawn_checks:
  type: task
  debug: false
  script:
    - wait 1t
    - if <context.location.world.name> not in s1|s2:
      - stop
    - ratelimit global_lock 10t
    - if <context.location.light.blocks> > 0 or <util.random_chance[90]>:
      - if <context.entity.is_spawned>:
        - teleport <context.entity> <context.entity.location.with_y[-10]>
        - wait 1t
        - remove <context.entity>
      - stop
    - if <context.location.find_entities.within[100].filter[is_mythicmob].size> > 1:
      - if <context.entity.is_spawned>:
        - teleport <context.entity> <context.entity.location.with_y[-10]>
        - wait 1t
        - remove <context.entity>
      - stop

mythicmobs_events:
  type: world
  debug: false
  events:
    on mythicmob nocsy_bokoblin_* dies:
      - define loc <context.entity.location>
      - wait 2s
      - if <util.random_chance[15]>:
        - drop bokoblin_fang <[loc]>
      - if <util.random_chance[10]>:
        - drop bokoblin_horn <[loc]>
      - if <util.random_chance[5]>:
        - drop bokoblin_guts <[loc]>
    on mythicmob nocsy_moblin_* dies:
      - define loc <context.entity.location>
      - wait 3s
      - if <util.random_chance[15]>:
        - drop moblin_fang <[loc]>
      - if <util.random_chance[10]>:
        - drop moblin_horn <[loc]>
      - if <util.random_chance[5]>:
        - drop moblin_guts <[loc]>
    on mythicmob nocsy_bokoblin_warrior dies:
      - define loc <context.entity.location>
      - wait 2s
      - if <util.random_chance[0.5]>:
        - drop bokoblin_club <[loc]>
    #on mythicmob nocsy_bokoblin_shaman dies:
    #  - define loc <context.entity.location>
    #  - wait 2s
    #  - if <util.random_chance[0.5]>:
    #    - drop bokoblin_club <[loc]>
    on mythicmob nocsy_bokoblin_swordsman dies:
      - define loc <context.entity.location>
      - wait 2s
      - if <util.random_chance[0.5]>:
        - drop bokoblin_slasher <[loc]>
    after mythicmob nocsy_bokoblin_warrior spawns:
      - inject mythicmobs_spawn_checks
      - narrate "spawned mm warrior" player:<server.match_offline_player[Mergu]>
      - foreach <context.location.find_spawnable_blocks_within[4].random>:
        - mythicspawn Nocsy_Bokoblin_Warrior <[value]>
    after mythicmob nocsy_bokoblin_swordsman spawns:
      - inject mythicmobs_spawn_checks
      - narrate "spawned mm swordsman" player:<server.match_offline_player[Mergu]>
      - foreach <context.location.find_spawnable_blocks_within[4].random>:
        - mythicspawn Nocsy_Bokoblin_Warrior <[value]>
    after mythicmob nocsy_bokoblin_shaman spawns:
      - inject mythicmobs_spawn_checks
      - narrate "spawned mm shaman" player:<server.match_offline_player[Mergu]>
      - foreach <context.location.find_spawnable_blocks_within[4].random>:
        - mythicspawn Nocsy_Bokoblin_Warrior <[value]>
    after mythicmob nocsy_moblin_brute spawns:
      - inject mythicmobs_spawn_checks
      - narrate "spawned mm moblin brute" player:<server.match_offline_player[Mergu]>
      - if <util.random_chance[25]>:
        - foreach <context.location.find_spawnable_blocks_within[4].random>:
          - mythicspawn Nocsy_Bokoblin_Shaman <[value]>
      - if <util.random_chance[25]>:
        - foreach <context.location.find_spawnable_blocks_within[4].random>:
          - mythicspawn Nocsy_Bokoblin_Swordsman <[value]>
    after mythicmob nocsy_moblin_ravager spawns:
      - inject mythicmobs_spawn_checks
      - narrate "spawned mm moblin ravager" player:<server.match_offline_player[Mergu]>
      - if <util.random_chance[25]>:
        - foreach <context.location.find_spawnable_blocks_within[4].random>:
          - mythicspawn Nocsy_Bokoblin_Shaman <[value]>
      - if <util.random_chance[25]>:
        - foreach <context.location.find_spawnable_blocks_within[4].random>:
          - mythicspawn Nocsy_Bokoblin_Swordsman <[value]>
