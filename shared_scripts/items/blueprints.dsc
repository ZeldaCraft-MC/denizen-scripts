blueprint:
  type: item
  material: paper
  display name: <&b>Blueprint
  flags:
    schem:
      name: startertent
      color: true

color_map:
  type: data
  colors:
    white: #ffffff
    orange: #ff9100
    magenta: #bf00ff
    light_blue: #00d0ff
    yellow: #ffdd00
    lime: #5eff00
    pink: #ff9eda
    gray: #707070
    light_gray: #9e9e9e
    cyan: #08a4a7
    purple: #9000ff
    blue: #0004ff
    brown: #7a5230
    green: #008a22
    red: #ff0000
    black: #4f4f4f

blueprint_angle_map:
  type: data
  south: 0
  west: 90
  north: 180
  east: 270

blueprint_printer:
  type: task
  definitions: schem|loc|dir
  script:
    - if !<player.has_flag[blueprint_preview]>:
      - stop

    - if <player.has_flag[schem_color]>:
      - define schem_color:<player.flag[schem_color]>
      - flag player schem_color:!

    - flag player blueprint_preview:!
    - narrate "<&a>Placing your blueprint!"

    - wait 1s
    - define cuboid <schematic[<[schem]>].cuboid[<[loc]>]>
    - define chunks <[cuboid].partial_chunks>
    - chunkload <[chunks]>
    - define origin <schematic[<[schem]>].origin>
    - define yaw <script[blueprint_angle_map].data_key[<[dir]>].add[180]>
    - spawn armor_stand[gravity=false;visible=false;is_small=true;marker=true;equipment=air|air|air|<server.flag[navi_head]>] <[loc].with_yaw[<[yaw]>]> save:e

    - repeat <schematic[<[schem]>].height> as:y:
      - repeat <schematic[<[schem]>].width> as:x:
        - repeat <schematic[<[schem]>].length> as:z:
          - define offset <[x].sub[1]>,<[y].sub[1]>,<[z].sub[1]>
          - define block <schematic[<[schem]>].block[<[offset]>]||null>
          - if <[block]> != null && <[block].name> != air && !<[block].name.contains_text[sign]> && !<[block].name.contains_text[_door]>:
            - if <[schem_color]||null> !== null:
              - if <[block].name.contains_text[_wool]>:
                - define block <[schem_color]>_wool
              - else if <[block].name.contains_text[_bed]>:
                - define block <[schem_color]>_bed[direction=<[block].direction>;half=<[block].half>]
            - define place_loc <[loc].add[<[offset]>].sub[<[origin]>]>
            - teleport <entry[e].spawned_entity> <[place_loc].center.with_yaw[<[yaw]>]>
            - modifyblock <[place_loc]> <[block]>
            - playsound <[place_loc]> sound:block_wool_place
            - wait 3t

    - schematic paste name:<[schem]> <[loc]> mask:air|chest
    - playsound <[loc]> sound:entity_player_levelup
    - remove <entry[e].spawned_entity>

    - wait 1s
    - chunkload remove <[chunks]>

blueprint_cancel:
  type: task
  script:
    - if <player.has_flag[blueprint_preview]>:
      - flag player blueprint_preview:!
      - narrate "<&c>Cancelled placing your blueprint."

blueprint_color:
  type: task
  definitions: color
  script:
    - if <player.has_flag[blueprint_preview]>:
      - define map <script[color_map].data_key[colors]>
      - title "title:<&7>Color: <&color[<[map].get[<[color]>]>]><[color].replace_text[_].with[ ].to_titlecase>"
      - flag player schem_color:<[color]> duration:10s
      - flag player blueprint_preview:<player.flag[blueprint_preview]> duration:10s

blueprint_events:
  type: world
  debug: false
  fail:
    - narrate "<&c>Sorry! You can only place this on a clear, flat plot."
    - playeffect effect:smoke at:<[loc].center> quantity:5 offset:0.2,0.2,0.2 targets:<player>
    - playsound <player> sound:block_sand_break
    - stop
  events:
    on player right clicks block with:blueprint:
      - determine passively cancelled
      - ratelimit <player> 5t
      - define loc <context.relative||null>
      - if <[loc]> == null:
        - stop
      - if !<list[north|south|east|west].contains[<player.location.direction>]>:
        - inject <script> path:fail
      - if !<context.item.has_flag[schem]>:
        - inject <script> path:fail

      - define schem <context.item.flag[schem.name]>_<player.location.direction>
      - if !<schematic[<[schem]>].exists>:
        - ~schematic load name:<[schem]>
      - define cuboid <schematic[<[schem]>].cuboid[<[loc]>]>
      - if <[cuboid].has_region>:
        - inject <script> path:fail
      - if !<[cuboid].blocks.filter[material.is_solid].is_empty>:
        - inject <script> path:fail
      - if <player.has_flag[blueprint_preview]>:
        - inject <script> path:fail

      - define loc_below <[cuboid].min.below[1]>
      - define cuboid_below <[loc_below].to_cuboid[<[cuboid].max.with_y[<[loc_below].y>]>]>
      - if !<[cuboid_below].blocks.filter[material.is_solid.not].is_empty>:
        - inject <script> path:fail

      - clickable blueprint_printer def:<[schem]>|<[loc]>|<player.location.direction> usages:1 for:<player> save:yes
      - clickable blueprint_cancel usages:1 for:<player> save:no
      - if <context.item.has_flag[schem.color]>:
        - define color_selection <empty>
        - foreach <script[color_map].data_key[colors]>:
          - clickable blueprint_color def:<[key]> for:<player> save:color
          - define color "<[key].replace_text[_].with[ ].to_titlecase>"
          - define hover "<&7>Click to change the color to <&color[<[value]>]><[color]><&7>!"
          - define color_selection "<[color_selection]> <&color[<[value]>]><element[<&lb><[color]><&rb>].on_click[<entry[color].command>].on_hover[<[hover]>]>"
          - if <[loop_index].sub[1].mod[6]> == 5:
            - define color_selection <[color_selection]><n>
        - narrate "<n><&7>Select a color below and click continue to place your blueprint!"
        - narrate <[color_selection]>
      - else:
        - narrate "<n><&7>Click continue to place your blueprint!"

      - narrate "<n><&a><element[<&lb>Continue<&rb>].on_click[<entry[yes].command>].on_hover[Click to continue]> <&c><element[<&lb>Cancel<&rb>].on_click[<entry[no].command>].on_hover[Click to cancel]><n>"
      - define id <util.random.duuid>
      - flag player blueprint_preview:<[id]> duration:10s
      - while <player.is_online> && <player.has_flag[blueprint_preview]> && <player.flag[blueprint_preview]> == <[id]>:
        - schematic paste fake_to:<player> fake_duration:1s name:<[schem]> <[loc]>
        - wait 1s
        - foreach <[cuboid].blocks>:
          - if <[loop_index].mod[5]> == 0:
            - light <[value]> 0 duration:1t
        - wait 1s
