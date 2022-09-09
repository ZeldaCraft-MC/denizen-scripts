blin_basher:
  type: item
  debug: false
  material: netherite_pickaxe
  data:
    discover: true
  display name: <&color[#57009a]>Blin Basher
  enchantments:
    - DIG_SPEED: 5
    - KNOCKBACK: 5
  mechanisms:
    custom_model_data: 800
  lore:
    - <empty>
    - <&color[#6d00c1]>A hammer made from Bokoblin Horns.
    - <&color[#6d00c1]>Smash and Crash!
  recipes:
    1:
      type: shaped
      input:
        - bokoblin_horn|obsidian_plate|crying_obsidian
        - air|amethyst_shard|obsidian_plate
        - moblin_fang|air|bokoblin_horn

decaying_hoe:
  type: item
  debug: false
  material: iron_hoe
  data:
    discover: true
  display name: <&color[#E2BE45]>Decaying Hoe
  mechanisms:
    custom_model_data: 800
  enchantments:
    - LOOT_BONUS_BLOCKS: 4
  lore:
    - <empty>
    - <&color[#D8C565]>The decaying remains of a Moblin,
    - <&color[#C28B72]>fashioned into a crude hoe.
    - <&color[#A03485]>The smell is putrid.
  recipes:
    1:
      type: shaped
      input:
        - moblin_horn|moblin_horn|large_amethyst_bud
        - air|raw_gold_block|moblin_fang
        - obsidian_plate|raw_gold_block|air

moblin_pickaxe:
  type: item
  debug: false
  material: golden_pickaxe
  data:
    discover: true
  display name: <&color[#349EA0]>Molblin Pickaxe
  mechanisms:
    custom_model_data: 600
  enchantments:
    - DIG_SPEED: 5
    - LOOT_BONUS_BLOCKS: 4
    - DAMAGE_UNDEAD: 3
  lore:
    - <empty>
    - <&color[#42BEDF]>A pickaxe fashioned from those,
    - <&color[#42C8D8]>who deal with the Prince of Darkness.
  recipes:
    1:
      type: shaped
      input:
        - moblin_horn|moblin_guts|moblin_guts
        - air|onox_shard|moblin_guts
        - netherite_ingot|air|moblin_horn

obsidian_plate:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: Obsidian Plate
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 1500
    hides:
      - ENCHANTS
  lore:
    - Forged from the tears
    - of lost souls.
  recipes:
    1:
      type: shaped
      input:
        - crying_obsidian|crying_obsidian|crying_obsidian
        - crying_obsidian|netherite_ingot|crying_obsidian
        - crying_obsidian|crying_obsidian|crying_obsidian

mythril_dragon_scale:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: Mythril Dragon Scale
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 1000
    hides:
      - ENCHANTS
  lore:
    - Icy white scales glow with purity.
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|zc_mythril|zc_dragon_scale
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale

gear_of_time:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: Gear of Time
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 300
    hides:
      - ENCHANTS
  lore:
    - A fragment of the Gate of Hylia
    - lost long ago. Perhaps with time,
    - it shall work again.

onox_shard:
  type: item
  debug: false
  material: flint
  display name: Onox Shard
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 1400
  lore:
    - A crystalized shard of onox.
