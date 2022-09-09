#test
check_block:
  type: task
  debug: false
  script:
    - define names <list[]>
    - define names <[names].include[enchanting_table|hopper|trapped_chest|crafting_table|barrel]>
    - define names <[names].include[chest|ender_chest|respawn_anchor|stonecutter|smithing_table]>
    - define names <[names].include[grindstone|fletching_table|cartography_table|blast_furnace|smoker]>
    - define names <[names].include[loom|jukebox|furnace|brewing_stand|beacon|redstone_wire]>
    - if <[names].contains[<context.location.material.name||null>]>:
      - stop
    - if <context.location.material.supports[switchable]||false>:
      - stop
    - if <context.location.material.name.contains_any_text[bed|shulker|anvil|sign]||false>:
      - stop

remove_ench_command:
  type: command
  name: disenchant
  description: Resets the enchantments on your triforce blade
  usage: /disenchant
  debug: false
  script:
    - if <player.item_in_hand.script||null> != <script[zc_triforce_blade]>:
      - narrate "You can only use this command with a triforce blade" format:zc_text
      - stop
    - if !<player.has_flag[confirmed]>:
      - narrate "Are you defintly sure to remove all the enchantments on your triforce blade?" format:zc_text
      - narrate "This command is only supposed to be used if you want to upgrade your blade." format:zc_text
      - narrate "click <&click[/disenchant]><&a>[here]<&end_click><&f> Or type the command again to confirm" format:zc_text
      - flag player confirmed duration:1m
      - stop
    - define enchantments <player.item_in_hand.enchantment_map>
    - if <[enchantments].get[sharpness].if_null[null]> == 10:
      - define enchantments <[enchantments].exclude[sharpness]>
    - if <[enchantments].is_empty>:
        - narrate "You cannot remove enchants from this sword, if it doesn't work with crafting please mention it to greenleeuw" format:zc_text
        - stop
    - if <player.item_in_hand.script||null> == <script[zc_triforce_blade]>:
      - give enchanted_book[enchantments=<[enchantments]>]
      - take iteminhand
      - give zc_triforce_blade

proj_target:
  type: task
  debug: false
  script:
    - foreach <player.eye_location.sub[0,1.4,0].points_between[<player.eye_location.sub[0,1.4,0].forward[15]>]>:
      - wait 2t
      - playeffect redstone quantity:5 <[value]> special_data:1|aqua velocity:<player.location.direction.vector.mul[0.5]>

ground_slam:
  type: task
  debug: false
  script:
    - cast <player> levitation duration:0.2s amplifier:14 no_ambient hide_particles no_icon
    - foreach <player.location.find_entities.within[2].exclude[<player>]>:
      - define 2:->:<[value]>
      - cast <[value]> levitation duration:0.2s amplifier:16 no_ambient hide_particles no_icon
      - hurt <[value]> 10 cause:VOID
    - foreach <player.location.find_entities.within[3].exclude[<player>|<[2]>]>:
      - define 2:->:<[value]>
      - cast <[value]> levitation duration:0.2s amplifier:13 no_ambient hide_particles no_icon
      - hurt <[value]> 8 cause:VOID
    - foreach <player.location.find_entities.within[4].exclude[<player>|<[2]>]>:
      - define 2:->:<[value]>
      - cast <[value]> levitation duration:0.2s amplifier:10 no_ambient hide_particles no_icon
      - hurt <[value]> 6 cause:VOID
    - foreach <player.location.find_entities.within[5].exclude[<player>|<[2]>]>:
      - cast <[value]> levitation duration:0.2s amplifier:7 no_ambient hide_particles no_icon
      - hurt <[value]> 4 cause:VOID
    - wait 1t
    - playeffect effect:block_crack special_data:<player.standing_on.material> offset:2.5,0.2,2.5 at:<player.location> quantity:200
    - playeffect effect:explosion_normal offset:2.5,0.2,2.5 at:<player.location> quantity:50
    - playeffect effect:flash at:<player.location> quantity:1

twili_scim_events:
  type: world
  debug: false
  events:
    on player damages entity with:zc_twilight_scimitar:
    - if <player.location.world.time.period> == night:
      - determine passively <context.damage.mul[1.2]>
    - if <util.random.int[1].to[5]> == 3:
      - playsound sound:entity_phantom_bite pitch:0.5 <player.location>
    on player right clicks block with:zc_twilight_scimitar:
    - ratelimit <player> 5t
    - inject check_block
    - if !<player.standing_on.material.exists>:
      - stop
    - define curr_magic <yaml[<player.uuid>].read[magicmeter]>
    - define max_magic <yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]>
    - define cost 70
    - if <[curr_magic]> < <[cost]>:
      - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&c>[Magic] <element[].pad_right[<[percent]>].with[|]><&4><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
      - stop
    - if <player.has_flag[twilight_cooldown]>:
      - narrate "<&c>This spell is still on cooldown! You can use it again in <player.flag_expiration[twilight_cooldown].duration_since[<util.time_now>].formatted>"
      - stop
    - flag player twilight_cooldown duration:35s

    - cast <player> levitation duration:0.2s amplifier:14 no_ambient hide_particles no_icon
    - playsound sound:entity_iron_golem_death pitch:0.5 <player.location>
    - define 2 <list[]>
    - foreach <player.location.find_entities[!armor_stand|item_frame|painting].within[2].exclude[<player>]>:
      - define 2:->:<[value]>
      - if !<[value].is_spawned>:
        - foreach next
      - if !<[value].is_living>:
        - foreach next
      - cast <[value]> levitation duration:0.2s amplifier:16 no_ambient hide_particles no_icon
      - hurt <[value]> 10 cause:VOID
    - foreach <player.location.find_entities[!armor_stand|item_frame|painting].within[3].exclude[<player>|<[2]>]>:
      - define 2:->:<[value]>
      - if !<[value].is_spawned>:
        - foreach next
      - if !<[value].is_living>:
        - foreach next
      - cast <[value]> levitation duration:0.2s amplifier:13 no_ambient hide_particles no_icon
      - hurt <[value]> 8 cause:VOID
    - foreach <player.location.find_entities[!armor_stand|item_frame|painting].within[4].exclude[<player>|<[2]>]>:
      - define 2:->:<[value]>
      - if !<[value].is_spawned>:
        - foreach next
      - if !<[value].is_living>:
        - foreach next
      - cast <[value]> levitation duration:0.2s amplifier:10 no_ambient hide_particles no_icon
      - hurt <[value]> 6 cause:VOID
    - foreach <player.location.find_entities[!armor_stand|item_frame|painting].within[5].exclude[<player>|<[2]>]>:
      - if !<[value].is_spawned>:
        - foreach next
      - if !<[value].is_living>:
        - foreach next
      - cast <[value]> levitation duration:0.2s amplifier:7 no_ambient hide_particles no_icon
      - hurt <[value]> 4 cause:VOID
    - playeffect effect:block_crack special_data:<player.standing_on.material> offset:2.5,0.2,2.5 at:<player.location> quantity:200
    - playeffect effect:explosion_normal offset:2.5,0.2,2.5 at:<player.location> quantity:50
    - playeffect effect:flash at:<player.location> quantity:1

    - define new_magic <[curr_magic].sub[<[cost]>]>
    - yaml set magicmeter:<[new_magic]> id:<player.uuid>
    - while <[curr_magic]> > <[new_magic]> && <player.is_online>:
      - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
      - define curr_magic <[curr_magic].sub[<[cost].div[5].round_up>].max[0]>
      - wait 1t
    - define percent <[new_magic].div[<[max_magic]>].mul[100].round_down>
    - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"

goddess_sword_events:
  type: world
  debug: false
  events:
    on player damages entity with:zc_goddes_sword:
    - if <util.random.int[1].to[5]> == 3:
      - playsound sound:entity_vex_hurt volume:4 pitch:0.5 <player.location>
    on player right clicks block with:zc_goddes_sword:
    - ratelimit <player> 5t
    - inject check_block
    - define curr_magic <yaml[<player.uuid>].read[magicmeter]>
    - define max_magic <yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]>
    - define cost 30
    - if <[curr_magic]> < <[cost]>:
      - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&c>[Magic] <element[].pad_right[<[percent]>].with[|]><&4><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
      - stop
    - if <player.has_flag[goddes_cooldown]>:
      - narrate "<&c>This spell is still on cooldown! You can use it again in <player.flag_expiration[goddes_cooldown].from_now.formatted||0s>"
      - stop
    - flag player goddes_cooldown duration:3s

    - playsound <player.location> sound:ENTITY_ILLUSIONER_CAST_SPELL volume:1
    - foreach <player.eye_location.sub[0,1.4,0].points_between[<player.eye_location.sub[0,1.4,0].forward[15]>]>:
      - wait 2t
      - playeffect redstone quantity:5 <[value]> special_data:1|aqua velocity:<player.location.direction.vector.mul[0.7]>
      - hurt <util.random.int[4].to[7]> <[value].find_entities[!armor_stand|item_frame|painting].within[0.4].exclude[<player>]> cause:VOID

    - define new_magic <[curr_magic].sub[<[cost]>]>
    - yaml set magicmeter:<[new_magic]> id:<player.uuid>
    - while <[curr_magic]> > <[new_magic]> && <player.is_online>:
      - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
      - define curr_magic <[curr_magic].sub[<[cost].div[5].round_up>].max[0]>
      - wait 1t
    - define percent <[new_magic].div[<[max_magic]>].mul[100].round_down>
    - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
