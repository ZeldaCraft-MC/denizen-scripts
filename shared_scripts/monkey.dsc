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

banana:
  type: item
  debug: false
  material: apple
  display name: Banana
  mechanisms:
    custom_model_data: 100
  lore:
    - This fruit grows mainly in tropical
    - forests of the Faron region.

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

monkey_shovel_events:
  type: world
  debug: false
  events:
    on jungle_leaves decay:
    - if <context.location.world.name> not in s1|s2|newnether|theendkek|resources|resources_nether|resources_the_end|resources_nullscape_end_island:
      - stop
    - if <util.random_chance[3]>:
      - drop banana <context.location>
    on player places monkey_head:
    - determine cancelled
