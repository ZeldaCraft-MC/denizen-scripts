shrine_item_pool:
  type: data
  debug: false
  items:
    - netherite_scrap[quantity=3]
    - diamond[quantity=5]
    - gold_ingot[quantity=10]
    - iron_ingot[quantity=20]
    - turtle_egg[quantity=10]
    - sponge[quantity=10]
    - cake[quantity=5]
    - anvil
    - enchanting_table
    - experience_bottle[quantity=15]
    - shulker_box
    - golden_apple[quantity=5]
    - painting[quantity=5]
    - item_frame[quantity=10]
    - wither_skeleton_skull
    - map[quantity=5]
    - diamond_horse_armor
    - golden_horse_armor
    - iron_horse_armor
    - leather_horse_armor
    - end_crystal[quantity=4]
    - name_tag[quantity=5]
    - trident
    - nautilus_shell[quantity=3]
    - heart_of_the_sea

shrine_events:
  type: world
  debug: false
  events:
    on player right clicks *_sign:
    - ratelimit <player> 1s
    - foreach <context.location.sign_contents>:
      - define line <[value].strip_color.to_lowercase||null>
      - if <[line]> == shrine || <[line]> == [shrine]:
        - if <player.has_flag[shrine.last_click]>:
          - define curr_time <util.time_now>
          - define flag_time <player.flag[shrine.last_click]>
          - if <[flag_time].day> == <[curr_time].day> && <[flag_time].month> == <[curr_time].month> && <[flag_time].year> == <[curr_time].year>:
            - narrate "<n><&7>You already used the shrine today! Come back tomorrow for more gifts!<n>"
            - stop
        - flag player shrine.last_click:<util.time_now>
        - narrate "<n><&7>You used the shrine! Come back tomorrow for more items!"
        - define item <script[shrine_item_pool].data_key[items].random.as[item]>
        - give <[item]> unlimit_stack_size
        - narrate "<&7>You gained <&a>x<[item].quantity> <[item].material.translated_name><n>"
        - stop
