ddoor_open:
    type: task
    debug: false
    script:
        - define door_name <[1].to_lowercase>
        - define properties <server.flag[<[1]>_ddoor_properties].as_map>
        - if <[properties].get[busy]||true> == true || ( <[properties].get[locked]||false> == true && <[2]||no> != bypasslock ) || <[properties].get[state]||false> == autoclose || <[properties].get[state]||false> == opened:
            - stop
        - flag server <[1]>_ddoor_properties:<server.flag[<[1]>_ddoor_properties].as_map.with[busy].as[true].with[state].as[opening]>
        - define properties <server.flag[<[1]>_ddoor_properties].as_map>
        - if <[properties].contains[opening_redstone_trigger]>:
            - modifyblock <[properties].get[opening_redstone_trigger]> redstone_block
        - if <[properties].contains[open_frames]> && <[properties].contains[origin]>:
            - repeat <[properties].get[open_frames]>:
                - if <schematic.list.contains[<[1]>_open_frame_<[value]>]>:
                    - repeat next
                - schematic load name:<[1]>_open_frame_<[value]>
            - repeat <[properties].get[open_frames]>:
                - schematic paste name:<[1]>_open_frame_<[value]> <[properties].get[origin]>
                - define pitch <[properties].get[open_pitch]||1.0>
                - define sound <[properties].get[open_sound]||block_piston_contract>
                - playsound <[properties].get[origin].as_location> sound:<[sound]> volume:1 pitch:<[pitch].add[<[value].mul[0.1]>]>
                - define delay <[properties].get[open_delay]||3t>
                - if <[value]> != <[properties].get[close_frames]>:
                    - wait <[delay]>
        - if <[properties].contains[open_redstone_trigger]>:
            - modifyblock <[properties].get[open_redstone_trigger]> redstone_block
            #- repeat <[properties].get[open_frames]>:
            #    - schematic unload name:<[1]>_open_frame_<[value]>
        - flag server <[1]>_ddoor_properties:<server.flag[<[1]>_ddoor_properties].as_map.with[busy].as[false].with[state].as[opened]>
        - if <[2]||false> == autoclose:
            - define door <server.notables.get[<server.notables.find_partial[ddoor_<[1]>]>]>
            - if <[door].players.size> < 1:
                - run ddoor_close def:<[1]>


ddoor_close:
    type: task
    debug: false
    script:
        - define door_name <[1].to_lowercase>
        - define properties <server.flag[<[1]>_ddoor_properties].as_map>
        - if <[properties].get[busy]||true> || ( <[properties].get[locked]||false> && <[2]||no> != bypasslock ) || <[properties].get[state]||false> == closed || ( !<server.notables.get[<server.notables.find_partial[ddoor_<[1]>]>].players.is_empty> && <[2]||no> != bypasslock ):
            - stop
        - flag server <[1]>_ddoor_properties:<server.flag[<[1]>_ddoor_properties].as_map.with[busy].as[true].with[state].as[closing]>
        - define properties <server.flag[<[1]>_ddoor_properties].as_map>
        - if <[properties].contains[closing_redstone_trigger]>:
            - modifyblock <[properties].get[closing_redstone_trigger]> redstone_block
        - if <[properties].contains[close_frames]> && <[properties].contains[origin]>:
            - repeat <[properties].get[close_frames]>:
                - if <schematic.list.contains[<[1]>_close_frame_<[value]>]>:
                    - repeat next
                - schematic load name:<[1]>_close_frame_<[value]>
            - repeat <[properties].get[close_frames]>:
                - schematic paste name:<[1]>_close_frame_<[value]> <[properties].get[origin]>
                - define pitch <[properties].get[close_pitch]||1.0>
                - define sound <[properties].get[close_sound]||block_piston_contract>
                - playsound <[properties].get[origin].as_location> sound:<[sound]> volume:1 pitch:<[pitch].sub[<[value].mul[0.1]>]>
                - define delay <[properties].get[close_delay]||3t>
                - if <[value]> != <[properties].get[close_frames]>:
                    - wait <[delay]>
        - if <[properties].contains[close_redstone_trigger]>:
            - modifyblock <[properties].get[close_redstone_trigger]> redstone_block
            #- repeat <[properties].get[close_frames]>:
            #    - schematic unload name:<[1]>_close_frame_<[value]>
        - flag server <[1]>_ddoor_properties:<server.flag[<[1]>_ddoor_properties].as_map.with[busy].as[false].with[state].as[closed]>

dungeon_doors:
    type: world
    debug: false
    events:
        on player enters ddoor_*:
        - if <player.gamemode> == spectator:
            - stop
        - define door_name <context.area.note_name.after[ddoor_]>
        - run ddoor_open def:<[door_name]>

        after player exits ddoor_*:
        - if <player.gamemode> == spectator:
            - stop
        - define door_name <context.area.note_name.after[ddoor_]>
        - run ddoor_close def:<[door_name]>

        on player right clicks block with lock_placer:
            - determine passively cancelled
            - ratelimit <player> 5t
            - define door_name <context.location.cuboids.get[<context.location.cuboids.find_partial[ddoor_]>].note_name.after[ddoor_]>
            - if <context.location.cuboids.find_partial[ddoor_]> >= 1 && <server.flag[<[door_name]>_ddoor_properties.state]||false> == closed:
                - spawn lock_entity <context.location.center.face[<player.eye_location.center>].forward[0.6].below[0.7]> save:lock
                - wait 2t
                - flag server <[door_name]>_ddoor_properties.locked:true
                - flag server <[door_name]>_ddoor_properties.lock_entities:|:<entry[lock].spawned_entity>
                - if <server.flag[<[door_name]>_ddoor_properties.lock_pos].size||0> >= 1:
                    - foreach <server.flag[<[door_name]>_ddoor_properties.lock_pos]>:
                        - if <[value].as_location.find.entities[lock_entity].within[0.1].is_empty||true>:
                            - flag server <[door_name]>_ddoor_properties.lock_pos:<-:<[value]>
                - flag server <[door_name]>_ddoor_properties.lock_pos:|:<entry[lock].spawned_entity.location>
                #delete lock pos with no lock entity spawned at them, this will leave only freshly spawned positions
                - flag <entry[lock].spawned_entity> ddoor:<[door_name]>
                - if <server.flag[<[door_name]>_ddoor_properties].as_map.contains[lock_id]>:
                    - flag <entry[lock].spawned_entity> lock_id:<server.flag[<[door_name]>_ddoor_properties.lock_id]>

        after player right clicks lock_entity:
        - ratelimit <player> 5t
        #- if !<player.inventory.contains.nbt[dungeon_key]>:
        - define dkey <player.item_in_hand>
        - if <player.item_in_hand.nbt[dungeon_key]||false> != <context.entity.flag[lock_id]||small_key>:
            - if !<player.inventory.contains.nbt[dungeon_key]>:
                - narrate "The door is locked. You need a <red><context.entity.flag[lock_id].as_element.replace[_].with[<&sp>]||small<&sp>key><reset> to open it"
                - playsound sound:block_iron_trapdoor_close pitch:0.2 volume:0.7 <context.entity.location> sound_category:blocks
                - wait 2t
                - playsound sound:block_iron_trapdoor_close pitch:0.1 volume:0.7 <context.entity.location> sound_category:blocks
                - stop
            - foreach <player.inventory.list_contents>:
                - if <[value].nbt[dungeon_key]||false> == <context.entity.flag[lock_id]||small_key>:
                    - define dkey <[value]>
                    - foreach stop
                - else if <[loop_index]> == <player.inventory.list_contents.size>:
                    - narrate "The door is locked. You need a <red><context.entity.flag[lock_id].as_element.replace_text[_].with[<&sp>]||small<&sp>key><reset> to open it"
                    - playsound sound:block_iron_trapdoor_close pitch:0.2 volume:0.7 <context.entity.location> sound_category:blocks
                    - wait 2t
                    - playsound sound:block_iron_trapdoor_close pitch:0.1 volume:0.7 <context.entity.location> sound_category:blocks
                    - stop
        - flag server <context.entity.flag[ddoor]>_ddoor_properties.lock_entities:<-:<context.entity>
        - playsound sound:item_armor_equip_netherite pitch:1.6 volume:0.7 <context.entity.location> sound_category:blocks
        - playsound sound:block_iron_trapdoor_open pitch:0.8 volume:0.7 <context.entity.location> sound_category:blocks
        - playsound sound:block_iron_door_open pitch:0.2 volume:1 <context.entity.location> sound_category:blocks
        - adjust <context.entity> gravity:true
        - playeffect effect:crit at:<context.entity.eye_location> quantity:10 visibility:100 offset:0.3
        - playeffect effect:smoke at:<context.entity.eye_location.above[0.5]> quantity:40 visibility:100 offset:0.2
        - if <player.gamemode> != CREATIVE:
            - take scriptname:<[dkey].script.name> quantity:1 from:<player.inventory>
        - if <server.flag[<context.entity.flag[ddoor]>_ddoor_properties.lock_entities].as_list.size||0> >= 1:
            - remove <context.entity>
            - stop
        - flag server <context.entity.flag[ddoor]>_ddoor_properties.locked:false
        - run ddoor_open def:<context.entity.flag[ddoor]>|<context.entity.location.cuboids.get[<context.entity.location.cuboids.find_partial[ddoor_]>]>
        - remove <context.entity>

        on player places small_key:
            - determine cancelled

ddoor_cmd:
    type: command
    name: ddoor
    description: commands for creating a dungeon door
    usage: /ddoor [set_region/set_property/set_frame/show_frame] [ddoor_name] (property) (property value)
    debug: true
    # tab completions:
    #     1: <list[set_region|set_property|set_frame|set_trigger|open|close|show_frame|delete].alphabetical>
    #     2: <server.flag[dungeon_doors].alphabetical>
    #     3: <list[state|busy|open_redstone_trigger|close_redstone_trigger|opening_redstone_trigger|closing_redstone_trigger|open_sound|close_sound|open_pitch|close_pitch|locked|open_delay|close_delay|lock_id].alphabetical>
    tab complete:
        - define base_cmds:|:set_region|set_property|set_frame|set_trigger|open|close|show_frame|delete
        # - if <player.is_op>:
        #     - define base_cmds:|:reload
        - define args <context.args>

        - if <context.raw_args.length> == 0 || <context.raw_args.char_at[<context.raw_args.length>]> == " " || <context.args.is_empty>:
            - define args:->:<empty>

        - if <[args].size> == 1:
            - determine <[base_cmds].filter[starts_with[<[args].get[1]>]].alphabetical>

        - if <[args].size> == 2:
            - determine <server.flag[dungeon_doors].alphabetical>
        - if <[args].size> == 3:
            - choose <[args].get[1]>:
                - case show_frame set_frame:
                    - determine <list[open|close]>
                - case open:
                    - determine <list[bypasslock|autoclose]>
                - case close:
                    - determine bypasslock
                - case set_property:
                    - determine <list[state|busy|open_redstone_trigger|close_redstone_trigger|opening_redstone_trigger|closing_redstone_trigger|open_sound|close_sound|open_pitch|close_pitch|locked|open_delay|close_delay|lock_id].alphabetical.filter[starts_with[<[args].get[3]>]]>
                - default:
                    - determine <empty>
        - if <[args].size> == 4:
            - choose <[args].get[3]>:
                - case open close:
                    - determine "<&lb>choose a frame number<&rb>"
                - case busy locked:
                    - determine <list[true|false].filter[starts_with[<[args].get[4]>]].alphabetical>
                - case state:
                    - determine <list[opening|open|closing|closed|autoclose].filter[starts_with[<[args].get[4]>]].alphabetical>
                - case lock_id:
                    - determine "<&lb>provide a lock id string <gold>eg. big_key<reset><&rb>"
                - case open_pitch close_pitch:
                    - determine "<&lb>choose a pitch value between 0.1 and 2.0<&rb>"
                - case open_delay close_delay:
                    - determine "<&lb>choose the number of ticks(t)/seconds(s)/minutes(m) between frames. <gold>eg. 5s<reset><&rb>"
                - case open_sound close_sound:
                    - determine <server.sound_types.filter[starts_with[<[args].get[4]>]].alphabetical>
                - case open_redstone_trigger close_redstone_trigger opening_redstone_trigger closing_redstone_trigger:
                    - define loc <list[]>
                    - if <player.cursor_on.material.is_solid||false>:
                        - define loc:|:<player.cursor_on.x>,<player.cursor_on.y>,<player.cursor_on.z>,<player.location.world.name>
                    - if <player.is_op>:
                        - define loc:|:<server.notes[locations]>
                    - determine "<[loc]>|<&lb>provide co-ordinates to place redstone in the format x,y,z,world name<&rb>"
                - default:
                    - determine <empty>
    script:
        - if !<player.is_op||true>:
            - narrate "<red>you do not have permissions to use this command"
            - stop
        - if <context.args.get[2].length||0> <= 1:
            - narrate "<red>Please supply a name for your dungeon door"
            - stop
        - define door_name <context.args.get[2].replace_text[ddoor_].with[].to_lowercase>
        - choose <context.args.get[1]>:
            - case set_region:
                - if <server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>A dungeon door of that name already exists. Please choose a new name, or use reset_region to override the existing region"
                    - stop
                - if <player.we_selection.volume||0> < 1:
                    - narrate "<red>There was an error creating your dungeon door, please ensure your world edit selection is greater than 1 block"
                    - stop
                - else:
                    - note <player.we_selection> as:ddoor_<[door_name]>
                    - wait 5t
                    - if <player.we_selection.intersects[ddoor_<[door_name]>]>:
                        - narrate "<green>Dungeon door: <gold><[door_name]><green> successfully created"
                        - flag server dungeon_doors:->:<[door_name]>
                        - flag server <[door_name]>_ddoor_properties:<map[state/closed|origin/<player.we_selection.blocks.get[<player.we_selection.blocks.size>]>|open_frames/<element[0].round>|close_frames/<element[0].round>|frame_region/<player.we_selection>].as_map>
                    - else:
                        - narrate "<red>There was an error creating your dungeon door, please ensure your world edit selection is greater than 1 block"
            - case set_frame:
                - if !<server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>Please supply a valid dungeon door name"
                    - stop
                - if !<context.args.get[4].is_integer||false>:
                    - narrate  "<red>Please specify a valid frame number"
                    - stop
                - if <server.flag[<[door_name]>_ddoor_properties.frame_region].size||0> < 1:
                    - narrate "<red>There was an error creating your dungeon door, please ensure your world edit selection is greater than 1 block"
                    - stop
                - choose <context.args.get[3]||null>:
                    - case open:
                        - if <context.args.get[4]> > <server.flag[<[door_name]>_ddoor_properties.open_frames]>:
                            - flag server <[door_name]>_ddoor_properties.open_frames:<context.args.get[4]>
                        - if <schematic.list.contains[<[door_name]>_open_frame_<context.args.get[4]>]>:
                            - schematic unload name:<[door_name]>_open_frame_<context.args.get[4]>
                            - adjust server delete_file:schematics/<[door_name]>_open_frame_<context.args.get[4]>.schem
                            - wait 2t
                        - schematic create name:<[door_name]>_open_frame_<context.args.get[4]> <server.flag[<[door_name]>_ddoor_properties.frame_region]> <server.flag[<[door_name]>_ddoor_properties.origin]>
                        - schematic save name:<[door_name]>_open_frame_<context.args.get[4]>
                        - narrate "<green>Open frame <gold><context.args.get[4]> <green>set for dungeon door <gold><[door_name]>"
                    - case close:
                        - if <context.args.get[4]> > <server.flag[<[door_name]>_ddoor_properties.close_frames]>:
                            - flag server <[door_name]>_ddoor_properties.close_frames:<context.args.get[4]>
                        - if <schematic.list.contains[<[door_name]>_close_frame_<context.args.get[4]>]>:
                            - schematic unload name:<[door_name]>_close_frame_<context.args.get[4]>
                            - adjust server delete_file:schematics/<[door_name]>_close_frame_<context.args.get[4]>.schem
                            - wait 2t
                        - schematic create name:<[door_name]>_close_frame_<context.args.get[4]> <server.flag[<[door_name]>_ddoor_properties.frame_region]> <server.flag[<[door_name]>_ddoor_properties.origin]>
                        - schematic save name:<[door_name]>_close_frame_<context.args.get[4]>
                        - narrate "<green>Close frame <gold><context.args.get[4]> <green>set for dungeon door <gold><[door_name]>"
                    - default:
                        - narrate "<red>Command must be input in the format: /ddoor set_frame [ddoor name] [open/close] [frame number]"
            - case show_frame:
                - choose <context.args.get[3]||null>:
                    - case open:
                        - define mode open
                    - case close:
                        - define mode close
                    - default:
                        - narrate "<red>Command must be input in the format: /ddoor show_frame [ddoor name] [open/close] [frame number]"
                - if ( <context.args.get[4]> <= <server.flag[<[door_name]>_ddoor_properties.open_frames]> ) && ( <schematic.list.contains[<[door_name]>_<[mode]>_frame_<context.args.get[4]>]> ) && <server.has_flag[<[door_name]>_ddoor_properties.origin]>:
                    - schematic load name:<[door_name]>_<[mode]>_frame_<context.args.get[4]>
                    - wait 2t
                    - schematic paste name:<[door_name]>_<[mode]>_frame_<context.args.get[4]> <server.flag[<[door_name]>_ddoor_properties.origin]>
                    - choose <[mode]>:
                        - case open:
                            - flag server <[door_name]>_ddoor_properties.state:opened
                        - case close:
                            - flag server <[door_name]>_ddoor_properties.state:closed
                        - default:
                            - stop
                - else:
                    - narrate "<red>There was an error showing frame <context.args.get[4]> for door <context.args.get[2]||null>. Please ensure this door is set up correctly"
            - case set_property:
                - if !<server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>Please supply a valid dungeon door name"
                - choose <context.args.get[3]||null>:
                    - case state:
                        - if <list[opening|open|closing|closed|autoclose].contains[<context.args.get[4]>].to_lowercase||false>:
                            - flag server <[door_name]>_ddoor_properties.state:<context.args.get[4].to_lowercase>
                            - narrate "<green>state value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply one of the following states: opening, closing, open, closed, autoclose"
                    - case busy:
                        - if <context.args.get[4].is_boolean||false>:
                            - flag server <[door_name]>_ddoor_properties.busy:<context.args.get[4]>
                            - narrate "<green>busy value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a boolean value"
                    - case locked:
                        - if <context.args.get[4].is_boolean||false>:
                            - flag server <[door_name]>_ddoor_properties.locked:<context.args.get[4]>
                            - narrate "<green>locked value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                            - if <context.args.get[4]||false> && <server.flag[<[door_name]>_ddoor_properties].as_map.contains[lock_pos]>:
                                - define lock_locs <server.flag[<[door_name]>_ddoor_properties.lock_pos].as_list>
                                - foreach <[lock_locs]>:
                                    - if !<[value].as_location.find_entities[lock_entity].within[0.1].is_empty||false>:
                                        - foreach next
                                    - spawn lock_entity <[value].as_location> save:lock
                                    - wait 2t
                                    - flag server <[door_name]>_ddoor_properties.lock_entities:|:<entry[lock].spawned_entity>
                                    - flag <entry[lock].spawned_entity> ddoor:<[door_name]>
                                    - if <server.flag[<[door_name]>_ddoor_properties].as_map.contains[lock_id]>:
                                        - flag <entry[lock].spawned_entity> lock_id:<server.flag[<[door_name]>_ddoor_properties.lock_id]>
                                    - narrate "<green>lock entity successfully spawned at <gold><[value].as_location.simple><green> for dungeon door <gold><[door_name]>"
                            - else if !<context.args.get[4]||false> && <server.flag[<[door_name]>_ddoor_properties].as_map.contains[lock_entities]>:
                                - remove <server.flag[<[door_name]>_ddoor_properties.lock_entities]>
                                - flag server <[door_name]>_ddoor_properties.lock_entities:!
                                - narrate "<green>lock entity removed for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a boolean value"
                    - case open_redstone_trigger:
                        - announce "<context.args.get[4].as_location.world.name> == <cuboid[ddoor_<[door_name]>].world.name>"
                        - if <server.notes.contains[<context.args.get[4].as_location>]||false>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[open_redstone_trigger].as[<context.args.get[4].as_location>]>
                            - narrate "<green>open_redstone_trigger value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a location tag in the same world as your dungeon door"
                    - case close_redstone_trigger:
                        - if <context.args.get[4].as_location.world||false> == <cuboid[ddoor_<[door_name]>].world>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[close_redstone_trigger].as[<context.args.get[4].as_location>]>
                            - narrate "<green>close_redstone_trigger value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a location tag in the same world as your dungeon door"
                    - case opening_redstone_trigger:
                        - if <context.args.get[4].as_location.world||false> == <cuboid[ddoor_<[door_name]>].world>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[opening_redstone_trigger].as[<context.args.get[4].as_location>]>
                            - narrate "<green>opening_redstone_trigger value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a location tag in the same world as your dungeon door"
                    - case closing_redstone_trigger:
                        - if <context.args.get[4].as_location.world||false> == <cuboid[ddoor_<[door_name]>].world>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[closing_redstone_trigger].as[<context.args.get[4].as_location>]>
                            - narrate "<green>closing_redstone_trigger value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a location tag in the same world as your dungeon door"
                    - case open_pitch:
                        - if <context.args.get[4].is_decimal>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[open_pitch].as[<context.args.get[4]>]>
                            - narrate "<green>open_pitch value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a decimal value between 0.1 and 2.0"
                    - case close_pitch:
                        - if <context.args.get[4].is_decimal>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[close_pitch].as[<context.args.get[4]>]>
                            - narrate "<green>close_pitch value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a decimal value between 0.1 and 2.0"
                    - case open_sound:
                        - if <server.sound_types.contains[<context.args.get[4]>]>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[open_sound].as[<context.args.get[4]>]>
                            - narrate "<green>open_sound value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a valid Bukkit sound name"
                    - case close_sound:
                        - if <server.sound_types.contains[<context.args.get[4]>]>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[close_sound].as[<context.args.get[4]>]>
                            - narrate "<green>close_sound value successfully set to <gold><context.args.get[4]><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a valid Bukkit sound name"
                    - case open_delay:
                        - if <context.args.get[4].as_duration||duration[0s]> > <duration[0s]>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[open_delay].as[<context.args.get[4].as_duration>]>
                            - narrate "<green>open_delay value successfully set to <gold><context.args.get[4].as_duration><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a duration greater than 0 seconds"
                    - case close_delay:
                        - if <context.args.get[4].as_duration||duration[0s]> > <duration[0s]>:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[close_delay].as[<context.args.get[4].as_duration>]>
                            - narrate "<green>close_delay value successfully set to <gold><context.args.get[4].as_duration><green> for dungeon door <gold><[door_name]>"
                        - else:
                            - narrate "<red>Please supply a duration greater than 0 seconds"
                    - case lock_id:
                        - if <context.args.get[4].as_element.replace_text[_].with[<&sp>].length||0> > 0:
                            - flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[lock_id].as[<context.args.get[4].as_element.replace_text[<&sp>].with[_]>]>
                            - narrate "<green>lock_id value successfully set to <gold><context.args.get[4].as_element.replace_text[_].with[<&sp>]><green> for dungeon door <gold><[door_name]>"
                            - if <server.flag[<[door_name]>_ddoor_properties].as_map.contains[lock_entities]||false>:
                                - foreach <server.flag[<[door_name]>_ddoor_properties].as_map.get[lock_entities].as_list>:
                                    - if <[value].as_entity.is_spawned||false>:
                                        - flag <[value].as_entity> lock_id:<server.flag[<[door_name]>_ddoor_properties].as_map.get[lock_id].as_element>
                        - else:
                            - narrate "<red>Please supply a lock id name"
                    - default:
                        - narrate "<red>Please enter a valid property name"
            - case set_trigger:
                - if !<server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>No dungeon door of that name exists."
                    - stop
                - if <player.we_selection.volume||0> < 1:
                    - narrate "<red>There was an error setting your dungeon door trigger region, please ensure your world edit selection is greater than 1 block"
                    - stop
                - else:
                    - note <player.we_selection> as:ddoor_<[door_name]>
                    - wait 5t
                    - if <player.we_selection.intersects[ddoor_<[door_name]>]>:
                        - narrate "<green>Trigger region set for dungeon door: <gold><[door_name]><green>"
                        #- flag server <[door_name]>_ddoor_properties:<server.flag[<[door_name]>_ddoor_properties].as_map.with[origin].as[<player.we_selection.blocks.get[<player.we_selection.blocks.size>]>]>
                    - else:
                        - narrate "<red>There was an error setting your dungeon door trigger region, please ensure your world edit selection is greater than 1 block"
            - case open:
                - if !<server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>No dungeon door of that name exists."
                    - stop
                - run ddoor_open def:<[door_name]>|<context.args.get[3]||null>
            - case close:
                - if !<server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>No dungeon door of that name exists."
                    - stop
                - run ddoor_close def:<[door_name]>|<context.args.get[3]||null>
            - case delete:
                - if !<server.flag[dungeon_doors].contains[<[door_name]>]>:
                    - narrate "<red>No dungeon door of that name exists. Please choose a valid ddoor name"
                    - stop
                - else:
                    - note remove as:ddoor_<[door_name]>
                    - repeat <server.flag[<[door_name]>_ddoor_properties.open_frames]>:
                        - if !<server.has_file[/schematics/<[door_name]>_open_frame_<[value]>.schem]>:
                            - foreach next
                        - adjust server delete_file:/schematics/<[door_name]>_open_frame_<[value]>.schem
                    - repeat <server.flag[<[door_name]>_ddoor_properties.close_frames]>:
                        - if !<server.has_file[/schematics/<[door_name]>_close_frame_<[value]>.schem]>:
                            - foreach next
                        - adjust server delete_file:/schematics/<[door_name]>_close_frame_<[value]>.schem
                    - if !<server.flag[<[door_name]>_ddoor_properties.lock_entities].is_empty||true>:
                        - announce haslock
                        - remove <server.flag[<[door_name]>_ddoor_properties.lock_entities]>
                    - flag server dungeon_doors:<-:<[door_name]>
                    - flag server <[door_name]>_ddoor_properties:!
                    - narrate "<green>Dungeon door: <gold><[door_name]><green> successfully deleted"

        # - define actionID <util.random_uuid>
        # - if <server.flag[opendoors].contains_any[<context.cuboids.get[0].notable_name>]>:
        #    - flag server opendoors:<-:<context.cuboids.get[0].notable_name>
        #    - define loc1 <context.cuboids.get[0].min.add[1,0,0].sub[0,1,0]>
        #    - define loc2 <context.cuboids.get[0].max>
        #    - define height <math:<[loc2].y.abs.round>-<[loc1].y.abs.round>>
        #    - define zlen <math:<[loc1].z.abs.round>-<[loc2].z.abs.round>>
        #    - define stored1 <[loc1].sub[0,<math:<[height]>+1>,0]>
        #    - repeat <[height]>:
        #        - define nstored1 <[stored1].add[0,<[value]>,0]>
        #        - define nstored2 <[stored1].add[0,<[value]>,<[zlen]>]>
        #        - schematic create name:clone_<[actionID]> cu@<[nstored1]>|<[nstored2]> <[stored1]>
        #        - define nheight <math:<[height]>-<math:<[value]>-1>>
        #        - define ypaste <[loc1].add[0,<[nheight]>,0]>
        #        - schematic paste name:clone_<[actionID]> <[ypaste].sub[0,<[value]>,0]> noair
        #        - schematic unload name:clone_<[actionID]>

        #        - modifyblock cu@<[nstored1]>|<[nstored2]> air
        #        - playsound <[stored1]> sound:BLOCK_PISTON_CONTRACT pitch:0.5 volume:0.5
        #        - wait 2t

update_ddoors:
    type: task
    debug: true
    script:
        - foreach <server.flag[dungeon_doors]>:
            - flag server <[value].replace_text[ddoor_].with[].to_lowercase>_ddoor_properties.frame_region:<cuboid[ddoor_<[value].replace_text[ddoor_].with[].to_lowercase>]>
lock_entity:
    debug: false
    type: entity
    entity_type: <entity[armor_stand]>
    gravity: false
    invulnerable: false
    custom_name: Lock
    is_small: true
    equipment: <list[<item[air]>|<item[air]>|<item[air]>|<item[lodestone]>|<item[air]>]>
    visible: false
    disabled_slots: HEAD|CHEST|LEGS|FEET
    scoreboard_tags: <list[Custom_Entity|Lock_Entity]>

Lock_Placer:
    type: item
    debug: false
    material: <item[lodestone]>
    display name: Lock_Placer
    lore:
    - "Right click Defined Dungeon doors to create a lock"

Small_Key:
    type: item
    debug: false
    material: <item[tripwire_hook[nbt=<list[Dungeon_Key/Small_key]>]]>
    display name: <aqua>Small Key
    lore:
    - "Can be used to unlock certain dungeon doors"

Boss_Key:
    type: item
    debug: false
    material: <item[tripwire_hook[nbt=<list[Dungeon_Key/Boss_key]>]]>
    display name: <gold><bold>Boss Key
    lore:
    - "Can be used to unlock a Boss door"
