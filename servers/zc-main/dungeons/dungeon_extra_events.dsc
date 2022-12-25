dungeon_extra_events:
    type: world
    debug: false
    events:
        # on projectile hits ice in ddoor_icecav_1:
        #     - if <context.projectile.on_fire>:
        #         - run ddoor_open def:icecav_1|bypasslock
        #         - remove <context.projectile>
        #         - playeffect effect:cloud at:<context.location> quantity:100 offset:0.5,2,2 targets:<context.location.find_players_within[100]>
        #         - wait 50t
        #         - run ddoor_close def:icecav_1|bypasslock
        on fireball spawns in:*_dungeon:
        - determine cancelled
        on player right clicks block with:glass_switcher in:testglass:
          - ratelimit <player> 5t
          - if <player.cursor_on_solid.material.name||false> == sea_lantern:
            - if <player.has_flag[dg_glass_type]>:
              - modifyblock <cuboid[testglass].blocks[structure_void]> <player.flag[dg_glass_type]>_stained_glass
              - flag <player> dg_glass_type:!
              - playsound sound:ENTITY_ILLUSIONER_PREPARE_MIRROR <player> pitch:1.3 volume:0.5
            - stop
          - if !<player.cursor_on_solid.material.name.contains_any[_glazed]||false>:
            - stop
          - define type <player.cursor_on.material.name.before[_glazed]||none>
          - if <player.has_flag[dg_glass_type]>:
            - if <player.flag[dg_glass_type]> == <[type]>:
              - stop
            - modifyblock <cuboid[testglass].blocks[structure_void]> <player.flag[dg_glass_type]>_stained_glass
          - modifyblock <cuboid[testglass].blocks[<[type]>_stained_glass]> structure_void
          - flag <player> dg_glass_type:<[type]>
          - playsound sound:ENTITY_ILLUSIONER_PREPARE_MIRROR <player> pitch:<util.random.decimal[1.8].to[2]> volume:0.5

glass_switcher:
  type: item
  material: nether_star
  debug: false
  display name: <gray>Glass Switcher
  lore:
    - <aqua>Right click terracotta
    - <aqua>block to remove glass
    - <aqua>of the same colour.
    - <aqua>Right click sea lanterns to reset
