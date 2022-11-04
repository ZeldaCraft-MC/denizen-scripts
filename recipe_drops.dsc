onox_shard_drop:
  type: world
  events:
    on player breaks crying_obsidian:
    - if <player.item_in_hand.material.name> != netherite_pickaxe:
      - stop
    - define droprate 0.5
    - if <player.item_in_hand.enchantment_map.contains[fortune]>:
      - if <player.item_in_hand.enchantment_map.get[fortune]> == 1:
        - define droprate 1
      - else if <player.item_in_hand.enchantment_map.get[fortune]> == 2:
        - define droprate 2.5
      - else if <player.item_in_hand.enchantment_map.get[fortune]> == 3:
        - define droprate 5
    - if <util.random_chance[<[droprate]>]>:
      - determine onox_shard[quantity=<util.random.int[1].to[3]>]
