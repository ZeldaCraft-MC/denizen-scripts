##ZC Recipe Scripts. Created by EyelessTenshi and SentisUrgelius

#Recipe Materials and Drop Scripts--

malice_fragment:
  type: item
  debug: false
  material: echo_shard
  data:
    discover: true
  display name: <&color[#8B159C]>Malice Fragment
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 100
    hides:
    - ENCHANTS
  lore:
  - <&color[#A03485]>A fragment of malice
  - <&color[#A03485]>left behind by the Calamity.
  - <&color[#A03485]>What power does it hold?

malice_fragment_drop:
  type: world
  debug: false
  events:
    on player kills warden:
    - define droprate 5
    - if <util.random_chance[<[droprate]>]>:
      - drop malice_fragment

compressed_sculk:
  type: item
  debug: false
  material: echo_shard
  data:
    discover: true
  display name: <&color[#087285]>Compressed Sculk
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 200
    hides:
    - ENCHANTS
  lore:
  - <&color[#1697AF]>A compressed mass of sculk.
  - <&color[#1697AF]>It pulsates with otherwordly flesh.
  recipes:
    1:
      type: shaped
      input:
        - sculk|sculk|sculk
        - sculk|sculk|sculk
        - sculk|sculk|sculk

fragmented_sculk:
  type: item
  debug: false
  material: echo_shard
  data:
    discover: true
  display name: <&color[#087285]>Fragmented <&color[#CFCCA5]>Sculk
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 300
    hides:
      - ENCHANTS
  lore:
  - <&color[#1697AF]>A combination of two worlds.
  - <&color[#DCD9B4]>Combined with the right materials
  - <&color[#1697AF]>it can be quite powerful.
  recipes:
    1:
      type: shaped
      input:
        - sculk|end_stone|sculk
        - end_stone|ender_eye|end_stone
        - sculk|end_stone|sculk

sculk_string:
  type: item
  debug: false
  material: string
  data:
    discover: true
  display name: <&color[#1697AF]>Sculk String
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 400
    hides:
    - ENCHANTS
  lore:
    - <&3>A piece of tainted string.
  recipes:
    1:
      type: shapeless
      input: string|sculk

tempered_iron_plate:
  type: item
  debug: false
  material: iron_ingot
  data:
    discover: true
  display name: <&color[#999999]>Tempered Iron Plate
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 200
    hides:
    - ENCHANTS
  lore:
    - <&7>A solid plate perfect for
    - <&7>armor smithing.
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
  display name: <&color[#BE7CEA]>Cured Quartz
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 100
    hides:
    - ENCHANTS
  lore:
    - <&color[#E9C8FF]>This quartz has been cleansed
    - <&color[#E9C8FF]>with amethyst, offering protection
    - <&color[#E9C8FF]>and guidance.
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
  display name: <&color[#BE7CEA]>Cured Quartz Plate
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 200
    hides:
    - ENCHANTS
  lore:
    - <&color[#E9C8FF]>A plate forged from
    - <&color[#E9C8FF]>cured quartz. You can
    - <&color[#E9C8FF]>feel it's purity.
  recipes:
    1:
      type: shaped
      input:
        - cured_quartz|cured_quartz|cured_quartz
        - cured_quartz|amethyst_cluster|cured_quartz
        - cured_quartz|cured_quartz|cured_quartz

mythril_dragon_scale:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: <&color[#79A6E2]>Mythril Dragon Scale
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1000
    hides:
    - ENCHANTS
  lore:
    - <&color[#A7CCFD]>Stronger than steel
    - <&color[#A7CCFD]>but at what cost?
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|zc_mythril|zc_dragon_scale
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale

reinforced_string:
  type: item
  debug: false
  material: string
  data:
    discover: true
  display name: <&color[#7934AD]>Reinforced String
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
    custom_model_data: 300
  lore:
    - <&color[#9553C6]>A sturdy spool of reinforced string.
  recipes:
    1:
      type: shapeless
      input: string|zc_dragon_scale

loftwing_feather:
  type: item
  debug: false
  material: feather
  display name: <&4>Loftwing Feather
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
    custom_model_data: 100
  lore:
    - <&c>A crimson feather dropped
    - <&c>by a large Loftwing.

loftwing_feathers_drop:
  type: world
  debug: false
  events:
    on player kills parrot:
    - define droprate 5
    - if <util.random_chance[<[droprate]>]>:
      - drop loftwing_feather[quantity=<util.random.int[1].to[3]>]

wizzrobe_crystal:
  type: item
  debug: false
  material: amethyst_shard
  display name: <&5>Wizzrobe Crystal
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
  lore:
    - <&d>A crystal broken off
    - <&d>from a Wizzrobe's robe.

wizzrobe_crystals_drop:
  type: world
  debug: false
  events:
    on player kills evoker:
    - define droprate 2
    - if <util.random_chance[<[droprate]>]>:
      - drop wizzrobe_crystal[quantity=<util.random.int[1].to[3]>]

enhanced_loftwing_feather:
  type: item
  debug: false
  material: feather
  data:
    discover: true
  display name: <&color[#AC7EFF]>Enhanced Loftwing Feather
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 200
    hides:
    - ENCHANTS
  lore:
    - <&color[#B999E6]>Once a simple feather
    - <&color[#B999E6]>now gleaming with magic.
  recipes:
    1:
      type: shapeless
      input: loftwing_feather|wizzrobe_crystal

onox_shard:
  type: item
  debug: false
  material: flint
  display name: <&color[#6F6F6F]>Onox Shard
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1400
    hides:
    - ENCHANTS
  lore:
    - <&color[#8B8B8B]>A shard of solid onox that
    - <&color[#8B8B8B]>reminds you of a seasons long past.

onox_shard_drop:
  type: world
  debug: false
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

deku_root:
  type: item
  debug: false
  material: stick
  display name: <&color[#806345]>Deku Root
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
    custom_model_data: 800
  lore:
    - <&color[#AD865E]>A root from remnants
    - <&color[#AD865E]>of ancient deku trees.

deku_root_drop:
  type: world
  debug: false
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
  display name: <&7>Skulltula Silk
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
    custom_model_data: 100
  lore:
    - <&f>Silk from a giant spider.

skulltula_silk_drop:
  type: world
  debug: false
  events:
    on player kills cave_spider:
    - define droprate 2
    - if <util.random_chance[<[droprate]>]>:
      - drop skulltula_silk[quantity=<util.random.int[1].to[3]>]

gold_skulltula_silk:
  type: item
  debug: false
  material: string
  data:
    discover: true
  display name: <&6>Gold Skulltula Silk
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 200
    hides:
    - ENCHANTS
  lore:
    - <&e>Silk that seems to be
    - <&e>spun from solid gold.
  recipes:
    1:
      type: shapeless
      input: skulltula_silk|gold_dust

gold_dust:
  type: item
  debug: false
  material: glowstone_dust
  display name: <&6>Gold Dust
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
    custom_model_data: 1000
  lore:
    - <&e>Mined by the Gorons of old,
    - <&e>it's quite explosive.

gold_dust_drop:
  type: world
  debug: false
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
      - determine gold_dust[quantity=<util.random.int[1].to[3]>]

chu_chu_jelly:
  type: item
  debug: false
  material: slime_ball
  display name: <&2>Chu Chu Jelly
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
  lore:
    - <&a>A gelatinous ball of
    - <&a>green chu chu jelly.
    - <&a>It smells.

chu_chu_jelly_drop:
  type: world
  debug: false
  events:
    on player kills slime:
    - define droprate 5
    - if <util.random_chance[<[droprate]>]>:
      - drop chu_chu_jelly[quantity=<util.random.int[1].to[3]>]

keaton_fur_tuft:
  type: item
  debug: false
  material: rabbit
  display name: <&6>Keaton Fur Tuft
  enchantments:
    - LUCK:1
  mechanisms:
    hides:
    - ENCHANTS
    custom_model_data: 100
  lore:
    - <&e>A piece of shed fur
    - <&e>from a Keaton.

keaton_fur_drop:
  type: world
  debug: false
  events:
    on fox breeds:
    - define droprate 15
    - if <util.random_chance[<[droprate]>]>:
      - drop keaton_fur_tuft[quantity=<util.random.int[1].to[3]>] <context.breeder.location>

plate_of_power:
  type: item
  debug: false
  material: fermented_spider_eye
  data:
    discover: true
  display name: <&color[#b63737]>Plate of Power
  mechanisms:
    custom_model_data: 600
    hides:
    - ENCHANTS
  enchantments:
    - LUCK:1
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
    custom_model_data: 400
    hides:
    - ENCHANTS
  enchantments:
    - LUCK:1
  lore:
    - <&color[#ffe599]>From the brighest
    - <&color[#ffe599]>of minds come the
    - <&color[#ffe599]>strongest warriors.
  recipes:
    1:
      type: shaped
      input:
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard
        - zc_wisdom_shard|zc_wisdom_shard|zc_wisdom_shard

plate_of_courage:
  type: item
  debug: false
  material: scute
  data:
    discover: true
  display name: <&color[#6aa84f]>Plate of Courage
  mechanisms:
    custom_model_data: 600
    hides:
    - ENCHANTS
  enchantments:
    - LUCK:1
  lore:
    - <&color[#b6d7a8]>Let tenacity and
    - <&color[#b6d7a8]>determination shine
    - <&color[#b6d7a8]>strong without fear.
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shard|zc_courage_shard|zc_courage_shard
        - zc_courage_shard|zc_courage_shard|zc_courage_shard
        - zc_courage_shard|zc_courage_shard|zc_courage_shard

timestone_shard:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: <&color[#5F5EAD]>Timestone Shard
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1700
    hides:
    - ENCHANTS
  lore:
    - <&color[#5EADA3]>A fragment of a timestone
    - <&color[#5EAD69]>lost to the Era of the Sky.

obsidian_plate:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: <&color[#7A13B0]>Obsidian Plate
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1500
    hides:
    - ENCHANTS
  lore:
    - <&color[#A12EE7]>Forged from the tears
    - <&color[#A12EE7]>of lost souls.
  recipes:
    1:
      type: shaped
      input:
        - crying_obsidian|crying_obsidian|crying_obsidian
        - crying_obsidian|netherite_ingot|crying_obsidian
        - crying_obsidian|crying_obsidian|crying_obsidian

gear_of_time:
  type: item
  debug: false
  material: flint
  data:
    discover: true
  display name: <&color[#E0A7FD]>Gear of Time
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 300
    hides:
    - ENCHANTS
  lore:
    - <&color[#F6A7FD]>A fragment of the Gate of Hylia
    - <&color[#CC75FE]>lost long ago. Perhaps with time,
    - <&color[#8567FF]>it shall work again.

gear_of_time_drop:
  type: world
  debug: false
  events:
    on player breaks budding_amethyst:
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
      - determine gear_of_time[quantity=<util.random.int[1].to[3]>]

timestone_shard_drop:
  type: world
  debug: false
  events:
    on player breaks deepslate_lapis_ore|deepslate_emerald_ore:
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
      - determine timestone_shard[quantity=<util.random.int[1].to[3]>]

# Actual crafted recipe items and item events--

calamitous_boots:
  type: item
  debug: false
  material: NETHERITE_BOOTS
  data:
    discover: true
  display name: <&color[#580464]>Calamitous Boots
  enchantments:
    - PROTECTION_ENVIRONMENTAL:4
    - DURABILITY:3
    - SWIFT_SNEAK:3
  mechanisms:
    hides:
      - enchants
  lore:
    - <&color[#A03485]>Boots crafted from remnants
    - <&color[#A03485]>of a haunted past.
  recipes:
    1:
      type: shaped
      input:
        - malice_fragment|air|malice_fragment
        - malice_fragment|air|malice_fragment

calamitous_boots_world:
  type: world
  debug: false
  events:
    after player equips calamitous_boots:
    - cast increase_damage amplifier:1 duration:1639
    - cast darkness duration:1639
    - playsound <player.location> sound:ENTITY_WARDEN_SONIC_BOOM volume:1.5
    on delta time secondly:
    - foreach <server.online_players.filter[has_equipped[calamitous_boots]]> as:__player:
      - playeffect effect:sonic_boom quantity:5 at:<player.location>
    on delta time minutely every:5:
    - foreach <server.online_players.filter[has_equipped[calamitous_boots]]> as:__player:
      - cast increase_damage amplifier:1 duration:1639
      - cast darkness duration:1639
    after player unequips calamitous_boots:
    - cast increase_damage remove
    - cast darkness remove

soul_bow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&3>Soul<&color[#087285]>Bow
  enchantments:
    - ARROW_DAMAGE:5
    - ARROW_INFINITE:1
  mechanisms:
    custom_model_data: 2000
  lore:
  - <&color[#1697AF]>Crafted with deadly precision
  - <&3>this bow of those lost to battle
  - <&color[#1697AF]>still damages those from beyond the grave.
  recipes:
    1:
      type: shaped
      input:
        - air|fragmented_sculk|sculk_string
        - fragmented_sculk|air|sculk_string
        - air|fragmented_sculk|sculk_string

soul_bow_scripts:
  type: world
  debug: false
  events:
    on player shoots soul_bow:
      - ratelimit <player> 1s
      - itemcooldown bow duration:1s
      - determine passively cancelled
      - shoot soul_arrow origin:<player> speed:<context.force> save:arrow no_rotate def:<context.projectile>
      - playsound <player.location> sound:BLOCK_SCULK_CHARGE volume:1
      - run soul_bow_particles def:<entry[arrow].shot_entity>
    on player shoots block with:soul_arrow:
      - remove <context.projectile>
    on arrow hits entity:
      - if <context.hit_entity.invulnerable>:
        - remove <context.projectile>
      - else if !<context.hit_entity.visible||true> && <context.hit_entity.entity_type> == ARMOR_STAND:
        - remove <context.projectile>

soul_bow_particles:
  type: task
  debug: false
  definitions: arrow
  script:
    - define spawned <util.time_now>
    - wait 2t
    - while <[arrow].is_spawned||false> && <util.time_now.is_before[<[spawned].add[60s]>]||false>:
      - playeffect <[arrow].location> effect:sculk_soul quantity:<util.random.int[1].to[5]> offset:0,3,0 velocity:0,0,0 visibility:100
      - playsound <[arrow].location> sound:BLOCK_SCULK_SHRIEKER_SHRIEK volume:0.5
      - wait 3t
    - if <[arrow].is_spawned||false>:
      - remove <[arrow]>

soul_arrow:
  type: entity
  debug: false
  entity_type: arrow
  mechanisms:
    damage: 0.1
    pickup_status: creative_only

keaton_boots:
  type: item
  debug: false
  material: GOLDEN_BOOTS
  data:
    discover: true
  display name: <&6>Keaton Boots
  lore:
    - <&e>Soft boots made from fur,
    - <&e>They have a strange aura.
  enchantments:
    - PROTECTION_ENVIRONMENTAL:1
    - DURABILITY:3
    - SOUL_SPEED:3
  recipes:
    1:
      type: shaped
      input:
        - keaton_fur_tuft|air|keaton_fur_tuft
        - keaton_fur_tuft|air|keaton_fur_tuft

keaton_boots_world:
  type: world
  debug: false
  events:
    after player equips keaton_boots:
    - cast speed amplifier:1 duration:1639
    after player unequips keaton_boots:
    - cast speed remove
    on delta time minutely every:5:
    - foreach <server.online_players.filter[has_equipped[keaton_boots]]> as:__player:
      - cast speed amplifier:1 duration:1639

loftwing_cap:
  type: item
  debug: false
  material: leather_helmet
  display name: <&4>Loftwing Cap
  enchantments:
    - feather_falling:10
  lore:
    - <&c>These feathers have been
    - <&c>fashioned into a nice cap,
    - <&c>you feel lighter!
  recipes:
    1:
      type: shaped
      input:
        - enhanced_loftwing_feather|enhanced_loftwing_feather|enhanced_loftwing_feather
        - enhanced_loftwing_feather|air|enhanced_loftwing_feather

loftwing_cap_world:
  type: world
  debug: false
  events:
    after player equips loftwing_cap:
      - cast slow_falling amplifier:1 duration:1639 hide_particles
    after player unequips loftwing_cap:
      - cast slow_falling remove
    on delta time minutely every:5:
      - foreach <server.online_players.filter[has_equipped[loftwing_cap]]> as:__player:
        - cast slow_falling amplifier:1 duration:1639 hide_particles

fairy_bow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&color[#00ae24]>Fairy Bow
  enchantments:
    - POWER:6
    - DURABILITY:4
  mechanisms:
    custom_model_data: 100
  lore:
    - <&color[#60dc53]>A thing that doesn't change
    - <&color[#60dc53]>with time is a memory
    - <&color[#60dc53]>of younger days.
  recipes:
    1:
      type: shaped
      input:
        - plate_of_courage|deku_root|zc_triforce_gem
        - deku_root|skulltula_silk|air
        - zc_triforce_gem|air|air

fairy_bow_scripts:
  type: world
  debug: false
  events:
    on player shoots fairy_bow priority:5:
      - ratelimit <player> 1s
      - itemcooldown bow duration:1s
      - determine passively cancelled
      - shoot fairy_arrow origin:<player> speed:<context.force> save:arrow no_rotate def:<context.projectile>
      - playsound <player.location> sound:block_amethyst_block_fall volume:1
      - run fairy_bow_particles def:<entry[arrow].shot_entity>
    on player shoots block with:fairy_arrow:
      - remove <context.projectile>
    on arrow hits entity:
      - if <context.hit_entity.invulnerable>:
        - remove <context.projectile>
      - else if !<context.hit_entity.visible||true> && <context.hit_entity.entity_type> == ARMOR_STAND:
        - remove <context.projectile>

fairy_bow_particles:
  type: task
  debug: false
  definitions: arrow
  script:
    - define spawned <util.time_now>
    - wait 2t
    - while <[arrow].is_spawned||false> && <util.time_now.is_before[<[spawned].add[60s]>]||false>:
      - playeffect <[arrow].location> effect:totem quantity:<util.random.int[1].to[5]> offset:0,3,0 velocity:0,0,0 visibility:100
      - playsound <[arrow].location> sound:block_amethyst_block_chime pitch:<util.random.decimal[1.2].to[1.8]>
      - wait <util.random.int[1].to[3]>t
    - if <[arrow].is_spawned||false>:
      - remove <[arrow]>

fairy_arrow:
  type: entity
  debug: false
  entity_type: arrow
  mechanisms:
    damage: 0.1
    pickup_status: creative_only

chu_chu_club:
  type: item
  debug: false
  material: wooden_sword
  data:
    discover: true
  display name: <&color[#02d500]>Chu Chu Club
  enchantments:
    - KNOCKBACK:5
  lore:
    - <&color[#97ff96]>Bonk!
  recipes:
    1:
      type: shaped
      input:
        - chu_chu_jelly
        - chu_chu_jelly
        - stick

diamond_demon_pickaxe:
  type: item
  debug: false
  material: netherite_pickaxe
  data:
    discover: true
  display name: <&color[#a41111]>Diamond Demon Pickaxe
  mechanisms:
    custom_model_data: 300
  lore:
    - <&color[#d92a2a]>It reminds you of
    - <&color[#d92a2a]>the Demon Lord
    - <&color[#d92a2a]>Ghirahim.
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|zc_shard_of_power|zc_shard_of_power
        - air|netherite_ingot|air
        - air|netherite_ingot|air

diamond_demon_axe:
  type: item
  debug: false
  material: netherite_axe
  data:
    discover: true
  display name: <&color[#a41111]>Diamond Demon Axe
  mechanisms:
    custom_model_data: 300
  lore:
    - <&color[#d92a2a]>Anyone who gets in
    - <&color[#d92a2a]>my way must be
    - <&color[#d92a2a]>dealt with!
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power|zc_shard_of_power|air
        - zc_shard_of_power|netherite_ingot|air
        - air|netherite_ingot|air

diamond_demon_blade:
  type: item
  debug: false
  material: netherite_sword
  data:
    discover: true
  display name: <&color[#a41111]>Diamond Demon Blade
  mechanisms:
    custom_model_data: 600
  lore:
    - <&color[#d92a2a]>Do you have any
    - <&color[#d92a2a]>idea how that makes me
    - <&color[#d92a2a]>feel? Furious! Outraged!
  recipes:
    1:
      type: shaped
      input:
        - air|air|zc_shard_of_power
        - air|zc_shard_of_power|air
        - netherite_ingot|air|air

diamond_demon_shovel:
  type: item
  debug: false
  material: netherite_shovel
  data:
    discover: true
  display name: <&color[#a41111]>Diamond Demon Shovel
  mechanisms:
    custom_model_data: 300
  lore:
    - <&color[#d92a2a]>Left behind by
    - <&color[#d92a2a]>a demon lord
    - <&color[#d92a2a]>on the land below.
  recipes:
    1:
      type: shaped
      input:
        - zc_shard_of_power
        - netherite_ingot
        - netherite_ingot

sword_spirit_blade:
  type: item
  debug: false
  material: diamond_sword
  data:
    discover: true
  display name: <&color[#00aded]>Sword Spirit Blade
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#b4a7d6]>Legend says an ancient
    - <&color[#b4a7d6]>voice resonates inside it.
    - <&color[#b4a7d6]>Can you hear it, Hero?
  recipes:
    1:
      type: shaped
      input:
        - gear_of_time
        - gear_of_time
        - cured_quartz

sword_spirit_shovel:
  type: item
  debug: false
  material: diamond_shovel
  data:
    discover: true
  display name: <&color[#00aded]>Sword Spirit Shovel
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#b4a7d6]>Left behind by the
    - <&color[#b4a7d6]>Hero of the Sky, it
    - <&color[#b4a7d6]>was said to grant wishes.
  recipes:
    1:
      type: shaped
      input:
        - gear_of_time
        - cured_quartz
        - cured_quartz

sword_spirit_pickaxe:
  type: item
  debug: false
  material: diamond_pickaxe
  data:
    discover: true
  display name: <&color[#00aded]>Sword Spirit Pickaxe
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#b4a7d6]>It is said that
    - <&color[#b4a7d6]>this tool had
    - <&color[#b4a7d6]>magical properties long ago.
  recipes:
    1:
      type: shaped
      input:
        - gear_of_time|gear_of_time|gear_of_time
        - air|cured_quartz|air
        - air|cured_quartz|air

sword_spirit_axe:
  type: item
  debug: false
  material: diamond_axe
  data:
    discover: true
  display name: <&color[#00aded]>Sword Spirit Axe
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#b4a7d6]>Lost to time, The blade
    - <&color[#b4a7d6]>allows you to render
    - <&color[#b4a7d6]>your enemies to dust.
  recipes:
    1:
      type: shaped
      input:
        - gear_of_time|gear_of_time
        - gear_of_time|cured_quartz
        - air|cured_quartz

dragon_boots:
  type: item
  debug: false
  material: netherite_boots
  data:
    discover: true
  display name: <&color[#7934AD]>Dragon Boots
  enchantments:
    - PROTECTION_ENVIRONMENTAL:4
    - PROTECTION_EXPLOSIONS:3
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#9851CE]>Did we really
    - <&color[#9851CE]>win the war?
  flags:
    custom_durability:
      max: 581
      current: 0
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
  display name: <&color[#7934AD]>Dragon Greaves
  enchantments:
    - PROTECTION_ENVIRONMENTAL:4
    - PROTECTION_EXPLOSIONS:3
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#9851CE]>People who do not believe in dragons,
    - <&color[#9851CE]>are often eaten by dragons.
  flags:
    custom_durability:
      max: 692
      current: 0
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
  display name: <&color[#7934AD]>Dragon Cuirass
  enchantments:
    - PROTECTION_ENVIRONMENTAL:4
    - PROTECTION_EXPLOSIONS:3
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#9851CE]>Come not between the dragon
    - <&color[#9851CE]>and her wrath.
  flags:
    custom_durability:
      max: 666
      current: 0
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
  display name: <&color[#7934AD]>Dragon Helmet
  enchantments:
    - PROTECTION_ENVIRONMENTAL:4
    - PROTECTION_EXPLOSIONS:3
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#9851CE]>Here are dragons to be slain,
    - <&color[#9851CE]>and treasures to be gain.
  flags:
    custom_durability:
      max: 607
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - zc_dragon_scale|zc_dragon_scale|zc_dragon_scale
        - zc_dragon_scale|air|zc_dragon_scale

frozen_drake_boots:
  type: item
  debug: false
  material: netherite_boots
  data:
    discover: true
  display name: <&color[#5187CE]>Frozen Drake Boots
  enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    - PROTECTION_EXPLOSIONS:5
    - PROTECTION_FIRE:5
  mechanisms:
    custom_model_data: 600
    attribute_modifiers:
      generic_knockback_resistance:
        1:
          operation: add_number
          amount: 0.2
          slot: feet
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 4
          slot: feet
      generic_armor:
        1:
          operation: add_number
          amount: 4
          slot: feet
  lore:
    - <&color[#79A6E2]>War never really changes.
  flags:
    custom_durability:
      max: 881
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|air|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale

frozen_drake_leggings:
  type: item
  debug: false
  material: netherite_leggings
  data:
    discover: true
  display name: <&color[#5187CE]>Frozen Drake Greaves
  enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    - PROTECTION_EXPLOSIONS:5
    - PROTECTION_FIRE:5
  mechanisms:
    custom_model_data: 600
    attribute_modifiers:
      generic_knockback_resistance:
        1:
          operation: add_number
          amount: 0.2
          slot: legs
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 4
          slot: legs
      generic_armor:
        1:
          operation: add_number
          amount: 7
          slot: legs
  lore:
    - <&color[#79A6E2]>Never anger the beast that
    - <&color[#79A6E2]>sleeps at the end of the world.
  flags:
    custom_durability:
      max: 1110
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale

frozen_drake_chestplate:
  type: item
  debug: false
  material: netherite_chestplate
  data:
    discover: true
  display name: <&color[#5187CE]>Frozen Drake Cuirass
  enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    - PROTECTION_EXPLOSIONS:5
    - PROTECTION_FIRE:5
  mechanisms:
    custom_model_data: 600
    attribute_modifiers:
      generic_knockback_resistance:
        1:
          operation: add_number
          amount: 0.2
          slot: chest
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 4
          slot: chest
      generic_armor:
        1:
          operation: add_number
          amount: 9
          slot: chest
  lore:
    - <&color[#79A6E2]>So comes snow after fire,
    - <&color[#79A6E2]>and even dragons have their endings.
  flags:
    custom_durability:
      max: 1184
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|air|mythril_dragon_scale
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale

frozen_drake_helmet:
  type: item
  debug: false
  material: netherite_helmet
  data:
    discover: true
  display name: <&color[#5187CE]>Frozen Drake Helmet
  enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    - PROTECTION_EXPLOSIONS:5
    - PROTECTION_FIRE:5
  mechanisms:
    custom_model_data: 600
    attribute_modifiers:
      generic_knockback_resistance:
        1:
          operation: add_number
          amount: 0.2
          slot: head
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 4
          slot: head
      generic_armor:
        1:
          operation: add_number
          amount: 4
          slot: head
  lore:
    - <&color[#79A6E2]>Death comes out
    - <&color[#79A6E2]>of the dragons mouth.
  flags:
    custom_durability:
      max: 814
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - mythril_dragon_scale|mythril_dragon_scale|mythril_dragon_scale
        - mythril_dragon_scale|air|mythril_dragon_scale

mythril_longbow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&color[#6FB3D4]>Mythril Longbow
  enchantments:
    - ARROW_DAMAGE:6
  mechanisms:
    custom_model_data: 800
  lore:
    - <&color[#97CEE8]>Fragments of mythril
    - <&color[#97CEE8]>form this sturdy bow.
  recipes:
    1:
      type: shaped
      input:
        - air|zc_mythril|reinforced_string
        - zc_mythril|air|reinforced_string
        - air|zc_mythril|reinforced_string

blin_basher:
  type: item
  debug: false
  material: netherite_pickaxe
  data:
    discover: true
  display name: <&color[#57009a]>Blin Basher
  enchantments:
    - DIG_SPEED:5
    - KNOCKBACK:5
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

decaying_scythe:
  type: item
  debug: false
  material: iron_hoe
  data:
    discover: true
  display name: <&color[#E2BE45]>Decaying Scythe
  mechanisms:
    custom_model_data: 800
  enchantments:
    - LOOT_BONUS_BLOCKS:4
  lore:
    - <empty>
    - <&color[#D8C565]>The decaying remains of a Moblin,
    - <&color[#C28B72]>fashioned into a crude scythe.
    - <&color[#A03485]>The smell is putrid.
  recipes:
    1:
      type: shaped
      input:
        - moblin_horn|moblin_horn|large_amethyst_bud
        - air|raw_gold_block|moblin_fang
        - obsidian_plate|raw_gold_block|air

moblin_axe:
  type: item
  debug: false
  material: golden_axe
  data:
    discover: true
  display name: <&color[#E2BE45]>Spiked Boko Axe
  mechanisms:
    custom_model_data: 600
  enchantments:
    - DAMAGE_UNDEAD:6
  lore:
    - <empty>
    - <&color[#C28B72]>Spiked thorns and teeth
    - <&color[#C28B72]>rip flesh from bone.
  recipes:
    1:
      type: shaped
      input:
        - moblin_fang|moblin_horn|bokoblin_guts
        - air|moblin_fang|air
        - obsidian_plate|stick|air

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
    - DIG_SPEED:5
    - LOOT_BONUS_BLOCKS:4
    - DAMAGE_UNDEAD:3
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

time_lord_blade:
  type: item
  debug: false
  material: diamond_sword
  data:
    discover: true
  display name: <&b>Time <&3>Lord <&a>Blade
  mechanisms:
    custom_model_data: 800
  enchantments:
    - DAMAGE_ALL:5
    - MENDING:1
  lore:
    - <&color[#42C8D8]>Fragments of the legendary
    - <&color[#42C8D8]>blade of a Fierce Deity.
  flags:
    custom_durability:
      max: 3000
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - gear_of_time
        - timestone_shard
        - zc_mythril_hilt

time_lord_shovel:
  type: item
  debug: false
  material: diamond_shovel
  data:
    discover: true
  display name: <&b>Time <&3>Lord <&a>Shovel
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#42C8D8]>Dig deep into
    - <&color[#42C8D8]>memories of a falseborn world.
  recipes:
    1:
      type: shaped
      input:
        - timestone_shard
        - cured_quartz_plate
        - tempered_iron_plate

time_lord_pickaxe:
  type: item
  debug: false
  material: diamond_pickaxe
  data:
    discover: true
  display name: <&b>Time <&3>Lord <&a>Pickaxe
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#42C8D8]>Forge your way
    - <&color[#42C8D8]>into your own creation,
    - <&color[#42C8D8]>avoid a terrible fate.
  recipes:
    1:
      type: shaped
      input:
        - timestone_shard|gear_of_time|timestone_shard
        - air|cured_quartz_plate|air
        - air|tempered_iron_plate|air

time_lord_axe:
  type: item
  debug: false
  material: diamond_axe
  data:
    discover: true
  display name: <&b>Time <&3>Lord <&a>Axe
  mechanisms:
    custom_model_data: 500
  lore:
    - <&color[#42C8D8]>A haunting axe
    - <&color[#42C8D8]>found deep within the
    - <&color[#42C8D8]>forgotten land of Termina.
  recipes:
    1:
      type: shaped
      input:
        - gear_of_time|timestone_shard
        - timestone_shard|cured_quartz_plate
        - air|tempered_iron_plate

warden_boots:
  type: item
  debug: false
  material: leather_boots
  data:
    discover: true
  display name: <&color[#1697AF]>Warden Boots
  mechanisms:
    color: 41,223,235
    hides: dye
    custom_model_data: 200
    attribute_modifiers:
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 2
          slot: feet
      generic_armor:
        1:
          operation: add_number
          amount: 3
          slot: feet
  enchantments:
    - DURABILITY:6
    - SOUL_SPEED:5
  lore:
    - <&b>Pulsating lights swirl
    - <&b>from the depths below.
  recipes:
    1:
      type: shaped
      input:
        - fragmented_sculk|air|fragmented_sculk
        - malice_fragment|air|malice_fragment

warden_chestplate:
  type: item
  debug: false
  material: leather_chestplate
  data:
    discover: true
  display name: <&color[#1697AF]>Warden Chestplate
  mechanisms:
    color: 41,223,235
    hides: dye
    custom_model_data: 300
    attribute_modifiers:
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 2
          slot: chest
      generic_armor:
        1:
          operation: add_number
          amount: 8
          slot: chest
  enchantments:
    - DURABILITY:6
  lore:
    - <&b>Otherwordly heartbeats thrum
    - <&b>within a cracked ribcage.
  recipes:
    1:
      type: shaped
      input:
        - fragmented_sculk|air|fragmented_sculk
        - fragmented_sculk|malice_fragment|fragmented_sculk
        - fragmented_sculk|fragmented_sculk|fragmented_sculk

warden_helmet:
  type: item
  debug: false
  material: leather_helmet
  data:
    discover: true
  display name: <&color[#1697AF]>Warden Helmet
  mechanisms:
    color: 41,223,235
    hides: dye
    custom_model_data: 100
    attribute_modifiers:
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 2
          slot: head
      generic_armor:
        1:
          operation: add_number
          amount: 3
          slot: head
  enchantments:
    - DURABILITY:6
  lore:
    - <&b>Beneath this hollow husk
    - <&b>lay spirits clouded in shadow.
  recipes:
    1:
      type: shaped
      input:
        - fragmented_sculk|fragmented_sculk|fragmented_sculk
        - malice_fragment|air|malice_fragment

warden_leggings:
  type: item
  debug: false
  material: leather_leggings
  data:
    discover: true
  display name: <&color[#1697AF]>Warden Leggings
  mechanisms:
    color: 41,223,235
    hides: dye
    custom_model_data: 200
    attribute_modifiers:
      generic_armor_toughness:
        1:
          operation: add_number
          amount: 2
          slot: legs
      generic_armor:
        1:
          operation: add_number
          amount: 6
          slot: legs
  enchantments:
    - DURABILITY:6
  lore:
    - <&b>Tread softly within the darkness,
    - <&b>whispering souls cry out.
  recipes:
    1:
      type: shaped
      input:
        - fragmented_sculk|fragmented_sculk|fragmented_sculk
        - malice_fragment|air|malice_fragment
        - fragmented_sculk|air|fragmented_sculk

knight_bow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&color[#999999]>Knights Bow
  mechanisms:
      custom_model_data: 200
  enchantments:
    - ARROW_DAMAGE:3
  lore:
  - <&7>The sturdy metal construction of
  - <&7>this bow offers superior durability.
  flags:
    custom_durability:
      max: 585
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - air|tempered_iron_plate|skulltula_silk
        - plate_of_wisdom|air|skulltula_silk
        - air|tempered_iron_plate|skulltula_silk

royal_guard_bow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&color[#A00063]>Royal Guard's Bow
  mechanisms:
    custom_model_data: 400
  enchantments:
    - ARROW_DAMAGE:5
  lore:
  - <&color[#C63D92]>Made with ancient technology,
  - <&color[#C63D92]>it boasts a high rate of firepower
  - <&color[#C63D92]>but has low durability.
  flags:
    custom_durability:
      max: 185
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - air|netherite_ingot|onox_shard
        - obsidian_plate|air|reinforced_string
        - air|netherite_ingot|onox_shard

hero_bow:
  type: item
  debug: false
  material: bow
  data:
    discover: true
  display name: <&e>Hero's Bow
  mechanisms:
    custom_model_data: 300
  enchantments:
    - ARROW_DAMAGE:3
    - DURABILITY:3
  lore:
  - <&6>A replica of the bow said
  - <&6>to be used in the Era of Twilight.
  flags:
    custom_durability:
      max: 450
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - air|stick|gold_skulltula_silk
        - plate_of_courage|air|gold_skulltula_silk
        - air|stick|gold_skulltula_silk

warden_armor_world:
  type: world
  debug: false
  events:
    after player equips warden_helmet:
      - playsound <player.location> sound:entity_warden_tendril_clicks volume:1.5
      - playsound <player.location> sound:entity_warden_heartbeat volume:1.5
    after player equips warden_chestplate:
      - playsound <player.location> sound:entity_warden_tendril_clicks volume:1.5
    after player equips warden_boots:
      - playsound <player.location> sound:entity_warden_tendril_clicks volume:1.5
      - playsound <player.location> sound:entity_warden_heartbeat volume:1.5
    after player equips warden_leggings:
      - playsound <player.location> sound:entity_warden_tendril_clicks volume:1.5
      - playsound <player.location> sound:entity_warden_heartbeat volume:1.5
    on delta time secondly:
      - foreach <server.online_players.filter[has_equipped[warden_helmet]]> as:__player:
        - if <player.has_equipped[warden_helmet]>:
          - playeffect effect:white_ash quantity:<util.random.int[1].to[5]> at:<player.location>
        - if <player.has_equipped[warden_chestplate]>:
          - playeffect effect:sculk_soul quantity:<util.random.int[1].to[5]> at:<player.location>
          - playsound <player.location> sound:entity_warden_heartbeat volume:1.5
        - if <player.has_equipped[warden_boots]>:
          - playeffect effect:sculk_charge quantity:<util.random.int[1].to[5]> at:<player.location>
        - if <player.has_equipped[warden_leggings]>:
          - playeffect effect:white_ash quantity:<util.random.int[1].to[5]> at:<player.location>

phantom_ganon_sword:
  type: item
  debug: false
  material: netherite_sword
  display name: <&color[#3DB0C6]>Phantom Blade
  enchantments:
    - DAMAGE_ALL:8
  mechanisms:
    custom_model_data: 100
  lore:
  - <&color[#52C6DC]>An illusion of the mind
  - <&7>created with forsaken magic.
  - <&color[#52C6DC]>Once wielded by a powerful phantom.
  flags:
    custom_durability:
      max: 2531
      current: <util.random.int[100].to[1000]>

phantom_ganon_drop:
  type: world
  debug: false
  events:
    on player kills warden:
    - define droprate 1
    - if <util.random_chance[<[droprate]>]>:
      - drop phantom_ganon_sword

great_fairy_sword:
  type: item
  debug: false
  material: netherite_sword
  data:
    discover: true
  display name: <&color[#F131FF]>Great Fairy Sword
  enchantments:
    - DAMAGE_ALL:6
  mechanisms:
    custom_model_data: 300
  lore:
  - <&color[#30BB2C]>A blessing bestowed upon those
  - <&color[#3CD937]>who helped fairies in the Era of Time.
  - <&color[#30BB2C]>Fairy magic flows through you.
  flags:
    custom_durability:
      max: 2500
      current: 0
  recipes:
    1:
      type: shaped
      input:
        - vine|cured_quartz|vine
        - cured_quartz|plate_of_courage|cured_quartz
        - vine|netherite_sword|vine

great_fairy_sword_world:
  type: world
  debug: false
  events:
    after player damages entity with:great_fairy_sword:
    - playsound <player.location> sound:entity_allay_ambient_with_item volume:1.5
    - playeffect effect:heart quantity:<util.random.int[1].to[5]> at:<player.location>
    - cast regeneration duration:2s

phantom_ganon_sword_world:
  type: world
  debug: false
  events:
    after player damages entity with:phantom_ganon_sword:
    - playsound <player.location> sound:ambient_soul_sand_valley_mood volume:1
    - playeffect effect:sonic_boom quantity:<util.random.int[1].to[5]> at:<context.entity.location>
    - cast darkness duration:2s <context.entity>

frost_drake_fishing_rod:
  type: item
  debug: false
  material: fishing_rod
  data:
    discover: true
  display name: <&color[#79A6E2]>Frost Drake Rod
  enchantments:
    - LUCK:7
  lore:
    - <&color[#A7CCFD]>A frozen rod fished from the frozen
    - <&color[#A7CCFD]>Lake Hylia in the Era of Time.
  recipes:
    1:
      type: shaped
      input:
        - air|air|tempered_iron_plate
        - air|mythril_dragon_scale|skulltula_silk
        - mythril_dragon_scale|air|skulltula_silk

rod_of_tenacity:
  type: item
  debug: false
  material: fishing_rod
  data:
    discover: true
  display name: <&color[#f1c232]>Rod of Tenacity
  enchantments:
    - LUCK:5
  lore:
    - <&color[#ffe599]>A rod crafted out of the strongest
    - <&color[#ffe599]>metal and rarest silks.
    - <&color[#ffe599]>Said to bring good luck.
  recipes:
    1:
      type: shaped
      input:
        - air|air|cured_quartz_plate
        - air|plate_of_wisdom|gold_skulltula_silk
        - plate_of_wisdom|air|gold_skulltula_silk

croak_cloak:
  type: item
  debug: false
  material: elytra
  data:
    discover: true
  display name: <&color[#30BB2C]>Croak Cloak
  lore:
  - <&color[#3CD937]>Ribbit Ribbit
  - <&color[#3CD937]>The sound of frogs comforts you.
  recipes:
    1:
      type: shaped
      input:
        - chu_chu_jelly|ochre_froglight|chu_chu_jelly
        - verdant_froglight|elytra|pearlescent_froglight
        - moss_block|moss_block|moss_block

croak_cloak_world:
  type: world
  debug: false
  events:
    after player equips croak_cloak:
      - playsound <player.location> sound:entity_frog_ambient volume:1.5
    on delta time secondly every:3:
      - foreach <server.online_players.filter[has_equipped[croak_cloak]]> as:__player:
        - playeffect effect:scrape quantity:<util.random.int[1].to[5]> at:<player.location>
        - playsound <player.location> sound:entity_frog_ambient volume:1.5

relic_of_dreams:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: <&color[#F131FF]>Relic of Dreams
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1200
    hides:
      - enchants
  lore:
  - <&color[#C305F2]>A Legendary Relic granted to the
  - <&color[#05E0F2]>Hero of Legend in a great slumber.
  - <&color[#F205A3]>The Wind Fish lives on in your memory.
  recipes:
    1:
      type: shaped
      input:
        - cured_quartz_plate|cured_quartz_plate|timestone_shard
        - cured_quartz_plate|gear_of_time|wizzrobe_crystal
        - timestone_shard|wizzrobe_crystal|wizzrobe_crystal

relic_of_wrath:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: <&color[#9700B9]>Relic of Wrath
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1300
    hides:
      - enchants
  lore:
  - <&color[#9D4BB0]>A Legendary Relic found in the ruins
  - <&color[#9FA26C]>said to be broken by the Hero of Time.
  - <&color[#A35863]>A corrupt aura eminates from it.
  recipes:
    1:
      type: shaped
      input:
        - plate_of_power|netherite_ingot|plate_of_power
        - onox_shard|malice_fragment|onox_shard
        - gold_skulltula_silk|netherite_ingot|gold_skulltula_silk

relic_of_shadow:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: <&color[#8F8F8F]>Relic of Shadow
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1100
    hides:
      - enchants
  lore:
  - <&color[#707070]>A Legendary Relic from the Twilight Realm.
  - <&color[#28A4AC]>They say that the Twilight Princess
  - <&color[#DA9317]>once used it to defeat the Usuper King Zant.
  recipes:
    1:
      type: shaped
      input:
        - timestone_shard|netherite_ingot|timestone_shard
        - fragmented_sculk|sculk|fragmented_sculk
        - tempered_iron_plate|tempered_iron_plate|tempered_iron_plate

relic_of_dreams_world:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players.filter[item_in_offhand.advanced_matches[relic_of_dreams]]> as:__player:
        - playeffect effect:wax_off quantity:<util.random.int[1].to[5]> at:<player.location>
        - cast JUMP duration:2s
    on player swaps items offhand:relic_of_dreams:
      - playsound <player.location> sound:block_amethyst_block_chime

relic_of_wrath_world:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players.filter[item_in_offhand.advanced_matches[relic_of_wrath]]> as:__player:
        - playeffect effect:damage_indicator quantity:<util.random.int[1].to[5]> at:<player.location>
        - cast INCREASE_DAMAGE duration:2s
    on player swaps items offhand:relic_of_wrath:
      - playsound <player.location> sound:entity_warden_heartbeat

relic_of_shadow_world:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players.filter[item_in_offhand.advanced_matches[relic_of_shadow]]> as:__player:
        - playeffect effect:enchantment_table quantity:<util.random.int[1].to[5]> at:<player.location>
        - cast NIGHT_VISION duration:12s
    on player swaps items offhand:relic_of_shadow:
      - playsound <player.location> sound:ambient_soul_sand_valley_mood

relic_of_sands:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: <&3>Relic of Sands
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 2100
    hides:
      - enchants
  lore:
  - <&color[#0BBCD1]>A Legendary Relic found within the deepest
  - <&color[#C2CF80]>of oceans. It is said that the sands within
  - <&color[#0BBCD1]>could defeat the most malevolent demons.
  recipes:
    1:
      type: shaped
      input:
        - plate_of_wisdom|plate_of_courage|plate_of_wisdom
        - glass|gold_dust|glass
        - plate_of_wisdom|plate_of_courage|plate_of_wisdom

relic_of_sands_world:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players.filter[item_in_offhand.advanced_matches[relic_of_sands]]> as:__player:
        - playeffect effect:bubble_pop quantity:<util.random.int[1].to[5]> at:<player.location>
        - cast INVISIBILITY duration:12s
    on player swaps items offhand:relic_of_sands:
      - playsound <player.location> sound:block_amethyst_block_hit

relic_of_time:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: <&color[#997D4E]>Relic of Time
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 1900
    hides:
      - enchants
  lore:
  - <&color[#B69661]>A Legendary Relic from the Era of Time.
  - <&color[#76B661]>The Sage of the Forest was said to
  - <&color[#5D9A49]>give this to the Hero of Time.
  recipes:
    1:
      type: shaped
      input:
        - zc_triforce_gem|deku_root|deku_root
        - brown_terracotta|plate_of_courage|brown_terracotta
        - plate_of_courage|brown_terracotta|brown_terracotta

relic_of_time_world:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players.filter[item_in_offhand.advanced_matches[relic_of_time]]> as:__player:
        - playeffect effect:note quantity:<util.random.int[1].to[5]> at:<player.location>
        - cast regeneration duration:2s
    on player swaps items offhand:relic_of_time:
      - playsound <player.location> sound:block_bell_resonate
      - wait 3s
      - playsound <player.location> sound:entity_allay_ambient_without_item

relic_of_darkness:
  type: item
  debug: false
  material: brick
  data:
    discover: true
  display name: <&color[#A28352]>Relic of Darkness
  enchantments:
    - LUCK:1
  mechanisms:
    custom_model_data: 2000
    hides:
      - enchants
  lore:
  - <&color[#DFBB3F]>Lost in the Era of Seasons, This
  - <&color[#8A8461]>Legendary Relic is all that remains
  - <&color[#61618A]>of General Onox, the Lord of Darkness.
  recipes:
    1:
      type: shaped
      input:
        - onox_shard|tempered_iron_plate|air
        - tempered_iron_plate|netherite_block|onox_shard
        - chain|chain|chain

relic_of_darkness_world:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <server.online_players.filter[item_in_offhand.advanced_matches[relic_of_darkness]]> as:__player:
        - playeffect effect:explosion_normal quantity:<util.random.int[1].to[5]> at:<player.location>
        - cast DAMAGE_RESISTANCE duration:2s
    on player swaps items offhand:relic_of_darkness:
      - playsound <player.location> sound:entity_ender_dragon_growl pitch: -1
