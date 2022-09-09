Build_tools:
    type: world
    debug: false
    events:
        # on delta time hourly:
        #     - foreach <server.flag[check_block_stay]> as:block:
        #         - if !<[block].chunk.is_loaded||true>:
        #             - chunkload <[block].chunk> duration:5t
        #             - wait 1t
        #         - if <[block].material.name> == air:
        #             - flag <[block]> block_stay:!
        #             - flag server check_block_stay:<-:<[block]>
        on player right clicks block with:midair_placer using:off_hand:
        - if <player.item_in_hand.material.is_block||true> && <player.gamemode> == creative:
            - modifyblock <player.cursor_on[2]||player.location.forward> <player.item_in_hand.material||air> no_physics
            - flag <player.cursor_on[2]||player.location.forward> block_stay
            - flag server check_block_stay:|:<player.cursor_on[2]||player.location.forward>
        on player breaks block location_flagged:block_stay:
            - flag <context.location> block_stay:!
            - flag server check_block_stay:<-:<context.location>
        on *coral* fades location_flagged:block_stay:
            - determine cancelled
        on player places *coral*:
            - if <player.gamemode> != creative:
                - stop
            - if <player.item_in_offhand.has_flag[nodeath_coral]||false>:
                - flag <context.location> block_stay
                - flag server check_block_stay:|:<context.location>
            # - if <context.item_in_hand.has_flag[nodeath_coral]> && <player.gamemode> == creative:
            #     - flag <context.location> block_stay
            #     - flag server check_block_stay:|:<context.location>
        on player right clicks block with:coral_meal using:either_hand:
            - determine passively cancelled
            - if <player.gamemode> != creative:
                - stop
            - define revive <context.location.find_blocks.within[10].filter[material.name.advanced_matches[dead_*]]>
            - if <[revive].size||0> >= 1:
                - foreach <[revive]>:
                    - adjust <[value]> block_type:<[value].material.replace_text[dead_].with[]>
                - if <context.location.find_blocks.within[10].filter[material.name.advanced_matches[*coral*]].size> < 1:
                    - stop
                - foreach <context.location.find_blocks.within[10].filter[material.name.advanced_matches[*coral*]]> as:block:
                    - if !<[block].has_flag[block_stay]>:
                        - flag <[block]> block_stay
                        - flag server check_block_stay:|:<[block]>

        on player right clicks block:
            - if <player.item_in_offhand.script.name||none> != physics_freezer:
                - stop
            - determine passively cancelled
            - ratelimit <player> 1t
            - if ( <player.gamemode> != creative ) || !<player.item_in_hand.material.is_block||false>:
                - stop
            - if <context.relative||null> != null:
              - flag <context.relative> block_stay
              - modifyblock <context.relative> <player.item_in_hand.material>
              - flag server check_block_stay:|:<context.relative>
        on player places block:
            - if <player.item_in_offhand.script.name||none> != midair_placer:
                - stop
            - determine passively cancelled
            - ratelimit <player> 1t
            - if <player.gamemode> != creative || !<player.item_in_hand.material.is_block||false>:
                - stop
            - flag <context.location> block_stay
            - wait 1t
            - modifyblock <context.location> <player.item_in_hand.material> no_physics
            - flag server check_block_stay:|:<context.location>
        # on block physics location_flagged:block_stay:
        #     - determine cancelled
        # on block falls location_flagged:block_stay:
        #     - determine cancelled
        on player clicks item in builders_toolbox:
            - if <context.item.material.name> != air && <player.gamemode> == creative:
                - give <context.item>
        on player right clicks grass_block with:grass_only_bonemeal:
            - ratelimit <player> 2t
            - flag <player.location.find_blocks.within[10]> no_flowers duration:2t
        on player right clicks block with:fire_placer:
            - ratelimit <player> 2t
            - modifyblock <context.relative> fire
        on player right clicks grass_block with:flower_only_bonemeal:
            - ratelimit <player> 2t
            - flag <player.location.find_blocks.within[10]> no_grass duration:2t
        on block grows location_flagged:no_flowers:
            - if !<context.material.name.contains_any[grass]>:
                - determine cancelled
        on block grows location_flagged:no_grass:
            - if <context.material.name.contains_any[grass]>:
                - determine cancelled
        on player right clicks block with:physics_freezer:
            - determine cancelled
        on player right clicks block with:schematic_placer:
            - ratelimit <player> 2t
            - if !<player.has_flag[previewing_schem]>:
              - run sp_schematic_load
              - wait 1s
              - flag <player> sp_menu_num:1
              - inventory open d:schematic_menu
            - else:
                - schematic paste name:<player.flag[previewing_schem]> noair <player.cursor_on.above[<player.flag[previewing_schem_offset]||1>]> entities
        on player left clicks block with:schematic_placer:
          - ratelimit <player> 2t
          - determine passively cancelled
          - if <player.is_sneaking>:
            - run sp_schematic_load
            - wait 10t
            - flag <player> sp_menu_num:1
            - inventory open d:schematic_menu
            - stop
          - if !<player.has_flag[previewing_schem]>:
            - stop
          - schematic rotate name:<player.flag[previewing_schem]> angle:90
        on player scrolls their hotbar:
          #- ratelimit <player> 2t
          - if !<player.has_flag[previewing_schem]>:
            - stop
          - determine passively cancelled
          # - announce <context.previous_slot>
          # - announce " <context.new_slot> <&gt> <context.previous_slot> "
          - if ( <context.new_slot> > <context.previous_slot> ) || ( ( <context.new_slot> < <context.previous_slot> ) && <context.previous_slot> == 9 ):
            - flag <player> previewing_schem_offset:-:1
          - if ( <context.new_slot> < <context.previous_slot> ) || ( ( <context.new_slot> > <context.previous_slot> ) && <context.previous_slot> == 1 ):
            - flag <player> previewing_schem_offset:+:1
          - adjust <player> item_slot:<context.previous_slot>
        on player_flagged:previewing_schem drops schematic_placer:
            - determine passively cancelled
            - flag <player> previewing_schem:!
            - flag <player> previewing_schem_offset:!
        on player clicks schematic_asset in schematic_menu priority:2:
          - determine passively cancelled
          - flag <player> sp_schematic:<context.item.display>
          - actionbar "<green>Right click to place <green>| <red>Scroll to change elevation <green>| <gold>Left click to rotate <green>| <yellow>Drop to cancel"
          - flag <player> previewing_schem:<player.flag[sp_schematic]>
          - flag <player> sp_schematic:!
          - flag <player> previewing_schem_offset:1
          - flag <player> previewing_schem_rotate:0
          - schematic unload name:<player.flag[previewing_schem]>
          - schematic load name:<player.flag[previewing_schem]>
          - wait 5t
          - inventory close d:schematic_menu
          - run sp_schematic_unload
          - flag <player> sp_menu_num:!
          - run schematic_preview
        on player clicks sp_next in schematic_menu:
          - flag <player> sp_menu_num:++
          - inventory open d:schematic_menu
        on player clicks sp_back in schematic_menu:
          - flag <player> sp_menu_num:--
          - inventory open d:schematic_menu
        on player clicks sp_main in schematic_menu:
          - flag <player> sp_menu_num:1
          - inventory open d:schematic_menu
        #after player enters twreg_*:
        #  - time player <context.area.flag[rtime]> freeze
        #  - weather player <context.area.flag[rweather]>
        #after player exits twreg_*:
        #  - time player reset
        #  - weather player reset

schematic_preview:
    type: task
    debug: false
    script:
        - ~schematic load name:<player.flag[previewing_schem]>
        - while <player.item_in_hand.script.name||none> == schematic_placer && <player.has_flag[previewing_schem]>:
            - light <player.cursor_on> 2 duration:4t
            - schematic paste name:<player.flag[previewing_schem]> fake_to:<player> fake_duration:4t noair <player.cursor_on.above[<player.flag[previewing_schem_offset]||1>]>
            - wait 4t
        - flag <player> previewing_schem:!

sp_schematic_load:
  type: task
  debug: false
  script:
    - foreach <util.list_files[/schematics].alphabetical>:
      - if !<schematic.list.contains[<[value].replace[.schem].with[]>]>:
        - schematic load name:<[value].replace[.schem].with[]>
        - flag server temp_sp_load:|:<[value].replace[.schem].with[]>

sp_schematic_unload:
  type: task
  debug: false
  script:
    - foreach <server.flag[temp_sp_load]>:
      - schematic unload name:<[value]>
    - flag server temp_sp_load:!

midair_placer:
  type: item
  debug: false
  material: phantom_membrane
  display name: <aqua>Mid-Air Placer
  lore:
  - Hold in offhand to place any block in main hand, even in midair

schematic_placer:
  type: item
  debug: false
  material: paper
  display name: <aqua>Schematic placer
  lore:
  - Preview and place schematics!
  - <green>Right click to place
  - <red>Scroll to change elevation
  - <gold>Left click to rotate
  - <yellow>Drop to cancel

physics_freezer:
  type: item
  debug: false
  material: ender_eye
  display name: <green>Physics freezer
  lore:
  - Physics, BEGONE!
  - Place any block, anywhere!

coral_meal:
  type: item
  debug: false
  material: bone_meal
  display name: <blue>Coral Meal
  flags:
      nodeath_coral: true
  lore:
  - Hold in offhand & any coral placed will stay alive
  - Use on dead coral to revive!

grass_only_bonemeal:
    type: item
    debug: false
    material: bone_meal
    display name: <green>Grass only bonemeal
    lore:
    - All green, everyday

flower_only_bonemeal:
    type: item
    debug: false
    material: bone_meal
    display name: <light_purple>Flower only bonemeal
    lore:
    - True flower power

fire_placer:
    type: item
    debug: false
    material: fire_charge
    display name: <red>Fire Placer
    lore:
    - <red>BURN

invisible_item_frame:
    type: item
    debug: false
    material: item_frame[invisible=true]
    display name: <gray>Invisible Item frame

schematic_asset:
    type: item
    debug: false
    material: paper
    display name: <red>PLACEHOLDER
    lore:
    - <red>TEST

sp_back:
    type: item
    debug: false
    material: magenta_glazed_terracotta
    display name: <red>BACK

sp_next:
    type: item
    debug: false
    material: magenta_glazed_terracotta
    display name: <green>Next

sp_main:
    type: item
    debug: false
    material: magenta_glazed_terracotta
    display name: <green>First<&sp>Page

sp_prev:
    type: item
    debug: false
    material: magenta_glazed_terracotta
    display name: <green>Last<&sp>Used<&sp>schematic

schematic_menu:
  type: inventory
  inventory: chest
  debug: false
  size: 54
  title: Schematic<&sp>Menu
  procedural items:
      - define items <list[]>
      - foreach <schematic.list.alphabetical.get[<player.flag[sp_menu_num].mul[45].sub[44]>].to[<player.flag[sp_menu_num].mul[45]>]>:
        - if <[loop_index]> >= 46:
          - foreach stop
        - define items:->:<item[schematic_asset].with[display=<[value]>]>
      - while <[items].size> < 45:
        - define items:->:air
      - if <player.flag[sp_menu_num]> > 1:
        - define items:->:sp_back
      - else:
        - define items:->:air
      - if <player.flag[sp_menu_num]> <= <schematic.list.size.div[45]>:
        - define items:->:sp_next
      - else:
        - define items:->:air
      - determine <[items]>
  slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [air] [air] [air] [sp_main] [sp_prev] [air] [air] []

builders_toolbox:
    type: inventory
    inventory: chest
    gui: true
    debug: false
    title: Builders Toolbox
    slots:
    - [midair_placer] [coral_meal] [physics_freezer] [debug_stick] [barrier] [grass_only_bonemeal] [flower_only_bonemeal] [invisible_item_frame] [fire_placer]

builders_toolbox_command:
  type: command
  description: opens builders toolsbox
  name: tools
  debug: false
  usage: /tools
  aliases:
  - bt
  script:
    - if <player.gamemode> != creative:
      - narrate "You must be in creative mode to use this command"
      - stop
    - inventory open d:builders_toolbox

region_time_command:
  type: command
  description: set the local time in a WE region
  name: region_time
  debug: false
  usage: /region_time
  aliases:
  - rtime
  tab complete:
    - determine afternoon|day|midnight|night|noon|sunrise|sunset
  script:
    - if <player.gamemode> != creative:
      - narrate "You must be in creative mode to use this command"
      - stop
    - if <player.we_selection||none> == none:
      - narrate "You must have a worldedit region selected"
      - stop
    - if <player.we_selection.max.cuboids.filter[note_name.contains_any_text[twreg]].size||0> < 1:
      - if !<server.has_flag[twregions]>:
        - flag server twregions:1
      - note <player.we_selection> as:twreg_<server.flag[twregions].add[1]>
      - flag server twregions <server.flag[twregions].add[1]>
    - choose <context.args.get[1]>:
      - case afternoon:
        - define time 9000t
      - case day:
        - define time 0t
      - case midnight:
        - define time 18000t
      - case morning:
        - define time 1000t
      - case night:
        - define time 14000t
      - case noon:
        - define time 6000t
      - case sunrise:
        - define time 23000t
      - case sunset:
        - define time 12000t
      - default:
        - define time <context.args.get[1]>
    - flag <player.we_selection.max.cuboids.filter[note_name.contains_any_text[twreg]].get[1]> rtime:<[time]>
    - narrate "<green>Time set to <[time]> in this region"

region_weather_command:
  type: command
  description: set the local time in a WE region
  name: region_weather
  debug: false
  usage: /region_weather
  aliases:
  - rweather
  tab complete:
    - determine rain|clear|thunder
  script:
    - if <player.gamemode> != creative:
      - narrate "You must be in creative mode to use this command"
      - stop
    - if <player.we_selection||none> == none:
      - narrate "You must have a worldedit region selected"
      - stop
    - if <player.we_selection.max.cuboids.filter[note_name.contains_any_text[twreg]].size||0> < 1:
      - if !<server.has_flag[twregions]>:
        - flag server twregions:1
      - note <player.we_selection> as:twreg_<server.flag[twregions].add[1]>
      - flag server twregions <server.flag[twregions].add[1]>
    - choose <context.args.get[1]>:
      - case rain:
        - define weather storm
      - case thunder:
        - define weather thunder
      - default:
        - define weather sunny
    - flag <player.we_selection.max.cuboids.filter[note_name.contains_any_text[twreg]].get[1]> rweather:<[weather]>
    - narrate "<green>Weather set to <[weather]> in this region"
