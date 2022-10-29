dragon_boots:
  type: item
  debug: false
  material: netherite_boots
  data:
    discover: true
  display name: Dragon Boots
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 4
    - PROTECTION_EXPLOSIONS: 3
  mechanisms:
    custom_model_data: 500
  lore:
    - Did we really
    - win the war?
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|air|zc_dragon_scale
        - zc_dragon_scale|air|zc_dragon_scale

dragon_leggings:
  type: item
  debug: false
  material: netherite_leggings
  data:
    discover: true
  display name: Dragon Graeves
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 4
    - PROTECTION_EXPLOSIONS: 3
  mechanisms:
    custom_model_data: 500
  lore:
    - People who do not believe in dragons,
    - are often eaten by dragons.
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|air|zc_dragon_scale
        - zc_dragon_scale|air|zc_dragon_scale

dragon_chestplate:
  type: item
  debug: false
  material: netherite_chestplate
  data:
    discover: true
  display name: Dragon Cuirass
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 4
    - PROTECTION_EXPLOSIONS: 3
  mechanisms:
    custom_model_data: 500
  lore:
    - Come not between the dragon
    - and her wrath.
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|air|zc_dragon_scale
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale

dragon_helmet:
  type: item
  debug: false
  material: netherite_helmet
  data:
    discover: true
  display name: Dragon Helmet
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 4
    - PROTECTION_EXPLOSIONS: 3
  mechanisms:
    custom_model_data: 500
  lore:
    - Here are dragons to be slain,
    - and treasures to be gain.
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|air|zc_dragon_scale

mythril_dragon_boots:
  type: item
  debug: false
  material: netherite_boots
  data:
    discover: true
  display name: Dragon Boots
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
    - PROTECTION_EXPLOSIONS: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 600
  lore:
    - War never really changes.
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|air|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale

mythril_dragon_leggings:
  type: item
  debug: false
  material: netherite_leggings
  data:
    discover: true
  display name: Dragon Graeves
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
    - PROTECTION_EXPLOSIONS: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 600
  lore:
    - Never anger the beast that
    - sleeps at the end of the world.
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale

mythril_dragon_chestplate:
  type: item
  debug: false
  material: netherite_chestplate
  data:
    discover: true
  display name: Dragon Cuirass
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
    - PROTECTION_EXPLOSIONS: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 600
  lore:
    - So comes snow after fire,
    - and even dragons have their endings.
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|air|mythril_dragon_scale
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale

mythril_dragon_helmet:
  type: item
  debug: false
  material: netherite_helmet
  data:
    discover: true
  display name: Dragon Helmet
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
    - PROTECTION_EXPLOSIONS: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 600
  lore:
    - Death comes out
    - of the dragons mouth.
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale


reinforced_string:
  type: item
  debug: false
  material: string
  display name: Reinforced String
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 300
  lore:
    - A 10-ft spool of reinforced string.
  recipes:
    1:
      type: shaped
      input:
        - string|string|string
        - string|zc_dragon_scale|string
        - string|string|string

mythril_longbow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: Mythril Longbow
  enchantments:
    - ARROW_DAMAGE: 6
  mechanisms:
    custom_model_data: 800
  lore:
    - Fragments of mythril
    - form this sturdy bow.
  recipes:
    1:
      type: shaped
      input:
        - air|zc_mythril|reinforced_string
        - zc_mythril|air|reinforced_string
        - air|zc_mythril|reinforced_string
