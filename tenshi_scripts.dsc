tempered_iron_plate:
  type: item
  debug: false
  material: iron_ingot
  data:
    discover: true
  display name: <&color[#999999]>Tempered Iron Plate
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - <&color[#eeeeee]>A solid plate perfect for
    - <&color[#eeeeee]>armor smithing.
  recipes:
    1:
      type: shaped
      input:
        - zc_tempered_iron|zc_tempered_iron|zc_tempered_iron
        - zc_tempered_iron|zc_tempered_iron_block|zc_tempered_iron
        - zc_tempered_iron|zc_tempered_iron|zc_tempered_iron

cured_quartz:
  type: item
  debug: false
  material: quartz
  data:
    discover: true
  display name: Cured Quartz
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 100
    hides:
      - ENCHANTS
  lore:
    - This quartz has been cleansed
    - with amethyst, offering protection
    - and guidance.
  recipes:
    1:
      type: shaped
      input:
        - quartz|amethyst_shard|quartz
        - amethyst_shard|quartz|amethyst_shard
        - quartz|amethyst_shard|quartz

cured_quartz_plate:
  type: item
  debug: false
  material: quartz
  data:
    discover: true
  display name: Cured Quartz Plate
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - A plate forged from
    - cured quartz. You can
    - feel it's purity.
  recipes:
    1:
      type: shaped
      input:
        - cured_quartz|cured_quartz|cured_quartz
        - cured_quartz|amethyst_cluster|cured_quartz
        - cured_quartz|cured_quartz|cured_quartz


loftwing_feather:
  type: item
  debug: false
  material: feather
  display name: Loftwing Feather
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - A crimson feather dropped
    - by a Loftwing.

loftwing_feathers_drop:
  type: world
  events:
    on player kills parrot:
    - define droprate 5
    - if <util.random_chance[<[droprate]>]>:
      - drop loftwing_feather[quantity=<util.random.int[1].to[3]>]

wizzrobe_crystal:
  type: item
  debug: false
  material: amethyst_shard
  display name: Wizzrobe Crystal
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - A crystal broken off
    - from a Wizzrobe's robe.

wizzrobe_crystals_drop:
  type: world
  events:
    on player kills evoker:
    - define droprate 2
    - if <util.random_chance[<[droprate]>]>:
      - drop wizzrobe_crystal[quantity=<util.random.int[1].to[3]>]

enhanced_loftwing_feather:
  type: item
  debug: false
  material: feather
  display name: Enhanced Loftwing Feather
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - Once a simple feather
    - now gleaming with magic.
  recipes:
    1:
      type: smithing
      base: loftwing_feather
      upgrade: wizzrobe_crystal


deku_root:
  type: item
  debug: false
  material: stick
  display name: Deku Root
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 800
  lore:
    - A root from remnants
    - of ancient deku trees.

deku_root_drop:
  type: world
  events:
    on player breaks rooted_dirt:
    - if <player.item_in_hand.material.name> != netherite_shovel:
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
      - determine deku_root[quantity=<util.random.int[1].to[3]>]

skulltula_silk:
  type: item
  debug: false
  material: string
  display name: Skulltula Silk
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - Silk from a giant spider.

skulltula_silk_drop:
  type: world
  events:
    on player kills cave_spider:
    - define droprate 2
    - if <util.random_chance[<[droprate]>]>:
      - drop wizzrobe_crystal[quantity=<util.random.int[1].to[3]>]

gold_skulltula_silk:
  type: item
  debug: false
  material: string
  display name: Gold Skulltula Silk
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 200
    hides:
      - ENCHANTS
  lore:
    - Silk that seems to be
    - spun from solid gold.
  recipes:
    1:
      type: smithing
      base: skulltula_silk
      upgrade: gold_dust

gold_dust:
  type: item
  debug: false
  material: glowstone_dust
  display name: Deku Root
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 1000
  lore:
    - Mined by the Gorons of old,
    - it's quite explosive.

gold_dust_drop:
  type: world
  events:
    on player breaks deepslate_gold_ore:
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
      - determine deku_root[quantity=<util.random.int[1].to[3]>]

fairy_bow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&color[#00ae24]>Fairy Bow
  enchantments:
    - POWER: 6
    - DURABILITY: 4
  mechanisms:
    custom_model_data: 200

  lore:
    - <&color[#60dc53]>A thing that doesn't change
    - <&color[#60dc53]>with time is a memory
    - <&color[#60dc53]>of younger days.
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|deku_tree_root|zc_triforce_gem
        - deku_tree_root|skulltula_silk|air
        - zc_triforce_gem|air|air

keaton_fur_tuft:
  type: item
  debug: false
  material: rabbit
  display name: Keaton Fur
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 100
  lore:
    - A piece of shedded fur
    - from a Keaton.

keaton_fur_drop:
  type: world
  events:
    on fox breeds:
    - define droprate 2
    - if <util.random_chance[<[droprate]>]>:
      - drop keaton_fur_tuft[quantity=<util.random.int[1].to[3]>]

keaton_boots:
  type: item
  material: GOLDEN_BOOTS
  Data: 0
  display name: <&6>Keaton<&6>Boots
  Lore:
        - <&e>Soft boots made from fur,
        - <&e>They have a strange aura.
  Enchantments:
    - PROTECTION_ENVIRONMENTAL:1
    - DURABILITY:3
    - SOUL_SPEED:3
  mechanisms:
    hides:
      - enchants
  recipes:
      type: shaped
      input:
        - keaton_fur_tuft|air|keaton_fur_tuft
        - keaton_fur_tuft|air|keaton_fur_tuft
keaton_boots_world:
  type: world
  events:
      after player equips keaton_boots:
       - cast speed amplifier:1.0 duration:1639
      after player unequips keaton_boots:
       - cast speed remove
loftwing_cap:
    type: item
    debug: false
    material: leather_helmet
    display name: <&4>Loftwing Cap
    enchantments:
        - luck 1
    mechanisms:
        hides:
            - enchants
    lore:
      - <&c>These feathers have been
      - <&c>fashioned into a nice cap,
      - <&c>you feel lighter!
    recipes:
      type: shaped
      input:
        - enhanced_loftwing_feather|enhanced_loftwing_feather|enhanced_loftwing_feather
        - enhanced_loftwing_feather|air|enhanced_loftwing_feather
loftwing_cap_world:
  type: world
  events:
    after player equips loftwing_cap:
      - cast slow_falling amplifier:1.0 duration:1639 hide_particles
    after player unequips loftwing_cap:
      - cast slow_falling remove

zc_bomb:
  type: item
  debug: false
  material: slime_ball
  data:
    discover: true
  display name: Bomb
  mechanisms:
    custom_model_data: 100
  lore:
    - Be careful to
    - detonate it on time!
  recipes:
    1:
      type: shaped
      input:
        - tnt|zc_power_dust|tnt
        - zc_power_dust|ink_sac|zc_power_dust
        - tnt|zc_poster_dust|tnt
      output: 2

chu_chu_jelly:
  type: item
  debug: false
  material: slime_ball
  display name: Chu Chu Jelly
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 200
  lore:
    - A gelatinous ball of
    - green chu chu jelly.
    - It smells.

chu_chu_jelly_drop:
  type: world
  events:
    on player kills slime:
    - define droprate 5
    - if <util.random_chance[<[droprate]>]>:
      - drop loftwing_feather[quantity=<util.random.int[1].to[3]>]

chu_chu_club:
  type: item
  debug: false
  material: wooden_sword
  data:
    discover: true
  display name: <&color[#02d500]>Chu Chu Club
  mechanisms:
    custom_model_data: 2500
  enchantments:
    - KNOCKBACK: 5
  lore:
    - <&color[#97ff96]>Bonk!

  recipes:
    1:
      type: shaped
      input:
        - chu_chu_jelly
        - chu_chu_jelly
        - stick

plate_of_power:
  type: item
  debug: false
  material: fermented_spider_eye
  data:
    discover: true
  display name: <&color[#b63737]>Plate of Power
  mechanisms:
    custom_model_data: 500
    enchantments:
      - LUCK: 1
    hides:
      - ENCHANTS
  lore:
    - <&color[#d24848]>Forged from the
    - <&color[#d24848]>fallen souls. Power
    - <&color[#d24848]>overcomes weakness.
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power

plate_of_wisdom:
  type: item
  debug: false
  material: gold_ingot
  data:
    discover: true
  display name: <&color[#f1c232]>Plate of Wisdom
  mechanisms:
    custom_model_data: 500
    enchantments:
      - LUCK: 1
    hides:
      - ENCHANTS
  lore:
    - <&color[#ffe599]>From the brighest
    - <&color[#ffe599]>of minds come the
    - <&color[#ffe599]>strongest warriors.
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_wisdom|zc_shard_of_wisdom|zc_shard_of_wisdom
        - zc_shard_of_wisdom|zc_shard_of_wisdom|zc_shard_of_wisdom
        - zc_shard_of_wisdom|zc_shard_of_wisdom|zc_shard_of_wisdom


plate_of_courage:
  type: item
  debug: false
  material: scute
  data:
    discover: true
  display name: <&color[#6aa84f]>Plate of Courage
  mechanisms:
    custom_model_data: 500
    enchantments:
      - LUCK: 1
    hides:
      - ENCHANTS
  lore:
    - <&color[#b6d7a8]>Let tenacity and
    - <&color[#b6d7a8]>determination shine
    - <&color[#b6d7a8]>strong without fear.
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_courage|zc_shard_of_courage|zc_shard_of_courage
        - zc_shard_of_courage|zc_shard_of_courage|zc_shard_of_courage
        - zc_shard_of_courage|zc_shard_of_courage|zc_shard_of_courage

keese_kleaver:
  type: item
  debug: false
  material: netherite_axe
  data:
    discover: true
  display name: <&color[#351c75]>Keese Kleaver
  mechanisms:
    custom_model_data: 500
    enchantments:
      - DAMAGE_ALL: 5
  lore:
    - <&color[#674ea7]>Erratic movements allow
    - <&color[#674ea7]>you to strike your enemies
    - <&color[#674ea7]>down with ease.

  recipes:
    1:
      type: shaped
      input:
        - tempered_iron_plate|tempered_iron_plate|keese_wing
        - tempered_iron_plate|keese_eye|air
        - air|stick|air

keese_bat_effect:
  type: world
  debug: false
  events:
    on player kills entity:
    - if <context.cause> == entity_attack:
      - if <context.damager.item_in_hand.script.name.if_null[null]> == keese_kleaver:
        - define players <context.damager.location.find_players_within[20]>
        - repeat 5:
          - define r1 <util.random.decimal[-0.2].to[0.2]>
          - define r2 <util.random.decimal[-0.2].to[0.2]>
          - fakespawn bat <context.entity.location> duration:1s players:<[players]>

harp_of_ages:
  type: item
  debug: false
  material: netherite_sword
  data:
    discover: true
  display name: <&color[#6fa8dc]>Harp of Ages
  mechanisms:
    custom_model_data: 2700
    enchantments:
      - DAMAGE_ALL: 5
      - LUCK: 3
  lore:
    - <&color[#cfe2f3]>Bestowed upon the Hero,
    - <&color[#fff2cc]>May Nayru's Love flow
    - <&color[#f4ccdd]>through you with music.

  recipes:
    1:
      type: shaped
      input:
        - tune_of_currents|tune_of_echoes|tune_of_time
        - tune_of_currents|tune_of_echoes|tune_of_time
        - tune_of_currents|tune_of_echoes|tune_of_time

ember_seed:
  type: item
  debug: false
  material: apple
  data:
    discover: true
  display name: Roasted Ember Seed
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 1400
  lore:
    - Tastes spicy!
    - Better to cook it first!

roasted_ember_seed:
  type: item
  debug: false
  material: apple
  data:
    discover: true
  display name: Roasted Ember Seed
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 1401
  lore:
    - Tastes spicy!
  recipes:
    1:
      type: blast
      cook_time: 6m
      experience: 1000
      input: ember_seed

ember_seed_events:
  type: world
  debug: false
  events:
    on birch_leaves decay:
    - if <context.location.world.name> not in s1|s2|newnether|theendkek|resources|resources_nether|resources_the_end|resources_nullscape_end_island:
      - stop
    - if <util.random_chance[3]>:
      - drop ember_seed <context.location>

pegasus_seed:
  type: item
  debug: false
  material: apple
  data:
    discover: true
  display name: Roasted Ember Seed
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 1500
  lore:
    - Better find my track shoes.

roasted_pegasus_seed:
  type: item
  debug: false
  material: apple
  data:
    discover: true
  display name: Roasted Ember Seed
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    custom_model_data: 1501
  lore:
    - Feels like I can run a marathon!
  recipes:
    1:
      type: blast
      cook_time: 6m
      experience: 1000
      input: pegasus_seed

pegasus_seed_events:
  type: world
  debug: false
  events:
    on oak_leaves decay:
    - if <context.location.world.name> not in s1|s2|newnether|theendkek|resources|resources_nether|resources_the_end|resources_nullscape_end_island:
      - stop
    - if <util.random_chance[3]>:
      - drop pegasus_seed <context.location>