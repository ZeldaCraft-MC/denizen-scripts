# Server flag: easter_points_flag_name set to easter_points_YEAR

rav_format:
  type: format
  debug: false
  format: <&a>[Ravioli] <&7><[text]>

easter_npc_cmd:
  type: command
  description: Created an easter NPC
  usage: /easter_npc
  debug: false
  name: easter_npc
  permission: zc.create_easter_npc
  tab completions:
    1: <server.flag[warps].keys>
  script:
    - if <context.args.get[1]||null> == null || !<server.flag[warps].contains[<context.args.get[1]>]>:
      - narrate "Usage: /easter_npc (warp)"
      - stop
    - create player Ravioli <player.location> save:rav
    - wait 1t
    - assignment set script:easter_assignment to:<entry[rav].created_npc>
    - adjust <entry[rav].created_npc> skin_blob:<server.flag[rav_skin]>
    - lookclose <entry[rav].created_npc> state:true range:5
    - adjust <entry[rav].created_npc> name_visible:false
    - adjust <entry[rav].created_npc> hologram_line_height:0.25
    - adjust <entry[rav].created_npc> "hologram_lines:<&color[#fdcede]>Happy Easter!|<&color[#fffcb8]>Click to interact|<&color[#9ef8df]>Ravioli"
    - flag <entry[rav].created_npc> essentials_warp:<context.args.get[1]>

easter_cleanup:
  type: world
  debug: false
  events:
    on player quits:
      - if <player.has_flag[finding_eggs]>:
        - flag player easter_timer:!
        - run easter_stop_finding
      - else if <player.has_flag[hiding_eggs]>:
        - run easter_stop_hiding def:true
      - flag player easter_npc:!
      - flag player hiding_eggs:!
      - flag player finding_eggs:!

easter_redeem_points:
  type: task
  debug: false
  script:
    - define num_eggs <player.flag[<server.flag[easter_points_flag_name]>].div_int[20]||0>
    - if <[num_eggs]> == 0:
      - narrate "You don't have enough points to redeem! You need 20 points per egg." format:rav_format
      - stop
    - flag player <server.flag[easter_points_flag_name]>:-:<[num_eggs].mul[20]>
    - give easter_egg[quantity=<[num_eggs]>]
    - narrate "You redeemed <&e><[num_eggs].mul[20]>pts<&7> for <&e>x<[num_eggs]> easter egg<&7>! You can throw these or trade them in for items in my shop!" format:rav_format

easter_open_menu:
  type: task
  debug: false
  script:
    - inventory open d:easter_menu_1

easter_assignment_inject:
  type: task
  debug: false
  script:
    - flag player easter_npc:<npc>
    - if <player.flag[<server.flag[easter_points_flag_name]>]||0> < 20:
      - run easter_open_menu
    - else:
      - narrate "What would you like to do?" format:rav_format
      - clickable easter_redeem_points usages:1 for:<player> until:1m save:redeem
      - clickable easter_open_menu usages:1 for:<player> until:1m save:open
      - narrate "<element[<&d>[Redeem Points (<player.flag[<server.flag[easter_points_flag_name]>]||0>)]].on_click[<entry[redeem].command>].on_hover[Click to redeem!]> <element[<&b>[Open Easter Menu]].on_click[<entry[open].command>].on_hover[Click to open!]>"

easter_assignment:
  type: assignment
  debug: false
  actions:
    on assignment:
      - trigger name:click state:true
      - trigger name:damage state:true
      - trigger name:proximity state:true
    on click:
      - inject easter_assignment_inject
    on damage:
      - inject easter_assignment_inject
    on move proximity:
      - ratelimit <npc> 1s
      - adjust <npc> velocity:0,0.15,0

get_easter_points:
  type: procedure
  debug: false
  definitions: attempts
  script:
    - if <[attempts]> < 10:
      - determine 20
    - if <[attempts]> < 25:
      - determine 40
    - if <[attempts]> < 50:
      - determine 60
    - if <[attempts]> < 75:
      - determine 80
    - if <[attempts]> < 100:
      - determine 100
    - determine 666

easter_shop_item:
  type: item
  debug: false
  material: turtle_spawn_egg
  display name: Easter Shop

easter_hide_item:
  type: item
  debug: false
  material: sheep_spawn_egg
  display name: Hide Eggs

easter_find_item:
  type: item
  debug: false
  material: wolf_spawn_egg
  display name: Find Eggs

easter_my_eggs_item:
  type: item
  debug: false
  material: drowned_spawn_egg
  display name: My Hidden Eggs

easter_other_locations_item:
  type: item
  debug: false
  material: pufferfish_spawn_egg
  display name: Other Locations

easter_menu_1:
  type: inventory
  debug: false
  inventory: chest
  title: <&f>Easter Menu
  size: 36
  gui: true
  slots:
    - [wsgp] [lsgp] [osgp] [ysgp] [psgp] [lbsgp] [msgp] [lsgp] [wsgp]
    - [wsgp] [] [easter_hide_item] [] [easter_find_item] [] [easter_shop_item] [] [wsgp]
    - [wsgp] [] [] [easter_my_eggs_item] [] [easter_other_locations_item] [] [] [wsgp]
    - [wsgp] [lsgp] [msgp] [lbsgp] [psgp] [ysgp] [osgp] [lsgp] [wsgp]

easter_previous_page:
  type: item
  debug: false
  material: paper
  display name: Previous Page

easter_next_page:
  type: item
  debug: false
  material: paper
  display name: Next Page

easter_current_page:
  type: item
  debug: false
  material: book
  display name: Current Page

wsgp:
  type: item
  debug: false
  material: white_stained_glass_pane
  display name: <&f>

lsgp:
  type: item
  debug: false
  material: lime_stained_glass_pane
  display name: <&f>

ysgp:
  type: item
  debug: false
  material: yellow_stained_glass_pane
  display name: <&f>

osgp:
  type: item
  debug: false
  material: orange_stained_glass_pane
  display name: <&f>

psgp:
  type: item
  debug: false
  material: pink_stained_glass_pane
  display name: <&f>

lbsgp:
  type: item
  debug: false
  material: light_blue_stained_glass_pane
  display name: <&f>

msgp:
  type: item
  debug: false
  material: magenta_stained_glass_pane
  display name: <&f>

easter_menu_2:
  type: inventory
  debug: false
  inventory: chest
  title: <&f>Find an egg!
  size: 54
  gui: true
  slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [easter_previous_page] [lsgp] [osgp] [ysgp] [easter_current_page] [psgp] [lbsgp] [msgp] [easter_next_page]

easter_other_locations_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&f>Ravioli Locations
  size: 9
  gui: true
  slots:
    - [] [] [] [] [] [] [] [] []

easter_my_eggs_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: <&f>My Hidden Eggs
  gui: true
  size: 9
  slots:
    - [] [] [] [] [] [] [] [] []

populate_easter_inv:
  type: task
  debug: false
  script:
    - define items <list[]>
    - foreach <player.flag[easter_npc].flag[hidden_eggs]||<map>> key:player as:id:
      - foreach <[id]> key:id as:egg_info:
        - define lore "<&7>Total Attempts: <&d><[egg_info].get[attempts]>|<&7>Time: <&b><[egg_info].get[time].add[5]>s|<&7>Value: <&e><[egg_info].get[attempts].proc[get_easter_points]>pts||<&a>Left click to hunt!"
        - define "items:->:<[player].flag[skull_item].with[lore=<[lore]>;display=<[player].name>'s Egg #<[loop_index]>].with_flag[easter_id:<[id]>].with_flag[player:<[player]>]>"
    - flag player open_easter_page:<player.flag[open_easter_page].min[<[items].size.sub[1].div_int[45].add[1]>]>
    - define page <player.flag[open_easter_page]>
    - define items <[items].get[<[page].mul[45].sub[44]>].to[<[page].mul[45]>]>
    - if !<[items].is_empty>:
      - inventory set d:<player.open_inventory> o:easter_menu_2
      - inventory set d:<player.open_inventory> slot:50 o:easter_current_page[quantity=<[page]>]
      - inventory set d:<player.open_inventory> o:<[items]>

easter_stop_hiding:
  type: task
  debug: false
  definitions: logging_out
  script:
    - adjust <player> stop_sound:zc_sfx.music.oot_horse_race
    - playsound sound:zc_sfx.oot.oot_horse_whistle custom <player> volume:100 sound_category:records
    - execute as_server "/lp user <player.name> permission unset essentials.signs.use.warp server=zc-main"
    - adjust <player> unhide_entities:player
    - adjust <player> unhide_entities:npc
    #- adjust <player> show_entity:<player.flag[easter_npc]>
    - define time <player.flag_expiration[easter_timer].from_now.in_seconds.round_down||0>
    - flag player easter_timer:!
    - flag player hiding_eggs:!
    - adjust <player> show_to_players
    - adjust <player> gamemode:survival
    - if !<[logging_out]||false>:
      - if <player.is_on_ground> || <player.location.material.name> == water:
        - define egg_id <util.random_uuid>
        - flag <player.flag[easter_npc]> hidden_eggs.<player>.<[egg_id]>.location:<player.location>
        - flag <player.flag[easter_npc]> hidden_eggs.<player>.<[egg_id]>.attempts:0
        - flag <player.flag[easter_npc]> hidden_eggs.<player>.<[egg_id]>.time:<element[60].sub[<[time]>]>
        - flag <player.flag[easter_npc]> hidden_eggs.<player>.<[egg_id]>.id:<[egg_id]>
        - flag <player.flag[easter_npc]> hidden_eggs.<player>.<[egg_id]>.player:<player>
        - narrate "You placed an easter egg! Other players can hunt for your egg to earn rewards!" format:rav_format
      - else:
        - narrate "<&c>You were not on ground or in water, so your egg was not placed!" format:rav_format
    - teleport <player> <server.flag[warps].get[<player.flag[easter_npc].flag[essentials_warp]>]>
    - wait 10t
    - adjust <player> unhide_entities:player
    - adjust <player> unhide_entities:npc

easter_repeating_event:
  type: world
  debug: false
  events:
    on player steps on block in:spawn|oot flagged:finding_eggs:
      - ratelimit <player> 1t
      - if <player.has_flag[easter_timer]>:
        - define distance <player.location.distance[<player.flag[finding_eggs.location]>]>
        - actionbar <[distance].round_down>m
        - if <[distance]> < 1:
          - run easter_stop_finding
    on system time secondly:
      - define players <server.online_players_flagged[easter_timer]>
      - if <[players].is_empty>:
        - stop
      - title subtitle:<player.flag_expiration[easter_timer].from_now.in_seconds.round_down> stay:1s fade_out:0s targets:<[players]> per_player

easter_stop_finding:
  type: task
  debug: false
  definitions: logging_out
  script:
    - adjust <player> stop_sound:zc_sfx.music.oot_horse_race
    - playsound sound:zc_sfx.oot.oot_horse_whistle custom <player> volume:100 sound_category:records
    - execute as_server "/lp user <player.name> permission unset essentials.signs.use.warp server=zc-main"
    - if <player.has_flag[egg_entity]>:
      - remove <player.flag[egg_entity]>
    - adjust <player> unhide_entities:player
    - adjust <player> unhide_entities:npc
    #- adjust <player> show_entity:<player.flag[easter_npc]>
    - adjust <player> show_to_players
    - adjust <player> gamemode:survival
    - teleport <player> <server.flag[warps].get[<player.flag[easter_npc].flag[essentials_warp]>]>
    - if <player.has_flag[easter_timer]>:
      - define attempts <player.flag[easter_npc].flag[hidden_eggs.<player.flag[finding_eggs.player]>.<player.flag[finding_eggs.id]>.attempts]>
      - flag <player.flag[easter_npc]> hidden_eggs.<player.flag[finding_eggs.player]>.<player.flag[finding_eggs.id]>:!
      - flag player <server.flag[easter_points_flag_name]>:+:<[attempts].proc[get_easter_points]>
      - narrate "You found <player.flag[finding_eggs.player].name>'s hidden egg! <&e>+<[attempts].proc[get_easter_points]> easter points" format:rav_format
      - if <player.flag[finding_eggs.player].is_online>:
        - narrate "<player.name> found one of your eggs at <&e>/warp <player.flag[easter_npc].flag[essentials_warp]><&7>! You should go hide another egg there!" targets:<player.flag[finding_eggs.player]> format:rav_format
    - else:
      - narrate "<&c>You failed to find the egg! Better luck next time!" format:rav_format
      - flag <player.flag[finding_eggs.player]> <server.flag[easter_points_flag_name]>:+:5
      - if <player.flag[finding_eggs.player].is_online>:
        - narrate "<player.name> could not find one of your eggs in time! <&e>+5 easter points" targets:<player.flag[finding_eggs.player]> format:rav_format
      - flag <player.flag[easter_npc]> hidden_eggs.<player.flag[finding_eggs.player]>.<player.flag[finding_eggs.id]>.attempts:++
      - flag <player.flag[easter_npc]> hidden_eggs.<player.flag[finding_eggs.player]>.<player.flag[finding_eggs.id]>.is_being_found:!
    - flag player finding_eggs:!
    - flag player easter_timer:!
    - flag player egg_entity:!
    - wait 10t
    - adjust <player> unhide_entities:player
    - adjust <player> unhide_entities:npc

countdown_from_3:
  type: task
  debug: false
  script:
    - define loc <server.flag[warps].get[<player.flag[easter_npc].flag[essentials_warp]>]>
    - adjust <player> hide_entities:player
    - adjust <player> hide_entities:npc
    - teleport <player> <[loc]> cause:unknown
    - spawn armor_stand[visible=false;disabled_slots=chest|feet|hand|head|legs|off_hand] <[loc]> save:e
    - adjust <player> spectate:<entry[e].spawned_entity>
    - title title:3 stay:1s
    - wait 1.5s
    - title title:2 stay:1s
    - wait 1.5s
    - title title:1 stay:1s
    - playsound sound:zc_sfx.music.oot_horse_race custom <player> volume:700 sound_category:records
    - wait 1.5s
    - title title:GO! fade_in:0s stay:1s
    - if <player.is_online>:
      - adjust <player> spectate:<player>
      - teleport <player> <[loc]> cause:unknown
    - remove <entry[e].spawned_entity>

easter_exploit_blocker:
  type: world
  debug: false
  events:
    on player kicked for flying:
      - determine passively fly_cooldown:20s
      - determine passively cancelled
    on command flagged:finding_eggs:
      - determine fulfilled
    on command flagged:hiding_eggs:
      - determine fulfilled
    on player stands on turtle_egg in:spawn|oot:
      - determine cancelled
    on player potion effects modified:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - if <context.action> == removed || <context.action> == cleared:
          - stop
        - determine passively cancelled
        - wait 1t
        - adjust <player> remove_effects
    on player teleports bukkit_priority:lowest:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - if <context.cause> != unknown:
          - determine cancelled
    on player picks up item:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player damaged:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player starts gliding:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player right clicks entity:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player drops item:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player clicks in inventory:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player drags in inventory:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled
    on player swaps items:
      - if <player.has_flag[finding_eggs]> || <player.has_flag[hiding_eggs]>:
        - determine cancelled

easter_npc_events:
  type: world
  debug: false
  events:
    after player joins:
      - wait 2s
      - flag <player> skull_item:<player.skull_item>
    on player closes inventory:
      - flag player open_easter_page:!
    on player kicked:
      - if "<context.reason.contains_text[Cannot interact with self]>" || "<context.reason.contains_text[You dropped your items too quickly]>":
        - determine cancelled
    on player right clicks block with:easter_egg_placer bukkit_priority:lowest:
      - determine passively cancelled
      - ratelimit <player> 1t
      - if <player.has_flag[easter_timer]>:
        - if <player.flag_expiration[easter_timer].from_now.in_seconds> > 50:
          - narrate "<&c>You're trying to place your egg too soon! Try to find a more difficult spot!" format:rav_format
          - stop
        - if <server.flag[warps].get[<player.flag[easter_npc].flag[essentials_warp]>].distance[<player.location>]> < 20:
          - narrate "<&c>You're trying to place your egg too close to the spawn! Try to find a more difficult spot!" format:rav_format
          - stop
        - run easter_stop_hiding
    on player right clicks block with:easter_egg_cancel bukkit_priority:lowest:
      - determine passively cancelled
      - ratelimit <player> 1t
      - execute as_server "/lp user <player.name> permission unset essentials.signs.use.warp server=zc-main"
      - adjust <player> unhide_entities:player
      - adjust <player> unhide_entities:npc
      #- adjust <player> show_entity:<player.flag[easter_npc]>
      - flag player easter_timer:!
      - flag player hiding_eggs:!
      - adjust <player> show_to_players
      - adjust <player> gamemode:survival
      - narrate "You cancelled placing your egg!" format:rav_format
      - teleport <player> <server.flag[warps].get[<player.flag[easter_npc].flag[essentials_warp]>]>
      - adjust <player> stop_sound:zc_sfx.music.oot_horse_race
      - playsound sound:zc_sfx.oot.oot_horse_whistle custom <player> volume:100 sound_category:records
      - wait 10t
      - adjust <player> unhide_entities:player
      - adjust <player> unhide_entities:npc
    on player right clicks block with:easter_egg_cancel_find bukkit_priority:lowest:
      - determine passively cancelled
      - ratelimit <player> 1t
      - if <player.has_flag[egg_entity]>:
        - remove <player.flag[egg_entity]>
      - execute as_server "/lp user <player.name> permission unset essentials.signs.use.warp server=zc-main"
      - adjust <player> unhide_entities:player
      - adjust <player> unhide_entities:npc
      #- adjust <player> show_entity:<player.flag[easter_npc]>
      - narrate "<&c>You failed to find the egg! Better luck next time!" format:rav_format
      - flag <player.flag[finding_eggs.player]> <server.flag[easter_points_flag_name]>:+:5
      - if <player.flag[finding_eggs.player].is_online>:
        - narrate "<player.name> could not find one of your eggs in time! <&e>+5 easter points" targets:<player.flag[finding_eggs.player]> format:rav_format
      - flag <player.flag[easter_npc]> hidden_eggs.<player.flag[finding_eggs.player]>.<player.flag[finding_eggs.id]>.attempts:++
      - flag <player.flag[easter_npc]> hidden_eggs.<player.flag[finding_eggs.player]>.<player.flag[finding_eggs.id]>.is_being_found:!
      - flag player easter_timer:!
      - flag player finding_eggs:!
      - flag player egg_entity:!
      - adjust <player> show_to_players
      - adjust <player> gamemode:survival
      - teleport <player> <server.flag[warps].get[<player.flag[easter_npc].flag[essentials_warp]>]>
      - adjust <player> stop_sound:zc_sfx.music.oot_horse_race
      - playsound sound:zc_sfx.oot.oot_horse_whistle custom <player> volume:100 sound_category:records
      - wait 10t
      - adjust <player> unhide_entities:player
      - adjust <player> unhide_entities:npc
    on player right clicks item_flagged:easter_id in easter_menu_2:
    - if <player.name> != greenleeuw:
      - stop
    - determine passively cancelled
    - flag <player.flag[easter_npc]> hidden_eggs.<context.item.flag[player]>.<context.item.flag[easter_id]>.is_being_found:!
    on player clicks item_flagged:easter_id in easter_menu_2:
      - if <context.item.flag[player].uuid> == <player.uuid>:
        - narrate "<&c>You can't hunt your own egg!" format:rav_format
        - stop
      - if !<player.flag[easter_npc].has_flag[hidden_eggs.<context.item.flag[player]>.<context.item.flag[easter_id]>]>:
        - narrate "<&c>This egg has already been found! Refreshing list..." format:rav_format
        - inventory open d:easter_menu_2
        - flag player open_easter_page:1
        - run populate_easter_inv
        - stop
      - if <player.flag[easter_npc].has_flag[hidden_eggs.<context.item.flag[player]>.<context.item.flag[easter_id]>.is_being_found]>:
        - narrate "<&c>Sorry! Someone else is already searching for this egg." format:rav_format
        - stop
      - execute as_server "/lp user <player.name> permission set essentials.signs.use.warp false server=zc-main"
      - flag <player.flag[easter_npc]> hidden_eggs.<context.item.flag[player]>.<context.item.flag[easter_id]>.is_being_found
      - define egg_info <player.flag[easter_npc].flag[hidden_eggs.<context.item.flag[player]>.<context.item.flag[easter_id]>]>
      - flag player finding_eggs:<[egg_info]>
      - define random_id <util.random_uuid>
      - flag player easter_unique:<[random_id]> duration:1.5m
      - adjust <player> hide_from_players
      - adjust <player> gamemode:adventure
      - wait 1t
      - inventory clear
      - heal
      - feed
      - adjust <player> remove_effects
      - adjust <player> item_slot:1
      - adjust <player> gliding:false
      - ~run countdown_from_3
      - if !<player.is_online>:
        - stop
      - adjust <player> remove_effects
      - adjust <player> gliding:false
      - give easter_egg_cancel_find
      - spawn armor_stand[marker=true;visible=false;gravity=false;is_small=true;equipment=air|air|air|sheep_spawn_egg] <[egg_info].get[location]> save:e
      - wait 1t
      - adjust <entry[e].spawned_entity> hide_from_players
      - adjust <player> show_entity:<entry[e].spawned_entity>
      - rotate <entry[e].spawned_entity> infinite
      - flag player easter_timer duration:<[egg_info].get[time].add[5]>
      - flag player egg_entity:<entry[e].spawned_entity>
      - wait <[egg_info].get[time].add[5]>
      - if <player.has_flag[finding_eggs]> && <player.flag[easter_unique]> == <[random_id]>:
        - flag player easter_timer:!
        - run easter_stop_finding
    on player clicks easter_other_locations_item in easter_menu_1:
      - inventory open d:easter_other_locations_inventory
      - define items <list[]>
      - foreach <server.npcs_flagged[essentials_warp]>:
        - define "items:->:player_head[skull_skin=<server.flag[rav_skull_skin]>;display=<[value].flag[essentials_warp].to_titlecase>;lore=<&a>Click to teleport;flag=warp:<[value].flag[essentials_warp]>]"
      - inventory set d:<player.open_inventory> o:<[items]>
    on player clicks item_flagged:warp in easter_other_locations_inventory:
      - inventory close
      - run warp_task def:<context.item.flag[warp]>
    on player clicks easter_my_eggs_item in easter_menu_1:
      - inventory open d:easter_my_eggs_inventory
      - define items <list[]>
      - foreach <player.flag[easter_npc].flag[hidden_eggs.<player>]||<map>> key:id as:egg_info:
        - define lore "<&7>Total Attempts: <&d><[egg_info].get[attempts]>|<&7>Time: <&b><[egg_info].get[time].add[5]>s|<&7>Value: <&e><[egg_info].get[attempts].proc[get_easter_points]>pts||<&a>Left click to teleport|<&c>Right click to delete"
        - define "items:->:<player.flag[skull_item].with[lore=<[lore]>;display=<player.name>'s Egg #<[loop_index]>].with_flag[easter_id:<[id]>]>"
      - inventory set d:<player.open_inventory> o:<[items]>
    on player right clicks item_flagged:easter_id in easter_my_eggs_inventory:
      - inventory close
      - narrate "Successfully removed egg!" format:rav_format
      - flag <player.flag[easter_npc]> hidden_eggs.<player>.<context.item.flag[easter_id]>:!
    on player left clicks item_flagged:easter_id in easter_my_eggs_inventory:
      - teleport <player> <player.flag[easter_npc].flag[hidden_eggs.<player>.<context.item.flag[easter_id]>.location]>
    on player clicks easter_shop_item in easter_menu_1:
      - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=64]|easter_egg[quantity=64];result=bunny_hood]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=50];result=egg_shooter]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=50];result=tal_tal_custom_record]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=25];result=villager_spawn_egg]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=10];result=wandering_trader_spawn_egg]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=10];result=shulker_spawn_egg]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=10];result=strider_spawn_egg]
      - define trades:->:trade[max_uses=9999;inputs=easter_egg[quantity=10];result=mooshroom_spawn_egg]
      #- if <util.time_now.hour> == 1 || <util.time_now.hour> == 5 || <util.time_now.hour> == 9 || <util.time_now.hour> == 13 || <util.time_now.hour> == 17 || <util.time_now.hour> == 21:
      #  - if !<player.has_flag[easterpref_1]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=1];result=ea_pref_i_1]
      #  - if !<player.has_flag[easterpref_3]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=10];result=ea_pref_i_3]
      #- else if <util.time_now.hour> == 2 || <util.time_now.hour> == 6 || <util.time_now.hour> == 10 || <util.time_now.hour> == 14 || <util.time_now.hour> == 18 || <util.time_now.hour> == 22:
      #  - if !<player.has_flag[easterpref_2]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=1];result=ea_pref_i_2]
      #  - if !<player.has_flag[easterpref_5]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=10];result=ea_pref_i_5]
      #- else if <util.time_now.hour> == 3 || <util.time_now.hour> == 7 || <util.time_now.hour> == 11 || <util.time_now.hour> == 15 || <util.time_now.hour> == 19 || <util.time_now.hour> == 23:
      #  - if !<player.has_flag[easterpref_4]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=1];result=ea_pref_i_4]
      #  - if !<player.has_flag[easterpref_7]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=10];result=ea_pref_i_7]
      #- else if <util.time_now.hour> == 4 || <util.time_now.hour> == 8 || <util.time_now.hour> == 12 || <util.time_now.hour> == 16 || <util.time_now.hour> == 20 || <util.time_now.hour> == 24:
      #  - if !<player.has_flag[easterpref_6]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=1];result=ea_pref_i_6]
      #  - if !<player.has_flag[easterpref_8]>:
      #    - define trades:->:trade[max_uses=1;inputs=easter_egg[quantity=5];result=ea_pref_i_8]
      - opentrades <[trades]>
    on player clicks easter_find_item in easter_menu_1:
      - inventory open d:easter_menu_2
      - flag player open_easter_page:1
      - run populate_easter_inv
    on player clicks easter_next_page in easter_menu_2:
      - ratelimit <player> 5t
      - flag player open_easter_page:<player.flag[open_easter_page].add[1]>
      - run populate_easter_inv
    on player clicks easter_previous_page in easter_menu_2:
      - ratelimit <player> 5t
      - flag player open_easter_page:<player.flag[open_easter_page].sub[1].max[1]>
      - run populate_easter_inv
    on player clicks easter_hide_item in easter_menu_1:
      - if <player.flag[easter_npc].flag[hidden_eggs.<player>].size||0> >= 9:
        - narrate "<&c>You already have 9 active eggs! You must wait for them to be found or remove them!" format:rav_format
        - stop
      - execute as_server "/lp user <player.name> permission set essentials.signs.use.warp false server=zc-main"
      - define random_id <util.random_uuid>
      - flag player easter_unique:<[random_id]> duration:1.5m
      - flag player hiding_eggs
      - adjust <player> hide_from_players
      - adjust <player> gamemode:adventure
      - wait 1t
      - inventory clear
      - heal
      - feed
      - adjust <player> remove_effects
      - adjust <player> gliding:false
      - ~run countdown_from_3
      - if !<player.is_online>:
        - stop
      - adjust <player> remove_effects
      - adjust <player> gliding:false
      - give easter_egg_placer|easter_egg_cancel
      - flag player easter_timer duration:60s
      - wait 60s
      - if <player.has_flag[hiding_eggs]> && <player.flag[easter_unique]> == <[random_id]>:
        - run easter_stop_hiding
