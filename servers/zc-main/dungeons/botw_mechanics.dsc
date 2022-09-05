beam_entity:
  type: entity
  debug: false
  entity_type: creeper
  mechanisms:
    has_ai: false
    invulnerable: true
    gravity: false
    powered: true
    silent: true
    potion_effects: invisibility,1,2147483647,false,false
    scoreboard_tags: perma_invis

beam_spawner:
  type: item
  debug: false
  material: stick

monk_spawner:
  type: item
  debug: false
  material: blaze_rod
  display name: Monk Spawner
  lore:
  - <&f>Right click to paste the monk
  - <&f>Left click the monk glass to remove it
  - <&f>shift left click the middle glass
  - <&f>to select it then shift click
  - <&f>anywhere else to make a tp point

beam_enttity_events:
  type: world
  debug: false
  events:
    after beam_entity spawns:
      - team name:NoCollision add:<context.entity.uuid>
    on player right clicks block with:monk_spawner:
      - ratelimit <player> 2t
      - if <context.location||null> == null || <context.location.material.name> == air:
        - stop
      - if !<schematic.list.contains[monk_shrine_ending]>:
        - ~schematic load name:monk_shrine_ending
      - schematic paste name:monk_shrine_ending <context.location> entities flags
    on player left clicks block with:monk_spawner:
      - ratelimit <player> 1t
      - if <player.is_sneaking>:
        - determine passively cancelled
        - if <context.location.has_flag[shrine_pane]>:
          - narrate "Shrine monk selected. Choose the teleport place"
          - flag player shrine_tp:<context.location>
          - stop
        - if !<player.has_flag[shrine_tp]>:
          - narrate "You need to have a shrine monk selected!"
          - stop
        - narrate "<player.location.simple> set as teleport spot for the monk located around <player.flag[shrine_tp].simple>"
        - flag <player.flag[shrine_tp]> shrine_tp:<player.location>
        - flag player shrine_tp:!
        - stop
      - if <player.we_selection||null> == null:
        - narrate "Select the monk area"
        - stop
      - if <player.we_selection.entities[armor_stand].filter[has_flag[shrine_monk]].is_empty>:
        - narrate "no monk found in this selection"
        - stop
      - remove <player.we_selection.entities[armor_stand].filter[has_flag[shrine_monk]]>
      - foreach <player.we_selection.blocks_flagged[shrine_pane]>:
        - flag <[value]> shrine_pane:!
      - modifyblock <player.we_selection> air
    on player right clicks block with:beam_spawner:
      - if <context.location||null> == null || <context.location.material.name> == air || <context.relative.material.name> != air:
        - stop
      - define top_loc <context.relative.with_pose[-90,0].ray_trace[range=100]||null>
      - if <[top_loc]> == null || <[top_loc].material.name> == air:
        - narrate "<&c>The maximum height of a portal is 10 blocks high."
        - stop
      - define marker <util.random_uuid>
      - define parity <context.relative.y.mod[2]>
      - foreach <cuboid[<context.relative.add[1,0,1]>|<[top_loc].sub[1,1,1]>].blocks> as:loc:
        - if <[loc].material.name> != air && <[loc].material.name> != structure_void && <[loc].material.name> != barrier:
          - foreach next
        - if <[loc].x> == <context.relative.x> && <[loc].z> == <context.relative.z>:
          - foreach next
        - if <[parity]> != <[loc].y.mod[2]>:
          - foreach next
        - spawn beam_entity[scoreboard_tags=flag/<[marker]>] <[loc].center.below[0.5]> save:e
        - flag server <[marker]>:|:<entry[e].spawned_entity>
    on player damages beam_entity:
      - determine passively cancelled
      - if <player.item_in_hand.script.name||null> == beam_spawner:
        - remove <server.flag[<context.entity.scoreboard_tags.filter[starts_with[flag/]].get[1].after[/]>]>

shrine_priest_format:
  type: format
  debug: false
  format: <&b><&o>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<&nl><&nl><&nl><&nl><[text]><&nl><&nl><&nl><&nl>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

shrine_orb_get:
  type: format
  debug: false
  format: <&7><&o>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<&nl><&nl><&nl><&f><&l><&o>Spirit Orb    <[text]>                      <&f>+1<&nl><&7><&m>-------------------------------------<&nl><&f><&o>A symbol of courage given tothose who<&nl>have overcome the challenges of a shrine.<&nl><&nl><&nl><&7><&o>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

conv_shrine_monk:
  type: task
  debug: false
  script:
    - foreach <player.we_Selection.entities[armor_stand]> as:e:
      - if <[e].scoreboard_tags.is_empty>:
        - foreach next
      - define tag <[e].scoreboard_tags.exclude[shrine_monk|shrine_monk_fan].first>
      - if <[tag].starts_with[shrine_monk_fan]>:
        - flag <[e]> shrine_monk.fan:<[tag].after[shrine_monk_fan]>
      - else if <[tag].starts_with[shrine_monk_leg]>:
        - flag <[e]> shrine_monk.leg:<[tag].after[shrine_monk_leg]>
      - else if <[tag].starts_with[shrine_monk_arm]>:
        - flag <[e]> shrine_monk.arm:<[tag].after[shrine_monk_arm]>
      - else:
        - flag <[e]> shrine_monk.<[tag].after[shrine_monk_].before[1].before[2]>:1
      - adjust <[e]> clear_scoreboard_tags

save_eq_monk:
  type: task
  debug: false
  script:
    - foreach <player.we_Selection.entities[armor_stand]> as:e:
      - flag <[e]> monk_equip:<[e].equipment>

shrine_monk_test:
  type: task
  debug: false
  script:
    - define ent <player.we_Selection.entities[armor_stand].random>
    - adjust <[ent]> glowing:true
    - narrate "<[ent].flag[shrine_monk].keys.first> number <[ent].flag[shrine_monk].values.first> selected"
    - wait 5s
    - adjust <[ent]> glowing:false

botw_ending_test:
  type: world
  debug: false
  events:
    on player right clicks blue_stained_glass_pane location_flagged:shrine_pane:
    - define base <context.location.find_entities[armor_stand].within[5].filter[has_flag[shrine_monk.base]].first>
    - define head <context.location.find_entities[armor_stand].within[5].filter[has_flag[shrine_monk.head]].first>
    - define arms <context.location.find_entities[armor_stand].within[5].filter[has_flag[shrine_monk.arm]]>
    - define legs <context.location.find_entities[armor_stand].within[5].filter[has_flag[shrine_monk.leg]]>
    - define fan <context.location.find_entities[armor_stand].within[5].filter[has_flag[shrine_monk.fan]]>
    - define mid <[base].location>
    - define players <context.location.find_players_within[20]>
    - define loc <context.location.add[0,-2,2].center.sub[0,0.5,0].with_yaw[180].with_pitch[-19]>
    - foreach <context.location.find_entities[armor_stand].within[5]>:
      - define <[value]>_equipment <[value].equipment>
    - spawn armor_stand[visible=false] <[loc]> save:ent
    - foreach <[players]> as:pa:
      - if <[pa].uuid.starts_with[0000]>:
        - teleport <[pa]> <[loc]>
        - foreach <[pa].eye_location.block.find_blocks[air].within[2].exclude[<[pa].eye_location.block>|<[pa].location.block>]>:
          - showfake barrier <[value]> players:<[pa]> d:1m
        - adjust <[pa]> hide_from_players
      - else:
        - adjust <[pa]> spectate:<entry[ent].spawned_entity>
        - adjust <[pa]> hide_from_players
        - teleport <[pa]> <[loc].add[0,-2,-5].center>
        - adjust <[pa]> can_fly:true
    - run shrine_music def:<list_single[<[players]>]>
    - playeffect effect:drip_water at:<context.location.center.add[0,0,0.2]> offset:0.5,0.5,0 quantity:200
    - wait 3s
    - foreach <context.location.flood_fill[20].types[blue_stained_glass_pane|light_blue_stained_glass_pane]> as:l:
      - playeffect effect:fireworks_spark at:<[l].center> offset:0.5,1,0.5 quantity:3
      - flag server shrine_return_block.<[l]>:<[l].material>
      - modifyblock <[l]> air
    - wait 4s
    - narrate " Your resourcefulness in overcoming this<&nl>   trial speaks to the promise pf a hero..." format:shrine_priest_format targets:<[players]>
    - wait 5s
    - narrate "  In the name of Goddess Hylia, I bestow<&nl>          upon you this Spirit Orb." format:shrine_priest_format targets:<[players]>
    - spawn ARMOR_STAND[passenger=dropped_item[item=ender_pearl;pickup_delay=100000];is_small=true;marker=true;visible=false] <[mid].add[0,2.0,0]> save:pearl
    - playeffect effect:end_rod at:<[mid].center.add[0,2,1]> offset:0.15,0.15,0.1 quantity:30
    - foreach <[mid].center.add[0,2,0].points_between[<[loc].center.add[0,0.4,0]>].distance[0.1]> as:o:
      - teleport <entry[pearl].spawned_entity> <[o]>
      - wait 2t
    - foreach <[players]> as:pl:
      - give ender_pearl to:<[pl].inventory>
    - playeffect effect:end_rod at:<[loc].center.add[0,1,-1]> offset:0.05,0.05,0.1 quantity:30
    - playeffect effect:enchantment_table at:<[loc].center.add[0,1,-1]> offset:0.02,0,0.02 quantity:300
    - remove <entry[pearl].spawned_entity.passenger>
    - remove <entry[pearl].spawned_entity>
    - wait 0.5s
    - narrate " " format:shrine_orb_get targets:<[players]>
    - wait 4.5s
    - narrate "     May the Goddess smile upon you.<&nl>" format:shrine_priest_format targets:<[players]>
    - wait 5.5s
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[-0.4,2.9,0.2]> offset:0.4,0.4,0.3 quantity:15
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[-0.4,2.9,0.2]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[-0.6,2.6,0.2]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.1,3.1,0.1]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[5]>]> head:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[-0.6,2.6,0.2]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0.1,3.1,0.1]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[-0.8,2.3,0.1]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.5,2.9,0.2]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[4]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[6]>]> head:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[-0.8,2.3,0.1]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.5,2.9,0.2]> offset:0.4,0.4,0.3 quantity:10
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0,2.4,0.7]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[-0.9,2.0,0]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.8,2.6,0.2]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[3]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[7]>]> head:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0,2.4,0.7]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[-0.9,2.0,0]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0.8,2.6,0.2]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0,1.8,0.2]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[-0.8,1.7,-0.1]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[1,2.3,0.1]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0,1.7,-0.1]> offset:0.4,0.4,0.3 quantity:20
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[2]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[8]>]> head:air
        - equip <[head]> head:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0,1.8,0.2]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[-0.8,1.7,-0.1]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[1,2.3,0.1]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0,1.7,-0.1]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0,1.3,0.4]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[-0.6,1.4,-0.2]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[1.1,2.0,0]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[1]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[9]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[0]>]> head:air
        - equip <[head]> chest:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0,1.3,0.4]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[-0.6,1.4,-0.2]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[1.1,2.0,0]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[1.0,1.7,-0.1]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[-0.6,1.1,-0.3]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[1.1,2.0,0]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[10]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[12]>]> head:air
        - equip <[arms].filter_tag[<[filter_value].flag[shrine_monk.arm].is[==].to[1]>]> legs:air
        - equip <[base]> chest:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[1.0,1.7,-0.1]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[-0.6,1.1,-0.3]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[1.1,2.0,0]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.8,1.4,-0.2]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.1,0.8,-0.4]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.4,1.0,0.7]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[11]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[14]>]> head:air
        - equip <[arms].filter_tag[<[filter_value].flag[shrine_monk.arm].is[==].to[1]>]> boots:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.8,1.4,-0.2]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0.1,0.8,-0.4]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0.4,1.0,0.7]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.5,1.1,-0.3]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.1,1.8,0]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0,0.6,0.8]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[13]>]> head:air
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[16]>]> head:air
        - equip <[arms].filter_tag[<[filter_value].flag[shrine_monk.arm].is[==].to[2]>]> legs:air
        - equip <[arms].filter_tag[<[filter_value].flag[shrine_monk.arm].is[==].to[2]>]> boots:air
        - equip <[base]> legs:air
        - equip <[base]> boots:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.5,1.1,-0.3]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0.1,1.8,0]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0,0.6,0.8]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.2,0.6,0.8]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0,0.6,1.1]> offset:0.4,0.4,0.3 quantity:10
      - playeffect effect:happy_villager at:<[mid].add[0.1,1.8,0]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[fan].filter_tag[<[filter_value].flag[shrine_monk.fan].is[==].to[15]>]> head:air
        - equip <[legs].filter_tag[<[filter_value].flag[shrine_monk.leg].is[==].to[1]>]> legs:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.2,0.6,0.8]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0,0.6,1.1]> offset:0.4,0.4,0.3 quantity:20
      - playeffect effect:happy_villager at:<[mid].add[0.1,1.8,0]> offset:0.4,0.4,0.3 quantity:20
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.2,0.6,1.1]> offset:0.4,0.4,0.3 quantity:10
      - if <[value]> == 1:
        - equip <[legs].filter_tag[<[filter_value].flag[shrine_monk.leg].is[==].to[2]>]> boots:air
        - equip <[legs].filter_tag[<[filter_value].flag[shrine_monk.leg].is[==].to[2]>]> legs:air
      - wait 1t
    - repeat 8:
      - playeffect effect:happy_villager at:<[mid].add[0.2,0.6,1.1]> offset:0.4,0.4,0.3 quantity:10
      - wait 1t
    - equip <[legs].filter_tag[<[filter_value].flag[shrine_monk.leg].is[==].to[1]>]> boots:air
    - wait 3s
    - if <context.location.has_flag[shrine_tp]>:
      - teleport <[players]> <context.location.flag[shrine_tp]>
    - else:
      - teleport <[players]> <[loc]>
    - foreach <context.location.find_entities[armor_stand].within[5]>:
      - if <[value].is_spawned>:
        - foreach next
      - adjust <[value]> equipment:<[<[value]>_equipment]>
    - foreach <[players]> as:p:
      - if <[p].uuid.starts_with[0000]>:
        - adjust <[p]> show_to_players
      - else:
        - adjust <[p]> spectate:<[p]>
        - adjust <[p]> show_to_players
        - adjust <[p]> can_fly:false
    - remove <entry[ent].spawned_entity>
    - foreach <server.flag[shrine_return_block].keys> as:k:
      - define mat <server.flag[shrine_return_block].get[<[k]>]>
      - modifyblock <[k]> <[mat].name>
      - flag server shrine_return_block.<[k]>:!

shrine_music:
  type: task
  debug: false
  definitions: players
  script:
    - foreach <server.flag[shrine_music].values> as:line:
      - if <[line].is_integer>:
        - wait <[line].mul[<context.args.get[1]||1>]>t
      - else:
        - if <[line].starts_with[minecraft:]>:
          - define sound <[line].after[minecraft:].split[,]>
        - else:
          - define sound <[line].split[,]>
        - playsound <[players]> sound:<[sound].get[1]> volume:<[sound].get[2]> pitch:<[sound].get[3]> sound_category:MASTER

#playsound_events:
#  type: world
#  debug: false
#  events:
#    on execute command:
#    - if <context.command_block_location.world.name||null> != dungeons:
#      - stop
#
#    - if !<context.command_block_location.cuboids.contains[<cuboid[shrine_music]>]>:
#      - stop
#
#    - define pos <context.args.find[run]||-1>
#    - if <[pos]> < 0:
#      - stop
#
#    - define cmd <context.args.get[<[pos].add[1]>].to[999]>
#    - if <[cmd].get[1]> != playsound:
#      - stop
#
#    # This is the first time this is run
#    - if !<server.has_flag[shrine_music_d]>:
#      - flag server shrine_music_d:<server.current_tick> duration:5s
#    # This is every other time
#    - else:
#      - define wait <server.current_tick.sub[<server.flag[shrine_music_d]>]>
#      - define num <server.flag[shrine_music].keys.size.add[1]||1>
#      - if <[wait]> != 0:
#        - flag server shrine_music_d:<server.current_tick> duration:5s
#        - flag server shrine_music.<[num]>:<[wait]>
#        - define num <[num].add[1]>
#      - flag server shrine_music.<[num]>:<[cmd].get[2].replace[.].with[_]>,<[cmd].get[8]>,<[cmd].get[9]>]
