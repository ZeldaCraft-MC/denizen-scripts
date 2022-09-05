disabled_commands_data:
  type: data
  cmds:
    - tp
    - sethome
    - fly
    - call
    - jump
ocarina_events:
  type: world
  events:
    on player right clicks block with:ocarina_prelude_of_light:
      - if !<player.is_on_ground>:
        - stop
      - ratelimit <player> 20s
      - playsound <player> sound:zc_sfx.oot.prelude_of_light volume:2 custom
      - run freeze_player def:<player>|freeze|<player.location>
      - repeat 34:
        - if <[value].div[3].round_down.mod[2]> == 0:
          - define color <&e>
        - else:
          - define color <&6>
        - actionbar "<[color]>Playing: Prelude of Light"
        - playeffect effect:redstone quantity:3 at:<player.location.above[1]> offset:0.3,1,0.3 data:1 special_data:3|#ffaa00
        - wait 10t
      - run freeze_player def:<player>|unfreeze
      - define loc <player.location>
      - flag player ocarina_played
      - teleport <player> ocarina_tp
      - run ocarina_check_boss_task
      - flag player ocarina_played:!
      - take item:ocarina_prelude_of_light quantity:1 from:<player.inventory>
    on player enters ocarine_no_tp:
      - if <player.has_permission[op]>:
        - stop
      - if !<player.has_flag[ocarina_played]>:
        - wait 1t
        - teleport <player> <context.from.if_null[<server.flag[warps.spawn]>]>
        - if <context.cause> == join || <context.cause> == quit:
          - teleport <player> <server.flag[warps.spawn]>
        - narrate "<&c>You cannot go there!"
    on command in:ocarine_no_tp:
      - if <context.source_type> != player:
        - stop
      - if <player.has_permission[op]>:
          - stop
      - foreach <script[disabled_commands_data].data_key[cmds]> as:cmd:
        - if <context.command.advanced_matches[*<[cmd]>*]>:
          - narrate "<&c>You cannot use that command in here!"
          - determine fulfilled

malice_colors:
  type: data
  debug: false
  colors:
    - 7c2542
    - 4f1b2a
    - 401928
    - 392429
    - 872e48
    - dd0852
    - 712b42
    - 231d1a
malice_color_test:
  type: task
  debug: false
  script:
    - repeat 10:
      - foreach <script[malice_colors].data_key[colors]> as:c:
        - playeffect effect:redstone at:<player.location.add[1,1,0]> special_data:0.8|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[1].to[6]>
      - wait 1s
ocarina_check_boss_task:
  type: task
  debug: false
  script:
    #- if !<cuboid[ganon_fight_room].players.is_empty>:
    #  - stop
    # if ganon fight still going with no one there end it
    - if !<server.flag[summon_sword_ent].exists>:
      - spawn summon_sword_bottom[passenger=summon_sword_top] summon_sword_loc save:ents
      - define ent1 <entry[ents].spawned_entity>
      - define ent2 <[ent1].passenger>
      - flag <[ent1]> linked:<[ent2]>
      - flag <[ent2]> linked:<[ent1]>
    - else:
      - teleport <server.flag[summon_sword_ent]> summon_sword_loc
      - flag <server.flag[summon_sword_ent].flag[linked]> pull_out:0
spawn_summon_sword:
  type: task
  debug: false
  script:
    - spawn summon_sword_bottom[passenger=summon_sword_top] <player.location.center> save:ents
    - define ent1 <entry[ents].spawned_entity>
    - define ent2 <[ent1].passenger>
    - flag <[ent1]> linked:<[ent2]>
    - flag <[ent2]> linked:<[ent1]>
summon_sword_world:
  type: world
  debug: false
  events:
    on player right clicks summon_sword_top:
      - if <context.entity.has_flag[busy]>:
        - stop
      - choose <context.entity.flag[pull_out].add[1]>:
        - case 1:
          - flag <context.entity> busy
          - repeat 5:
            - foreach <script[malice_colors].data_key[colors]> as:c:
              - playeffect  effect:redstone at:<context.entity.location.add[0,0.8,0]> special_data:0.8|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[1].to[6]>
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
          - flag <context.entity> pull_out:++
          - flag <context.entity> busy:!
        - case 2:
          - flag <context.entity> busy
          - repeat 10:
            - foreach <script[malice_colors].data_key[colors]> as:c:
              - playeffect  effect:redstone at:<context.entity.location.add[0,0.5,0]> special_data:0.8|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[3].to[7]>
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
          - flag <context.entity> pull_out:++
          - flag <context.entity> busy:!
        - case 3:
          - flag <context.entity> busy
          - repeat 15:
            - foreach <script[malice_colors].data_key[colors]> as:c:
              - playeffect  effect:redstone at:<context.entity.location.add[0,0.5,0]> special_data:0.8|<color[#<[c]>]> offset:0.3,0.3,0.3 quantity:<util.random.int[5].to[8]>
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
            - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.add[0.01]>]>
            - wait 0.15s
          - foreach <script[malice_colors].data_key[colors]> as:c:
            - playeffect  effect:redstone at:<context.entity.location.add[0,0,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,0.2,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,0.4,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,0.6,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,0.8,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,1,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,1.2,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,1.4,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
            - playeffect  effect:redstone at:<context.entity.location.add[0,1.6,0]> special_data:1.2|<color[#<[c]>]> offset:0.2,0.2,0.2 quantity:<util.random.int[2].to[4]>
          - define loc <context.entity.location.sub[0,0.9,0]>
          - teleport <context.entity.flag[linked]> <context.entity.flag[linked].location.with_y[<context.entity.flag[linked].location.y.sub[3.9]>]>
          - repeat 17 as:n:
            - foreach <script[malice_colors].data_key[colors]> as:c:
              - playeffect  effect:redstone at:<[loc].add[<[n]>,<[n].div[2]>,0]> special_data:1.5|<color[#<[c]>]> offset:0.5,0.5,0.5 quantity:5
              - playeffect  effect:redstone at:<[loc].add[-<[n]>,<[n].div[2]>,0]> special_data:1.5|<color[#<[c]>]> offset:0.5,0.5,0.5 quantity:5
              - playeffect  effect:redstone at:<[loc].add[0,<[n].div[2]>,<[n]>]> special_data:1.5|<color[#<[c]>]> offset:0.5,0.5,0.5 quantity:5
              - playeffect  effect:redstone at:<[loc].add[0,<[n].div[2]>,-<[n]>]> special_data:1.5|<color[#<[c]>]> offset:0.5,0.5,0.5 quantity:5
            - wait 0.3s
          - run spawn_ganon_boss_task
          - flag <context.entity> pull_out:0
          - flag <context.entity> busy:!
spawn_ganon_boss_task:
  type: task
  debug: false
  script:
    - spawn armor_stand <location[summon_sword_loc].add[0,3,0]>
summon_sword_bottom:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    equipment: air|air|air|netherite_sword[custom_model_data=1900]
    visible: false
    gravity: false
summon_sword_top:
  type: entity
  debug: false
  entity_type: armor_stand
  flags:
    pull_out: 0
  mechanisms:
    visible: false
    gravity: false
