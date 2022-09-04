openec_command:
  type: command
  description: Opens an ender chest
  debug: false
  usage: /openec (player) (group) (gamemode)
  name: openec
  permission: zc.openinv
  tab completions:
    1: <server.online_players.parse[name]>
    2: <script[inv_groups].data_key[groups].keys>
    3: survival|adventure|creative
  script:
    - define name <context.args.get[1]||null>
    - define group <context.args.get[2]||null>
    - define gamemode <context.args.get[3]||null>

    - if <[name]> == null:
      - narrate "<&c>You must provide a player name."
      - stop

    - define target <server.match_offline_player[<[name]>]||null>
    - if <[target]> == null:
      - narrate "<&e>Could not find a matching player for <[name]>."
      - stop
    - if <[group]> == null:
      - narrate "<&c>You must provide a group name."
      - stop
    - if !<list[survival|adventure|creative].contains[<[gamemode]>]>:
      - narrate "Must provide a valid gamemode."
      - stop

    - if <[target].is_online>:
      - inventory open d:players_ender_chest
      - inventory set d:<player.open_inventory> o:<yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.enderchest]||<map>>
    - else:
      - ~yaml load:inventories/<[target].uuid>.yml id:<[target].uuid>_inventories
      - inventory open d:players_ender_chest
      - inventory set d:<player.open_inventory> o:<yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.enderchest]||<map>>
      - yaml unload id:<[target].uuid>_inventories
openinv_command:
  type: command
  description: Opens an inventory
  debug: false
  usage: /openinv (player) (group) (gamemode)
  name: openinv
  permission: zc.openinv
  tab completions:
    1: <server.online_players.parse[name]>
    2: <script[inv_groups].data_key[groups].keys>
    3: survival|adventure|creative
  script:
    - define name <context.args.get[1]||null>
    - define group <context.args.get[2]||null>
    - define gamemode <context.args.get[3]||null>

    - if <[name]> == null:
      - narrate "<&c>You must provide a player name."
      - stop

    - define target <server.match_offline_player[<[name]>]||null>
    - if <[target]> == null:
      - narrate "<&e>Could not find a matching player for <[name]>."
      - stop

    - if <[target].is_online> && <[group]> == null:
      - define current_inv <yaml[<[target].uuid>_inventories].read[current_inventory].split[.]||null>
      - if <[current_inv]> == null:
        - narrate "<&c>This should never happen?"
        - stop
      - define group <[current_inv].get[2]>
      - define gamemode <[current_inv].get[3]>

    - if <[group]> == null:
      - narrate "<&c>You must provide a group name."
      - stop
    - if !<list[survival|adventure|creative].contains[<[gamemode]>]>:
      - narrate "Must provide a valid gamemode."
      - stop

    - if <[target].is_online>:
      #- if groups.<[group]>.<[gamemode]> == <yaml[<[target].uuid>_inventories].read[current_inventory]>:
      #  - inventory open d:<[target].inventory>
      #- else:
      - define helmet <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.helmet]||air>
      - define chestplate <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.chestplate]||air>
      - define leggings <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.leggings]||air>
      - define boots <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.boots]||air>
      - define offhand <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.offhand]||air>
      - inventory open d:players_inventory
      - inventory set d:<player.open_inventory> o:<yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.inventory]||<map>>
    - else:
      - ~yaml load:inventories/<[target].uuid>.yml id:<[target].uuid>_inventories
      - define helmet <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.helmet]||air>
      - define chestplate <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.chestplate]||air>
      - define leggings <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.leggings]||air>
      - define boots <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.equipment.boots]||air>
      - define offhand <yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.offhand]||air>
      - inventory open d:players_inventory
      - inventory set d:<player.open_inventory> o:<yaml[<[target].uuid>_inventories].read[groups.<[group]>.<[gamemode]>.inventory]||<map>>
      - yaml unload id:<[target].uuid>_inventories

openinv_world:
  type: world
  debug: false
  events:
    on player clicks in players_inventory permission:zc.openinv:
      - if <context.slot> in <list[37|38|39|40|41|42|43|44|45|51|52|53|54]>:
        - determine cancelled
      - define player "<server.match_offline_player[<context.inventory.title.before[, ]>]||error>"
      - define id <[player].uuid>_inventories
      - if <yaml.list.contains[<[id]>]> || <[player].is_online> || <[player]> == error:
        - narrate "Currently cannot change the players inventory" format:zc_text
        - determine cancelled
    on player clicks in players_ender_chest permission:zc.openinv:
      - define player "<server.match_offline_player[<context.inventory.title.before[, ]>]||error>"
      - define id <[player].uuid>_inventories
      - if <yaml.list.contains[<[id]>]> || <[player].is_online> || <[player]> == error:
        - narrate "Currently cannot change the players enderchest" format:zc_text
        - determine cancelled
    on player closes players_ender_chest permission:zc.openinv:
    - define inv <context.inventory>
    - define player "<server.match_offline_player[<[inv].title.before[, ]>]||error>"
    - define group "<[inv].title.after[, ].before_last[, ]>"
    - define gamemode "<[inv].title.after_last[, ]>"
    - define inventory <[inv].map_slots.get_subset[<util.list_numbers_to[27]>]||<map[]>>
    - define id <[player].uuid>_inventories
    - if <yaml.list.contains[<[id]>]> || <[player].is_online> || <[player]> == error:
      - narrate "Currently cannot change the players inventory" format:zc_text
      - stop
    - ~yaml load:inventories/<[player].uuid>.yml id:<[id]>
    - define path groups.<[group]>.<[gamemode]>
    # enderchest
    - if <[inventory].is_empty>:
      - yaml set <[path]>.enderchest:! id:<[id]>
    - else:
      - yaml set <[path]>.enderchest:<[inventory]> id:<[id]>
    - ~yaml savefile:inventories/<[player].uuid>.yml id:<[id]>
    - yaml unload id:<[id]>
    - narrate "succesfully edited the players enderchest" format:zc_text
    on player closes players_inventory permission:zc.openinv:
    - define inv <context.inventory>
    - define player "<server.match_offline_player[<[inv].title.before[, ]>]||error>"
    - define group "<[inv].title.after[, ].before_last[, ]>"
    - define gamemode "<[inv].title.after_last[, ]>"
    - definemap equipment:
        boots: <[inv].slot[49]||air>
        leggings: <[inv].slot[48]||air>
        chestplate: <[inv].slot[47]||air>
        helmet: <[inv].slot[46]||air>
    - define offhand <[inv].slot[50]||air>
    - define inventory <[inv].map_slots.get_subset[<util.list_numbers_to[36]>]||<map[]>>
    - define id <[player].uuid>_inventories
    - if <yaml.list.contains[<[id]>]> || <[player].is_online> || <[player]> == error:
      - narrate "Currently cannot change the players inventory" format:zc_text
      - stop
    - ~yaml load:inventories/<[player].uuid>.yml id:<[id]>
    - define path groups.<[group]>.<[gamemode]>
    # inventory
    - if <[inventory].is_empty>:
      - yaml set <[path]>.inventory:! id:<[id]>
    - else:
      - yaml set <[path]>.inventory:<[inventory]> id:<[id]>
    # equipment
    - if <[equipment].values.deduplicate> == <list[<item[air]>]>:
      - yaml set <[path]>.equipment:! id:<[id]>
    - else:
      - yaml set <[path]>.equipment:<[equipment]> id:<[id]>
    # offhand
      - yaml set <[path]>.offhand:<[offhand]> id:<[id]>
    - ~yaml savefile:inventories/<[player].uuid>.yml id:<[id]>
    - yaml unload id:<[id]>
    - narrate "succesfully edited the players inventory" format:zc_text
players_ender_chest:
  type: inventory
  inventory: chest
  size: 27
  debug: false
  title: <[target].name||error>, <[group]||error>, <[gamemode]||error>
players_inventory:
  type: inventory
  inventory: chest
  debug: false
  size: 54
  title: <[target].name||error>, <[group]||error>, <[gamemode]||error>
  slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - "[leather_helmet[display=<&f>Head Slot]] [leather_chestplate[display=<&f>Chest Slot]] [leather_leggings[display=<&f>Pants Slot]] [leather_boots[display=<&f>Boots Slot]] [shield[display=<&f>Offhand]] [gray_stained_glass_pane[display=<&f>]] [gray_stained_glass_pane[display=<&f>]] [gray_stained_glass_pane[display=<&f>]] [gray_stained_glass_pane[display=<&f>]]"
    - [<[helmet]||air>] [<[chestplate]||air>] [<[leggings]||air>] [<[boots]||air>] [<[offhand]||air>] [gray_stained_glass_pane[display=<&f>]] [gray_stained_glass_pane[display=<&f>]] [gray_stained_glass_pane[display=<&f>]] [gray_stained_glass_pane[display=<&f>]]
