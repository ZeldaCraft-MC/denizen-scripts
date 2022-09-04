# A collection of task scripts to be run when a spell is activated

bake_cookie_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:block_crack at:<player.location> special_data:white_wool visibility:100 quantity:20 offset:1.0
    - give cookie

zora_tunic_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:block_crack at:<player.location> special_data:lapis_block visibility:100 quantity:20 offset:1.0
    - cast water_breathing d:300 p:1

lantern_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:block_crack at:<player.location> special_data:glowstone visibility:100 quantity:20 offset:1.0
    - cast night_vision d:300 p:1

goron_tunic_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:block_crack at:<player.location> special_data:redstone_block visibility:100 quantity:20 offset:1.0
    - cast fire_resistance d:300 p:1

fire_rod_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_blaze_shoot pitch:1.0
    - playeffect effect:lava at:<player.location> visibility:100 quantity:20 offset:0.5
    - shoot fireball speed:0

triforce_light_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:fireworks_spark at:<player.location> visibility:100 quantity:20 offset:1.0
    - cast glowing d:120

redead_wrath_spell:
  type: task
  debug: false
  script:
    - define loc <player.location.forward_flat[5].find.surface_blocks.within[5].get[1].above[1.5]||null>
    - if <[loc]> == null:
      - narrate "Not enough room to summon!"
      - determine failed
    - else:
      - playsound <player.location> sound:entity_husk_converted_to_zombie pitch:0.5
      - playeffect effect:portal at:<player.location> visibility:100 quantity:250 offset:0.5
      - spawn redead_entity_script[scoreboard_tags=<player.uuid>] <[loc]>
###################################
redead_entity_script:
  type: entity
  debug: false
  entity_type: zombie

redead_spell_event:
  type: world
  debug: false
  events:
      on redead_entity_script targets player:
        - if <context.entity.scoreboard_tags.find[<player.uuid>]> != -1:
          - determine cancelled
      on redead_entity_script targets zombie:
        - determine cancelled
      on redead_entity_script targets villager:
        - determine cancelled
#####################################
magic_cape_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - cast invisibility d:60 p:1 hide_particles

strength_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:block_crack at:<player.location> special_data:redstone_block visibility:100 quantity:20 offset:1.0
    - cast fast_digging d:300 p:1

magic_rod_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_blaze_shoot pitch:1.5
    - playeffect effect:lava at:<player.location> visibility:200 quantity:20 offset:1.0
    - shoot fireball speed:2

fairy_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:block_stone_step pitch:0.5
    - playeffect effect:block_crack at:<player.location> special_data:diamond_block visibility:100 quantity:20 offset:1.0
    - cast regeneration d:15

nayru_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - playeffect effect:block_crack at:<player.location> special_data:sea_lantern visibility:100 quantity:20 offset:1.0
    - cast damage_resistance d:60 p:1

din_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - playeffect effect:block_crack at:<player.location> special_data:sea_lantern visibility:100 quantity:20 offset:1.0
    - cast increase_damage d:60 p:1

thunder_spell:
  type: task
  debug: false
  script:
    - strike <player.precise_target_position>

end_hunger_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - playeffect effect:block_crack at:<player.location> special_data:emerald_block visibility:100 quantity:20 offset:1.0
    - feed <player>

great_fairy_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - playeffect effect:block_crack at:<player.location> special_data:emerald_block visibility:100 quantity:100 offset:1.0
    - cast regeneration d:30 p:1

nayru_2_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - playeffect effect:heart at:<player.location> visibility:100 quantity:100 offset:1.0
    - cast damage_resistance d:2400 p:1

power_spell:
  type: task
  debug: false
  script:
    - playsound <player.location> sound:entity_ghast_shoot pitch:1.0
    - playeffect effect:enchantment_table at:<player.location> visibility:100 quantity:200 offset:1.0
    - cast damage_resistance d:120 p:1
    - cast increase_damage d:120 p:1
    - cast glowing d:120

##NewSpells##

kitty_cannon_spell:
  type: task
  debug: false
  script:
    - execute as_op "kittycannon"
