# A file containing mob drops for mythicmobs entities

master_sword:
  type: item
  debug: false
  material: netherite_sword
  mechanisms:
    custom_model_data: 1900
    hides: attributes
    attribute_modifiers:
      generic_attack_speed:
        1:
          operation: add_number
          amount: -2.4
          slot: hand
        2:
          operation: multiply_scalar_1
          amount: 0.3
          slot: hand
  display name: <&color[#4ad0f5]>Master Sword
  lore:
    - <empty>
    - <&color[#87feff]>Whether skyward bound, adrift in time,
    - <&color[#87feff]>or steeped in the glowing embers of
    - <&color[#87feff]>twilight... The sacred blade is forever
    - <&color[#87feff]>bound to the soul of the Hero.
    - <empty>
    - <&7>When in Main Hand<&co>
    - <&9>+30<&pc> Attack Speed

master_sword_events:
  type: world
  events:
    on player damages entity with:master_sword:
      - narrate <context.final_damage>

bokoblin_club:
  type: item
  debug: false
  material: golden_sword
  display name: <&color[#8c5939]>Bokoblin Club
  mechanisms:
    custom_model_data: 2500
  lore:
    - <empty>
    - <&color[#c19965]>A crude Bokoblin club made to clobber small prey.
    - <&color[#c19965]>It's essentially a stick, so its durability is low.

bokoblin_slasher:
  type: item
  debug: false
  material: iron_sword
  display name: <&color[#c3cfed]>Bokoblin Slasher
  mechanisms:
    custom_model_data: 2000
  lore:
    - <empty>
    - <&color[#8c95cd]>An advanced Bokoblin combat sword,
    - <&color[#8c95cd]>used to slice and dice their foes.

bokoblin_staff:
  type: item
  debug: false
  material: wooden_sword
  display name: <&color[#8530cd]>Bokoblin Staff
  mechanisms:
    custom_model_data: 2400
  lore:
    - <empty>
    - <&color[#5e25a9]>The staff of a powerful Bokoblin shaman.
    - <&color[#5e25a9]>You can sense its magic in the air around you.

ocarina_prelude_of_light_fragment:
  type: item
  debug: false
  material: paper
  mechanisms:
    custom_model_data: 301
  lore:
    - <empty>
    - <&color[#a7d1de]>A fragment of an ancient relic, lost to time.
    - <&color[#a7d1de]>You can sense its desire to be whole.
  display name: <&color[#3d8cc9]>Relic Fragment

ocarina_prelude_of_light:
  type: item
  debug: false
  material: paper
  mechanisms:
    custom_model_data: 300
  lore:
    - <&7>Plays: Prelude of Light
    - <empty>
    - <&color[#a7d1de]>Ancient legends tell of a Hero who
    - <&color[#a7d1de]>used this to shape reality itself.
    - <&color[#a7d1de]>Perhaps some of its power remains?
  display name: <&color[#3d8cc9]>Reassembled Ocarina
  recipes:
    1:
      type: shaped
      input:
        - ocarina_prelude_of_light_fragment|air|air
        - ocarina_prelude_of_light_fragment|ocarina_prelude_of_light_fragment|ocarina_prelude_of_light_fragment
        - ocarina_prelude_of_light_fragment|ocarina_prelude_of_light_fragment|ocarina_prelude_of_light_fragment

bokoblin_guts:
  type: item
  debug: false
  material: rotten_flesh
  mechanisms:
    custom_model_data: 100
  lore:
    - <empty>
    - <&color[#d9a2f1]>A rare material obtained by defeating
    - <&color[#d9a2f1]>a Bokoblin. It convulses on its own
    - <&color[#d9a2f1]>every now and then, which is really
    - <&color[#d9a2f1]>creepy, but perhaps it has a use.
  display name: <&color[#9e67b9]>Bokoblin Guts

bokoblin_fang:
  type: item
  debug: false
  material: paper
  mechanisms:
    custom_model_data: 303
  lore:
    - <empty>
    - <&color[#f0eed6]>A tooth obtained from a Bokoblin.
    - <&color[#f0eed6]>It's worn down and not very sharp,
    - <&color[#f0eed6]>but it's still pretty hard.
    - <&color[#f0eed6]>Perhaps it has a use.
  display name: <&color[#dcd8ab]>Bokoblin Fang

bokoblin_horn:
  type: item
  debug: false
  material: paper
  mechanisms:
    custom_model_data: 302
  lore:
    - <empty>
    - <&color[#d5c17f]>The severed horn of a Bokoblin,
    - <&color[#d5c17f]>a creature often encountered
    - <&color[#d5c17f]>on the plains of Hyrule.
    - <&color[#d5c17f]>Perhaps it has a use.
  display name: <&color[#a08747]>Bokoblin Horn

moblin_guts:
  type: item
  debug: false
  material: rotten_flesh
  mechanisms:
    custom_model_data: 101
  lore:
    - <empty>
    - <&color[#a0f2cd]>This prized ingredient can be
    - <&color[#a0f2cd]>obtained from Moblins. Its odor
    - <&color[#a0f2cd]>is too pungent for normal food
    - <&color[#a0f2cd]>preparation, but there may be
    - <&color[#a0f2cd]>other uses for it.
  display name: <&color[#62bba9]>Moblin Guts

moblin_horn:
  type: item
  debug: false
  material: paper
  mechanisms:
    custom_model_data: 305
  lore:
    - <empty>
    - <&color[#cdcb9a]>This splendid horn once grew atop
    - <&color[#cdcb9a]>the head of a Moblin. Perhaps there
    - <&color[#cdcb9a]>is a use for it.
  display name: <&color[#b2b17a]>Moblin Horn

moblin_fang:
  type: item
  debug: false
  material: paper
  mechanisms:
    custom_model_data: 304
  lore:
    - <empty>
    - <&color[#e4dfbf]>A sharp fang obtained from a Moblin.
    - <&color[#e4dfbf]>Perhaps there is a use for it.
  display name: <&color[#b5b196]>Moblin Fang
