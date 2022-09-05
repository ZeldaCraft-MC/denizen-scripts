recipe_command:
  type: command
  name: recipes
  description: Shows you all of our custom recipes
  usage: /recipes
  debug: false
  script:
  - inventory open d:zc2_recipes_inv

zc2_recipes_inv:
  type: inventory
  inventory: hopper
  title: Recipes
  slots:
  - [] [modified_ct] [] [custom_ct] []

zc_recipes_world:
  type: world
  debug: false
  events:
    on player uses recipe book:
      - if <player.has_flag[recipe_inv]>:
        - determine cancelled

    on player clicks in inventory:
      - if <context.item.script.name||null> == null:
        - stop
      - define new_item <context.item>
      - if <context.item.script.name> == site:
        - stop
      - define script_item <item[<context.item.script.name>]>
      - if <[script_item].has_custom_model_data> && !<context.item.has_custom_model_data>:
        - define new_item <[new_item].with[custom_model_data=<[script_item].custom_model_data>]>
      - if <[script_item].material> != <context.item.material>:
        - if !<context.item.material.name.contains_text[netherite]>:
          - define new_item <[new_item].with[material=<[script_item].material>]>
      - determine <[new_item]>

    on player clicks in zc2_recipes_inv:
    - determine passively cancelled
    - if <context.item.script.exists>:
      - if <context.item.script> == <script[custom_ct]>:
        - inventory open d:zc_recipes_inv
      - if <context.item.script> == <script[modified_ct]>:
        - inventory open d:other_recipes_inv

    on player drags in zc2_recipes_inv:
    - determine passively cancelled

    on player closes zc_recipes_inv:
    - wait 1t
    - inventory update

    on player closes other_recipes_inv:
    - wait 1t
    - if <player.is_online>:
      - inventory update

    on player drags in smoker:
    - if <player.open_inventory.id_type> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled

    on player drags in blast_furnace:
    - if <player.open_inventory.id_type> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled

    on player clicks in smoker:
    - if <player.open_inventory.id_type> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled
    - if <context.clicked_inventory> == <player.flag[recipe_inv]||none>:
      - if <context.item.recipe_ids.first.starts_with[denizen]>:
        - inject switch_inv

    on player clicks in blast_furnace:
    - if <player.open_inventory.id_type> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled
    - if <context.clicked_inventory> == <player.flag[recipe_inv]||none>:
      - if <context.item.recipe_ids.first.starts_with[denizen]>:
        - inject switch_inv

    on player drags in furnace:
    - if <player.open_inventory.id_type> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled

    on player clicks in furnace:
    - if <player.open_inventory.id_type> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled
    - if <context.clicked_inventory.id_type||null> == <player.flag[recipe_inv]||none>:
      - if <context.item.recipe_ids.first.starts_with[denizen]>:
        - inject switch_inv

    on player drags in workbench:
    - if <player.open_inventory> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled

    on player clicks in workbench:
    - if <player.open_inventory> != <player.flag[recipe_inv]||none>:
      - stop
    - determine passively cancelled
    - if <context.clicked_inventory||null> == <player.flag[recipe_inv]||none>:
      - if <context.item.recipe_ids.first.starts_with[denizen]||false>:
        - inject switch_inv

    on player closes workbench:
    - if !<player.has_flag[recipe_inv]>:
      - stop
    - flag player recipe_inv:!
    - adjust <player.open_inventory> matrix:<list[air|]>
    - if <player.inventory.contains.nbt[remove]>:
      - take item:<player.inventory.list_contents.get[<player.inventory.list_contents.find_all_partial[nbt=<list[<element[remove/true]>]>]>]> quantity:64
    - wait 1t
    - inventory update

    on player closes furnace:
    - if <player.has_flag[recipe_inv]>:
      - flag player recipe_inv:!
      - if <player.inventory.contains.nbt[remove]>:
        - take item:<player.inventory.list_contents.get[<player.inventory.list_contents.find_all_partial[nbt=<list[<element[remove/true]>]>]>]> quantity:64

    on player closes blast_furnace:
    - if <player.has_flag[recipe_inv]>:
      - flag player recipe_inv:!
      - if <player.inventory.contains.nbt[remove]>:
        - take item:<player.inventory.list_contents.get[<player.inventory.list_contents.find_all_partial[nbt=<list[<element[remove/true]>]>]>]> quantity:64

    on player closes smoker:
    - if <player.has_flag[recipe_inv]>:
      - flag player recipe_inv:!
      - if <player.inventory.contains.nbt[remove]>:
        - take item:<player.inventory.list_contents.get[<player.inventory.list_contents.find_all_partial[nbt=<list[<element[remove/true]>]>]>]> quantity:64

    on player drags in other_recipes_inv:
    - determine passively cancelled

    on player clicks in other_recipes_inv:
    - determine passively cancelled
    - if <context.clicked_inventory.script||null> == <script[other_recipes_inv]>:
      - inject switch_inv

    on player drags in other_recipe_inv:
    - determine passively cancelled

    on player clicks in zc_recipes_inv:
    - determine passively cancelled
    - if <context.clicked_inventory.script||null> == <script[zc_recipes_inv]>:
      - inject switch_inv

modified_ct:
  type: item
  debug: false
  material: crafting_table
  display name: <&e>Modified crafting recipes
  lore:
  - <&f>Show crafting recipes<&nl><&f>we made for already existing items

custom_ct:
  type: item
  debug: false
  material: crafting_table
  display name: <&6>Custom item recipes
  lore:
  - <&f>Show crafting recipes for custom items
  mechanisms:
    hides: ALL
  enchantments:
  - lure:1

zc_recipes_inv:
  type: inventory
  inventory: chest
  debug: false
  title: Custom Item Recipes
  size: 54
  procedural items:
    - define items <list[]>
    - foreach <server.recipe_ids.get[<server.recipe_ids.find_all_partial[denizen]>].get[<server.recipe_ids.get[<server.recipe_ids.find_all_partial[denizen]>].find_all_partial[zc]>]>:
      - define item <server.recipe_result[<[value]>]>
      - define items <[items].include[<[item]>]>
    - determine <[items].deduplicate.alphanumeric>

other_recipes_inv:
  type: inventory
  inventory: chest
  debug: false
  title: Custom Recipes
  size: 54
  procedural items:
    - define items <list[]>
    - foreach <server.recipe_ids.get[<server.recipe_ids.find_all_partial[denizen]>].remove[<server.recipe_ids.get[<server.recipe_ids.find_all_partial[denizen]>].find_all_partial[zc]>]>:
      - define item <server.recipe_result[<[value]>]>
      #- if <[item]> == <item[bee_nest]>:
      #  - goto next
      - if <[item]> == <item[coal_block]>:
        - foreach next
      - define items <[items].include[<[item]>]>
    - determine <[items].deduplicate.alphanumeric>

switch_inv:
  type: task
  debug: false
  script:
    - if <context.item.recipe_ids.is_empty>:
      - define id denizen<&co><context.item.material.name>
    - else:
      - define id <context.item.recipe_ids.first>
    - if <server.recipe_type[<[id]>]> == furnace:
      - inventory open d:furnace
      - flag player recipe_inv:<player.open_inventory.id_type>
      - adjust <player.open_inventory> fuel:<item[coal].with[nbt=remove/true]>
      - adjust <player.open_inventory> input:<server.recipe_items[<[id]>].first.with[nbt=remove/true]>
      - adjust <player.open_inventory> result:<context.item.with[nbt=remove/true]>
      - stop
    - if <server.recipe_type[<[id]>]> == blasting:
      - inventory open d:furnace[title=Blast<&sp>Furnace]
      - flag player recipe_inv:<player.open_inventory.id_type>
      - adjust <player.open_inventory> fuel:<item[coal].with[nbt=remove/true]>
      - adjust <player.open_inventory> input:<server.recipe_items[<[id]>].first.with[nbt=remove/true]>
      - adjust <player.open_inventory> result:<context.item.with[nbt=remove/true]>
      - stop
    - if <server.recipe_type[<[id]>]> == smoking:
      - inventory open d:smoker
      - flag player recipe_inv:<player.open_inventory.id_type>
      - adjust <player.open_inventory> fuel:<item[coal].with[nbt=remove/true]>
      - adjust <player.open_inventory> input:<server.recipe_items[<[id]>].first.with[nbt=remove/true]>
      - adjust <player.open_inventory> result:<context.item.with[nbt=remove/true]>
      - stop
    # workbenches
    - inventory open d:workbench
    - flag player recipe_inv:<player.open_inventory>
    - define items <list>
    - if <server.recipe_type[<[id]>]> == shaped:
      - define cols <server.recipe_shape[<[id]>].before[x]>
      - define recipe_items <server.recipe_items[<[id]>].sub_lists[<[cols]>]>
      - foreach <[recipe_items]> as:row:
        - if <[cols]> == 1:
          - define full_row <[row].pad_left[2].with[<item[air]>].pad_right[3].with[<item[air]>]>
        - else:
          - define full_row <[row].pad_right[3].with[<item[air]>]>
        - foreach <[full_row]>:
          - if <[value].material.name> == air:
            - define items <[items].include[<[value]>]>
            - foreach next
          - if <[value].starts_with[material:]>:
            - define value <[value].after[:].as[item]>
          - define items:->:<[value].with[nbt=remove/true]||null>
    - else:
      - foreach <server.recipe_items[<[id]>]>:
        - if <[value].material.name> == air:
          - define items <[items].include[<[value]>]>
          - foreach next
        - if <[value].starts_with[material:]>:
          - define value <[value].after[:].as[item]>
        - define items:->:<[value].with[nbt=remove/true]||null>
    - adjust <player.open_inventory||null> matrix:<[items]||null>
