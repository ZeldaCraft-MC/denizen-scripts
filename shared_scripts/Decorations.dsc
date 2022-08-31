Decorations:
  type: world
  debug: false
  events:
    on player right clicks item_frame with:paper:
      - ratelimit <player> 2t
      - if ( !<context.entity.has_framed_item> && <context.item.has_custom_model_data> ) && <player.gamemode> != adventure:
        - adjust <context.entity> visible:false
        - flag <context.entity> deco_invis
        - if <context.item.has_flag[solid_deco]> || <script[decorations_data].data_key[paper].get[<context.item.custom_model_data>].contains[solid]||false>:
          - modifyblock <context.entity.location> barrier
          - flag <context.entity.location> deco_block:<context.entity>
          - wait 1t
          - adjust <context.entity> fixed:true
        - define base <script[decorations_data].data_key[paper].get[<context.item.custom_model_data>].get[name].replace[<&sp>].with[_]||null>
        - if <[base]> == null:
          - stop
        - if <context.item.display.replace[<&sp>].with[_].contains_all_case_sensitive_text[<[base]>]||false>:
          - wait 1t
          - adjust <context.entity> framed:<context.entity.framed_item.with[display=]>
    on player right clicks item_frame with:leather_horse_armor:
      - ratelimit <player> 2t
      - if !<context.entity.has_framed_item> && <context.item.has_custom_model_data>:
        - adjust <context.entity> visible:false
        - flag <context.entity> deco_invis
        - if <context.item.has_flag[solid_deco]> || <script[decorations_data].data_key[leather_horse_armor].get[<context.item.custom_model_data>].contains[solid]||false>:
          - modifyblock <context.entity.location> barrier
          - flag <context.entity.location> deco_block:<context.entity>
          - wait 1t
          - adjust <context.entity> fixed:true
        - define base <script[decorations_data].data_key[leather_horse_armor].get[<context.item.custom_model_data>].get[name].replace[<&sp>].with[_]>
        - if <context.item.display.replace[<&sp>].with[_].contains_all_case_sensitive_text[<[base]>]||false>:
          - wait 1t
          - adjust <context.entity> framed:<context.entity.framed_item.with[display=]>
    on item_frame damaged:
      - if <context.entity.has_flag[deco_invis]> && <context.damager.gamemode||adventure> != adventure:
        - adjust <context.entity> visible:true
      - if <context.entity.location.has_flag[deco_block]>:
        - determine cancelled
    on hanging breaks:
      - if <context.hanging.location.has_flag[deco_block]>:
        - determine cancelled
    on projectile breaks hanging:
      - if <context.hanging.fixed||false>:
        - determine cancelled
    on projectile hits item_frame:
      - if <context.hit_entity.fixed>:
        - determine cancelled
    on player right clicks barrier location_flagged:deco_block:
      - if <context.location.flag[deco_block].exists> && <player.is_sneaking> && ( <player.worldguard.can_build[<context.location>]> && <player.gamemode> != adventure || <player.groups.contains_any[admin|gm]> ) :
        - determine passively cancelled
        - choose <context.location.flag[deco_block].framed_item_rotation>:
          - case none:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|clockwise_45
          - case clockwise_45:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|clockwise
          - case clockwise:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|clockwise_135
          - case clockwise_135:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|flipped
          - case flipped:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|flipped_45
          - case flipped_45:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|counter_clockwise
          - case counter_clockwise:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|counter_clockwise_45
          - case counter_clockwise_45:
            - adjust <context.location.flag[deco_block]> framed:<context.location.flag[deco_block].framed_item>|none
    on player left clicks barrier location_flagged:deco_block:
      - if ( <player.worldguard.can_build[<context.location>]> || <player.groups.contains_any[admin|gm]> ) && <player.gamemode> != adventure:
        - define item <context.location.flag[deco_block].framed_item>
        - adjust <context.location.flag[deco_block]> framed:air
        - adjust <context.location.flag[deco_block]> visible:true
        - adjust <context.location.flag[deco_block]> fixed:false
        - flag <context.location.flag[deco_block]> deco_invis:!
        - flag <context.location> deco_block:!
        - modifyblock <context.location> air
        - wait 2t
        - drop <[item]> <context.location.center>

custom_items_command:
    type: command
    name: custom_items
    debug: false
    usage: /custom_items (search)
    description: Searches a list of custom items.
    permission: zc.custom_items
    aliases:
      - ci
    # tab complete:
    #     - define args <context.raw_args>
    #     - determine <script[decorations_data].list_deep_keys.alphabetical.filter[starts_with[<[args]>]]>
    script:
      - if <player.gamemode> == creative || <player.groups.contains[gm]>:
        - foreach <script[decorations_data].list_keys.exclude[debug|type|paper].insert[paper].at[1]> as:type:
          - foreach <script[decorations_data].data_key[<[type]>].keys.alphanumeric> as:item:
            - define base <script[decorations_data].data_key[<[type]>].get[<[item]>].get[name].replace[_].with[<&sp>]>
            - if !<player.has_flag[fav_ci_list]>:
              - flag <player> fav_ci_list:|:paper[display=sunglasses;custom_model_data=9200]
            - if <player.flag[fav_ci_list].advanced_matches[*<[base]>*]>:
              - define fav <gold>Favourite
            - else:
              - define fav <empty>
            - if <script[decorations_data].data_key[<[type]>].get[<[item]>].contains[custom_item]>:
              - define ci <gray>custom_item=<light_purple><script[decorations_data].data_key[<[type]>].get[<[item]>].get[custom_item]||false>
            - else:
              - define ci <empty>
            - if <script[decorations_data].data_key[<[type]>].get[<[item]>].contains[solid]>:
              - define solid <gray>is_solid=<green><script[decorations_data].data_key[<[type]>].get[<[item]>].get[solid]||<red>false>
            - else:
              - define solid <empty>
            - define tags <script[decorations_data].data_key[<[type]>].get[<[item]>].get[tags]||<list[]>>
            - define lore <list[<gray>base_item=<aqua><[type]>|<gray>model_data=<aqua><[item]>|<[solid]>|<[ci]>|<[fav]>].exclude[||].include[<[tags].as_list>].combine>
            - define custom_items:|:<[type]||paper>[custom_model_data=<[item]>;display_name=<[base]>;lore=<[lore]>]
        - if <context.args.first||<empty>> != <empty>:
          - if <context.args.first.before[:]||nothing> == model:
            - define custom_items <[custom_items].filter_tag[<item[<[filter_value]>].custom_model_data.contains_text[<context.args.first.after[model:]>]||false>]>
          - else:
            - define custom_items <[custom_items].filter_tag[<item[<[filter_value]>].lore.contains_any_text[<context.args.first>]||false>]>
        - run custom_items_inv_open_task def.ci_list:<[custom_items]> def.page:1

custom_items_inv_open_task:
    type: task
    definitions: ci_list|page
    debug: false
    script:
    - if <player.has_flag[in_fav_custom_item]>:
        - flag player fav_ci_page:<[page]>
        - define inv <inventory[custom_items_favourites_inventory]>
        - inventory set d:<[inv]> o:custom_items_favourites slot:50
    - else:
        - flag player current_ci_list:!|:<[ci_list]>
        - flag player current_ci_page:<[page]>
        - define inv <inventory[custom_items_list_inventory]>
        - inventory set d:<[inv]> o:search_sign slot:51
        - inventory set d:<[inv]> o:custom_items_favourites slot:49
    - inventory set d:<[inv]> o:<[ci_list].get[<[page].sub[1].mul[45].max[1]>].to[<[page].mul[45]>]>
    - if <[page]> > 1:
        - inventory set d:<[inv]> o:custom_items_arrow_left_item slot:46
    - if <[ci_list].size> >= <[page].mul[45]>:
        - inventory set d:<[inv]> o:custom_items_arrow_right_item slot:54
    - inventory open d:<[inv]>

custom_items_list_inventory:
    type: inventory
    inventory: chest
    debug: false
    title: <aqua>Items - Right click to favourite
    size: 54
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

custom_items_favourites_inventory:
    type: inventory
    inventory: chest
    debug: false
    title: <red>Favourites - Right click to remove
    size: 54
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

custom_items_inv_world:
    type: world
    debug: false
    events:
        on server start:
          - if <yaml.list.contains[custom_items_list]>:
              - yaml unload id:custom_items_list
          - ~yaml load:custom_items_list.yml id:custom_items_list
        on player closes custom_items_favourites_inventory:
            - wait 5t
            - if <player.open_inventory.script.name||null> != custom_items_favourites_inventory:
                - flag <player> in_fav_custom_item:!
        on player clicks in custom_items*_inventory priority:1:
        - if <context.click> == right:
            - if <context.clicked_inventory.script.name||null> != custom_items_favourites_inventory && <context.clicked_inventory.script.name||null> != custom_items_list_inventory:
              - stop
            - if <context.item.material.name> == air:
              - stop
            - if <player.flag[fav_ci_list].advanced_matches[*Custom_Model_data=<context.item.custom_model_data>*]>:
                - flag <player> fav_ci_list:<-:<context.item>
                - actionbar "<red>Removed from favourites"
                - if <player.has_flag[in_fav_custom_item]>:
                  - run custom_items_inv_open_task def.ci_list:<player.flag[fav_ci_list]> def.page:<player.flag[fav_ci_page]||1>
                - stop
            - flag <player> fav_ci_list:|:<context.item>
            - actionbar "<green>Added to favourites"
            - stop
        - if <context.raw_slot||100> < 55 && <context.item.material.name||air> != air:
          - if <context.click> == shift_left:
            - give <script[decorations_data].data_key[<context.item.material.name||paper>].get[<context.item.custom_model_data||100>].get[custom_item]||<context.item>>
          - else:
            - give <context.item>
        on player clicks custom_items_arrow_left_item in custom_items*_inventory:
        - determine passively cancelled
        - if !<player.has_flag[current_ci_list]>:
            - stop
        - if <player.has_flag[in_fav_custom_item]>:
            - run custom_items_inv_open_task def.ci_list:<player.flag[fav_ci_list]> def.page:<player.flag[fav_ci_page].sub[1]>
            - stop
        - run custom_items_inv_open_task def.ci_list:<player.flag[current_ci_list]> def.page:<player.flag[current_ci_page].sub[1]>
        on player clicks custom_items_arrow_right_item in custom_items*_inventory:
        - determine passively cancelled
        - if !<player.has_flag[current_ci_list]>:
            - stop
        - if <player.has_flag[in_fav_custom_item]>:
            - run custom_items_inv_open_task def.ci_list:<player.flag[fav_ci_list]> def.page:<player.flag[fav_ci_page].add[1]>
            - stop
        - run custom_items_inv_open_task def.ci_list:<player.flag[current_ci_list]> def.page:<player.flag[current_ci_page].add[1]>
        on player clicks custom_items_favourites in custom_items*_inventory:
        - determine passively cancelled
        - if !<player.has_flag[fav_ci_list]>:
            - stop
        - if <player.has_flag[in_fav_custom_item]>:
            - flag <player> in_fav_custom_item:!
            - run custom_items_inv_open_task def.ci_list:<player.flag[current_ci_list]> def.page:<player.flag[current_ci_page]>
            - stop
        - flag <player> fav_ci_page:1
        - flag <player> in_fav_custom_item
        - run custom_items_inv_open_task def.ci_list:<player.flag[fav_ci_list]> def.page:<player.flag[fav_ci_page]||1>

#-----------------#
# by green testing
#-----------------#
fake_sign_w:
  type: world
  debug: true
  events:
    on player changes sign:
    - if !<player.has_flag[deco_searching]>:
      - stop
    - if <context.new.unseparated> == <empty>:
      - adjust <player> edit_sign
      - narrate "The sign cannot be empty"
      - stop
    - define search_result <context.new.unseparated>
    - narrate "Searching for: <[search_result]>"
    - execute as_player "ci <[search_result]>"
    on player clicks search_sign in custom_items_list_inventory:
    - flag player deco_searching expire:20m
    - adjust <player> edit_sign

decorations_data:
  type: data
  debug: false
  paper:
    15001:
      name: Wood Chair
    15002:
      name: Wood Bench
    15003:
      name: Wood Coffee Table
    15004:
      name: Wood Coffee Table 2
    15005:
      name: Wood Crate
    15006:
      name: Wood Light Post
    15007:
      name: Wood Nightstand
    15008:
      name: Wood Palette 1
    15009:
      name: Wood Palette 2
    15010:
      name: Wood Palette 3
    15011:
      name: Wood Picnic Table
    15012:
      name: Wood Shelf Large
    15013:
      name: Wood Shelf Small
    15014:
      name: Wood Side Table
    15015:
      name: Wood Stool
    15016:
      name: Wood Table
    15017:
      name: Wood Wall Lamp
    15018:
      name: Wood Wall Sign
    900:
      name: Banana Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - banana
        - food
    1000:
      name: Mythril Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - mythril
        - ore
    1100:
      name: Potato Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - potato
        - food
    1200:
      name: Honey Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - liquid
        - honey
        - bee
    1300:
      name: Water Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - liquid
        - water
    1400:
      name: Amethyst Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - amethyst
        - ore
        - crystal
    1500:
      name: Apple Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - apple
        - food
    1600:
      name: Beetroot Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - beetroot
        - food
    1700:
      name: Cobblestone Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - cobblestone
        - stone
    1800:
      name: Dirt Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - dirt
        - nature
    2600:
      name: Gold Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - gold
        - ore
    2700:
      name: Green Apple Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - food
        - green
        - apple
    2800:
      name: Iron Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - iron
        - ore
    2900:
      name: Milk Crate
      solid: true
      tags:
        - barrel
        - crate
        - wood
        - decor
        - decorations
        - liquid
        - milk
        - cow
        - farm
    3500:
      name: Strawberry Planter
      solid: true
      tags:
        - wood
        - decor
        - decorations
        - food
        - strawberry
        - berry
        - planter
        - farm
    2100:
      name: Blue Fairy Jar
      tags:
        - fairy
        - animated
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - blue
    2300:
      name: Pink Fairy Jar
      tags:
        - fairy
        - animated
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - pink
    2500:
      name: Purple Fairy Jar
      tags:
        - fairy
        - animated
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - purple
    2400:
      name: Yellow Fairy Jar
      tags:
        - fairy
        - animated
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - yellow
    2000:
      name: Honey Jar
      tags:
        - honey
        - jar
        - decor
        - decorations
        - glass
        - bee
        - liquid
    2200:
      name: Fern Jar
      tags:
        - fern
        - jar
        - decor
        - decorations
        - glass
        - bush
        - grass
        - nature
    3100:
      name: Mushroom Jar
      tags:
        - mushroom
        - jar
        - decor
        - decorations
        - glass
        - shroom
        - nature
    3400:
      name: Sapling Jar
      tags:
        - sapling
        - jar
        - decor
        - decorations
        - glass
        - bush
        - tree
        - nature
    3000:
      name: Milk Jar
      tags:
        - milk
        - jar
        - decor
        - decorations
        - glass
        - cow
        - liquid
        - farm
    3700:
      name: Acacia Table
      solid: true
      tags:
        - acacia
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    3800:
      name: Spruce Table
      solid: true
      tags:
        - spruce
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    3900:
      name: Warped Table
      solid: true
      tags:
        - warped
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    4000:
      name: Birch Table
      solid: true
      tags:
        - birch
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    4100:
      name: Oak Table
      solid: true
      tags:
        - oak
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    4200:
      name: Dark Oak Table
      solid: true
      tags:
        - dark
        - oak
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    4300:
      name: Crimson Table
      solid: true
      tags:
        - crimson
        - table
        - decor
        - decorations
        - wood
        - counter
        - house
        - interior
    4400:
      name: Chess Table
      solid: true
      tags:
        - chess
        - board
        - table
        - decor
        - decorations
        - wood
        - games
        - house
        - play
        - interior
    4500:
      name: Chess Board
      tags:
        - chess
        - board
        - decor
        - decorations
        - games
        - play
    4600:
      name: Blue Potion Jar
      tags:
        - potion
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - blue
        - liquid
        - witch
        - brew
    4700:
      name: Red Potion Jar
      tags:
        - potion
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - red
        - liquid
        - witch
        - brew
    4800:
      name: Green Potion Jar
      tags:
        - potion
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - green
        - liquid
        - witch
        - brew
    4900:
      name: Yellow Potion Jar
      tags:
        - potion
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - yellow
        - liquid
        - witch
        - brew
    5100:
      name: Bottle
      tags:
        - bottle
        - decor
        - decorations
        - glass
        - beer
        - wine
        - liquid
        - bar
        - brew
        - empty
    5200:
      name: Playing Cards
      tags:
        - playing
        - cards
        - decor
        - decorations
        - games
        - play
        - poker
        - casino
    5000:
      name: Lon Lon Milk Jar
      tags:
        - milk
        - jar
        - decor
        - decorations
        - glass
        - cow
        - lon
        - zelda
        - liquid
        - farm
    7000:
      name: DCaff95 Plushie
      tags:
        - dcaff95
        - caff
        - plushie
        - decor
        - decorations
        - wool
        - stinky
        - staff
        - meme
        - choggy
        - best
        - HelpImStuckInAnInventoryGetMeOutOfHere!!
    7100:
      name: Mergu Plushie
      tags:
        - mergu
        - merg
        - ryder
        - plushie
        - decor
        - decorations
        - wool
        - artist
        - meme
    8400:
      name: EyelessTenshi Plushie
      tags:
        - tenshi
        - eyelesstenshi
        - plushie
        - decor
        - decorations
        - wool
        - artist
        - builder
    5700:
      name: basket
      tags:
        - basket
        - decor
        - decorations
        - wood
        - storage
        - drawer
        - shelf
        - interior
        - empty
    5500:
      name: Acacia Mug
      tags:
        - acacia
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    6000:
      name: Birch Mug
      tags:
        - birch
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    6800:
      name: Dark Oak Mug
      tags:
        - dark
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    7400:
      name: Jungle Mug
      tags:
        - jungle
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    7800:
      name: Oak Mug
      tags:
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    8200:
      name: Spruce Mug
      tags:
        - spruce
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    6400:
      name: Crimson Mug
      tags:
        - crimson
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - empty
    8800:
      name: Warped Mug
      tags:
        - acacia
        - mug
        - decorations
        - decor
        - cup
        - liquid
    8500:
      Name: Vine Basket
      tags:
        - basket
        - decor
        - decorations
        - wood
        - storage
        - drawer
        - shelf
        - interior
        - vine
        - nature
        - grass
        - bush
    12201:
      Name: Spruce Chair
      solid: true
      tags:
        - spruce
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
    12202:
      Name: Warped Chair
      tags:
        - warped
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
      solid: true
    12203:
      Name: Birch Chair
      tags:
        - birch
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
      solid: true
    12204:
      Name: Crimson Chair
      tags:
        - crimson
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
      solid: true
    12205:
      Name: Oak Chair
      tags:
        - oak
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
      solid: true
    12206:
      Name: Jungle Chair
      tags:
        - jungle
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
      solid: true
    12207:
      Name: Dark Oak Chair
      tags:
        - dark
        - oak
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
      solid: true
    12208:
      Name: White Chair
      tags:
        - white
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - interior
      solid: true
    12209:
      Name: Black Chair
      tags:
        - black
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - interior
      solid: true
    12212:
      Name: Black Stool
      tags:
        - black
        - stool
        - decorations
        - decor
        - table
        - counter
        - interior
      solid: true
    12213:
      Name: White Stool
      solid: true
      tags:
        - white
        - stool
        - decorations
        - decor
        - table
        - counter
        - interior
    12215:
      Name: Bar Stool
      solid: true
      tags:
        - bar
        - stool
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
        - casino
    12216:
      Name: Dark Bar Stool
      solid: true
      tags:
        - dark
        - bar
        - stool
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - wood
        - interior
        - casino
    600:
      Name: Bunny Hood
      custom_item: bunny_hood
      tags:
        - bunny
        - hood
        - mask
        - equipment
        - zelda
        - armor
        - util
        - wearable
        - gear
        - easter
        - helmet
    700:
      Name: Bug Net
      tags:
        - bug
        - net
        - item
        - zelda
        - nature
        - tool
    800:
      Name: Super Bug Net
      tags:
        - super
        - bug
        - net
        - item
        - zelda
        - nature
        - tool
    5300:
      Name: Acacia Mug Beer
      tags:
        - acacia
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    5400:
      Name: Acacia Mug Coffee
      tags:
        - acacia
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    5600:
      Name: Acacia Mug Milk
      tags:
        - acacia
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    5800:
      Name: Birch Mug Beer
      tags:
        - birch
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    5900:
      Name: Birch Mug Coffee
      tags:
        - birch
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - cofee
        - cafe
    6100:
      Name: Birch Mug Milk
      tags:
        - birch
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    6200:
      Name: Crimson Mug Beer
      tags:
        - crimson
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    6300:
      Name: Crimson Mug Coffee
      tags:
        - crimson
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    6500:
      Name: Crimson Mug Milk
      tags:
        - crimson
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    6600:
      Name: Dark Oak Mug Beer
      tags:
        - dark
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    6700:
      Name: Dark Oak Mug Coffee
      tags:
        - dark
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    6900:
      Name: Dark Oak Mug Milk
      tags:
        - dark
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    7200:
      Name: Jungle Mug Beer
      tags:
        - jungle
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    7300:
      Name: Jungle Mug Coffee
      tags:
        - jungle
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    7500:
      Name: Jungle Mug Milk
      tags:
        - jungle
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    7600:
      Name: Oak Mug Beer
      tags:
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    7700:
      Name: Oak Mug Coffee
      tags:
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    7900:
      Name: Oak Mug Milk
      tags:
        - oak
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    8000:
      Name: Spruce Mug Beer
      tags:
        - spruce
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    8100:
      Name: Spruce Mug Coffee
      tags:
        - spruce
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    8300:
      Name: Spruce Mug Milk
      tags:
        - spruce
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    8600:
      Name: Warped Mug Beer
      tags:
        - warped
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - beer
        - bar
    8700:
      name: warped mug coffee
      tags:
        - warped
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - coffee
        - cafe
    8900:
      name: warped mug milk
      tags:
        - warped
        - mug
        - decorations
        - decor
        - cup
        - liquid
        - milk
        - cow
    9000:
      name: yellow striped beach towel
      tags:
        - yellow
        - striped
        - decorations
        - decor
        - beach
        - towel
        - summer
        - wool
        - sand
        - lounge
        - picnic
        - mat
        - carpet
        - cloth
    9100:
      name: light blue striped towel
      tags:
        - light
        - blue
        - striped
        - decorations
        - decor
        - beach
        - towel
        - summer
        - wool
        - sand
        - lounge
        - picnic
        - mat
        - carpet
        - cloth
    9200:
      name: sunglasses
      tags:
        - sunglasses
        - shades
        - sun
        - helmet
        - equipment
        - wearable
        - towel
        - summer
        - armor
        - util
        - gear
        - dark
        - cool
        - beach
    9300:
      name: shells3
      tags:
        - shell
        - shells
        - beach
        - ocean
        - item
        - decor
        - decorations
        - summer
        - 3
    9400:
      name: shells2
      tags:
        - shell
        - shells
        - beach
        - ocean
        - item
        - decor
        - decorations
        - summer
        - 2
    9500:
      name: shells
      tags:
        - shell
        - shells
        - beach
        - ocean
        - item
        - decor
        - decorations
        - summer
        - 1
    9600:
      name: light blue beach towel
      tags:
        - light
        - blue
        - decorations
        - decor
        - beach
        - towel
        - summer
        - wool
        - sand
        - lounge
        - picnic
        - mat
        - carpet
        - cloth
    9700:
      name: orange beach towel
      tags:
        - orange
        - decorations
        - decor
        - beach
        - towel
        - summer
        - wool
        - sand
        - lounge
        - picnic
        - mat
        - carpet
        - cloth
    9800:
      name: white beach towel
      tags:
        - white
        - decorations
        - decor
        - beach
        - towel
        - summer
        - wool
        - sand
        - lounge
        - picnic
        - mat
        - carpet
        - cloth
    9900:
      name: red beach chair
      tags:
        - red
        - beach
        - decorations
        - decor
        - deck
        - summer
        - wool
        - lounge
        - picnic
        - mat
        - garden
        - cloth
        - chair
        - seat
        - sittable
        - sit
      solid: true
    10000:
      name: lime beach chair
      tags:
        - lime
        - beach
        - decorations
        - decor
        - deck
        - summer
        - wool
        - lounge
        - picnic
        - mat
        - garden
        - cloth
        - chair
        - seat
        - sittable
        - sit
      solid: true
    10100:
      name: blue beach chair
      tags:
        - blue
        - beach
        - decorations
        - decor
        - deck
        - summer
        - wool
        - lounge
        - picnic
        - mat
        - garden
        - cloth
        - chair
        - seat
        - sittable
        - sit
      solid: true
    10200:
      name: white beach chair
      tags:
        - white
        - beach
        - decorations
        - decor
        - deck
        - summer
        - wool
        - lounge
        - picnic
        - mat
        - garden
        - cloth
        - chair
        - seat
        - sittable
        - sit
      solid: true
    10300:
      name: purple beach chair
      tags:
        - purple
        - beach
        - decorations
        - decor
        - deck
        - summer
        - wool
        - lounge
        - picnic
        - mat
        - garden
        - cloth
        - chair
        - seat
        - sittable
        - sit
      solid: true
    10400:
      name: yellow beach chair
      tags:
        - yellow
        - beach
        - decorations
        - decor
        - deck
        - summer
        - wool
        - lounge
        - picnic
        - mat
        - garden
        - cloth
        - chair
        - seat
        - sittable
        - sit
      solid: true
    10500:
      name: deku son
      tags:
        - deku
        - butler
        - decorations
        - decor
        - son
        - dead
        - creepy
        - nature
        - tree
        - majora
        - tenshi
        - wood
        - bush
        - halloween
        - spooky
      solid: true
    10600:
      name: candy basket
      tags:
        - candy
        - basket
        - empty
        - item
        - wood
        - bush
        - halloween
        - pumpkin
        - bucket
        - trick
        - treat
        - spooky
    10700:
      name: candy basket 1
      tags:
        - candy
        - basket
        - item
        - wood
        - bush
        - halloween
        - pumpkin
        - bucket
        - trick
        - treat
        - spooky
        - 1
    10800:
      name: candy basket 2
      tags:
        - candy
        - basket
        - item
        - wood
        - bush
        - halloween
        - pumpkin
        - bucket
        - trick
        - treat
        - spooky
        - 2
    10900:
      name: candy basket 3
      tags:
        - candy
        - basket
        - item
        - wood
        - bush
        - halloween
        - pumpkin
        - bucket
        - trick
        - treat
        - spooky
        - 3
    11000:
      name: candy basket 4
      tags:
        - candy
        - basket
        - item
        - wood
        - bush
        - halloween
        - pumpkin
        - bucket
        - trick
        - treat
        - spooky
        - 4
    11100:
      name: candy basket max
      tags:
        - candy
        - basket
        - full
        - item
        - wood
        - bush
        - halloween
        - pumpkin
        - bucket
        - trick
        - treat
        - spooky
        - 5
        - max
    11200:
      name: scarecrow mask
      tags:
        - scarecrow
        - mask
        - scare
        - scary
        - farm
        - spooky
        - equipment
        - helmet
        - straw
        - halloween
        - pumpkin
        - hat
        - trick
        - treat
        - wearable
        - armor
        - gear
    11300:
      name: axe hat
      tags:
        - axe
        - scary
        - blood
        - spooky
        - equipment
        - helmet
        - head
        - halloween
        - bleed
        - hat
        - wearable
        - armor
        - gear
    11400:
      name: boarded window1
      tags:
        - boarded
        - window
        - zombie
        - board
        - decor
        - decorations
        - wood
        - barrier
        - halloween
        - planks
        - spooky
        - 1
    11500:
      name: boarded window2
      tags:
        - boarded
        - window
        - zombie
        - board
        - decor
        - decorations
        - wood
        - barrier
        - halloween
        - planks
        - spooky
        - 2
    11600:
      name: boarded window3
      tags:
        - boarded
        - window
        - zombie
        - board
        - decor
        - decorations
        - wood
        - barrier
        - halloween
        - planks
        - spooky
        - 3
    11700:
      name: skeleton
      tags:
        - skeleton
        - dead
        - sitting
        - mob
        - bone
        - decor
        - decorations
        - sit
        - halloween
        - spooky
        - scary
        - spoopy
    11800:
      name: wither skeleton
      tags:
        - wither
        - skeleton
        - dead
        - sitting
        - mob
        - bone
        - decor
        - decorations
        - sit
        - halloween
        - spooky
        - scary
        - spoopy
    12000:
      name: pumpkin lights
      tags:
        - pumpkin
        - lights
        - lighting
        - hanging
        - decor
        - decorations
        - halloween
        - animated
    12100:
      name: ghost
      tags:
        - ghost
        - spirit
        - ghoul
        - SpoOoOoOky
        - decor
        - decorations
        - spooky
        - halloween
    12210:
      name: black and white chair
      tags:
        - block
        - white
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - interior
      solid: true
    12211:
      name: froggy chair
      tags:
        - froggy
        - chair
        - decorations
        - decor
        - seat
        - sittable
        - sit
        - interior
        - animal
        - crossing
        - frog
        - meme
      solid: true
    12214:
      name: black and white stool
      tags:
        - black
        - white
        - stool
        - decorations
        - decor
        - table
        - counter
        - interior
      solid: true
    12217:
      name: halloweentenshiplush
      tags:
        - tenshi
        - eyelesstenshi
        - plushie
        - decor
        - decorations
        - wool
        - artist
        - builder
        - halloween
        - spooky
        - headlesstenshi
        - tombshi
    12218:
      name: oak bedframe
      tags:
        - oak
        - bedframe
        - bed
        - decor
        - decorations
        - wool
        - wood
        - sleep
        - bedroom
        - frame
        - multi
        - full
        - single
    12219:
      name: oak bedframe left
      tags:
        - oak
        - bedframe
        - bed
        - decor
        - decorations
        - wool
        - wood
        - sleep
        - bedroom
        - frame
        - multi
        - middle
    12220:
      name: oak bedframe middle
      tags:
        - oak
        - bedframe
        - bed
        - decor
        - decorations
        - wool
        - wood
        - sleep
        - bedroom
        - frame
        - multi
        - left
    12221:
      name: oak bedframe right
      tags:
        - oak
        - bedframe
        - bed
        - decor
        - decorations
        - wool
        - wood
        - sleep
        - bedroom
        - frame
        - multi
        - right
    12222:
      name: spruce bedframe
      tags:
        - spruce
        - bedframe
        - bed
        - decor
        - decorations
        - wool
        - wood
        - sleep
        - bedroom
        - frame
        - multi
        - full
        - single
    12223:
      name: dark oak bedframe
      tags:
        - dark
        - oak
        - bedframe
        - bed
        - decor
        - decorations
        - wool
        - wood
        - sleep
        - bedroom
        - frame
        - multi
        - full
        - single
    12224:
      name: hourglass
      tags:
        - hourglass
        - phantom
        - sand
        - glass
        - decorations
        - decor
        - time
    12225:
      name: antlers
      tags:
        - antlers
        - antler
        - deer
        - reindeer
        - equipment
        - helmet
        - head
        - christmas
        - xmas
        - hat
        - wearable
        - armor
        - gear
    12226:
      name: winter antlers
      tags:
        - antlers
        - antler
        - deer
        - reindeer
        - equipment
        - helmet
        - head
        - christmas
        - xmas
        - hat
        - wearable
        - armor
        - gear
        - winter
    12227:
      name: xmas axe
      tags:
        - axe
        - item
        - tool
        - weapon
        - candy
        - candycane
        - peppermint
        - christmas
        - xmas
        - winter
    12228:
      name: candy cane
      tags:
        - item
        - food
        - candy
        - candycane
        - peppermint
        - christmas
        - xmas
        - winter
    12229:
      name: peppermint bark
      tags:
        - item
        - food
        - wood
        - tree
        - candy
        - candycane
        - peppermint
        - christmas
        - xmas
        - winter
    12230:
      name: peppermint cookie
      tags:
        - item
        - food
        - cookie
        - candy
        - candycane
        - peppermint
        - christmas
        - xmas
        - winter
    12240:
      name: peppermint cookie flip
      tags:
        - item
        - food
        - cookie
        - flip
        - candy
        - candycane
        - peppermint
        - christmas
        - xmas
        - winter
    12231:
      name: fairy pink
      tags:
        - fairy
        - animated
        - jar
        - decor
        - decorations
        - glass
        - zelda
        - yellow
    12232:
      name: fairy purple
      tags:
        - fairy
        - animated
        - decor
        - decorations
        - zelda
        - purple
    12233:
      name: fairy yellow
      tags:
        - fairy
        - animated
        - decor
        - decorations
        - zelda
        - yellow
    12234:
      name: fairy blue
      tags:
        - fairy
        - animated
        - decor
        - decorations
        - zelda
        - blue
        - navi
    12235:
      name: Halloween DCaff plushie
      tags:
        - dcaff95
        - caff
        - plushie
        - halloween
        - spooky
        - dracula
        - dcaffula
        - decor
        - decorations
        - wool
        - BLEHH!
    12237:
      name: Halloween Kyran plushie
      tags:
        - kyran
        - kkyran
        - plushie
        - plush
        - halloween
        - spooky
        - zombie
        - brain
        - 5head
        - decor
        - decorations
        - wool
        - cursed
        - nightmare
        - goodlad
    12236:
      name: Halloween Sent plushie
      tags:
        - Sent
        - plushie
        - plush
        - halloween
        - spooky
        - gambler
        - baker
        - decor
        - decorations
        - wool
        - edgy
        - ow!theedge
    12238:
      name: Halloween Angel plushie
      tags:
        - angel
        - angeltiramisu
        - plushie
        - plush
        - halloween
        - spooky
        - candy
        - pumpkin
        - angol
        - decor
        - decorations
        - wool
        - chipsahoy
        - devil
        - CanBeYourAngelTiramisuOrYourDevilTiramisu
    12401:
          name: Turkey
    12402:
          name: Mushroom Hat
    12403:
          name: Oak Shelf
    12404:
          name: Cod
    12405:
          name: Breads
    12406:
          name: Cantaloupe
    12407:
          name: Cantaloupesmall
    12408:
          name: Cantaloupesnot
    12409:
          name: Barrelapp
    12410:
          name: Fruitbox
    12411:
          name: Potveg 4
    12412:
          name: Barrelpotat
    12413:
          name: Cantaloupeblock
    12414:
          name: Barrelcarrots
    12415:
          name: Cantaloupex4
    12416:
          name: Fruitboxbig
    12417:
          name: Fruitboxbig2
    12418:
          name: Fruitboxbr
    12419:
          name: Fruitboxcan
    12420:
          name: Fruitboxban
    12421:
          name: Fruitboxfish
    12422:
          name: Fruitboxpo
    12423:
          name: Fruitboxza
    12424:
          name: Melonslices
    12425:
          name: Onions
    12426:
          name: Onions2
    12427:
          name: Onions3
    12428:
          name: Plant1
    12429:
          name: Plant2
    12430:
          name: Plant2b
    12431:
          name: Plates4
    12432:
          name: Plate
    12433:
          name: Platedirty
    12434:
          name: Pot
    12435:
          name: Potatoes
    12436:
          name: Potbeet0
    12437:
          name: Potbeet1
    12438:
          name: Potbeet2
    12439:
          name: Potmush 0
    12440:
          name: Potmush 1
    12441:
          name: Potveg 0
    12442:
          name: Purpturnip
    12443:
          name: Purpturnip2
    12444:
          name: Purpturnip3
    12445:
          name: Radish
    12446:
          name: Radish2
    12447:
          name: Radish3
    12448:
          name: Old Clock
          solid: true
    12449:
          name: Oak Bench 2
          solid: true
    12450:
          name: Oak Bench
          solid: true
    12451:
          name: Woodenpath1
    12452:
          name: Meal01
    12453:
          name: Disneyxmasplush
    12454:
          name: Tenshixmasplush
    12455:
          name: Thunderxmasplush
    12456:
          name: Merguxmasplush
    12457:
          name: Sentxmasplush
    12458:
          name: Chesterxmasplush
    12459:
          name: Dcaffxmasplush
    12460:
          name: Fireflyxmasplush
    12461:
          name: Angelxmasplush
    12462:
          name: Kyranxmasplush
    12463:
          name: Porkyxmasplush
    12464:
          name: Monkeyxmasplush
    12465:
          name: Dracoxmasplush
    12466:
          name: Zazzxmasplush
    12467:
          name: Keatonplush
    12468:
          name: Present 1
    12469:
          name: Present 2
    12470:
          name: Present 3
    12471:
          name: Present 4
    12472:
          name: Present 5
    12473:
          name: Present 6
    13000:
          name: Peppermint Cookie Flip
    13100:
          name: Chuckie
    13101:
          name: Xmas Cloth
    13102:
          name: Xmas Ornament
    13103:
          name: Xmas Ribbon
    13104:
          name: Xmas Magic
    13105:
          name: Xmas Stuffing
    13106:
          name: Xmas Thread
    13107:
          name: Xmas Stocking
    13108:
          name: Present 7
    13109:
          name: Present 8
    13110:
          name: Red Scarf
    13111:
          name: Blue Scarf
    13112:
          name: Green Scarf
    13113:
          name: Cocoa Mug
    13114:
          name: Penguin
    13115:
          name: Present Pile
    13116:
          name: Snowman Hat
    13117:
          name: Light Crown
    13118:
          name: Xmas Lights
    13119:
          name: Ornament
    13120:
          name: Stocking
    13121:
          name: Coldjiro
    13122:
          name: Fairy Fish
    13123:
          name: Great Fairy Fish
    13124:
          name: Snowflake Seasnake
    13125:
          name: Spiderbell Crab
    13126:
          name: Ambrosial Amberjack
    13127:
          name: Dancing Bream
    13128:
          name: Giant Emerald Swordfish
    13129:
          name: Skippyjack
    13130:
          name: Bashful Angler
    13131:
          name: Ninja Flounder
    13132:
          name: Rusty Swordfish
    13133:
          name: Goobta Goby
    13134:
          name: Icy Seasnake
    13135:
          name: Jolly Longfin
    13136:
          name: Loover
    13137:
          name: Armored Porgy
    13138:
          name: Mighty Porgy
    13139:
          name: Termina Bass
    13140:
          name: Termina Seabass
    13141:
          name: Frog Lure
    13142:
          name: Popper Lure
    13143:
          name: Sinking Lure
    13144:
          name: Spinner Lure
    13145:
          name: Swimmer Lure
    13196:
          name: Kafei's Inkwell
    14001:
          name: Red Fairy Ring
    14002:
          name: Blue Fairy Ring
    14003:
          name: Yellow Fairy Ring
    14004:
          name: Small Stones
    14005:
          name: Small Stones
    14006:
          name: Small Stones
    14007:
          name: Clover Patch
    14008:
          name: Clover Patch
    14009:
          name: Decorative Peach
    14010:
          name: Red Book
    14011:
          name: The White Owl

    # 12239:
    #   name: Teapot
    #   tags:
    #     - teapot
    #     - tea
    #     - kettle
    #     - liquid
    #     - coffee
    #     - classy
    #     - indoor
    #     - briish
    #     - decor
    #     - decorations
    # 12241:
    #   name: Cry About It
    #   tags:
    #     - dcaff
    #     - chair
    #     - fearme
    #     - sitonmemommy
    #     - dominance
    #     - cryaboutit
    #     - youwont
    #     - cry
    #     - about
    #     - it
    #     - meme
    #     - dchair
    #     - GetsMoreAssThanAToiletSeat
  apple:
    100:
      Name: Banana
      tags:
        - banana
        - food
        - item
        - edible
    200:
      Name: Candy1
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    300:
      Name: Candy2
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    400:
      Name: Candy3
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    500:
      Name: Candy4
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    600:
      Name: Candy5
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    700:
      Name: Candy6
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    800:
      Name: Candy7
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    900:
      Name: Candy8
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
    1000:
      Name: Candy9
      tags:
        - candy
        - food
        - item
        - edible
        - halloween
        - sweet
        - treat
  black_dye:
    100:
      Name: Black Dye Bag
      tags:
        - black
        - dye
        - bag
        - colour
        - color
        - item
  blaze_rod:
    100:
      Name: Everfire Rod
  blue_dye:
    100:
      Name: Blue Dye Bag
      tags:
        - blue
        - dye
        - bag
        - colour
        - color
        - item
  brick:
    100:
      Name: Study Stone
      custom_item: zc_study_stone
      tags:
        - study
        - stone
        - zc
        - recipe
        - rpg
        - survival
        - ore
        - wisdom
        - zeldacraft
        - craft
        - crafting
        - item
  brown_dye:
    100:
      Name: Brown Dye Bag
      tags:
        - brown
        - dye
        - bag
        - colour
        - color
        - item
  clay_ball:
    100:
      Name: Zelda Bomb
      solid: true
      tags:
        - bomb
        - zelda
        - explosive
        - tnt
        - tool
        - item
        - util
        - dungeon
        - explode
    200:
      Name: Zelda Bomb Exploding
      solid: true
      tags:
        - bomb
        - zelda
        - exploding
        - red
        - explosive
        - tnt
        - tool
        - item
        - util
        - dungeon
        - explode
        - animated
    300:
      Name: Zelda Bomb Exploding Fast
      solid: true
      tags:
        - bomb
        - zelda
        - exploding
        - fast
        - red
        - explosive
        - tnt
        - tool
        - item
        - util
        - dungeon
        - explode
        - animated
  cooked_beef:
    100:
      Name: Dog Food
  cyan dye:
    100:
      Name: Cyan Dye Bag
      tags:
        - cyan
        - dye
        - bag
        - colour
        - color
        - item
  diamond:
    100:
      Name: Mythril
      custom_item: zc_myhtril
      tags:
        - mythril
        - zc
        - recipe
        - rpg
        - survival
        - ore
        - zeldacraft
        - crafting
        - craft
        - item
    200:
      Name: Mythril Hilt
      custom_item: zc_myhtril_hilt
      tags:
        - mythril
        - zc
        - recipe
        - rpg
        - survival
        - ore
        - zeldacraft
        - crafting
        - craft
        - item
    300:
      Name: Prism Core
  diamond_axe:
    100:
      Name: Mythril Axe
      custom_item: zc_myhtril_axe
    200:
      Name: Swordspirit Axe
    300:
      Name: Diamond Demon Axe
    400:
      Name: Gravedigger Axe
    500:
      Name: Time Lord Axe
  diamond_boots:
    100:
      Name: Power Boots
      custom_item: zc_power_boots
    200:
      Name: Courage Boots
      custom_item: zc_courage_boots
    300:
      Name: Wisdom Boots
      custom_item: zc_wisdom_boots
    400:
      Name: Mythril Boots
      custom_item: zc_myhtril_boots
  diamond_chestplate:
    100:
      Name: Power Chestplate
      custom_item: zc_power_chestplate
    200:
      Name: Courage Chestplate
      custom_item: zc_courage_chestplate
    300:
      Name: Wisdom Chestplate
      custom_item: zc_wisdom_chestplate
    400:
      Name: Mythril Chestplate
      custom_item: zc_mythril_chestplate
  diamond_hoe:
    100:
      Name: Mythril Hoe
      custom_item: zc_mythril_hoe
    200:
      Name: Plunger Gang
  diamond_leggings:
    100:
      Name: Power Leggings
      custom_item: zc_power_leggings
    200:
      Name: Courage Leggings
      custom_item: zc_courage_leggings
    300:
      Name: Wisdom Leggings
      custom_item: zc_wisdom_leggings
    400:
      Name: Mythril Leggings
      custom_item: zc_mythril_leggings
  diamond_pickaxe:
    100:
      Name: Mythril Pickaxe
      custom_item: zc_mythril_pickaxe
    200:
      Name: Swordspirit Pickaxe
    300:
      Name: Diamond Demon Pickaxe
    400:
      Name: Gravedigger Pickaxe
    500:
      Name: Time Lord Pickaxe
  diamond_shovel:
    100:
      Name: Mythril Shovel
      custom_item: zc_mythril_shovel
    200:
      Name: Swordspirit Shovel
    300:
      Name: Diamond Demon Shovel
    400:
      Name: Gravedigger Shovel
    500:
      Name: Time Lord Shovel
  diamond_sword:
    100:
      Name: Master Sword
    200:
      Name: Fierce Deity Sword
    300:
      Name: Great Fairy Sword
    400:
      Name: Shiekah Gauntlet
    500:
      Name: Spirit Sword
    600:
      Name: Diamond Demon Sword
    700:
      Name: Gravedigger Scythe
    800:
      Name: Time Lord Sword
    900:
      Name: Demon Carver
  elytra:
    100:
      Name: Navi Wings
      custom_item: zc_navi_wings
    200:
      Name: Broken Navi Wings
    400:
      Name: Dragon Wings
  emerald:
    100:
      Name: Rupee
      tags:
        - rupee
        - money
        - 1
        - currency
        - zelda
    200:
      Name: 5 Rupee
      tags:
        - rupee
        - money
        - 5
        - currency
        - zelda
    300:
      Name: 20 Rupee
      tags:
        - rupee
        - money
        - 20
        - currency
        - zelda
    400:
      Name: 50 Rupee
      tags:
        - rupee
        - money
        - 50
        - currency
        - zelda
    500:
      Name: 100 Rupee
      tags:
        - rupee
        - money
        - 100
        - currency
        - zelda
    600:
      Name: 200 Rupee
      tags:
        - rupee
        - money
        - 200
        - currency
        - zelda
    700:
      Name: 1000 Rupee
      tags:
        - rupee
        - money
        - 1000
        - currency
        - zelda
  enderpearl:
    100:
      Name: Spirit Orb
  fermented_spider_eye:
    100:
      Name: Power Dust Shards
      custom_item: zc_power_dust
    200:
      Name: Power Shard
      custom_item: zc_power_dust_shard
    300:
      Name: Power Shard Orb
      custom_item: zc_shard_of_power
  flint:
    100:
      Name: Dragon Scale
      custom_item: zc_dragon_scale
  glowstone_dust:
    100:
      Name: Magic Powder
  gold_ingot:
    100:
      Name: Stone Of Knowledge
      custom_item: zc_stone_of_know
    200:
      Name: Wisdom Shard Orb
      custom_item: zc_wisdom_shard
    300:
      Name: Fools Gold
      custom_item: fools_gold
  gold_nugget:
    100:
      Name: Gold Key
  golden_axe:
    100:
      Name: Royal Halberd
    200:
      Name: Swordspirit Axe
    300:
      Name: Diamond Demon Axe
    400:
      Name: Gravedigger Axe
    500:
      Name: Time Lord Axe
  golden_pickaxe:
    200:
      Name: Swordspirit Pickaxe
    300:
      Name: Diamond Demon Pickaxe
    400:
      Name: Gravedigger Pickaxe
    500:
      Name: Time Lord Pickaxe
  golden_shovel:
    200:
      Name: Swordspirit Shovel
    300:
      Name: Diamond Demon Shovel
    400:
      Name: Gravedigger Shovel
    500:
      Name: Time Lord Shovel
  golden_sword:
    100:
      Name: Goddess Sword
    500:
      Name: Spirit Sword
    600:
      Name: Diamond Demon Sword
    700:
      Name: Gravedigger Scythe
    800:
      Name: Time Lord Sword
    900:
      Name: Demon Carver
  gray_dye:
    100:
      Name: Gray Dye Bag
      tags:
        - gray
        - grey
        - dye
        - bag
        - colour
        - color
        - item
  green_dye:
    100:
      Name: Green Dye Bag
      tags:
        - green
        - dye
        - bag
        - colour
        - color
        - item
  ink_sac:
    100:
      Name: Phantom Essence
    200:
      Name: Fire Essence
    300:
      Name: Heart Piece
  iron_axe:
    200:
      Name: Swordspirit Axe
    300:
      Name: Diamond Demon Axe
    400:
      Name: Gravedigger Axe
    500:
      Name: Time Lord Axe
  iron_hoe:
    100:
      Name: Spooky Scythe
  iron_ingot:
    100:
      Name: Tempered Iron
  iron_nugget:
    100:
      Name: Silver Key
  iron_pickaxe:
    200:
      Name: Swordspirit Pickaxe
    300:
      Name: Diamond Demon Pickaxe
    400:
      Name: Gravedigger Pickaxe
    500:
      Name: Time Lord Pickaxe
  iron_shovel:
    200:
      Name: Swordspirit Shovel
    300:
      Name: Diamond Demon Shovel
    400:
      Name: Gravedigger Shovel
    500:
      Name: Time Lord Shovel
  iron_sword:
    100:
      Name: Stop Sign
    200:
      Name: Triforce Blade
      custom_item: zc_triforce_blade
    300:
      Name: Biggorans Sword
    500:
      Name: Spirit Sword
    600:
      Name: Diamond Demon Sword
    700:
      Name: Gravedigger Scythe
    800:
      Name: Time Lord Sword
    900:
      Name: Demon Carver
  leather_horse_armor:
    100:
      Name: Wings
    200:
      Name: Kaepora Wings
    300:
      Name: Fairywings
    400:
      Name: Sephiroth
    500:
      Name: Butterfly Wings
    600:
      Name: Crow
    700:
      Name: Batwings
    800:
      Name: Loftwing
    900:
      Name: Backpack
    1000:
      Name: Bone Dragon
    1100:
      Name: Hylian Shield
    1200:
      Name: Flower Crown
    1300:
      Name: Dragon Tail
    1400:
      Name: Cat Tail
    1500:
      Name: Ghirahim Cape
    2400:
      Name: Curtain
      tags:
        - dyeable
        - dye
        - curtain
        - colour
        - window
        - item
        - fabric
    2700:
      Name: Armchair
      solid: true
    2701:
      Name: Wide Armchair
      solid: true
    21000:
      name: Wood Cushion Chair
    21001:
      name: Wood Cushion Loveseat
    21002:
      name: Wood Pet House
    21003:
      name: Wood Swinging Chair
    21004:
      name: Wood Swinging Loveseat
  light_blue_dye:
    100:
      Name: Zora Sapphire
    200:
      Name: Light Blue Dye Bag
      tags:
        - light
        - blue
        - dye
        - bag
        - colour
        - color
        - item
  light_gray_dye:
    100:
      Name: Light Gray Dye Bag
      tags:
        - light
        - gray
        - grey
        - dye
        - bag
        - colour
        - color
        - item
  lime_dye:
    100:
      Name: Kokiri Emerald
    200:
      Name: Lime Dye Bag
      tags:
        - lime
        - dye
        - bag
        - colour
        - color
        - item
  magenta_dye:
    100:
      Name: Magenta Dye Bag
      tags:
        - magenta
        - dye
        - bag
        - colour
        - color
        - item
  magma_cream:
    100:
      Name: Triforce Gem
      custom_item: zc_triforce_gem
    200:
      Name: Ancient Core
  milk_bucket:
    100:
      Name: Bee Bottle
    200:
      Name: Big Poe Soul
    300:
      Name: Blue Potion
    400:
      Name: Bluefire
    500:
      Name: Bottled Zora Egg
    600:
      Name: Breathing Potion
    700:
      Name: Bug Bottle
    800:
      Name: Chateau Romani
    900:
      Name: Chu Jelly
    1000:
      Name: Chug Jug
    1100:
      Name: Elixer Soup
    1200:
      Name: Fairy Tears
    1300:
      Name: Fairybottle
    1400:
      Name: Fishbottle
    1500:
      Name: Forest Fairy
    1600:
      Name: Forest Water
    1700:
      Name: Gold Dust
    1800:
      Name: Good Bee
    1900:
      Name: Green Potion
    2000:
      Name: Guardian Potion
    2100:
      Name: Heart Potion
    2200:
      Name: Hot Spring Water
    2300:
      Name: Lantern Oil
    2400:
      Name: Lonlonmilk
    2500:
      Name: Mushroom Scent
    2600:
      Name: Mushroom Spores
    2700:
      Name: Mystery Milk
    2800:
      Name: Poe Soul
    2900:
      Name: Pumpkin Soup
    3000:
      Name: Purple Potion
    3100:
      Name: Red Potion
    3200:
      Name: Revitalizing Potion
    3300:
      Name: Sacred Water
    3400:
      Name: Spring Water
    3500:
      Name: Stamina Potion
    3600:
      Name: Water Bottle
  music_disc_13:
    100:
      Name: Tal Tal Record
      custom_item: tal_tal_custom_record
    200:
      Name: Kass Theme Record
      custom_item: kass_theme_custom_record
    300:
      Name: Final Hours Record
      custom_item: final_hours_custom_record
  nether_brick:
    100:
      Name: Softened Iron
      custom_item: zc_soft_iron
  nether_star:
    100:
      Name: Heart Of Fire
  netherite_axe:
    100:
      Name: Mythril Axe Netherite
    600:
      Name: Incinerator
    200:
      Name: Swordspirit Axe
    300:
      Name: Diamond Demon Axe
    400:
      Name: Gravedigger Axe
    500:
      Name: Time Lord Axe
  netherite_boots:
    500:
      Name: Ancient Boots
  netherite_chestplate:
    500:
      Name: Ancient Chestplate
  netherite_helmet:
    500:
      Name: Ancient Helmet
  netherite_hoe:
    100:
      Name: Mythril Hoe Netherite
  netherite_leggings:
    500:
      Name: Ancient Leggings
  netherite_pickaxe:
    100:
      Name: Mythril Pickaxe Netherite
    200:
      Name: Swordspirit Pickaxe
    300:
      Name: Diamond Demon Pickaxe
    400:
      Name: Gravedigger Pickaxe
    500:
      Name: Time Lord Pickaxe
  netherite_shovel:
    100:
      Name: Mythril Shovel Netherite
    200:
      Name: Swordspirit Shovel
    300:
      Name: Diamond Demon Shovel
    400:
      Name: Gravedigger Shovel
    500:
      Name: Time Lord Shovel
  netherite_sword:
    100:
      Name: Phantom Ganon Sword
    200:
      Name: Twilight Sword
    300:
      Name: Royal Guards Spear
    400:
      Name: Flame Eternal
    500:
      Name: Spirit Sword
    600:
      Name: Diamond Demon Sword
    700:
      Name: Gravedigger Scythe
    800:
      Name: Time Lord Sword
    900:
      Name: Demon Carver
  orange_dye:
    100:
      Name: Orange Dye Bag
      tags:
        - orange
        - dye
        - bag
        - colour
        - color
        - item
  pink_dye:
    100:
      Name: Pink Dye Bag
      tags:
        - pink
        - dye
        - bag
        - colour
        - color
        - item
  purple_dye:
    100:
      Name: Purple Dye Bag
      tags:
        - purple
        - dye
        - bag
        - colour
        - color
        - item
  red_dye:
    100:
      Name: Goron Ruby
    200:
      Name: Red Dye Bag
      tags:
        - red
        - dye
        - bag
        - colour
        - color
        - item
  scute:
    100:
      Name: Courage Shard
      custom_item: zc_courage_shell
    200:
      Name: Courage Shard Orb
      custom_item: zc_courage_shard
    300:
      Name: Shell
    400:
      Name: Shell Orange
    500:
      Name: Shell Purple
  slime ball:
    100:
      Name: Bomb Texture
      custom_item: bomb_item
  steak:
    100:
      Name: Dog Food
  stick:
    100:
      Name: Boomerang
      custom_item: boomerang_item
    200:
      Name: Boomerang Throw
    300:
      Name: Slingshot
      custom_item: slingshot
    400:
      Name: Forest Slingshot
      custom_item: forestslingshot
  stone_axe:
    100:
      Name: Ancient Bladesaw
    200:
      Name: Swordspirit Axe
    300:
      Name: Diamond Demon Axe
    400:
      Name: Gravedigger Axe
    500:
      Name: Time Lord Axe
  stone_pickaxe:
    200:
      Name: Swordspirit Pickaxe
    300:
      Name: Diamond Demon Pickaxe
    400:
      Name: Gravedigger Pickaxe
    500:
      Name: Time Lord Pickaxe
  stone_shovel:
    200:
      Name: Swordspirit Shovel
    300:
      Name: Diamond Demon Shovel
    400:
      Name: Gravedigger Shovel
    500:
      Name: Time Lord Shovel
  stone_sword:
    500:
      Name: Spirit Sword
    600:
      Name: Diamond Demon Sword
    700:
      Name: Gravedigger Scythe
    800:
      Name: Time Lord Sword
    900:
      Name: Demon Carver
  turtle_egg:
    100:
      Name: Easter Egg
      custom_item: easter_egg
  white_dye:
    100:
      Name: White Dye Bag
      tags:
        - white
        - dye
        - bag
        - colour
        - color
        - item
  wooden_axe:
    200:
      Name: Swordspirit Axe
    300:
      Name: Diamond Demon Axe
    400:
      Name: Gravedigger Axe
    500:
      Name: Time Lord Axe
  wooden_pickaxe:
    200:
      Name: Swordspirit Pickaxe
    300:
      Name: Diamond Demon Pickaxe
    400:
      Name: Gravedigger Pickaxe
    500:
      Name: Time Lord Pickaxe
  wooden_shovel:
    200:
      Name: Swordspirit Shovel
    300:
      Name: Diamond Demon Shovel
    400:
      Name: Gravedigger Shovel
    500:
      Name: Time Lord Shovel
  wooden_sword:
    100:
      Name: Boat Oar
    200:
      Name: Boko Bat
    300:
      Name: Ladle
    500:
      Name: Spirit Sword
    600:
      Name: Diamond Demon Sword
    700:
      Name: Gravedigger Scythe
    800:
      Name: Time Lord Sword
    900:
      Name: Demon Carver
    1000:
      Name: Broom
  yellow_dye:
    100:
      Name: Yellow Dye Bag
      tags:
        - yellow
        - dye
        - bag
        - colour
        - color
        - item
