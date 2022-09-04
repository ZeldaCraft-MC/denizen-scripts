easter_egg_placer:
  type: item
  debug: false
  material: sheep_spawn_egg
  display name: <&d>Easter Egg
  lore:
    - <&e>Right click to place egg!

easter_egg_cancel:
  type: item
  debug: false
  material: barrier
  display name: <&c>Cancel Placement
  lore:
    - <&4>Right click to cancel egg placement.

easter_egg_cancel_find:
  type: item
  debug: false
  material: barrier
  display name: <&c>Cancel Finding Egg
  lore:
    - <&4>Right click to cancel egg finding.

bunny_hood:
  type: item
  debug: false
  material: paper
  display name: <&e><&l>Bunny Hood
  mechanisms:
    nbt_attributes: generic.movement_speed/head/0/0.1|generic.armor/head/0/2|generic.armor_toughness/head/0/1
    custom_model_data: 600
  lore:
    - <&6>Use <&c>/hat <&6>to equip!
    - ""
    - <&6>Earned as a part of the
    - <&e>2022 Easter event
  flags:
    unique: <util.random.uuid>

easter_firework:
  type: item
  debug: false
  material: firework_rocket
  display name: Easter Firework

fake_egg:
  type: item
  debug: false
  material: turtle_egg
  mechanisms:
    custom_model_data: 100

easter_egg:
  type: item
  debug: false
  material: turtle_egg
  display name: <&d>Easter Egg
  mechanisms:
    custom_model_data: 100
  lore:
    - <&7>Right click to throw!
    - <&7>Trade in for prizes at Ravioli's shop!

easter_events:
  type: world
  debug: false
  events:
    on inventory picks up fake_egg:
      - determine cancelled
    on player right clicks block with:easter_firework using:either_hand:
      - if <player.is_gliding>:
        - determine cancelled
    on firework bursts:
      - if <context.item.script.name||none> != easter_firework:
        - stop
      - wait 1t
      - repeat 20:
        - define velocity <util.random.decimal[-0.3].to[0.3]>,<util.random.decimal>,<util.random.decimal[-0.3].to[0.3]>
        - spawn dropped_item[item=fake_egg;pickup_delay=<util.int_max>;time_lived=4.90m;velocity=<[velocity]>] <context.location>
    on player right clicks block with:easter_egg using:either_hand:
      - determine passively cancelled
      - ratelimit <player> 1t
      - if <context.hand> == off_hand:
        - take slot:41 quantity:1
      - else:
        - take iteminhand quantity:1
      - shoot snowball[item=easter_egg] speed:1 script:random_bunny_spawn
      - playsound <player.location> sound:entity_egg_throw pitch:0.5

random_bunny_spawn:
  type: task
  debug: false
  script:
    - if <[hit_entities].get[1].is_player||false> && !<[hit_entities].get[1].is_inside_vehicle>:
      - mount <[hit_entities].get[1]>|rabbit
    - else if <util.random.decimal> < 0.10:
      - spawn rabbit[age=baby] <[location]>
