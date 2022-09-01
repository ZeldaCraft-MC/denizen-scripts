################
# Zc Bind Menu #  (Credits to Merg for making me think of the Comments ### as a billboard
################  Created by Ichi, Finished by Marshall_Lee
######################Ayden/Merg Helped with some of the scripting too.
###############
###Definition##
###############

bindmenu_cmd:
  type: command
  debug: false
  description: Used for binding ZC Spells
  name: bindmenu
  usage: /bindmenu
  permission: bindmenu
  aliases:
  - bind
  - bm
  - spellmenu
  script:
  - inventory open d:bindmenu

##############
##   MENU   ##
##############

bindmenu:
  type: inventory
  inventory: chest
  debug: false
  title: <&4><&l>Spell Menu
  size: 27
  gui: true
  slots:
  - [bakecookie] [kittycannon] [zoratunic] [dlantern] [gorontunic] [firerod] [triforcelight] [redeadwrath] [magiccape]
  - [goronstrength] [magicrod] [fairy] [nayru] [din_item] [thunder] [endhunger] [greatfairy] [nayru2]
  - [power_menu_item] [] [] [] [unbind_item] [] [] [] []

##################
###ItemHandler####
#################

bakecookie:
  type: item
  debug: false
  material: cookie
  display name: <&7><&l>Bake Cookie
  lore:
  - <&f>Bakes a delicious cookie!
  - Cooldown: 10 Seconds
  - Magic Cost: 10
  - Requires 1 Dungeon Point

kittycannon:
  type: item
  debug: false
  material: cat_spawn_egg
  display name: <&7><&l>Kitty Cannon
  lore:
  - <&f>:3 Me-OW!
  - Cooldown: 1 Second
  - Magic Cost: 1
  - Requires 5 Secret Points

zoratunic:
  type: item
  debug: false
  material: leather_chestplate[dye=60,68,170]
  display name: <&1><&l>Zora Tunic
  lore:
  - <&f>Lets you breathe underwater for 5 minutes.
  - Magic Cost: 10
  - Requires 2 Dungeon Points

unbind_item:
  type: item
  debug: false
  material: barrier
  display name: <&7><&l>Unbind Item
  lore:
  - <&f>Unbinds spell from item

dlantern:
  type: item
  debug: false
  material: lantern
  display name: <&e><&l>Lantern
  lore:
  - <&f>Casts Night Vision for 5 minutes.
  - Magic Cost: 10
  - Requires 4 Dungeon Points

gorontunic:
  type: item
  debug: false
  material: leather_chestplate[dye=176,46,38]
  display name: <&4><&l>Goron Tunic
  lore:
  - <&f>Protects you from fire and lava for 5 minutes.
  - Magic Cost: 10
  - Requires 6 Dungeon Points

firerod:
  type: item
  debug: false
  material: redstone_torch
  display name: <&c><&l>Fire Rod
  lore:
  - <&f>Shoot fire at your enemies!
  - Magic Cost: 3
  - Requires 8 Dungeon Points
  - Requires 3 Secret Points

triforcelight:
  type: item
  debug: false
  material: glowstone
  display name: <&6><&l>Triforce Light
  lore:
  - <&f>Makes you glow for 2 minutes.
  - Magic Cost: 10
  - Requires 12 Secret Points

redeadwrath:
  type: item
  debug: false
  material: rotten_flesh
  display name: <&2><&l>Redead Wrath
  lore:
  - <&f>Summon a Zombie that will attack a nearby target
  - Cooldown: 10 minutes
  - Magic Cost: 30
  - Requires 10 Dungeon Points
  - Requires 10 Secret Points

magiccape:
  type: item
  debug: false
  material: elytra
  display name: <&d><&l>Magic Cape
  lore:
  - <&f>Turn Invisible for one minute
  - Cooldown: 1 Minute
  - Magic Cost: 20
  - Requires 10 Dungeon Points
  - Requires 5 Secret Points

goronstrength:
  type: item
  debug: false
  material: blaze_powder
  display name: <&7><&l>Goron's Strength
  lore:
  - <&f>Mine blocks 20<&pc> faster for 5 minutes
  - Magic Cost: 10
  - Requires 12 Dungeon Points

magicrod:
  type: item
  debug: false
  material: blaze_rod
  display name: <&4><&l>Magic Rod
  lore:
  - <&f>Shoot fire at your enemies!
  - <&f>More efficient than Fire Rod.
  - Magic Cost: 2
  - Requires 14 Dungeon Point
  - Requires 14 Secret Points

fairy:
  type: item
  debug: false
  material: apple
  display name: <&d><&l>Fairy
  lore:
  - <&f>Gives you a health regeneration effect for 15 seconds.
  - Magic Cost: 30
  - Requires 18 Dungeon Points
  - Requires 5 Secret Points

nayru:
  type: item
  debug: false
  material: iron_chestplate
  display name: <&9><&l>Nayrus Love
  lore:
  - <&f>Reduces damage dealt by 20<&pc>
  - Cooldown: 2 minutes
  - Magic Cost: 30
  - Requires 20 Dungeon Points
  - Requires 16 Secret Points

din_item:
  type: item
  debug: false
  material: fire_charge
  display name: <&c><&l>Din's Fire
  lore:
  - <&f>Boosts your melee attack damage for one minute.
  - Cooldown: 2 minutes
  - Magic Cost: 30
  - Requires 22 Dungeon Points
  - Requires 16 Secret Points

thunder:
  type: item
  debug: false
  material: chorus_flower
  display name: <&f><&l>Thunder
  lore:
  - <&f>Strikes thunder at the targeted area.
  - Magic Cost: 10
  - Requires 26 Dungeon Points
  - Requires 200 PVP Score

endhunger:
  type: item
  debug: false
  material: cooked_beef
  display name: <&4><&l>End Hunger
  lore:
  - <&f>Replenishes your hunger meter.
  - Magic Cost: 25
  - Requires 28 Dungeon Points
  - Requires 15 Secret Points

greatfairy:
  type: item
  debug: false
  material: golden_apple
  display name: <&5><&l>Great Fairy's Blessing
  lore:
  - <&f>Gives you a health regeneration effect for 30 seconds.
  - Cooldown: 1 minute 30 seconds
  - Magic Cost: 50
  - Requires 30 Dungeon Points
  - Requires 15 Secret Points

nayru2:
  type: item
  debug: false
  material: enchanted_golden_apple
  display name: <&1><&l>Nayru's Love II
  lore:
  - <&f>Absorbs 4 health points worth of damage.
  - Cooldown: 2 minutes
  - Magic Cost: 30
  - Requires 35 Dungeon Points
  - Requires 18 Secret Points

power_menu_item:
  type: item
  debug: false
  material: gold_block
  display name: <&e><&l>Power of the Goddesses
  lore:
  - <&f>Gives the effects of
  - <&f>Nayru's Love and Din's Fire. 2 minute timer.
  - Cooldown: 2 minutes
  - Magic Cost: 90
  - Requires 40 Dungeon Points
  - Requires 22 Secret Points


############
##Binding ##
############

bind_item:
  type: task
  debug: false
  definitions: spell_item
  data:
    item_to_spell_map:
      kittycannon: kitty_cannon
      bakecookie: bake_cookie
      zoratunic: zora_tunic
      dlantern: lantern
      gorontunic: goron_tunic
      firerod: fire_rod
      triforcelight: triforce_light
      redeadwrath: redead_wrath
      magiccape: magic_cape
      goronstrength: strength
      magicrod: magic_rod
      fairy: fairy
      nayru: nayru
      din_item: din
      thunder: thunder
      endhunger: end_hunger
      greatfairy: great_fairy
      nayru2: nayru_2
      power_menu_item: power
  script:
    - if !<script.data_key[data.item_to_spell_map].contains[<[spell_item]>]>:
      - stop
    - if <player.item_in_hand.material.name> == air:
      - narrate "<&c>You cannot bind spells to air! Please hold an item."
      - inventory close
      - stop
    - execute as_player "zc bind <script.data_key[data.item_to_spell_map.<[spell_item]>]>"
    - wait 1t
    - inventory close

bind_handler:
  type: world
  debug: false
  events:
    on player clicks item in bindmenu:
      - define script_name <context.item.script.name.if_null[none]>
      - if <[script_name]> == unbind_item:
        - if <player.item_in_hand.material.name> == air:
          - narrate "<&c>You cannot unbind air!"
          - inventory close
          - stop
        - execute as_player "zc unbind"
        - wait 1t
        - inventory close
        - stop
      - run bind_item def:<[script_name]>
