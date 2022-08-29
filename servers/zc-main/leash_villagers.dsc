leash_villagers_events:
  type: world
  debug: false
  events:
    on player right clicks villager:
      - ratelimit <player> 2t
      - if <context.entity.is_leashed> || !<list[s1|s2|s3].contains[<player.world.name>]> || <context.entity.is_npc>:
        - stop
      - if <player.item_in_hand.material.name> == lead:
        - determine passively cancelled
        - define slot hand
      - else if <player.item_in_offhand.material.name> == lead:
        - determine passively cancelled
        - define slot offhand
      - else:
        - stop
      - if <player.gamemode> != creative:
        - take slot:<[slot]> quantity:1
      - wait 1t
      - leash <context.entity> holder:<player>
