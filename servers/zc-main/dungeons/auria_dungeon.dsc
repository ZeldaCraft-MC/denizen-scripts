dungeon_chunk_reset:
  type: task
  debug: false
  script:
    - foreach <cuboid[auria_dungeon].chunks> as:chunk:
      - adjust <[chunk]> load
      - wait 2t
      - if <[loop_index].mod[10]> <= 0:
        - wait 1s
        - announce "<[loop_index]>/<cuboid[auria_dungeon].chunks.size> loaded!" to_console
    - announce "Loading done!" to_console
    - foreach <cuboid[auria_dungeon].chunks> as:chunk:
      - adjust <[chunk]> unload
      - wait 2t
      - if <[loop_index].mod[10]> <= 0:
        - wait 1s
        - announce "<[loop_index]>/<cuboid[auria_dungeon].chunks.size> unloaded!" to_console

#only run this if you set it up or something massive happened(entities being removed)
#for targets do not use this if the entities still exsist it will just spawn multiple off them. which may confuse people
target_entity_reset:
    type: task
    debug: false
    script:
    - spawn target_e <location[target1.1].center> save:target1
    - spawn target_e <location[target2.1].center> save:target2
    - spawn target_e <location[target3.1].center> save:target3
    - spawn target_e <location[target4.1].center> save:target4
    - spawn target_e <location[target5.1].center> save:target5
    - spawn target_e <location[target6.1].center> save:target6
    - spawn target_e <location[target7.1].center> save:target7
    - flag server entity_target1:<entry[target1].spawned_entity>
    - flag server entity_target2:<entry[target2].spawned_entity>
    - flag server entity_target3:<entry[target3].spawned_entity>
    - flag server entity_target4:<entry[target4].spawned_entity>
    - flag server entity_target5:<entry[target5].spawned_entity>
    - flag server entity_target6:<entry[target6].spawned_entity>
    - flag server entity_target7:<entry[target7].spawned_entity>

#for arms it will remove them automatically and replace them (bc they stop working on server restart)
shadowend_arms_reset:
    type: task
    debug: false
    script:
    - remove <location[shadowendbeam4].find_entities[armor_stand].within[20]>
    - run shadowend_right_arm_reset
    - run shadowend_left_arm_reset

shadowend_right_arm_reset:
    type: task
    debug: false
    script:
    - spawn armor_stand[gravity=false;visible=false] <location[shadowend_right_arm].center> save:center
    - flag server arm_right:<entry[center].spawned_entity>
    - spawn sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi <entry[center].spawned_entity.location> save:obi
    - foreach <entry[obi].spawned_entities>:
        - flag server obi_ent<[loop_index]>:<[value]>
    - spawn sblackwool|sblackwool|sblackwool|sblackwool <entry[center].spawned_entity.location> save:blwool
    - foreach <entry[blwool].spawned_entities>:
        - flag server blwool_ent<[loop_index]>:<[value]>
    - attach <server.flag[obi_ent1]> to:<entry[center].spawned_entity> offset:0.62,0,0
    - attach <server.flag[obi_ent2]> to:<entry[center].spawned_entity> offset:0,0,0.62
    - attach <server.flag[obi_ent3]> to:<entry[center].spawned_entity> offset:-0.62,0,0
    - attach <server.flag[obi_ent4]> to:<entry[center].spawned_entity> offset:0,0,-0.62
    - attach <server.flag[obi_ent5]> to:<entry[center].spawned_entity> offset:0,0.62,
    - attach <server.flag[obi_ent6]> to:<entry[center].spawned_entity> offset:0,-0.62,0
    - attach <server.flag[obi_ent7]> to:<entry[center].spawned_entity> offset:0,0,0
    - attach <server.flag[obi_ent8]> to:<entry[center].spawned_entity> offset:1.24,0.62,0
    - attach <server.flag[obi_ent9]> to:<entry[center].spawned_entity> offset:-1.86,0.62,0
    - attach <server.flag[blwool_ent1]> to:<entry[center].spawned_entity> offset:1.24,0,0
    - attach <server.flag[blwool_ent2]> to:<entry[center].spawned_entity> offset:1.86,0.62,0
    - attach <server.flag[blwool_ent3]> to:<entry[center].spawned_entity> offset:-1.24,0.62,0
    - attach <server.flag[blwool_ent4]> to:<entry[center].spawned_entity> offset:-1.24,0,0

shadowend_left_arm_reset:
    type: task
    debug: false
    script:
    - spawn armor_stand[gravity=false;visible=false] <location[shadowend_left_arm].center> save:center
    - flag server arm_left:<entry[center].spawned_entity>
    - spawn sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi|sobi <entry[center].spawned_entity.location> save:obi
    - foreach <entry[obi].spawned_entities>:
        - flag server obi_ent<[loop_index]>:<[value]>
    - spawn sblackwool|sblackwool|sblackwool|sblackwool <entry[center].spawned_entity.location> save:blwool
    - foreach <entry[blwool].spawned_entities>:
        - flag server blwool_ent<[loop_index]>:<[value]>
    - attach <server.flag[obi_ent1]> to:<entry[center].spawned_entity> offset:0.62,0,0
    - attach <server.flag[obi_ent2]> to:<entry[center].spawned_entity> offset:0,0,0.62
    - attach <server.flag[obi_ent3]> to:<entry[center].spawned_entity> offset:-0.62,0,0
    - attach <server.flag[obi_ent4]> to:<entry[center].spawned_entity> offset:0,0,-0.62
    - attach <server.flag[obi_ent5]> to:<entry[center].spawned_entity> offset:0,0.62,
    - attach <server.flag[obi_ent6]> to:<entry[center].spawned_entity> offset:0,-0.62,0
    - attach <server.flag[obi_ent7]> to:<entry[center].spawned_entity> offset:0,0,0
    - attach <server.flag[obi_ent8]> to:<entry[center].spawned_entity> offset:1.24,0.62,0
    - attach <server.flag[obi_ent9]> to:<entry[center].spawned_entity> offset:-1.86,0.62,0
    - attach <server.flag[blwool_ent1]> to:<entry[center].spawned_entity> offset:1.24,0,0
    - attach <server.flag[blwool_ent2]> to:<entry[center].spawned_entity> offset:1.86,0.62,0
    - attach <server.flag[blwool_ent3]> to:<entry[center].spawned_entity> offset:-1.24,0.62,0
    - attach <server.flag[blwool_ent4]> to:<entry[center].spawned_entity> offset:-1.24,0,0

#for fake pushable blocks do not use this if the entities still exist. will break puzzles completely
fake_pb_reset:
    type: task
    debug: false
    script:
    - spawn fake_pb[color=brown] <location[fake_pb1]>
    - spawn fake_pb[color=brown] <location[fake_pb2]>
    - spawn fake_pb[color=black] <location[fake_pb3]>
    - spawn fake_pb[color=black] <location[fake_pb4]>
    - spawn fake_pb[color=black] <location[fake_pb5]>
    - spawn fake_pb[color=light_gray] <location[fake_pb6]>
    - spawn fake_pb[color=light_gray] <location[fake_pb7]>
    - spawn fake_pb[color=light_gray] <location[fake_pb8]>
    - spawn fake_pb[color=gray] <location[fake_pb9]>
    - spawn fake_pb[color=gray] <location[fake_pb10]>
    - spawn fake_pb[color=gray] <location[fake_pb11]>

#for pb_reset it will remove them automatically and replace them (for an easy reset)
pb_reset:
    type: task
    debug: false
    script:
        - remove <location[pb_loc1].find_entities[shulker].within[17]>
        - remove <location[pb_loc1].find_entities[armor_stand].within[17]>
        - spawn pushable_block[color=BLACK;shulker_peek=0] <location[pb_loc1]> save:block
        - spawn armor_stand[visible=false;is_small=true] <entry[block].spawned_entities.get[1].location||null> save:stand
        - flag <entry[block].spawned_entities.get[1]||null> link:<entry[stand].spawned_entities.get[1]||null>
        - flag <entry[stand].spawned_entities.get[1]||null> link:<entry[block].spawned_entities.get[1]||null>
        - wait 1t
        - adjust <entry[stand].spawned_entities.get[1]||null> gravity:false
        - spawn pushable_block[color=BLACK;shulker_peek=0] <location[pb_loc2]> save:block1
        - spawn armor_stand[visible=false;is_small=true] <entry[block1].spawned_entities.get[1].location||null> save:stand1
        - flag <entry[block1].spawned_entities.get[1]||null> link:<entry[stand1].spawned_entities.get[1]||null>
        - flag <entry[stand1].spawned_entities.get[1]||null> link:<entry[block1].spawned_entities.get[1]||null>
        - wait 1t
        - adjust <entry[stand].spawned_entities.get[1]||null> gravity:false

#general brain
#items and formats
info_text:
    type: format
    debug: false
    format: <&7>[<&a>#<&7>]<&f> <[text]> <&7>[<&a>#<&7>]<&f>

shadowend:
    type: format
    debug: false
    format: <&f><&l>S<&color[#E5CCFF]><&l>h<&color[#CC99FF]><&l>a<&color[#B266FF]><&l>d<&color[#9933FF]><&l>o<&color[#7F00FF]><&l>w<&color[#6600CC]><&l>e<&color[#4C0099]><&l>n<&color[#330066]><&l>d <&color[#330066]><&l><&gt><&gt><&f> <[text]> <&color[#330066]><&l><&lt><&lt>

#first area (target and island)
island_world:
    type: world
    debug: false
    events:
        on player clicks potted_bamboo in:magic_island:
        - determine cancelled
        #on player enters auria_dungeon:
        #- adjust <player> resource_pack:https://www.planetminecraft.com/texture-pack/auria-dungeon/download/file/13393085
        on target_e damaged:
        - if <context.cause> != projectile:
            - determine cancelled
        - else:
            - determine passively cancelled
            - remove <context.projectile>
            - if <context.damager.type> == player:
                - if <context.damager.flag[target].contains[<context.entity>]||false>:
                    - stop
                - flag <context.damager> target:->:<context.entity>
                - adjust <context.damager> hide_entity:<context.entity>
                - actionbar "<context.damager.flag[target].size>/7 <&c>Targets<&f> hit"
        - if <context.damager.flag[target].size> == 7:
            - playsound <context.damager> sound:ui_toast_challenge_complete pitch:100
            - showfake cancel <location[stone_water_door]>|<location[stone_water_door].add[0,1,0]> players:<player>
            - narrate "A door has opened in the fountain" format:info_text targets:<context.damager>
            - narrate "Take a look before it closes" format:info_text targets:<context.damager>
            - wait 1m
            - showfake stone <location[stone_water_door]>|<location[stone_water_door].add[0,1,0]> players:<player> d:100h
            - foreach <context.damager.flag[target]>:
                - adjust <context.damager> show_entity:<[value]>
            - flag <context.damager> target:!
        on player clicks campfire with:branch:
        - determine passively cancelled
        - take iteminhand
        - give branch_onfire
        on player clicks smoker with:branch_onfire:
        - if <context.location> == <location[is_steamer]>:
            - determine passively cancelled
            - take iteminhand
            - adjustblock <location[is_steamer]> lit:true
            - playsound <player> sound:item_firecharge_use pitch:0.7
            - flag player steamer_lit
            - wait 10s
            - adjustblock <location[is_steamer]> lit:false
        on player enters target_practice:
        - flag player target_practice
        - showfake stone <location[stone_water_door]>|<location[stone_water_door].add[0,1,0]> players:<player> d:100h
        - title "title:<&5>Auria <&color[#FFE5CC]>T<&color[#FFCC99]>a<&color[#FFB266]>r<&color[#FF9933]>g<&color[#FF8000]>e<&color[#CC6600]>t<&color[#994C00]>s" "subtitle:only the best archer can continue" targets:<player>
        on player exits target_practice:
        - flag player target_practice:!
        on player enters magic_island:
        - title "title:<&5>Auria <&color[#CCFFFF]>I<&color[#99FFFF]>s<&color[#66FFFF]>l<&color[#33FFFF]>a<&color[#00FFFF]>n<&color[#00CCCC]>d" "subtitle:only the smart can continue" targets:<player>
        on player right clicks black_shulker_box in:magic_island:
        - determine passively cancelled
        - if <context.location> == <location[is_branchbox]>:
            - if <player.inventory.contains_item[branch]>:
                - stop
            - if <player.inventory.contains_item[branch_onfire]>:
                - stop
            - if <player.has_flag[steamer_lit]>:
                - stop
            - inventory open d:generic[size=9;title=<&d>Branch<&sp><&f>Box;contents=branch]
        on system time secondly every:5:
        - if <server.online_players.is_empty>:
            - stop
        - if !<server.online_players.parse[has_flag[target_practice]].contains_any_text[true]>:
            - stop
        - repeat 7:
          - if <server.flag[entity_target<[value]>].is_truthy>:
            - teleport <server.flag[entity_target<[value]>]> <location[<list[target<[value]>.1|target<[value]>.2|target<[value]>.3].random>].center>
        on player enters hottub:
        - if <player.has_flag[steamer_lit]>:
            - flag player steamer_lit:!
            - playsound <player> sound:ui_toast_challenge_complete pitch:100
            - cast speed amplifier:-6 duration:10 no_ambient hide_particles no_icon
            - cast jump amplifier:-6 duration:10 no_ambient hide_particles no_icon
            - cast blindness amplifier:5 duration:10 no_ambient hide_particles no_icon
            - wait 1s
            - cast confusion amplifier:5 duration:9 no_ambient hide_particles no_icon
            - wait 7s
            - teleport <player> <location[shadowend_spawn]>
            - wait 2s
        - else:
            - narrate "Nothing seems to happen" format:info_text

#shadowend boss battle
shadowend_world:
    type: world
    debug: false
    events:
        on player enters shadowend:
        - if <server.has_flag[boss_restore]>:
            - narrate "wait <&b><server.flag_expiration[boss_restore].from_now.in_seconds><&f>s until you can enter again" format:info_text
            - wait 1t
            - teleport <player> <location[shadowend_spawn]>
            - stop
        - if <server.has_flag[shadowendfight]>:
            - narrate "A fight is already going on, wait until it is finished" format:info_text
            - wait 1t
            - teleport <player> <location[shadowend_spawn]>
            - stop
        - ratelimit player 1s
        - run shadowend_arms_reset
        - flag server shadowendfight:!
        - flag server lasertarget:!
        - flag server shadowend_hit:!
        - flag server shadow_attack:!
        - title "title:<&5>Auria <&f>S<&color[#E5CCFF]>h<&color[#CC99FF]>a<&color[#B266FF]>d<&color[#9933FF]>o<&color[#7F00FF]>w<&color[#6600CC]>e<&color[#4C0099]>n<&color[#330066]>d" "subtitle:you can't hide nor run." targets:<player>
        - flag server shadowendfight:<player>
        - run shadowend_quotes
        - wait 2s
        - if !<server.current_bossbars.contains[shadowend]>:
            - bossbar Shadowend players:<player> "title:<&5>Auria <&f>S<&color[#E5CCFF]>h<&color[#CC99FF]>a<&color[#B266FF]>d<&color[#9933FF]>o<&color[#7F00FF]>w<&color[#6600CC]>e<&color[#4C0099]>n<&color[#330066]>d" color:purple style:segmented_6 progress:1
        - wait 3s
        - run shadowend_attack
        - wait 2s
        - playsound <player> sound:minecraft:music.vaati custom
        on player exits shadowend:
        - if <server.flag[shadowendfight]||null> != <player>:
            - stop
        - if <server.current_bossbars.contains[shadowend]>:
            - bossbar remove shadowend
        - adjust <player> stop_sound
        - flag server boss_restore duration:10s
        - flag server shadowendfight:!
        - flag server lasertarget:!
        - flag server shadow_hit:!
        - flag server shadowend_hit:!
        - flag server shadow_attack:!
        - remove <location[shadowendbeam4].find_entities[shulker].within[20]>
        on player dies in:shadowend:
        - determine passively cancelled
        - teleport <player> <location[shadowend_spawn]>
        - cast blindness amplifier:5 duration:5 no_ambient hide_particles no_icon
        - cast speed amplifier:-6 duration:5 no_icon no_ambient hide_particles
        - cast jump amplifier:-6 duration:5 no_ambient no_icon hide_particles
        - title "title:<&4><&l>You Died" stay:5s targets:<player>
        after player steps on black_concrete in:shadowend:
        - teleport <player> <location[shadowend_spawn]>
        - cast blindness amplifier:5 duration:5 no_ambient hide_particles no_icon
        - cast speed amplifier:-6 duration:5 no_icon no_ambient hide_particles
        - cast jump amplifier:-6 duration:5 no_ambient no_icon hide_particles
        - title "title:<&4><&l>You Died" stay:5s targets:<player>
        on player steps on purple_stained_glass in:shadowend:
        - teleport <player> <location[shadowend_spawn]>
        - cast blindness amplifier:5 duration:5 no_ambient hide_particles no_icon
        - cast speed amplifier:-6 duration:5 no_icon no_ambient hide_particles
        - cast jump amplifier:-6 duration:5 no_ambient no_icon hide_particles
        - title "title:<&4><&l>You Died" stay:5s targets:<player>
        on player damages shadoweye:
        - flag server shadowend_hit
        - flag server shadow_hit:++
        - random:
            - narrate "That left barely a scratch!" format:shadowend targets:<server.flag[shadowendfight]||null>
            - narrate "You think 1 arrow can stop me?" format:shadowend targets:<server.flag[shadowendfight]||null>
            - narrate "This playtime is getting less fun by the minute" format:shadowend targets:<server.flag[shadowendfight]||null>
        - if <server.flag[shadow_hit]> == 3:
            - run shadowend_dies
            - stop
        - narrate "that seemed to hurt it. keep on going" format:info_text targets:<server.flag[shadowendfight]||null>
        - wait 2s
        - run shadowend_attack

shadowend_dies:
    type: task
    debug: false
    script:
    - bossbar update Shadowend progress:0
    - wait 4s
    - bossbar update Shadowend "title:<&5>Auria <&f>$<&color[#E5CCFF]>#<&color[#CC99FF]>@<&color[#B266FF]>d<&color[#9933FF]>o<&color[#7F00FF]>w<&color[#6600CC]>e<&color[#4C0099]>n<&color[#330066]>d"
    - playeffect effect:smoke_large at:<location[shadowendbeam4]> quantity:200 offset:10,10,10 visibility:25
    - wait 10t
    - bossbar update Shadowend "title:<&5>Auria <&f>$<&color[#E5CCFF]>#<&color[#CC99FF]>r<&color[#B266FF]>d<&color[#9933FF]>t<&color[#7F00FF]>w<&color[#6600CC]>0<&color[#4C0099]>n<&color[#330066]>d"
    - playeffect effect:smoke_large at:<location[shadowendbeam4]> quantity:200 offset:10,10,10 visibility:25
    - wait 10t
    - bossbar update Shadowend "title:<&5>Auria <&f>+<&color[#E5CCFF]>-<&color[#CC99FF]>@<&color[#B266FF]>b<&color[#9933FF]>o<&color[#7F00FF]>f<&color[#6600CC]>e<&color[#4C0099]>6<&color[#330066]>d"
    - playeffect effect:smoke_large at:<location[shadowendbeam4]> quantity:200 offset:10,10,10 visibility:25
    - wait 10t
    - bossbar update Shadowend "title:<&5>Auria <&f>*<&color[#E5CCFF]>+<&color[#CC99FF]>-<&color[#B266FF]>/<&color[#9933FF]>0<&color[#7F00FF]>2<&color[#6600CC]>5<&color[#4C0099]>7<&color[#330066]>9"
    - playeffect effect:flame at:<location[shadowendbeam4]> quantity:200 offset:10,10,10 visibility:25
    - playsound sound:entity_witch_death <server.flag[shadowendfight]||null> pitch:-7 sound_category:master volume:10
    - wait 20t
    - bossbar update Shadowend "title:<&5>Auria <&f><&k>$<&color[#E5CCFF]><&k>#<&color[#CC99FF]><&k>@<&color[#B266FF]><&k>d<&color[#9933FF]><&k>o<&color[#7F00FF]><&k>w<&color[#6600CC]><&k>e<&color[#4C0099]><&k>n<&color[#330066]><&k>d"
    - playeffect effect:explosion_large at:<location[shadowendbeam4]> quantity:200 offset:5,5,5 visibility:25
    - playsound <server.flag[shadowendfight]||null> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
    - wait 5t
    - playeffect effect:explosion_large at:<location[shadowendbeam4]> quantity:200 offset:5,5,5 visibility:25
    - playsound <server.flag[shadowendfight]||null> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
    - wait 5t
    - playeffect effect:explosion_large at:<location[shadowendbeam4]> quantity:200 offset:5,5,5 visibility:25
    - playsound <server.flag[shadowendfight]||null> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
    - wait 5t
    - playeffect effect:explosion_large at:<location[shadowendbeam4]> quantity:200 offset:5,5,5 visibility:25
    - playsound <server.flag[shadowendfight]||null> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
    - wait 3t
    - playsound <server.flag[shadowendfight]||null> sound:ui_toast_challenge_complete pitch:100
    - title "title:<&5>Auria <&f>S<&color[#E5CCFF]>h<&color[#CC99FF]>a<&color[#B266FF]>d<&color[#9933FF]>o<&color[#7F00FF]>w<&color[#6600CC]>e<&color[#4C0099]>n<&color[#330066]>d" "subtitle:Defeated! Good Job." targets:<server.flag[shadowendfight]>
    - teleport <server.flag[shadowendfight]||null> <location[dungeon2_spawn]>

shadowend_attack:
    type: task
    debug: false
    script:
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - choose <server.flag[shadow_difficulty]||normal>:
        - case easy:
            - if <server.flag[shadow_hit]||null> == 2:
                - if <server.flag[shadow_attack]||null> == 3:
                    - bossbar update Shadowend progress:0.11
                    - run special_attack
                    - flag server shadow_attack:!
                    - stop
                - random:
                    - run turret_attack
                    - run laser_attack
                    - run arms_attack
                - flag server shadow_attack:++
                - if <server.flag[shadow_attack]||null> == 2:
                    - bossbar update Shadowend progress:0.22
                - if <server.flag[shadow_attack]||null> == 1:
                    - bossbar update Shadowend progress:0.33
                - stop
            - if <server.flag[shadow_hit]||null> == 1:
                - if <server.flag[shadow_attack]||null> == 2:
                    - bossbar update Shadowend progress:0.44
                    - run special_attack
                    - flag server shadow_attack:!
                    - stop
                - random:
                    - run turret_attack
                    - run laser_attack
                    - run arms_attack
                - flag server shadow_attack:++
                - if <server.flag[shadow_attack]||null> == 1:
                    - bossbar update Shadowend progress:0.60
                - stop
            - if <server.flag[shadow_attack]||null> == 1:
                - bossbar update Shadowend progress:0.825
                - run special_attack
                - flag server shadow_attack:!
                - stop
            - random:
                - run turret_attack
                - run laser_attack
                - run arms_attack
            - flag server shadow_attack:++
        - case normal:
            - if <server.flag[shadow_hit]||null> == 2:
                - if <server.flag[shadow_attack]||null> == 4:
                    - bossbar update Shadowend progress:0.0825
                    - run special_attack
                    - flag server shadow_attack:!
                    - stop
                - random:
                    - run turret_attack
                    - run laser_attack
                    - run arms_attack
                - flag server shadow_attack:++
                - if <server.flag[shadow_attack]||null> == 3:
                    - bossbar update Shadowend progress:0.165
                - if <server.flag[shadow_attack]||null> == 2:
                    - bossbar update Shadowend progress:0.2475
                - if <server.flag[shadow_attack]||null> == 1:
                    - bossbar update Shadowend progress:0.33
                - stop
            - if <server.flag[shadow_hit]||null> == 1:
                - if <server.flag[shadow_attack]||null> == 3:
                    - bossbar update Shadowend progress:0.44
                    - run special_attack
                    - flag server shadow_attack:!
                    - stop
                - random:
                    - run turret_attack
                    - run laser_attack
                    - run arms_attack
                - flag server shadow_attack:++
                - if <server.flag[shadow_attack]||null> == 2:
                    - bossbar update Shadowend progress:0.55
                - if <server.flag[shadow_attack]||null> == 1:
                    - bossbar update Shadowend progress:0.66
                - stop
            - if <server.flag[shadow_attack]||null> == 2:
                - bossbar update Shadowend progress:0.825
                - run special_attack
                - flag server shadow_attack:!
                - stop
            - random:
                - run turret_attack
                - run laser_attack
                - run arms_attack
            - flag server shadow_attack:++
            - if <server.flag[shadow_attack]||null> == 1:
                - bossbar update Shadowend progress:0.99
        - case hard:
            - if <server.flag[shadow_hit]||null> == 2:
                - if <server.flag[shadow_attack]||null> == 5:
                    - bossbar update Shadowend progress:0.066
                    - run special_attack
                    - flag server shadow_attack:!
                    - stop
                - random:
                    - run turret_attack
                    - run laser_attack
                    - run arms_attack
                - flag server shadow_attack:++
                - if <server.flag[shadow_attack]||null> == 4:
                    - bossbar update shadowend progress:0.132
                - if <server.flag[shadow_attack]||null> == 3:
                    - bossbar update Shadowend progress:0.198
                - if <server.flag[shadow_attack]||null> == 2:
                    - bossbar update Shadowend progress:0.264
                - if <server.flag[shadow_attack]||null> == 1:
                    - bossbar update Shadowend progress:0.33
                - stop
            - if <server.flag[shadow_hit]||null> == 1:
                - if <server.flag[shadow_attack]||null> == 4:
                    - bossbar update Shadowend progress:0.4125
                    - run special_attack
                    - flag server shadow_attack:!
                    - stop
                - random:
                    - run turret_attack
                    - run laser_attack
                    - run arms_attack
                - flag server shadow_attack:++
                - if <server.flag[shadow_attack]||null> == 3:
                    - bossbar update Shadowend progress:0.495
                - if <server.flag[shadow_attack]||null> == 2:
                    - bossbar update Shadowend progress:0.5775
                - if <server.flag[shadow_attack]||null> == 1:
                    - bossbar update Shadowend progress:0.66
                - stop
            - if <server.flag[shadow_attack]||null> == 3:
                - bossbar update Shadowend progress:0.77
                - run special_attack
                - flag server shadow_attack:!
                - stop
            - random:
                - run turret_attack
                - run laser_attack
                - run arms_attack
            - flag server shadow_attack:++
            - if <server.flag[shadow_attack]||null> == 2:
                - bossbar update Shadowend progress:0.88
            - if <server.flag[shadow_attack]||null> == 1:
                - bossbar update Shadowend progress:0.99

special_attack:
    type: task
    debug: false
    script:
        - run shadowend_quotes
        - spawn shadowbeam <location[shadowendbeam1].center.add[0,0.5,0]> save:shadowbeam1
        - define beam1 <entry[shadowbeam1].spawned_entity>
        - team name:beamcolor add:<[beam1].uuid> color:green
        - wait 2s
        - if !<server.has_flag[shadowendfight]>:
            - remove <[beam1]>
            - stop
        - if <server.has_flag[shadowend_hit]>:
            - flag server shadowend_hit:!
            - remove <[beam1]>
            - stop
        - spawn shadowbeam <location[shadowendbeam2].center.add[0,0.5,0]> save:shadowbeam2
        - define beam2 <entry[shadowbeam2].spawned_entity>
        - team name:beamcolor add:<[beam2].uuid> color:yellow
        - wait 2s
        - if !<server.has_flag[shadowendfight]>:
            - remove <[beam1]>|<[beam2]>
            - stop
        - if <server.has_flag[shadowend_hit]>:
            - flag server shadowend_hit:!
            - remove <[beam1]>|<[beam2]>
            - stop
        - spawn shadowbeam <location[shadowendbeam3].center.add[0,0.5,0]> save:shadowbeam3
        - define beam3 <entry[shadowbeam3].spawned_entity>
        - team name:beamcolor add:<[beam3].uuid> color:gold
        - wait 2s
        - if !<server.has_flag[shadowendfight]>:
            - remove <[beam1]>|<[beam2]>|<[beam3]>
            - stop
        - if <server.has_flag[shadowend_hit]>:
            - flag server shadowend_hit:!
            - remove <[beam1]>|<[beam2]>|<[beam3]>
            - stop
        - spawn shadoweye <location[shadowendbeam4].center.add[0,-0.8,0]> save:shadowbeam4
        - define beam4 <entry[shadowbeam4].spawned_entity>
        - team name:beamcolor add:<[beam4].uuid> color:red
        - wait 2s
        - if !<server.has_flag[shadowendfight]>:
            - remove <[beam1]>|<[beam2]>|<[beam3]>|<[beam4]>
            - stop
        - if <server.has_flag[shadowend_hit]>:
            - flag server shadowend_hit:!
            - remove <[beam1]>|<[beam2]>|<[beam3]>
            - stop
        - team name:beamcolor color:dark_red
        - wait 1s
        - if !<server.has_flag[shadowendfight]>:
            - remove <[beam1]>|<[beam2]>|<[beam3]>|<[beam4]>
            - stop
        - if <server.has_flag[shadowend_hit]>:
            - flag server shadowend_hit:!
            - remove <[beam1]>|<[beam2]>|<[beam3]>
            - stop
        - spawn primed_tnt[explosion_radius=3;fuse_ticks=1] <[beam1].beam_target>
        - playeffect effect:explosion_large at:<[beam1].beam_target> quantity:5
        - playsound <[beam1].beam_target> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
        - spawn primed_tnt[explosion_radius=3;fuse_ticks=1] <[beam2].beam_target>
        - playeffect effect:explosion_large at:<[beam2].beam_target> quantity:5
        - playsound <[beam2].beam_target> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
        - spawn primed_tnt[explosion_radius=3;fuse_ticks=1] <[beam3].beam_target>
        - playeffect effect:explosion_large at:<[beam3].beam_target> quantity:5
        - playsound <[beam3].beam_target> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
        - spawn primed_tnt[explosion_radius=3;fuse_ticks=1] <[beam4].beam_target>
        - playeffect effect:explosion_large at:<[beam4].beam_target> quantity:5
        - playsound <[beam4].beam_target> sound:entity_dragon_fireball_explode  volume:10 pitch:0.7
        - remove <[beam1]>|<[beam2]>|<[beam3]>|<[beam4]>
        - wait 1s
        - run shadowend_attack

shadowend_quotes:
  type: task
  debug: false
  script:
  - random:
    - repeat 1:
      - playsound sound:entity_witch_celebrate <server.flag[shadowendfight]> pitch:-7 sound_category:master volume:10
      - random:
        - narrate "Look at me. Look at me! Look into my eye!<&nl>Good now die!" format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "Experience is the ultimate teacher and an old immortal eye can always see the truth better than mortals ever could." format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "Fool. It does not truly matter about what kind of weapon you're holding.<&nl>What truly makes one powerful is who's holding that weapon." format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "Anyone can kill people, but that would be just too boring" format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "If time healed all wounds we wouldn't have these scares would we?<&nl>No time is but an illusion due to weak mortality" format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "A monster me? Well aren't you jealous.<&nl>I'm sure if you had suffered through at least 1/10th of the suffering I went through you'd be a monster like me." format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "Now let the monster of hate consume you!" format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "Experience is the ultimate teacher and what our eyes see makes us into what we are." format:shadowend targets:<server.flag[shadowendfight]>
        - narrate "WAHAHAHHA. I won't kill you, at least not yet.<&nl>You're too much fun for me" format:shadowend targets:<server.flag[shadowendfight]>
    - stop
    - stop

turret_attack:
    type: task
    debug: false
    script:
    - run shadowend_quotes
    - playeffect effect:redstone special_data:1.2|yellow at:<location[shadowendbeam4].points_between[<location[turret_pos1]>]> quantity:5
    - wait 10t
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - spawn turret_black <location[turret_pos1]>
    - wait 10t
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - playeffect effect:redstone special_data:1.2|lime at:<location[shadowendbeam4].points_between[<location[turret_pos2]>]> quantity:5
    - wait 10t
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - spawn turret_magenta <location[turret_pos2]>
    - wait 10t
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - playeffect effect:redstone special_data:1.2|orange at:<location[shadowendbeam4].points_between[<location[turret_pos3]>]> quantity:5
    - wait 10t
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - spawn turret_purple <location[turret_pos3]>
    - flag server lasertarget
    - wait 1s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - run laser_target
    - wait 20s
    - flag server lasertarget:!
    - run shadowend_attack

laser_attack:
    type: task
    debug: false
    script:
    - run shadowend_quotes
    - flag server lasertarget
    - wait 1s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - run laser_target
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - run shadowend_attack
    - flag server lasertarget:!

arms_attack:
    type: task
    debug: false
    script:
    - run shadowend_quotes
    - define rarm:<location[turret_pos1].add[-1,0,1]>
    - define larm:<location[turret_pos3].add[2,0,2]>
    - define marm:<location[turret_pos2]>
    - playeffect effect:campfire_cosy_smoke at:<[rarm]> velocity:0,0.04,0 quantity:10 offset:2,0.5,2 visibility:25
    - playeffect effect:campfire_cosy_smoke at:<[larm]> velocity:0,0.04,0 quantity:10 offset:2,0.5,2 visibility:25
    - playeffect effect:campfire_cosy_smoke at:<[marm]> velocity:0,0.04,0 quantity:10 offset:2,0.5,2 visibility:25
    - wait 4s
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - foreach <location[shadowend_right_arm].points_between[<[rarm]>]>:
        - teleport <server.flag[arm_right]> <[value]>
        - wait 2t
    - spawn primed_tnt[explosion_radius=4;fuse_ticks=1] <[rarm]>
    - playeffect effect:flame at:<[rarm]> quantity:50 offset:2,1,2
    - playeffect effect:block_dust special_data:obsidian at:<[rarm]> quantity:120 offset:2,1,2
    - playsound <[rarm]> sound:entity_dragon_fireball_explode  volume:5 pitch:2
    - teleport <server.flag[arm_right]> <location[shadowend_right_arm]>
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - foreach <location[shadowend_left_arm].points_between[<[larm]>]>:
        - teleport <server.flag[arm_left]> <[value]>
        - wait 2t
    - spawn primed_tnt[explosion_radius=4;fuse_ticks=1] <[larm]>
    - playeffect effect:flame at:<[larm]> quantity:50 offset:2,1,2
    - playeffect effect:block_dust special_data:obsidian at:<[larm]> quantity:120 offset:2,1,2
    - playsound <[larm]> sound:entity_dragon_fireball_explode  volume:5 pitch:2
    - teleport <server.flag[arm_left]> <location[shadowend_left_arm]>
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - foreach <location[shadowend_right_arm].points_between[<[marm]>]>:
        - teleport <server.flag[arm_right]> <[value]>
        - wait 2t
    - spawn primed_tnt[explosion_radius=4;fuse_ticks=1] <[marm]>
    - playeffect effect:flame at:<[marm]> quantity:50 offset:2,1,2
    - playeffect effect:block_dust special_data:obsidian at:<[marm]> quantity:120 offset:2,1,2
    - playsound <[marm]> sound:entity_dragon_fireball_explode  volume:5 pitch:2
    - teleport <server.flag[arm_right]> <location[shadowend_right_arm]>
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - foreach <location[shadowend_left_arm].points_between[<[marm]>]>:
        - teleport <server.flag[arm_left]> <[value]>
        - wait 2t
    - spawn primed_tnt[explosion_radius=4;fuse_ticks=1] <[marm]>
    - playeffect effect:flame at:<[marm]> quantity:50 offset:2,1,2
    - playeffect effect:block_dust special_data:obsidian at:<[marm]> quantity:120 offset:2,1,2
    - playsound <[marm]> sound:entity_dragon_fireball_explode  volume:5 pitch:2
    - teleport <server.flag[arm_left]> <location[shadowend_left_arm]>
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - foreach <location[shadowend_right_arm].points_between[<[rarm]>]>:
        - teleport <server.flag[arm_right]> <[value]>
        - wait 2t
    - spawn primed_tnt[explosion_radius=4;fuse_ticks=1] <[rarm]>
    - playeffect effect:flame at:<[rarm]> quantity:50 offset:2,1,2
    - playeffect effect:block_dust special_data:obsidian at:<[rarm]> quantity:120 offset:2,1,2
    - playsound <[rarm]> sound:entity_dragon_fireball_explode  volume:5 pitch:2
    - teleport <server.flag[arm_right]> <location[shadowend_right_arm]>
    - if !<server.has_flag[shadowendfight]>:
        - stop
    - foreach <location[shadowend_left_arm].points_between[<[larm]>]>:
        - teleport <server.flag[arm_left]> <[value]>
        - wait 2t
    - spawn primed_tnt[explosion_radius=4;fuse_ticks=1] <[larm]>
    - playeffect effect:flame at:<[larm]> quantity:50 offset:2,1,2
    - playeffect effect:block_dust special_data:obsidian at:<[larm]> quantity:120 offset:2,1,2
    - playsound <[larm]> sound:entity_dragon_fireball_explode  volume:5 pitch:2
    - teleport <server.flag[arm_left]> <location[shadowend_left_arm]>
    - run shadowend_attack

laser_target:
    type: task
    debug: false
    script:
    - while <server.has_flag[lasertarget]>:
        - wait 1s
        - define laserlocation:<location[shadowendbeam4].points_between[<server.flag[shadowendfight].location||<location[shadowendbeam4]>>]||null>
        - define playerloc:<server.flag[shadowendfight].location.simple||null>
        - wait 0.5s
        - playeffect effect:redstone special_data:1.0|purple at:<[laserlocation]>  quantity:8 offset:0.2,0.2,0.2
        - repeat 5:
            - if !<server.has_flag[shadowendfight]>:
                - stop
            - foreach <[laserlocation]>:
                - if !<server.has_flag[shadowendfight]>:
                    - stop
                - if <server.flag[shadowendfight].location.simple||null> == <[value].simple> || <server.flag[shadowendfight].location.simple||null> == <[playerloc]>:
                    - hurt 4 <server.flag[shadowendfight]||null>
                    - actionbar "You got hit by a magic laser" format:info_text targets:<server.flag[shadowendfight]||null>
            - wait 2t

#pushable block dungeon + end
pbdungeon_world:
    type: world
    debug: false
    events:
        on player right clicks loom with:old_book:
        - determine passively cancelled
        - if <player.fake_block[<context.location>]||null> != null:
            - stop
        - showfake bookshelf <context.location> players:<player> d:100h
        - take scriptname:old_book
        - flag player p2_books:++
        - actionbar "<player.flag[p2_books]>/16 bookshelves restored"
        - if <player.flag[p2_books]> == 16:
            - narrate "<&7>Ancient <&8>Librarian <&f><&gt> Thank you for restoring the bookshelves.<&nl>I made the buttons reappear."
            - showfake cancel <player.fake_block_locations> players:<player>
            - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate1]>|<location[pb_gate1].add[0,1,0]>|<location[pb_gate1].add[0,0,-1]>|<location[pb_gate1].add[0,1,-1]>|<location[pb_gate1].add[0,0,-2]>|<location[pb_gate1].add[0,1,-2]> players:<player> d:100h
            - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
            - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate2]>|<location[pb_gate2].add[0,1,0]>|<location[pb_gate2].add[0,0,-1]>|<location[pb_gate2].add[0,1,-1]>|<location[pb_gate2].add[0,0,-2]>|<location[pb_gate2].add[0,1,-2]> players:<player> d:100h
            - showfake crimson_fence[faces=<list[east|west]>]|warped_fence[faces=<list[east|west]>] <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
            - wait 5s
            - narrate "<&7>Ancient <&8>Librarian <&f><&gt> O i did lock the gates again. Finish what you came here to do and they should reopen."
        on server start:
        - run pb_reset
        on player shoots bell in:pb_dungeon:
        - if <player.flag[bells].contains[<context.location>]||false>:
            - remove <context.projectile>
            - stop
        - flag player bells:->:<context.location>
        - showfake air <context.location> players:<context.shooter> d:100h
        - remove <context.projectile>
        - actionbar "<player.flag[bells].size||0>/5 Bells hit."
        - if <player.flag[bells].size||null> == 5:
            - flag player answering:riddle4
            - cast speed amplifier:-6 duration:10h no_ambient hide_particles no_icon
            - cast jump amplifier:-6 duration:10h no_ambient hide_particles no_icon
            - cast blindness amplifier:5 duration:10h no_ambient hide_particles no_icon
            - narrate "<&8>[???]<&f><&nl>I am peacefull yet i hunt<&nl>I was usefull now I'm not<&nl>Patience is the way you get me<&nl>I tend to stay away from strangers<&nl>What am I?"
            - wait 3s
            - narrate "<&6>Click one:"
            - narrate "<&6>*<&f> <list[Ocelot|Cat|Fox|Wolf].random[4].parse_tag[<[parse_value].on_click[/<[parse_value]>]>].separated_by[<&nl><&6>*<&f> ]>"
        on command in:pb_dungeon:
        - if !<player.has_flag[answering]>:
            - if <list[Skeleton|Spider|Strider|Stray|Husk|Zombie|Drowned|Phantom|Vindicator|Evoker|Pillager|Ravager|Ocelot|Cat|Fox|Wolf].contains_any[<context.command>]>:
                - determine fulfilled
            - stop
        - choose <context.command>:
            - case Skeleton:
                - determine passively fulfilled
                - if <player.flag[answering]||null> == riddle1:
                    - narrate "<&6>You choose <&f><context.command>"
                    - cast speed remove
                    - cast jump remove
                    - cast blindness remove
                    - wait 2s
                    - flag player answering:!
                    - flag player answered:++
                    - fakespawn skeleton <location[fake_skel]> players:<player> d:100h
                    - if <player.flag[answered]||0> == 4:
                        - flag player answered:!
                        - narrate "correct you have found all the prisoners" format:info_text
                        - wait 2s
                        - narrate "you heard a gate open" format:info_text
                        - playsound <player> sound:ui_toast_challenge_complete pitch:100
                        - showfake cancel <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
                        - showfake cancel <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
                        - determine fulfilled
                    - narrate "correct you found this prisoner." format:info_text
                    - actionbar "<player.flag[answered]||0>/4 Prisoners found"
            - case Husk:
                - determine passively fulfilled
                - if <player.flag[answering]||null> == riddle2:
                    - narrate "<&6>You choose <&f><context.command>"
                    - cast speed remove
                    - cast jump remove
                    - cast blindness remove
                    - wait 2s
                    - flag player answering:!
                    - flag player answered:++
                    - fakespawn husk <location[fake_husk]> players:<player> d:100h
                    - if <player.flag[answered]||0> == 4:
                        - flag player answered:!
                        - narrate "correct you have found all the prisoners" format:info_text
                        - wait 2s
                        - narrate "you heard a gate open" format:info_text
                        - playsound <player> sound:ui_toast_challenge_complete pitch:100
                        - showfake cancel <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
                        - showfake cancel <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
                        - determine fulfilled
                    - narrate "correct you found this prisoner." format:info_text
                    - actionbar "<player.flag[answered]||0>/4 Prisoners found"
            - case Vindicator:
                - determine passively fulfilled
                - if <player.flag[answering]||null> == riddle3:
                    - narrate "<&6>You choose <&f><context.command>"
                    - cast speed remove
                    - cast jump remove
                    - cast blindness remove
                    - wait 2s
                    - flag player answering:!
                    - flag player answered:++
                    - fakespawn vindicator <location[fake_vind]> players:<player> d:100h
                    - if <player.flag[answered]||0> == 4:
                        - flag player answered:!
                        - narrate "correct you have found all the prisoners" format:info_text
                        - wait 2s
                        - narrate "you heard a gate open" format:info_text
                        - playsound <player> sound:ui_toast_challenge_complete pitch:100
                        - showfake cancel <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
                        - showfake cancel <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
                        - determine fulfilled
                    - narrate "correct you found this prisoner." format:info_text
                    - actionbar "<player.flag[answered]||0>/4 Prisoners found"
            - case Ocelot:
                - determine passively fulfilled
                - if <player.flag[answering]||null> == riddle4:
                    - narrate "<&6>You choose <&f><context.command>"
                    - cast speed remove
                    - cast jump remove
                    - cast blindness remove
                    - wait 2s
                    - flag player answering:!
                    - flag player answered:++
                    - fakespawn ocelot <location[fake_ocel]> players:<player> d:100h
                    - if <player.flag[answered]||0> == 4:
                        - flag player answered:!
                        - narrate "correct you have found all the prisoners" format:info_text
                        - wait 2s
                        - narrate "you heard a gate open" format:info_text
                        - playsound <player> sound:ui_toast_challenge_complete pitch:100
                        - showfake cancel <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
                        - showfake cancel <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
                        - determine fulfilled
                    - narrate "correct you found this prisoner." format:info_text
                    - actionbar "<player.flag[answered]||0>/4 Prisoners found"
            - default:
                - determine passively fulfilled
                - narrate "<&6>You choose <&f><context.command>"
                - cast speed remove
                - cast jump remove
                - cast blindness remove
                - wait 2s
                - flag player answering:!
                - flag player answered:!
                - flag player bells:!
                - narrate "Wrong answer! Start over." format:info_text
                - if <player.has_flag[hidden_entities]>:
                    - foreach <player.flag[hidden_entities]>:
                        - adjust <player> show_entity:<[value]>
                    - flag player hidden_entities:!
                - if <player.has_flag[pb_entity]>:
                    - foreach <player.flag[pb_entity]>:
                        - if !<[value].is_spawned>:
                            - foreach next
                        - if <[value].has_flag[link]||false>:
                            - remove <[value].flag[link]>|<[value]>
                        - flag player pb_entity:!
                - foreach <player.fake_entities>:
                    - fakespawn <[value]> cancel
                - showfake <player.standing_on.material> <player.standing_on> players:<player>
                - showfake cancel <player.fake_block_locations||location[fake_pb1]> players:<player>
        after player right clicks pushable_block in:pb_dungeon:
        - wait 5t
        - ratelimit player 5t
        - if !<context.entity.is_spawned>:
            - stop
        - adjust <context.entity> shulker_peek:0
        - if <player.location.distance[<context.entity.location>]> < 2.2 && <player.location.block.y> == <context.entity.location.block.y>:
            - define new_loc <context.entity.location.add[0,-1,0]>
            - if <[new_loc].material> == <material[netherite_block]>:
                - showfake lime_concrete <[new_loc]> players:<player> d:100h
                - flag player p1_finish:++
                - remove <context.entity.flag[link]>|<context.entity>
                - if <player.flag[p1_finish]||0> == 2:
                    - playsound <player> sound:ui_toast_challenge_complete pitch:100
                    - showfake cancel <location[pb_gate1]>|<location[pb_gate1].add[0,1,0]>|<location[pb_gate1].add[0,0,-1]>|<location[pb_gate1].add[0,1,-1]>|<location[pb_gate1].add[0,0,-2]>|<location[pb_gate1].add[0,1,-2]> players:<player> d:100h
                    - narrate "You heard a gate open" targets:<player> format:info_text
            - if <[new_loc].material> == <material[ancient_debris]>:
                - showfake lime_concrete <[new_loc]> players:<player> d:100h
                - flag player p2_finish:++
                - remove <context.entity.flag[link]>|<context.entity>
                - if <player.flag[p2_finish]||0> == 3:
                    - playsound <player> sound:ui_toast_challenge_complete pitch:100
                    #- showfake air <location[pb_gate2]>|<location[pb_gate2].add[0,1,0]>|<location[pb_gate2].add[0,0,-1]>|<location[pb_gate2].add[0,1,-1]>|<location[pb_gate2].add[0,0,-2]>|<location[pb_gate2].add[0,1,-2]> players:<player> d:100h
                    - showfake cancel <location[pb_gate1]>|<location[pb_gate1].add[0,1,0]>|<location[pb_gate1].add[0,0,-1]>|<location[pb_gate1].add[0,1,-1]>|<location[pb_gate1].add[0,0,-2]>|<location[pb_gate1].add[0,1,-2]> players:<player> d:100h
                    - showfake cancel <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
                    #- showfake air <location[pb_gate2]>|<location[pb_gate2].add[0,1,0]>|<location[pb_gate2].add[0,0,-1]>|<location[pb_gate2].add[0,1,-1]>|<location[pb_gate2].add[0,0,-2]>|<location[pb_gate2].add[0,1,-2]> players:<player> d:100h
                    - narrate "You heard a gate open" targets:<player> format:info_text
            - if <[new_loc].material> == <material[lodestone]>:
                - showfake lime_concrete <[new_loc]> players:<player> d:100h
                - flag player p3_finish:++
                - remove <context.entity.flag[link]>|<context.entity>
                - if <player.flag[p3_finish]||0> == 3:
                    - playsound <player> sound:ui_toast_challenge_complete pitch:100
                    #- showfake air <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
                    - showfake cancel <location[pb_gate1]>|<location[pb_gate1].add[0,1,0]>|<location[pb_gate1].add[0,0,-1]>|<location[pb_gate1].add[0,1,-1]>|<location[pb_gate1].add[0,0,-2]>|<location[pb_gate1].add[0,1,-2]> players:<player> d:100h
                    - showfake cancel <location[pb_gate2]>|<location[pb_gate2].add[0,1,0]>|<location[pb_gate2].add[0,0,-1]>|<location[pb_gate2].add[0,1,-1]>|<location[pb_gate2].add[0,0,-2]>|<location[pb_gate2].add[0,1,-2]> players:<player> d:100h
                    - narrate "You heard a gate open" targets:<player> format:info_text
            - if <[new_loc].material> == <material[crimson_nylium]>:
                - remove <context.entity.flag[link]>|<context.entity>
                - narrate "Uh oh your block seems to be stuck Let me fix that for you<&nl>You will have to do any other mazes you did before again too though." format:info_text
                - wait 1s
                - flag player pb_entity:<-:<context.entity>
                - wait 1s
                - teleport <player> <location[maze_respawn]>
                - if <player.has_flag[hidden_entities]>:
                    - foreach <player.flag[hidden_entities]>:
                        - adjust <player> show_entity:<[value]>
                    - flag player hidden_entities:!
                - if <player.has_flag[pb_entity]>:
                    - foreach <player.flag[pb_entity]>:
                        - if <[value].has_flag[link]||false>:
                            - remove <[value].flag[link]>|<[value]>
                    - flag player pb_entity:!
                - flag player p3_finish:!
                - showfake <player.standing_on.material> <player.standing_on> players:<player>
                - showfake cancel <player.fake_block_locations||location[fake_pb1]> players:<player>
            - if <[new_loc].material> == <material[warped_hyphae[direction=Z]]>:
                - showfake lime_concrete <[new_loc]> players:<player> d:100h
                - remove <context.entity.flag[link]>|<context.entity>
                - if <[new_loc].block.note_name> == pb_riddle1:
                    - flag player answering:riddle1
                    - cast speed amplifier:-6 duration:10h no_ambient hide_particles no_icon
                    - cast jump amplifier:-6 duration:10h no_ambient hide_particles no_icon
                    - cast blindness amplifier:5 duration:10h no_ambient hide_particles no_icon
                    - narrate "<&8>[???]<&f><&nl>You can see my humerus<&nl>But it doesn’t mean I’m funny<&nl>I’ve got no skin so I don’t get tanned<&nl>When outside it’s hot and sunny<&nl>What am I?"
                    - wait 3s
                    - narrate "<&6>Click one:"
                    - narrate "<&6>*<&f> <list[Skeleton|Spider|Strider|Stray].random[4].parse_tag[<[parse_value].on_click[/<[parse_value]>]>].separated_by[<&nl><&6>*<&f> ]>"
                - if <[new_loc].block.note_name> == pb_riddle2:
                    - flag player answering:riddle2
                    - cast speed amplifier:-6 duration:10h no_ambient hide_particles no_icon
                    - cast jump amplifier:-6 duration:10h no_ambient hide_particles no_icon
                    - cast blindness amplifier:5 duration:10h no_ambient hide_particles no_icon
                    - narrate "<&8>[???]<&f><&nl>I am dead but alive<&nl>I eat but am never satisfied<&nl>I consume knowledge but gain none<&nl>I survive both the heat and the cold<&nl>What am I?"
                    - wait 3s
                    - narrate "<&6>Click one:"
                    - narrate "<&6>*<&f> <list[Husk|Zombie|Drowned|Phantom].random[4].parse_tag[<[parse_value].on_click[/<[parse_value]>]>].separated_by[<&nl><&6>*<&f> ]>"
                - if <[new_loc].block.note_name> == pb_riddle3:
                    - flag player answering:riddle3
                    - cast speed amplifier:-6 duration:10h no_ambient hide_particles no_icon
                    - cast jump amplifier:-6 duration:10h no_ambient hide_particles no_icon
                    - cast blindness amplifier:5 duration:10h no_ambient hide_particles no_icon
                    - narrate "<&8>[???]<&f><&nl>A ruthless murderer a heartless creature<&nl>At sight of a human or innocent bystander<&nl>Their fate has already been secured<&nl>But with a simple change of a name<&nl>The more psycho I become<&nl>What am I?"
                    - wait 3s
                    - narrate "<&6>Click one:"
                    - narrate "<&6>*<&f> <list[Vindicator|Evoker|Pillager|Ravager].random[4].parse_tag[<[parse_value].on_click[/<[parse_value]>]>].separated_by[<&nl><&6>*<&f> ]>"
        on player enters pb_dungeon:
        - title "title:<&5>Auria <&color[#E0E0E0]>B<&color[#C0C0C0]>l<&color[#A0A0A0]>o<&color[#808080]>c<&color[#606060]>k<&color[#404040]>s" "subtitle:problem solvers may continue" targets:<player>
        - adjust <player> noclip:true
        - if <player.has_flag[hidden_entities]>:
            - foreach <player.flag[hidden_entities]>:
                - adjust <player> show_entity:<[value]>
            - flag player hidden_entities:!
        - if <player.has_flag[pb_entity]>:
            - foreach <player.flag[pb_entity]>:
                - if <[value].has_flag[link]||false>:
                    - remove <[value].flag[link]>|<[value]>
            - flag player pb_entity:!
        - flag player p1_finish:!
        - flag player p2_finish:!
        - flag player received_books:!
        - flag player p2_books:!
        - flag player p3_finish:!
        - flag player answering:!
        - flag player answered:!
        - flag player bells:!
        - if <player.has_effect[jump]>:
            - cast jump remove
        - if <player.has_effect[blindness]>:
            - cast blindness remove
        - if <player.has_effect[speed]>:
            - cast speed remove
        - if <player.inventory.contains_item[old_book]>:
            - take scriptname:old_book quantity:64
        - run pb_reset
        - foreach <player.fake_entities>:
            - fakespawn <[value]> cancel
        - showfake <player.standing_on.material> <player.standing_on> players:<player>
        - showfake cancel <player.fake_block_locations||location[fake_pb1]> players:<player>
        - showfake air <location[pb_button1]> players:<player> d:100h
        - showfake air <location[pb_button2]> players:<player> d:100h
        - showfake air <location[pb_button3]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate1]>|<location[pb_gate1].add[0,1,0]>|<location[pb_gate1].add[0,0,-1]>|<location[pb_gate1].add[0,1,-1]>|<location[pb_gate1].add[0,0,-2]>|<location[pb_gate1].add[0,1,-2]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate2]>|<location[pb_gate2].add[0,1,0]>|<location[pb_gate2].add[0,0,-1]>|<location[pb_gate2].add[0,1,-1]>|<location[pb_gate2].add[0,0,-2]>|<location[pb_gate2].add[0,1,-2]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[east|west]>]|warped_fence[faces=<list[east|west]>] <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
        on player exits pb_dungeon:
        - adjust <player> noclip:false
        - if <player.has_flag[hidden_entities]>:
            - foreach <player.flag[hidden_entities]>:
                - adjust <player> show_entity:<[value]>
            - flag player hidden_entities:!
        - if <player.has_flag[pb_entity]>:
            - foreach <player.flag[pb_entity]>:
                - if !<[value].is_spawned>:
                    - foreach next
                - if <[value].has_flag[link]||false>:
                    - remove <[value].flag[link]>|<[value]>
            - flag player pb_entity:!
        - flag player p1_finish:!
        - flag player p2_finish:!
        - flag player received_books:!
        - flag player p2_books:!
        - flag player p3_finish:!
        - flag player answering:!
        - flag player answered:!
        - flag player bells:!
        - if <player.has_effect[jump]>:
            - cast jump remove
        - if <player.has_effect[blindness]>:
            - cast blindness remove
        - if <player.has_effect[speed]>:
            - cast speed remove
        - if <player.inventory.contains_item[old_book]>:
            - take scriptname:old_book quantity:64
        - foreach <player.fake_entities>:
            - fakespawn <[value]> cancel
        - showfake <player.standing_on.material> <player.standing_on> players:<player>
        - showfake cancel <player.fake_block_locations> players:<player>
        - showfake air <location[pb_button1]> players:<player> d:100h
        - showfake air <location[pb_button2]> players:<player> d:100h
        - showfake air <location[pb_button3]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate1]>|<location[pb_gate1].add[0,1,0]>|<location[pb_gate1].add[0,0,-1]>|<location[pb_gate1].add[0,1,-1]>|<location[pb_gate1].add[0,0,-2]>|<location[pb_gate1].add[0,1,-2]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate3]>|<location[pb_gate3].add[0,1,0]>|<location[pb_gate3].add[0,0,-1]>|<location[pb_gate3].add[0,1,-1]>|<location[pb_gate3].add[0,0,-2]>|<location[pb_gate3].add[0,1,-2]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[north|south]>]|warped_fence[faces=<list[north|south]>] <location[pb_gate2]>|<location[pb_gate2].add[0,1,0]>|<location[pb_gate2].add[0,0,-1]>|<location[pb_gate2].add[0,1,-1]>|<location[pb_gate2].add[0,0,-2]>|<location[pb_gate2].add[0,1,-2]> players:<player> d:100h
        - showfake crimson_fence[faces=<list[east|west]>]|warped_fence[faces=<list[east|west]>] <location[pb_gate4].add[-1,1,0]>|<location[pb_gate4].add[-1,2,0]>|<location[pb_gate4].add[-1,3,0]>|<location[pb_gate4].add[-1,0,0]>|<location[pb_gate4].add[0,1,0]>|<location[pb_gate4].add[0,2,0]>|<location[pb_gate4].add[0,3,0]>|<location[pb_gate4]>|<location[pb_gate4].add[-2,0,0]>|<location[pb_gate4].add[-2,1,0]>|<location[pb_gate4].add[-2,2,0]>|<location[pb_gate4].add[-2,3,0]>|<location[pb_gate4].add[-3,0,0]>|<location[pb_gate4].add[-3,1,0]>|<location[pb_gate4].add[-3,2,0]>|<location[pb_gate4].add[-3,3,0]>|<location[pb_gate4].add[-4,0,0]>|<location[pb_gate4].add[-4,1,0]>|<location[pb_gate4].add[-4,2,0]>|<location[pb_gate4].add[-4,3,0]> players:<player> d:100h
        on player right clicks fake_pb:
        - adjust <context.entity> shulker_peek:0
        - if <player.location.distance[<context.entity.location>]> < 1.2 && <player.location.block.y> == <context.entity.location.block.y>:
            - define x <player.location.direction.vector.x>
            - define z <player.location.direction.vector.z>
            - if <[x].abs> > <[z].abs>:
                - if <player.location.block.z> != <context.entity.location.block.z>:
                    - stop
                - if <[x]> < 0:
                    - define direction -1,0,0
                - else:
                    - define direction 1,0,0
            - else:
                - if <player.location.block.x> != <context.entity.location.block.x>:
                    - stop
                - if <[z]> < 0:
                    - define direction 0,0,-1
                - else:
                    - define direction 0,0,1
            - define new_loc <context.entity.location.add[<[direction]>]>
            - if <[new_loc].material.name> != air && <[new_loc].material.name> != water && !<[new_loc].material.name.contains[pressure_plate]>:
                - stop
            - if !<[new_loc].find_entities.within[0.45].is_empty>:
                - stop
            - spawn pushable_block[color=<context.entity.color>;shulker_peek=0] <[new_loc]> save:block
            - spawn armor_stand[visible=false;is_small=true] <entry[block].spawned_entities.get[1].location> save:stand
            - if <player.has_flag[pb_entity]>:
                - flag player pb_entity:->:<entry[block].spawned_entities.get[1]>
            - else:
                - flag player pb_entity:<entry[block].spawned_entities.get[1]>
            - if <player.has_flag[hidden_entities]>:
                - flag player hidden_entities:->:<context.entity>
            - else:
                - flag player hidden_entities:<context.entity>
            - flag <entry[block].spawned_entities.get[1]> link:<entry[stand].spawned_entities.get[1]>
            - flag <entry[stand].spawned_entities.get[1]> link:<entry[block].spawned_entities.get[1]>
            - wait 1t
            - adjust <entry[stand].spawned_entities.get[1]> gravity:false
            - adjust <entry[block].spawned_entities.get[1]> hide_from_players:true
            - adjust <player> show_entity:<entry[block].spawned_entities.get[1]>
            - adjust <player> hide_entity:<context.entity>
            - playsound <[new_loc]> sound:ENTITY_IRON_GOLEM_ATTACK volume:1 pitch:0
        on player right clicks lectern in:pb_dungeon:
        - if <context.location> == <location[pb_lectern]>:
            - if <player.has_flag[received_books]>:
                - stop
            - flag player received_books
            - give old_book quantity:16
        on player drops old_book:
        - determine passively cancelled
        - wait 1t
        - inventory update
        - narrate "You cannot drop dungeon items" format:info_text
        on player drops branch:
        - determine passively cancelled
        - wait 1t
        - inventory update
        - narrate "You cannot drop dungeon items" format:info_text
        on player drops branch_onfire:
        - determine passively cancelled
        - wait 1t
        - inventory update
        - narrate "You cannot drop dungeon items" format:info_text
        on player clicks in inventory in_area:pb_dungeon:
        - if <context.inventory> != <player.inventory>:
            - if <context.item.simple> == <item[old_book].simple>:
                - determine passively cancelled
                - wait 1t
                - inventory update
                - narrate "you cannot store dungeon items" format:info_text
        on player clicks in inventory in_area:magic_island:
        - if <context.inventory> != <player.inventory>:
            - if <context.clicked_inventory> != <context.inventory>:
                - if <context.item.simple> == <item[branch].simple>:
                    - determine passively cancelled
                    - wait 1t
                    - inventory update
                    - narrate "you cannot store dungeon items" format:info_text
                - if <context.item.simple> == <item[branch_onfire].simple>:
                    - determine passively cancelled
                    - wait 1t
                    - inventory update
                    - narrate "you cannot store dungeon items" format:info_text
        on player kicked for flying:
        - if <player.location.cuboids.contains[<cuboid[auria_dungeon]>]>:
            - determine passively fly_cooldown:<duration[1h]>
            - determine cancelled
        on player enters auria_end:
        - cast speed amplifier:-6 duration:10 no_ambient hide_particles no_icon
        - cast jump amplifier:-6 duration:10 no_ambient hide_particles no_icon
        - cast blindness amplifier:5 duration:10 no_ambient hide_particles no_icon
        - wait 1s
        - cast confusion amplifier:5 duration:9 no_ambient hide_particles no_icon
        - wait 7s
        - teleport <player> <location[auria_end_loc].center>
        - wait 2s
        - wait 10t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title title:<&5>A<&f>_ fade_in:0
        - wait 3t
        - title title:<&5>A fade_in:0
        - wait 3t
        - title title:<&5>A<&f>_ fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title title:<&5>Au<&f>_ fade_in:0
        - wait 3t
        - title title:<&5>Au fade_in:0
        - wait 3t
        - title title:<&5>Au<&f>_ fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title title:<&5>Aur<&f>_ fade_in:0
        - wait 3t
        - title title:<&5>Aur fade_in:0
        - wait 3t
        - title title:<&5>Aur<&f>_ fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title title:<&5>Auri<&f>_ fade_in:0
        - wait 3t
        - title title:<&5>Auri fade_in:0
        - wait 3t
        - title title:<&5>Auri<&f>_ fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title title:<&5>Auria<&f>_ fade_in:0
        - wait 3t
        - title title:<&5>Auria fade_in:0
        - wait 3t
        - title title:<&5>Auria<&f>_ fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria " fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&color[#009900]>e<&f>_" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&color[#009900]>e" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&color[#009900]>e<&f>_" fade_in:0
        - wait 3t
        - playsound <player> sound:minecraft:ui.loom.select_pattern volume:10 pitch:1.5 custom
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&color[#009900]>e<&color[#006600]>d" fade_in:0
        - wait 3t
        - title "title:<&5>Auria <&color[#CCFFCC]>F<&color[#99FF99]>i<&color[#66FF66]>n<&color[#33FF33]>i<&color[#00FF00]>s<&color[#00CC00]>h<&color[#009900]>e<&color[#006600]>d" subtitle:Congratulations fade_in:0
        - playsound <player> sound:minecraft:music.congratulations custom

#entities
target_e:
    type: entity
    debug: false
    entity_type: armor_stand
    mechanisms:
        base_plate: false
        equipment: leather_boots[color=255,0,0]|leather_leggings[color=255,255,255]|leather_chestplate[color=255,0,0]|target

shadowbeam:
    type: entity
    debug: false
    entity_type: ender_crystal
    mechanisms:
        beam_target: <server.flag[shadowendfight].standing_on||null>
        invulnerable: true
        glowing: true

shadoweye:
    type: entity
    debug: false
    entity_type: ender_crystal
    mechanisms:
        beam_target: <server.flag[shadowendfight].standing_on||null>
        glowing: true

turret_purple:
    type: entity
    debug: false
    entity_type: shulker
    mechanisms:
        health: 0.1
        color: purple

turret_black:
    type: entity
    debug: false
    entity_type: shulker
    mechanisms:
        health: 0.1
        color: black

turret_magenta:
    type: entity
    debug: false
    entity_type: shulker
    mechanisms:
        health: 0.1
        color: magenta

sobi:
    type: entity
    debug: false
    entity_type: armor_stand
    mechanisms:
        equipment: air|air|air|obsidian
        visible: false
        gravity: false
        invulnerable: true

sblackwool:
    type: entity
    debug: false
    entity_type: armor_stand
    mechanisms:
        equipment: air|air|air|black_wool
        visible: false
        gravity: false
        invulnerable: true

fake_pb:
    type: entity
    debug: false
    entity_type: shulker
    mechanisms:
        has_ai: false
        invulnerable: true

difficulty_changer_e_shadow:
    type: entity
    debug: false
    entity_type: armor_stand
    mechanisms:
        custom_name: <server.flag[shadow_difficulty].to_titlecase>
        custom_name_visible: true
        disabled_slots: CHEST/ALL|FEET/ALL|HAND/ALL|HEAD/ALL|LEGS/ALL|OFF_HAND/ALL

diff_change_shaddow_w:
  type: world
  debug: false
  events:
    on player right clicks difficulty_changer_e_shadow:
    - if <server.has_flag[boss_restore]> || <server.has_flag[shadowendfight]>:
      - narrate "Difficulty cannot be changed while there is a fight going on!" format:info_text
      - stop
    - choose "<context.entity.custom_name.after[ ]>":
      - case Easy:
        - flag server shadow_difficulty:normal
      - case Normal:
        - flag server shadow_difficulty:hard
      - case Hard:
        - flag server shadow_difficulty:easy
    - wait 1t
    - adjust <context.entity> "custom_name:<&5>Difficulty<&co><&f> <server.flag[shadow_difficulty].to_titlecase||Normal>"
