# Handles the navigation menu in the survival player's inventory
# 1 (45 in fakeitem) - result       1 + (46 - 2)
# 2 (44 in fakeitem) - top left     2 + (46 - 4)
# 3 (43 in fakeitem) - top right    3 + (46 - 6)
# 4 (42 in fakeitem) - bottom left  4 + (46 - 8)
# 5 (41 in fakeitem) - bottom right 5 + (46 - 10)

nav_crafting:
  type: item
  debug: false
  material: crafting_table
  display name: <&e><&l>Open Workbench

nav_compass:
  type: item
  debug: false
  material: compass
  display name: <&b><&l>View Warps

nav_home:
  type: item
  debug: false
  material: red_bed
  display name: <&c><&l>Teleport Home

nav_discord:
  type: item
  debug: false
  material: shulker_shell
  display name: <&5><&l>Join Discord

nav_recipes:
  type: item
  debug: false
  material: knowledge_book
  display name: <&a><&l>View Custom Recipes

fakeitem_slot:
  type: procedure
  debug: false
  definitions: slot
  script:
    - determine <[slot].add[46].sub[<[slot].mul[2]>]>

get_nav_item:
  type: procedure
  debug: false
  definitions: slot
  script:
    - choose <[slot]>:
      - case 1:
        - determine nav_compass
      - case 2:
        - determine nav_crafting
      - case 3:
        - determine nav_home
      - case 4:
        - determine nav_discord
      - case 5:
        - determine nav_recipes
      - default:
        - determine air

set_nav_menu:
  type: task
  debug: false
  script:
    - repeat 5:
      - fakeitem <[value].proc[get_nav_item]> slot:<[value].proc[fakeitem_slot]> player_only

nav_menu_events:
  type: world
  debug: false
  events:
    after player closes inventory:
      - if <player.name> != Mergu || <player.gamemode> in creative|spectator:
        - stop
      - narrate "setting, <player.gamemode>"
      - inject set_nav_menu
    after player joins:
      - if <player.name> != Mergu || <player.gamemode> in creative|spectator:
        - stop
      - inject set_nav_menu
    after player drags in inventory:
      - if <player.name> != Mergu || <player.gamemode> in creative|spectator:
        - stop
      - inject set_nav_menu
    on player clicks in inventory:
      - if <player.name> != Mergu || <player.gamemode> in creative|spectator:
        - stop
      - if <context.clicked_inventory.inventory_type||none> == crafting:
        - determine passively cancelled
        - wait 1t
        - define item <context.slot.proc[get_nav_item]>
        - if <[item]> == nav_crafting:
          - inventory close
          - inventory open d:workbench
        - inject set_nav_menu
      - else if <context.clicked_inventory.inventory_type||none> == player:
        - wait 1t
        - inject set_nav_menu
