zc_monkey_shovel:
  type: item
  debug: false
  material: diamond_shovel
  data:
    discover: true
  display name: <&color[#7B3F00]>Monkey Shovel
  mechanisms:
    custom_model_data: 600
  enchantments:
    - IMPALING: 10
    - LUCK: 5
    - PROTECTION_EXPLOSIONS: 8
  lore:
    - <empty>
    - <&color[#C19A6B]>OOH Ooh Ooh Ooh Ah
    - <&color[#C19A6B]>Ooh OOH Ooh Ooh Ah
    - <&color[#C19A6B]>Ooh Ooh OOH OOH AH
  recipes:
    1:
      type: shaped
      input:
        - monkey_head
        - diamond
        - zc_mythril_hilt

monkey_head:
  type: item
  debug: false
  material: player_head
  data:
    discover: true
  display name: <&color[#7B3F00]>Monkey Head
  mechanisms:
    skull_skin: 00000000-0000-0000-0000-000000000000|e3RleHR1cmVzOntTS0lOOnt1cmw6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTVkNzIwNzZhYWI5NWMwZDRmZWNjNmYzMGVhMjk1NDJjMGJmZjVlMjQ0NDY2ODI2Y2NkMTg5MzRkZDhmMDIyNiJ9fX0=|Monkey
  lore:
    - <empty>
    - <&color[#C19A6B]>The detached head of a monkey.
    - <&color[#C19A6B]>The smell is putrid.
  recipes:
    1:
      type: shaped
      input:
        - banana|banana|banana
        - banana|wither_skeleton_skull|banana
        - banana|banana|banana

place_monkey:
  type: world
  events:
    on player places monkey_head:
    - determine cancelled

banana_drops:
  type: world
  events:
    on jungle_leaves decay:
    - if <util.random_chance[3]>:
      - drop banana <context.location>
