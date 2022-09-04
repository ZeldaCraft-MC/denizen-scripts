#something
silk_cake:
  type: world
  debug: false
  events:
    on player breaks cake:
    - if <player.item_in_hand.enchantment_map.contains[silk_touch]||false>:
      - if <context.material.level> != 0:
        - stop
      - determine <context.material.name>
