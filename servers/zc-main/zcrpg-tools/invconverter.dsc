get_slot_map_task:
  type: task
  debug: false
  definitions: serializedmap
  script:
    - define slotmap <map[]>
    - foreach <[serializedmap].keys> as:key:
      - define itemmap <map[].with[item].as[<[serializedmap].get[<[key]>]>]>
      - define serialized <proc[map_serialize].context[<[itemmap]>]>
      - wait 1t
      - if <[itemmap].get[item].get[type]> == FILLED_MAP:
        - define item <item[filled_map]>
      - else:
        - define item <server.parse_bukkit_item[<[serialized]>]||null>
      #- narrate "<&c>DONE PARSING"
      #- narrate <[item]>
      - if <[item]> == null:
        - determine null
      - else:
        - if <[item].material.name> == player_head && !<[item].skull_skin.contains_text[|]>:
          - define item <item[player_head]>
        - define slotmap <[slotmap].with[<[key].add[1]>].as[<[item]>]>
    - determine <[slotmap]>

get_slot_map:
  type: procedure
  debug: false
  definitions: serializedmap
  script:
    - define slotmap <map[]>
    - foreach <[serializedmap].keys> as:key:
      - define itemmap <map[].with[item].as[<[serializedmap].get[<[key]>]>]>
      - define serialized <proc[map_serialize].context[<[itemmap]>]>
      #- narrate "<&c>PARSING BUKKIT ITEM"
      - define item <server.parse_bukkit_item[<[serialized]>]||null>
      #- narrate "<&c>DONE PARSING"
      - if <[item]> == null:
        - determine null
      - else:
        - if <[item].material.name> == player_head && !<[item].skull_skin.contains_text[|]>:
          - define item <item[player_head]>
        - define slotmap <[slotmap].with[<[key].add[1]>].as[<[item]>]>
    - determine <[slotmap]>

inv_converter:
  type: command
  name: invconv
  debug: false
  permission: aaaaaaaaaaa
  groups:
    - surbible
    - VIPCreative
    - dungeons
  worlds:
    s3: surbible
    spawn: surbible
    newnether: surbible
    news3: surbible
    s1: surbible
    theendkek: surbible
    s2: surbible
    dungeons: dungeons
    dungeonvip: VIPCreative
    NewVIP: VIPCreative
  script:
    - define numbers <util.list_numbers_to[36]>
    - define files <server.list_files[../Multiverse-Inventories/players]>
    - ~yaml load:../Multiverse-Inventories/groups.yml id:groups_conf
    - define groups_conf <yaml[groups_conf].read[groups]>
    - yaml unload id:groups_conf
    - foreach <[files]> as:file:
    #- foreach <[files]> as:file:
      - ~yaml load:../Multiverse-Inventories/players/<[file]> id:temp
      - define world <yaml[temp].read[playerData.lastWorld]||null>
      - define name <yaml[temp].read[playerData.lastKnownName]||null>
      - if <[world]> == null || <[name]> == null:
        - foreach next
      - yaml create id:BUILDING
      - define world_group <script.data_key[worlds].get[<[world]>]>
      - define group_invs <script.data_key[groups].exclude[<[world_group]>]>
      - narrate "<&a>Elapsed time: <queue.time_ran.in_minutes>m, <[loop_index]>/<[files].size>"

      - define inv_files:!|:../Multiverse-Inventories/worlds/<[world]>/<[name]>.json
      - define inv_files:|:../Multiverse-Inventories/groups/<[group_invs].get[1]>/<[name]>.json
      - define inv_files:|:../Multiverse-Inventories/groups/<[group_invs].get[2]>/<[name]>.json

      - foreach <[inv_files]> as:inv_file:
        - if !<server.has_file[<[inv_file]>]>:
          - foreach next
        - define group <[inv_file].after[groups/].before[/]>
        - if <[group].length> == 0:
          - define group <[world_group]>
        - narrate "<&a>Loading file <[inv_file]>"
        - define time <server.current_time_millis>
        - ~yaml load:<[inv_file]> id:temp
        #- narrate "Took <server.current_time_millis.sub[<[time]>]>ms"
        - foreach <yaml[temp].list_keys[]> as:gamemode:
          #- narrate <[gamemode]>

          - define inv_contents <yaml[temp].read[<[gamemode]>.inventoryContents]||<map[]>>
          #- narrate <[inv_contents].to_yaml>
          - if !<[inv_contents].is_empty>:
            #- ~run get_slot_map_task def:<[inv_contents]> save:foo
            #- define slot_map <entry[foo].created_queue.determination.get[1].get_subset[<[numbers]>]||null>
            - define slot_map <proc[get_slot_map].context[<[inv_contents]>].get_subset[<util.list_numbers_to[36]>]||null>
            - if <[slot_map]> == null:
              - narrate "<&c>WTF WENT WRONG 1"
              - foreach next
            - yaml set groups.<[group]>.<[gamemode]>.inventory:<[slot_map]> id:BUILDING

          #- narrate "got here 1"

          - define echest_contents <yaml[temp].read[<[gamemode]>.enderChestContents]||<map[]>>
          - if !<[echest_contents].is_empty>:
            - define slot_map <proc[get_slot_map].context[<[echest_contents]>]||null>
            #- ~run get_slot_map_task def:<[echest_contents]> save:foo
            #- define slot_map <entry[foo].created_queue.determination.get[1]||null>
            - if <[slot_map]> == null:
              - narrate "<&c>WTF WENT WRONG 2"
              - foreach next
            - yaml set groups.<[group]>.<[gamemode]>.enderchest:<[slot_map]> id:BUILDING

          #- narrate "got here 2"

          - define offhand <yaml[temp].read[<[gamemode]>.offHandItem]||<map[]>>
          - if <[offhand].get[type]||air> != air:
            - define item <proc[get_slot_map].context[<map[].with[0].as[<[offhand]>]>].get[1]||null>
            - if <[item]> == null:
              - narrate "<&c>WTF WENT WRONG 3"
              - foreach next
            - yaml set groups.<[group]>.<[gamemode]>.offhand:<[item]> id:BUILDING

          #- narrate "got here 3"

          - define armor_contents <yaml[temp].read[<[gamemode]>.armorContents]||<map[]>>
          #- narrate <[armor_contents].to_yaml>
          - if !<[armor_contents].is_empty>:
            - define slot_map <proc[get_slot_map].context[<[armor_contents]>]||null>
            #- narrate <[slot_map]>
            #- narrate "AAAAAAAAAAA"
            #- if <[slot_map]> == null:
            #  - narrate "<&c>WTF WENT WRONG 4"
            #  - foreach next
            #- narrate "BBBBBBBB"
            - define mappings <list[boots|leggings|chestplate|helmet]>
            #- narrate "CCCCCCCCC"
            - define armor_map <map[]>
            #- narrate "DDDDDDDDDDD"
            - repeat 4:
              - if <[slot_map].get[<[value]>]||null> != null:
                #- narrate <[value]>
                - define armor_map <[armor_map].with[<[mappings].get[<[value]>]>].as[<[slot_map].get[<[value]>]>]>
            #- narrate "SETTING YAML groups.<[group]>.<[gamemode]>.equipment, <[armor_map]>"
            - yaml set groups.<[group]>.<[gamemode]>.equipment:<[armor_map]> id:BUILDING
            #- narrate "DONE SETTING"

          #- narrate "got here 4"

      #- ~yaml savefile:blah.yml id:BUILDING
      - if !<yaml[BUILDING].list_keys[].is_empty>:
        - yaml savefile:inventories/<[file].before[.]>.yml id:BUILDING
      - yaml unload id:BUILDING
    - yaml unload id:temp
    - narrate "<&a>DONE!"
