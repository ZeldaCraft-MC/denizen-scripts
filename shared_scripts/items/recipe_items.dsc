# Add `discover: true` to any recipes you wish to be auto-discovered by all players.
# To treat the resulting item as a normal vanilla item, add `no_id: true` to the item and
#  a unique `recipe_id` to each recipe.

recipe_handler:
  type: world
  debug: false
  events:
    on player joins:
      - adjust <player> discover_recipe:<proc[get_custom_recipes]>
    on item recipe formed:
      # Cancel all script item -> vanilla item crafting
      - if <context.item.script.if_null[null]> != null || <context.recipe.filter[script.is_truthy].is_empty>:
        - stop
      - determine cancelled
    on player prepares smithing item:
      # Fix smithing items
      - if <context.inventory.list_contents.first.script.name.starts_with[zc_]||false> && <context.inventory.list_contents.first.material.name.starts_with[diamond_]||false> && <context.inventory.list_contents.get[2].material.name||error> == netherite_ingot:
        - define mat netherite_<context.inventory.list_contents.first.material.name.after[diamond_]>
        - determine <context.inventory.list_contents.first.with[material=<[mat]>]>

get_custom_recipes:
  type: procedure
  debug: false
  script:
    - define recipes <list>
    - foreach <util.scripts.filter[container_type.is[==].to[ITEM]].filter[data_key[data.discover]]> as:script:
      - if <[script].data_key[no_id]||false>:
        - foreach <[script].list_keys[recipes]||<list>> as:id:
          - define recipe_id <[script].data_key[recipes.<[id]>.recipe_id]||null>
          - if <[recipe_id]> != null:
            - define recipes <[recipes].include[denizen:<[recipe_id]>]>
      - else:
        - define recipes <[recipes].include[<[script].name.as[item].recipe_ids>]>
    - determine <[recipes]>

unplaceable_items:
  type: world
  debug: false
  events:
    on player places zc_*:
      - if <context.item.script.name> == zc_nest || <context.item_in_hand.script.name> == zc_mythril_shovel || <context.item_in_hand.script.name> == zc_mythril_hoe || <context.item_in_hand.script.name> == zc_mythril_axe:
        - stop
      - determine cancelled

furnace_events:
  type: world
  debug: false
  events:
    on furnace smelts item into gold_nugget:
      - determine gold_ingot
    on furnace smelts item into iron_nugget:
      - determine iron_ingot

villager_events:
  type: world
  debug: false
  events:
    on wandering_trader death:
      - determine zc_power_dust
    on villager death:
      - if <list[DROWNED|ZOMBIE|HUSK|ZOMBIE_VILLAGER].contains[<context.damager.entity_type||none>]>:
        - stop
      - if <util.random_decimal> < 0.5:
        - determine zc_power_dust

ds_nest:
  type: item
  debug: false
  material: bee_nest
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: bee_nest
      input:
        - honeycomb|honeycomb|honeycomb
        - honeycomb|beehive|honeycomb
        - honeycomb|honeycomb|honeycomb

ds_coal_block:
  type: item
  debug: false
  material: coal_block
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: coal_block
      input:
        - charcoal|charcoal|charcoal
        - charcoal|charcoal|charcoal
        - charcoal|charcoal|charcoal

zc_mythril_shovel:
  type: item
  debug: false
  material: diamond_shovel
  data:
    discover: true
  display name: Mythril Shovel
  enchantments:
    - DIG_SPEED: 6
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
       type: shaped
       input:
         - zc_mythril
         - stick
         - stick

zc_mythril_axe:
  type: item
  debug: false
  material: diamond_axe
  data:
    discover: true
  display name: Mythril Axe
  enchantments:
    - DIG_SPEED: 6
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|zc_mythril
        - zc_mythril|stick
        - air|stick

zc_mythril_hoe:
  type: item
  debug: false
  material: diamond_hoe
  data:
    discover: true
  display name: Mythril Hoe
  enchantments:
    - DIG_SPEED: 6
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|zc_mythril
        - air|stick
        - air|stick

zc_study_stone:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: Study Stone
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - Learning is not attained by chance,
    - it must be sought for with ardor
    - and attended to with diligence.
  recipes:
    1:
      type: blast
      cook_time: 6m
      experience: 1000
      input: gold_block

zc_stone_of_know:
  type: item
  debug: false
  material: gold_ingot
  data:
    discover: true
  display name: Stone of Knowledge
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 101
  lore:
    - Any fool can know.
    - The point is to understand.
  recipes:
    1:
      type: shapeless
      input: zc_study_stone|potion[potion_effects=WATER,false,false]

zc_wisdom_shard:
  type: item
  debug: false
  material: gold_ingot
  data:
    discover: true
  display name: Wisdom Shard
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - The only true wisdom...
    - is in knowing you know nothing.
  recipes:
    1:
      type: shaped
      input:
        - zc_stone_of_know|zc_stone_of_know|zc_stone_of_know
        - zc_stone_of_know|zc_stone_of_know|zc_stone_of_know
        - zc_stone_of_know|zc_stone_of_know|zc_stone_of_know

zc_courage_shell:
  type: item
  debug: false
  material: scute
  data:
    discover: true
  display name: Courage Shell
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - Life shrinks or expands..
    - in proportion to one's courage.
  recipes:
    1:
      type: shaped
      input:
        - emerald|emerald|emerald
        - emerald|scute|emerald
        - emerald|emerald|emerald

zc_courage_shard:
  type: item
  debug: false
  material: scute
  data:
    discover: true
  display name: Courage Shard
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - Courage is resistance to fear.
    - Courage is mastery of fear.
    - Courage is not the absence of fear.
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shell|zc_courage_shell|zc_courage_shell
        - zc_courage_shell|zc_courage_shell|zc_courage_shell
        - zc_courage_shell|zc_courage_shell|zc_courage_shell

zc_power_dust:
  type: item
  debug: false
  material: fermented_spider_eye
  display name: Power Dust
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - You Monster...
    - Nobody gives you power. You take it.

zc_power_dust_block:
  type: item
  debug: false
  material: fermented_spider_eye
  display name: Power Dust Block
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - So Many Innocents......
    - The measure of a person is what they do with power.
  recipes:
    1:
      type: shaped
      input:
        - zc_power_dust|zc_power_dust|zc_power_dust
        - zc_power_dust|zc_power_dust|zc_power_dust
        - zc_power_dust|zc_power_dust|zc_power_dust

zc_shard_of_power:
  type: item
  debug: false
  material: fermented_spider_eye
  display name: Power Shard
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 300
    hides:
      - ENCHANTS
  lore:
    - Did you really have to cook them!?
    - Only the dead have seen the end of war.
  recipes:
    1:
      type: furnace
      cook_time: 6m
      experience: 1000
      input: zc_power_dust_block

zc_triforce_gem:
  type: item
  debug: false
  material: magma_cream
  display name: Triforce Gem
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 100
    hides:
      - ENCHANTS
  lore:
    - A fragment of the legendary relic.
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|zc_courage_shard|zc_wisdom_shard
        - zc_courage_shard|zc_wisdom_shard|zc_shard_of_power
        - zc_wisdom_shard|zc_shard_of_power|zc_shard_of_power

zc_mythril_hilt:
  type: item
  debug: false
  material: diamond
  display name: Mythril Hilt
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  recipes:
    1:
      type: shapeless
      input: zc_mythril|zc_mythril

zc_triforce_blade:
  type: item
  debug: false
  material: iron_sword
  display name: Triforce Blade
  enchantments:
    - DAMAGE_ALL: 10
  lore:
    - Power
    - Courage
    - Wisdom
    - It is dangerous to go alone...
  mechanisms:
    custom_model_data: 200
  recipes:
    1:
      type: shaped
      input:
        - zc_triforce_gem
        - zc_triforce_gem
        - zc_mythril_hilt

zc_soft_iron:
  type: item
  debug: false
  material: nether_brick
  data:
    discover: true
  display name: Softened Iron
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - Superheated iron becomes soft.
  recipes:
    1:
      type: blast
      cook_time: 6m
      experience: 1000
      input: iron_block

zc_tempered_iron:
  type: item
  debug: false
  material: iron_ingot
  data:
    discover: true
  display name: Tempered Iron
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - When you rapidly cool superheated metal,
    - it becomes less brittle and more tough.
  recipes:
    1:
      type: shapeless
      input: zc_soft_iron|potion[potion_effects=WATER,false,false]

zc_tempered_iron_block:
  type: item
  debug: false
  material: iron_block
  data:
    discover: true
  display name: Tempered Iron Block
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
  recipes:
    1:
      type: shaped
      input:
        - zc_tempered_iron|zc_tempered_iron|zc_tempered_iron
        - zc_tempered_iron|zc_tempered_iron|zc_tempered_iron
        - zc_tempered_iron|zc_tempered_iron|zc_tempered_iron

zc_dragon_scale:
  type: item
  debug: false
  material: flint
  display name: Dragon Scale
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - Dragons seek war. I give it to them.

zc_mythril:
  type: item
  debug: false
  material: diamond
  data:
    discover: true
  display name: Mythril
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|zc_tempered_iron_block|zc_dragon_scale
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale

zc_mythril_pickaxe:
  type: item
  debug: false
  material: diamond_pickaxe
  data:
    discover: true
  display name: Mythril Pickaxe
  enchantments:
    - DIG_SPEED: 6
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|zc_mythril|zc_mythril
        - air|stick|air
        - air|stick|air

ds_saddle:
  type: item
  debug: false
  material: saddle
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: saddle
      input:
      - leather|leather|leather
      - tripwire_hook|air|tripwire_hook

ds_enchanted_golden_apple:
  type: item
  debug: false
  material: enchanted_golden_apple
  mechanisms:
    quantity: 8
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: enchanted_golden_apple
      input:
      - golden_apple|golden_apple|golden_apple
      - golden_apple|nether_star|golden_apple
      - golden_apple|golden_apple|golden_apple

ds_heart_of_the_sea:
  type: item
  debug: false
  material: heart_of_the_sea
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: heart_of_the_sea
      input:
      - nautilus_shell|nautilus_shell|nautilus_shell
      - prismarine_shard|nether_star|prismarine_shard
      - nautilus_shell|nautilus_shell|nautilus_shell

ds_trident:
  type: item
  debug: false
  material: trident
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: trident
      input:
      - quartz|heart_of_the_sea|quartz
      - quartz|prismarine_shard|quartz
      - air|prismarine_shard|air

ds_golden_horse_armor:
  type: item
  debug: false
  material: golden_horse_armor
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: golden_horse_armor
      group: horse_armor
      input:
      - air|air|gold_ingot
      - gold_ingot|saddle|gold_ingot
      - gold_ingot|air|gold_ingot

ds_iron_horse_armor:
  type: item
  debug: false
  material: iron_horse_armor
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: iron_horse_armor
      group: horse_armor
      input:
      - air|air|iron_ingot
      - iron_ingot|saddle|iron_ingot
      - iron_ingot|air|iron_ingot

ds_diamond_horse_armor:
  type: item
  debug: false
  material: diamond_horse_armor
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: diamond_horse_armor
      group: horse_armor
      input:
      - air|air|diamond
      - diamond|saddle|diamond
      - diamond|air|diamond

ds_pufferfish_bucket:
  type: item
  debug: false
  material: pufferfish_bucket
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: pufferfish_bucket
      group: bucket_of_fish
      input:
      - pufferfish
      - water_bucket

ds_salmon_bucket:
  type: item
  debug: false
  material: salmon_bucket
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: salmon_bucket
      group: bucket_of_fish
      input:
      - salmon
      - water_bucket

ds_cod_bucket:
  type: item
  debug: false
  material: cod_bucket
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: cod_bucket
      group: bucket_of_fish
      input:
      - cod
      - water_bucket

ds_tropical_fish_bucket:
  type: item
  debug: false
  material: tropical_fish_bucket
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: tropical_fish_bucket
      group: bucket_of_fish
      input:
      - tropical_fish
      - water_bucket

ds_melon_slice:
  type: item
  debug: false
  material: melon_slice
  mechanisms:
    quantity: 9
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: melon_slice
      input:
        - melon

ds_bell:
  type: item
  debug: false
  material: bell
  data:
    discover: true
  no_id: true
  recipes:
    1:
      type: shaped
      recipe_id: bell
      input:
        - stick|stick|stick
        - stone_slab|gold_block|stone_slab
        - stone_slab|gold_nugget|stone_slab

zc_power_chest:
  type: item
  debug: false
  material: diamond_chestplate
  data:
    discover: true
  display name: Chestplate of Power
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_EXPLOSIONS: 5
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|air|zc_shard_of_power
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power

zc_power_helm:
  type: item
  debug: false
  material: diamond_helmet
  data:
    discover: true
  display name: Helmet of Power
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_EXPLOSIONS: 5
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power
        - zc_shard_of_power|air|zc_shard_of_power

zc_power_boots:
  type: item
  debug: false
  material: diamond_boots
  data:
    discover: true
  display name: Boots of Power
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_EXPLOSIONS: 5
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|air|zc_shard_of_power
        - zc_shard_of_power|air|zc_shard_of_power

zc_power_legs:
  type: item
  debug: false
  material: diamond_leggings
  data:
    discover: true
  display name: Leggings of Power
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_EXPLOSIONS: 5
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power
        - zc_shard_of_power|air|zc_shard_of_power
        - zc_shard_of_power|air|zc_shard_of_power

zc_courage_chest:
  type: item
  debug: false
  material: diamond_chestplate
  data:
    discover: true
  display name: Chestplate of Courage
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_PROJECTILE: 5
  mechanisms:
    custom_model_data: 200
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|air|zc_courage_shard
        - zc_courage_shard|zc_courage_shard|zc_courage_shard
        - zc_courage_shard|zc_courage_shard|zc_courage_shard

zc_courage_helm:
  type: item
  debug: false
  material: diamond_helmet
  data:
    discover: true
  display name: Helmet of Courage
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_PROJECTILE: 5
  mechanisms:
    custom_model_data: 200
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|zc_courage_shard|zc_courage_shard
        - zc_courage_shard|air|zc_courage_shard

zc_courage_boots:
  type: item
  debug: false
  material: diamond_boots
  data:
    discover: true
  display name: Boots of Courage
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_PROJECTILE: 5
  mechanisms:
    custom_model_data: 200
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|air|zc_courage_shard
        - zc_courage_shard|air|zc_courage_shard

zc_courage_legs:
  type: item
  debug: false
  material: diamond_leggings
  data:
    discover: true
  display name: Leggings of Courage
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_PROJECTILE: 5
  mechanisms:
    custom_model_data: 200
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|zc_courage_shard|zc_courage_shard
        - zc_courage_shard|air|zc_courage_shard
        - zc_courage_shard|air|zc_courage_shard

zc_wisdom_chest:
  type: item
  debug: false
  material: diamond_chestplate
  data:
    discover: true
  display name: Chestplate of Wisdom
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 300
  recipes:
    1:
      type: shaped
      input:
        - zc_wisdom_shard|air|zc_wisdom_shard
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard

zc_wisdom_helm:
  type: item
  debug: false
  material: diamond_helmet
  data:
    discover: true
  display name: Helmet of Wisdom
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 300
  recipes:
    1:
      type: shaped
      input:
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard
        - zc_wisdom_shard|air|zc_wisdom_shard

zc_wisdom_boots:
  type: item
  debug: false
  material: diamond_boots
  data:
    discover: true
  display name: Boots of Wisdom
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 300
  recipes:
    1:
      type: shaped
      input:
        - zc_wisdom_shard|air|zc_wisdom_shard
        - zc_wisdom_shard|air|zc_wisdom_shard

zc_wisdom_legs:
  type: item
  debug: false
  material: diamond_leggings
  data:
    discover: true
  display name: Leggings of Wisdom
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_FIRE: 5
  mechanisms:
    custom_model_data: 300
  recipes:
    1:
      type: shaped
      input:
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard
        - zc_wisdom_shard|air|zc_wisdom_shard
        - zc_wisdom_shard|air|zc_wisdom_shard

zc_mythril_chest:
  type: item
  debug: false
  material: diamond_chestplate
  data:
    discover: true
  display name: Mythril Chestplate
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
  mechanisms:
    custom_model_data: 400
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|air|zc_mythril
        - zc_mythril|zc_mythril|zc_mythril
        - zc_mythril|zc_mythril|zc_mythril

zc_mythril_helm:
  type: item
  debug: false
  material: diamond_helmet
  data:
    discover: true
  display name: Mythril Helmet
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
  mechanisms:
    custom_model_data: 400
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|zc_mythril|zc_mythril
        - zc_mythril|air|zc_mythril

zc_mythril_legs:
  type: item
  debug: false
  material: diamond_leggings
  data:
    discover: true
  display name: Mythril Leggings
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
  mechanisms:
    custom_model_data: 400
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|zc_mythril|zc_mythril
        - zc_mythril|air|zc_mythril
        - zc_mythril|air|zc_mythril

zc_mythril_boots:
  type: item
  debug: false
  material: diamond_boots
  data:
    discover: true
  display name: Mythril Boots
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 6
  mechanisms:
    custom_model_data: 400
  recipes:
    1:
      type: shaped
      input:
        - zc_mythril|air|zc_mythril
        - zc_mythril|air|zc_mythril

zc_navi_wings:
  type: item
  debug: false
  material: elytra
  data:
    discover: true
  display name: Navi Wings
  enchantments:
    - PROTECTION_ENVIRONMENTAL: 5
    - PROTECTION_FALL: 5
    - DURABILITY: 5
  mechanisms:
    custom_model_data: 100
  recipes:
    1:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    2:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    3:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=15]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    4:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=1]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    5:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=2]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    6:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=3]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    7:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=4]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    8:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=5]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    9:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=6]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    10:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|elytra|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    11:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=8]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    12:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=9]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    13:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=10]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    14:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=11]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    15:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=12]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    16:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=13]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    17:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=14]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
    18:
      type: shaped
      input:
        - zc_triforce_gem|air|zc_triforce_gem
        - zc_triforce_gem|ender_dragon_wings[durability=0;repair_cost=7]|zc_triforce_gem
        - zc_triforce_gem|air|zc_triforce_gem
