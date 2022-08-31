has_saddle:
  type: procedure
  debug: false
  definitions: entity
  script:
    - determine <[entity].inventory.slot[1].material.name.is[==].to[saddle]||false>

setup_horse:
  type: task
  debug: false
  script:
    - if !<player.vehicle.has_flag[original_speed]>:
      - flag <player.vehicle> original_speed:<player.vehicle.speed>
    - if !<player.vehicle.has_flag[total_boosts]>:
      - define r1 <util.random.int[2].to[6]>
      - define r2 <util.random.int[4].to[6]>
      - flag <player.vehicle> total_boosts:<[r1].min[<[r2]>]>
    - if !<player.vehicle.has_flag[curr_boosts]>:
      - flag <player.vehicle> curr_boosts:<player.vehicle.flag[total_boosts]>
    - adjust <player.vehicle> speed:<player.vehicle.flag[original_speed]>
    - flag <player> last_loc:<player.location>
    - wait 1t
    - run looping_horse_carrots

horse_events:
  type: world
  debug: false
  events:
    after player enters *horse:
      - if <player.vehicle.is_tamed||false>:
        - if <player.vehicle.proc[has_saddle]> || <player.vehicle.has_flag[original_speed]>:
          - inject setup_horse
    on player left clicks block:
      - if !<player.is_inside_vehicle> || <player.vehicle.entity_type||null> not in horse|skeleton_horse|zombie_horse:
        - stop
      - if !<player.has_flag[moving]>:
        - stop
      - if !<player.vehicle.has_flag[original_speed]>:
        - stop
      - if <player.vehicle.flag[curr_boosts]> <= 0:
        - stop
      - if !<player.vehicle.proc[has_saddle]>:
        - stop
      - ratelimit <player> 15t
      - define horse <player.vehicle>
      - flag <[horse]> curr_boosts:--
      - if <[horse].flag[curr_boosts]> <= 0:
        - flag <[horse]> boost_cooldown expire:5s
      - else:
        - flag <[horse]> boost_cooldown expire:50t
      - define gallop_uuid <util.random_uuid>
      - flag <player> gallop_uuid:<[gallop_uuid]> expire:45t
      - adjust <[horse]> speed:<[horse].flag[original_speed].mul[1.8]>
      - playsound <player> sound:zc_sfx.botw.link_gallop custom pitch:1 volume:1
      - playsound <player> sound:BLOCK_NOTE_BLOCK_BIT pitch:1 volume:0.5
      - repeat 20:
        - if <player.is_online> && <player.has_flag[moving]>:
          - playeffect effect:snowflake at:<player.eye_location.forward_flat[7]>
        - wait 2t
      - if <player.flag[gallop_uuid]||null> == <[gallop_uuid]> && <[horse].is_spawned>:
        - adjust <[horse]> speed:<[horse].flag[original_speed]>
    on player quits:
      - if <player.is_inside_vehicle.if_null[false]> && <player.vehicle.has_flag[original_speed]>:
        - adjust <player.vehicle> speed:<player.vehicle.flag[original_speed]>
    after player clicks in inventory:
      - if <player.is_inside_vehicle> && <player.vehicle.is_tamed||false> && <player.vehicle.proc[has_saddle]> && !<player.vehicle.has_flag[original_speed]||true>:
        - inject setup_horse


looping_horse_carrots:
  type: task
  debug: false
  script:
    - repeat 1000:
      - if !<player.is_online>:
        - stop
      - if !<player.is_inside_vehicle> || <player.vehicle.entity_type||null> not in horse|skeleton_horse|zombie_horse:
        - title subtitle:<empty>
        - actionbar <empty>
        - flag <player> last_loc:!
        - stop
      - if <player.flag[last_loc].x.round_down> != <player.location.x.round_down> || <player.flag[last_loc].z.round_down> != <player.location.z.round_down>:
        - flag <player> moving expire:5t
      - flag <player> last_loc:<player.location>
      - if <player.vehicle.entity_type> == horse:
        - define char <&chr[1000].font[icons]>
      - else if <player.vehicle.entity_type> == skeleton_horse:
        - define char <&chr[1001].font[icons]>
      - else:
        - define char <&chr[1002].font[icons]>
      - define total_boosts <player.vehicle.flag[total_boosts]>
      - define curr_boosts <player.vehicle.flag[curr_boosts]>
      - define msg <list.pad_right[<[curr_boosts]>].with[<[char]>]>
      - define msg <[msg].pad_right[<[total_boosts]>].with[<&color[#404040]><[char]>]>
      - title "subtitle:<[msg].separated_by[  ]>" fade_in:0s
      - actionbar "<&chr[0002].font[icons]> Sneak to dismount <&chr[0004].font[icons]> Left Click to gallop"
      # Boost restores
      - if <[curr_boosts]> < <[total_boosts]>:
        - if !<player.vehicle.has_flag[boost_cooldown]>:
          - flag <player.vehicle> curr_boosts:++
          - flag <player.vehicle> boost_cooldown expire:10t
          - playsound <player> sound:BLOCK_NOTE_BLOCK_BIT pitch:2 volume:0.5
      - wait 2t
    - run looping_horse_carrots
