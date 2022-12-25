zeldabombv3:
  type: world
  debug: false
  events:
    on bomb_entity exits vehicle:
      - if !<context.entity.has_flag[mount_cancel]>:
        - determine cancelled
    on player places bomb_item:
      - determine cancelled
      # shift clicking and re-pickup water bombs causes them to sink
      # very strange behavior when thrown while swimming on waterbed
    on player right clicks block with:*bomb_item using:either_hand:
      - ratelimit <player> 0.5s
      - flag <player> custom_entity_cooldown duration:4t
      - wait 1t
      - determine passively cancelled
      - if <context.item.script.name> != water_bomb_item && ( <player.eye_location.is_liquid> || <player.eye_location.material.waterlogged||false> || <player.eye_location.material.name> in kelp|kelp_plant|seagrass|tall_seagrass ):
        - stop
      - else if <player.has_flag[lifting]||false> || <player.has_passenger>:
        - if <player.flag[lifting].script.name> == BOMB_ENTITY:
          - define held_bomb <player.flag[lifting]>
          - flag <[held_bomb]> mount_cancel
          - mount cancel <[held_bomb]>
          - flag <[held_bomb]> liftable
          - wait 1t
          - if <player.is_sneaking> && ( <player.cursor_on[5].material.is_solid||false> && <player.cursor_on[5].above.material.name||none> == air ) || ( <[held_bomb].has_flag[water_bomb]> && ( <player.cursor_on[5].above.is_liquid> || <player.cursor_on[5].above.material.waterlogged||false> || <player.cursor_on[5].above.material.name> in kelp|kelp_plant|seagrass|tall_seagrass ) ):
            - adjust <[held_bomb]> equipment:air|air|air|bomb_item_model[custom_model_data=<[held_bomb].flag[model_data]||100>]
            - adjust <[held_bomb]> item_in_hand:air
            - teleport <[held_bomb]> <context.location.add[0,1,0]>
            - wait 5t
            - run onland def:<[held_bomb]>
          - else:
            - adjust <[held_bomb]> equipment:air|air|air|bomb_item_model[custom_model_data=<[held_bomb].flag[model_data]||100>]
            - adjust <[held_bomb]> item_in_hand:air
            - if <context.item.script.name> == water_bomb_item && ( <player.eye_location.is_liquid> || <player.eye_location.material.waterlogged||false> || <player.eye_location.material.name> in kelp|kelp_plant|seagrass|tall_seagrass ):
              - push <[held_bomb]> origin:<player> destination:<player.cursor_on||<player.location.forward[10]>> speed:0.4 script:onland def:<[held_bomb]>
            - else:
              - shoot <[held_bomb]> origin:<player> destination:<player.cursor_on.above[5]||<player.location.forward[10].above[5]>> speed:0.8 height:3 script:onland def:<[held_bomb]>
          - flag <player> lifting:!
          - flag <[held_bomb]> player_lifting:!
          - flag <player> bombcooldown duration:0.2s
          - stop
        - else:
          - actionbar targets:<player> "You are already lifting something!"
          - stop
      - else if <player.has_flag[bombcooldown]> || <player.cursor_on[5].has_inventory||false> || <player.cursor_on[5].material.name.contains_any_text[button|lever|door|sign]||false> || <player.is_inside_vehicle>:
        - stop
      - else if <player.is_sneaking>  && !<player.has_flag[lifting]||false> && ( <context.location.material.is_solid||false> && <context.location.above.material.name||none> == air ) || ( <context.item.script.name> == water_bomb_item && ( <context.location.above.is_liquid> || <context.location.above.material.waterlogged||false> || <context.location.material.name.contains_any_text[kelp|kelp_plant|seagrass|tall_seagrass]> ) ):
        - if <player.gamemode> != CREATIVE:
          - take item:bomb_item quantity:1 from:<player.inventory>
        - spawn bomb_entity <context.location.center> save:bomb
        - wait 1t
        - if <context.item.script.name> == water_bomb_item:
          - flag <entry[bomb].spawned_entity> water_bomb
        - teleport <entry[bomb].spawned_entity> <entry[bomb].spawned_entity.location.add[0,1,0]>
        - define spawned_bomb <entry[bomb].spawned_entity>
        - flag <[spawned_bomb]> model_data:100
        - adjust <[spawned_bomb]> equipment:air|air|air|bomb_item_model[custom_model_data=<[spawned_bomb].flag[model_data]||100>]
        - adjust <[spawned_bomb]> item_in_hand:air
        - flag <[spawned_bomb]> spawned_by:<player>
        - flag <[spawned_bomb]> liftable
        # should this be enabled, or just cancelled for water bombs?
        #- run onland def:<entry[bomb].spawned_entity>
      - else:
        - flag <player> lifting:!
        - if <player.gamemode> != CREATIVE:
            - take item:bomb_item quantity:1 from:<player.inventory>
        - spawn bomb_entity <player.location.center> save:bomb
        - if <context.item.script.name> == water_bomb_item:
          - flag <entry[bomb].spawned_entity> water_bomb
        - define spawned_bomb <entry[bomb].spawned_entity>
        - flag <[spawned_bomb]> model_data:100
        - mount <[spawned_bomb]>|<player> <player.location>
        - adjust <[spawned_bomb]> equipment:air|air|air|air
        - adjust <[spawned_bomb]> item_in_hand:bomb_item_model[custom_model_data=<[spawned_bomb].flag[model_data]||100>]
        - flag <[spawned_bomb]> liftable:!
        - flag <player> lifting:<[spawned_bomb]>
        - flag <[spawned_bomb]> spawned_by:<player>
        - flag <[spawned_bomb]> player_lifting:<player>
        - actionbar targets:<player> "<blue>You pulled out a bomb, right click to throw it!"
      - if <context.item.lore.contains[NoFuse]||false>:
        - stop
      - run prime d:<[spawned_bomb]>|<player>|8s instantly

    after player right clicks bomb_entity bukkit_priority:lowest:
      - ratelimit <player> 0.5s
      - if <player.has_flag[custom_entity_cooldown]>:
        - stop
      - if <player.flag[lifting]||false> == <context.entity> && <context.entity.flag[player_lifting]||false> == <player>:
        - determine passively cancelled
        - flag <context.entity> mount_cancel
        - mount cancel <context.entity>
        - flag <context.entity> liftable
        - wait 1t
        # change to a vector non relient on player targeting block
        #- announce "<player.is_sneaking> && ( <player.cursor_on[5].material.is_solid||false> && <player.cursor_on[5].above.material.name||none> == air ) || ( <context.entity.has_flag[water_bomb]> && ( <player.cursor_on[5].above.is_liquid> || <player.cursor_on[5].above.material.waterlogged||false> || <player.cursor_on[5].above.material.contains_any[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]> ) )"
        - if <player.is_sneaking> && ( <player.cursor_on[5].material.is_solid||false> && <player.cursor_on[5].above.material.name||none> == air ) || ( <context.entity.has_flag[water_bomb]> && ( <player.cursor_on[5].above.is_liquid> || <player.cursor_on[5].above.material.waterlogged||false> || <player.cursor_on[5].above.material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]> ) ):
          - teleport <context.entity> <player.cursor_on.add[0,1,0].center||player.location.forward>
          - adjust <context.entity> equipment:air|air|air|bomb_item_model[custom_model_data=<context.entity.flag[model_data]||100>]
          - adjust <context.entity> item_in_hand:air
          - wait 5t
          # should this be removed?? or just not triggered for water bombs
          #- run onland def:<context.entity>
        - else:
          - adjust <context.entity> equipment:air|air|air|bomb_item_model[custom_model_data=<context.entity.flag[model_data]||100>]
          - adjust <context.entity> item_in_hand:air
          - if <context.entity.has_flag[water_bomb]> && ( <player.eye_location.is_liquid> || <player.eye_location.material.waterlogged||false> || <player.eye_location.material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]> ):
            - push <context.entity> origin:<player> destination:<player.cursor_on||<player.location.forward[10]>> speed:0.4 script:onland def:<context.entity>
          - else:
            - shoot <context.entity> origin:<player> destination:<player.cursor_on.above[5]||<player.location.forward[10].above[5]>> speed:0.8 height:3 script:onland def:<context.entity>
        - flag <player> lifting:!
        - flag <context.entity> player_lifting:!
        - flag <player> bombcooldown duration:0.2s
      - else if <player.has_flag[lifting]||false> || <player.has_passenger>:
        - actionbar targets:<player> "You are already lifting something!"
        - stop
      - else:
        - if <context.entity.has_flag[liftable]> && !<context.entity.has_flag[player_lifting]>:
          - if <context.item.material.name.contains_any[bow|trident|fishing_rod]>:
            - determine passively cancelled
          - flag <context.entity> liftable:!
          - wait 2t
          - mount <context.entity>|<player> <player.location>
          - adjust <context.entity> equipment:air|air|air|air
          - adjust <context.entity> item_in_hand:bomb_item_model[custom_model_data=<context.entity.flag[model_data]||100>]
          - flag <player> lifting:<context.entity>
          - flag <context.entity> player_lifting:<player>
          - actionbar targets:<player> "<blue>You picked up a bomb, right click to throw it!"

    on bomb_entity damaged ignorecancelled:true:
      - if <context.entity.has_flag[exploded]>:
        - determine passively cancelled
        - stop
      - determine passively cancelled
      - if <context.entity> == <context.damager.flag[lifting]||false>:
        - stop
      - if <context.projectile.is_spawned||false>:
        - remove <context.projectile>
      - if !<list[fall|suffocation].contains[<context.cause>]>:
        - if <context.entity.has_flag[NoDmg]> || <context.entity.flag[blocked_damage].contains[<context.cause>]||false>:
          - stop
        - else:
          - run bomb_explode instantly def:<context.entity>
    on vehicle collides with bomb_entity:
      - if <context.vehicle.has_flag[bomb_can_ride]||false> && !<context.entity.has_passenger>:
        - determine passively cancelled
        - mount <context.entity>|<context.vehicle>
    on dropped_item damaged by bomb_entity:
      - determine cancelled
    on armor_stand damaged by bomb_entity:
      - if !<context.entity.has_flag[damaged_by_bomb]> && !<context.entity.has_flag[bomb_entity]>:
          - determine cancelled

    # dispensers don't shoot heads :(
    # on block dispenses item:
    #     - announce hi
    #     - spawn bomb_entity <context.location.center> save:bomb
    #     #- adjust <entry[bomb].spawned_entity> gravity:false
    #     - wait 1t
    #     - teleport <entry[bomb].spawned_entity> <entry[bomb].spawned_entity.location.add[0,0.5,0]>
    #     - define spawned_bomb <entry[bomb].spawned_entity>
    #     - flag <[spawned_bomb]> spawned_by:<context.location.material>
    #     - run onland def:<entry[bomb].spawned_entity>

    on player quits:
      - if <player.has_flag[lifting]>:
        - define bomb <player.flag[lifting]>
        - flag <[bomb]> mount_cancel
        - mount cancel <[bomb]>
        - flag <player> lifting:!
        - flag <[bomb]> player_lifting:!
        - flag <[bomb]> NoDmg:!
        - flag <[bomb]> liftable:!
        - flag <[bomb]> explode_time:!
        - remove <[bomb]>
    on player teleports:
      - if <player.has_flag[lifting]>:
        - determine passively cancelled
        - define bomb <player.flag[lifting]>
        - flag <[bomb]> mount_cancel
        - mount cancel <[bomb]>
        - flag <player> lifting:!
        - flag <[bomb]> player_lifting:!
        - flag <[bomb]> NoDmg:!
        - flag <[bomb]> liftable:!
        - flag <[bomb]> explode_time:!
        - remove <[bomb]>
        - wait 2t
        - teleport <player> <context.destination>
    on home|warp|tp|tpa|tpo command:
      - if <player.has_flag[lifting]>:
        - determine passively cancelled
        - define bomb <player.flag[lifting]>
        - flag <[bomb]> mount_cancel
        - mount cancel <[bomb]>
        - flag <player> lifting:!
        - flag <[bomb]> player_lifting:!
        - flag <[bomb]> NoDmg:!
        - flag <[bomb]> liftable:!
        - flag <[bomb]> explode_time:!
        - remove <[bomb]>
    on player dies by:bomb_entity priority:0:
      - define owner <context.damager.flag[spawned_by].name||someone>
      - if <[owner]> == <player.name>:
        - determine "<player.name> was blown up by their own bomb..."
      - else:
        - determine "<player.name> was blown up by <[owner]>'s bomb!"
    on bomb_entity breaks hanging:
      - if <context.hanging.has_flag[bomb_trigger]>:
        - stop
      - determine cancelled
    on bomb_entity enters portal:
      - determine cancelled

prime:
  type: task
  debug: false
  script:
    - define explode_time <util.time_now.add[<[3].as[duration]>].if_null[<util.time_now.add[8s]>]>
    - define bomb_entity <[1]>
    - run fuse_sfx def:<[bomb_entity]>|<[explode_time].from_now.in_seconds>
    - adjust <[bomb_entity]> custom_name:<[3].as[duration]>
    - adjust <[bomb_entity]> custom_name_visible:true
    - define prime_start_time <util.time_now>
    - define flashing 0
    - while <[bomb_entity].is_spawned> && <util.time_now.is_before[<[explode_time].sub[1s]>]>:
      - adjust <[bomb_entity]> custom_name:<[3].as[duration].sub[<util.time_now.duration_since[<[prime_start_time]>]>].formatted.before[.].before[s]>
      - if <[bomb_entity].has_flag[player_lifting]>:
        - title targets:<[bomb_entity].flag[player_lifting]> "subtitle:<red>Bomb exploding in: <[3].as[duration].sub[<util.time_now.duration_since[<[prime_start_time]>]>].formatted.before[.].before[s]> seconds" stay:8t fade_in:0t fade_out:0t
      - playeffect <[1].location.add[0,0.2,0]> effect:smoke visibility:20 quantity:10 offset:0.05,0.3,0.05
      - if !<[bomb_entity].has_flag[water_bomb]> && ( ( <[bomb_entity].location.is_liquid> && <[bomb_entity].location.material.name> != bubble_column ) || <[bomb_entity].location.material.waterlogged||false> || <[bomb_entity].location.material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]> ):
        - adjust <[bomb_entity]> velocity:<[bomb_entity].velocity.x>,0.04,<[bomb_entity].velocity.z>
      - if !<util.time_now.is_before[<[explode_time].sub[2s]>]> && <[flashing]> < 2:
        - flag <[bomb_entity]> model_data:300
        - if <[bomb_entity].item_in_hand.material.name> == clay_ball:
          - adjust <[bomb_entity]> item_in_hand:bomb_item_model[custom_model_data=<[bomb_entity].flag[model_data]||100>]
          - adjust <[bomb_entity]> equipment:air|air|air|air
        - else:
          - adjust <[bomb_entity]> equipment:air|air|air|bomb_item_model[custom_model_data=<[bomb_entity].flag[model_data]||100>]
          - adjust <[bomb_entity]> item_in_hand:air
        - define flashing 2
      - else if !<util.time_now.is_before[<[explode_time].sub[5s]>]> && <[flashing]> < 1:
        - flag <[bomb_entity]> model_data:200
        - if <[bomb_entity].item_in_hand.material.name> == clay_ball:
          - adjust <[bomb_entity]> item_in_hand:bomb_item_model[custom_model_data=<[bomb_entity].flag[model_data]||100>]
          - adjust <[bomb_entity]> equipment:air|air|air|air
        - else:
          - adjust <[bomb_entity]> equipment:air|air|air|bomb_item_model[custom_model_data=<[bomb_entity].flag[model_data]||100>]
          - adjust <[bomb_entity]> item_in_hand:air
        - define flashing 1
      - wait 5t
    - if <[1].is_spawned||false>:
      - run bomb_explode instantly def:<[1]>

onland:
  type: task
  debug: false
  definitions: bomb
  script:
    #- announce <[location].material>
    - if <[bomb].has_flag[water_bomb]>:
      - while <[bomb].is_spawned||false> && ( <[bomb].location.is_liquid||false> || <[bomb].location.material.waterlogged||false> || <[bomb].location.material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]||false> ):
        - if <[bomb].location.forward.material.is_solid>:
          - run bomb_explode instantly def:<[bomb]>
          - stop
        - push <[bomb]> origin:<[bomb].location> destination:<[bomb].location.forward[2]> speed:0.4
        - wait 2t
    # this does nothing..
    - if <context.item.lore.contains[NoFuse]||false>:
      - if <[1].location.is_liquid||false> || <[1].location.material.waterlogged||false> || <[1].location.material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]||false>:
        #- adjust <[1]> armor_pose:head|3.15,0,0
        - wait 1s
        - while ( <[1].location.is_liquid> || <[1].location.material.waterlogged||false> || <[1].location.material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]> ) && <[1].is_spawned||false>:
          - adjust <[1]> velocity:<[1].velocity.x>,0.08,<[1].velocity.z>
          - wait 6t
      # - else:
      #     - adjust <[1]> armor_pose:head|3.15,0,0

bomb_explode:
  type: task
  debug: false
  script:
    - define loc <[1].location>
    - define bomb <[1]>
    - flag <[bomb]> exploded
    - if <[bomb].has_flag[player_lifting]>:
      - flag <[bomb].flag[player_lifting]> lifting:!
      - flag <[bomb].flag[player_lifting]> bombcooldown duration:0.2s
    - if ( <[loc].is_liquid> || <[loc].material.waterlogged||false> || <[loc].material.name.contains_any_text[<list[kelp|kelp_plant|seagrass|tall_seagrass]>]> ) && !<[loc].material.name.contains_text[lava]> && !<[bomb].has_flag[water_bomb]>:
      - playeffect <[loc]> effect:bubble quantity:50
      - playeffect <[loc]> effect:smoke quantity:50
      - playsound <[loc]> sound:ambient_underwater_enter pitch:0.5 volume:0.5
    - else:
      - if <[loc].world.name> == s3:
        - explode power:3 <[loc]> source:<[bomb]> breakblocks
      - else:
        - explode power:3 <[loc]> source:<[bomb]>
      - playsound <[loc]> sound:zc_sfx.tp.tp_bomb_blow custom volume:2
      - wait 5t
      - playeffect <[loc]> effect:explode quantity:50
      - hurt 10 <[loc].find_entities.within[5].exclude[bomb_entity]||null> cause:ENTITY_EXPLOSION source:<[bomb]>
      - foreach <[loc].find_entities[ARMOR_STAND|SHULKER].within[5].exclude[<[bomb]>]||<list>>:
        - if <[value].has_flag[bomb_trigger]||false>:
          - define offset <[value].flag[bomb_trigger]>
          - modifyblock <[value].location.add[<[offset]>]> redstone_block
        - if <[value].has_flag[bomb_entity]> && <[value].is_spawned>:
          - hurt <[value]> cause:CUSTOM
          - wait 2t
      - foreach <server.flag[bombable_blocks].shared_contents[<[loc].find_blocks.within[5]||<list>>]||<list>>:
        - if <[value].material.name> != air:
          - modifyblock <[value]> air
          - playeffect <[value]> effect:campfire_cosy_smoke quantity:1 offset:0,0.5,0 data:0.01
      - foreach <server.flag[temp_bombable_blocks].shared_contents[<[loc].find_blocks.within[5]||<list>>]||<list>>:
        - modifyblock <[value]> air
        - playeffect <[value]> effect:campfire_cosy_smoke quantity:1 offset:0,0.5,0 data:0.01
        - flag server temp_bombable_blocks:<-:<[value]>
      - if !<[loc].find_blocks_flagged[crystal_switch_loc].within[5].is_empty>:
        - foreach <[loc].find_blocks_flagged[crystal_switch_loc].within[5]>:
          - run crystal_switch_trigger def:<[value]>|<[value].flag[crystal_switch_loc].escaped>|bomb
    - flag <[bomb]> NoDmg:!
    - flag <[bomb]> liftable:!
    - flag <[bomb]> explode_time:!
    - if <[bomb].is_inside_vehicle||false>:
      - flag <[bomb].vehicle> lifting:!
      - flag <[bomb]> mount_cancel
      - mount cancel <[bomb]>
    - if <[bomb].is_spawned>:
      - remove <[bomb]>

fuse_sfx:
  type: task
  debug: false
  definitions: bomb|fuse
  script:
    - while <[bomb].is_spawned>:
      - playsound <[bomb].location> sound:zc_sfx.tp.tp_bomb_fuse_loop custom volume:0.5
      - wait 0.5s

#bomb_entity:
#    type: entity
#    entity_type: e@zombie
#    invulnerable: false
#    custom_name: Bomb
#    age: baby
#    equipment: li@i@air|i@air|i@air|i@player_head[skull_skin=4bf7a3f5-0839-4fe3-a39c-ba6216130a52|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYmM1NjNiOWI1ODI0MDlmNDFmMGUwNzgxYTk4M2FmZTNkOGZlMmZiZjM4M2M1M2E1ZDI3NDMxNTU1NjRkNjgifX19]|i@air
#    custom_name_visible: false
#    has_ai: true
#    silent: true
#    hide_from_players: true
#    speed: 0

bomb_entity:
  debug: false
  type: entity
  entity_type: armor_stand
  mechanisms:
    invulnerable: false
    custom_name: Bomb
    is_small: true
    equipment: air|air|air|air|air
    item_in_hand: <item[bomb_item_model]>
    visible: false
    disabled_slots: HEAD|CHEST|LEGS|FEET|HAND/ALL|HAND/REMOVE
  # flags:
  #     Custom_Entity: Bomb_Entity
