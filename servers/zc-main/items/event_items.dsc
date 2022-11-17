trophy_resurrect_events:
  type: world
  debug: false
  events:
    on player resurrected:
      - if <player.item_in_hand.script.name||null> == totem_of_speed || <player.item_in_offhand.script.name||null> == totem_of_speed:
        - determine cancelled

sunglasses_world:
  type: world
  debug: false
  events:
    on player equips paper:
      - if <context.new_item.custom_model_data||0> == 9200:
        - title title:<&chr[f027]> targets:<player> stay:99h
    on player unequips paper:
      - if <context.old_item.custom_model_data||0> == 9200:
        - title title:<&chr[f027]> targets:<player> stay:0t fade_in:0t fade_out:1s
    on player joins:
      - if <player.equipment_map.get[helmet]||nope> == <item[paper[custom_model_data=9200;display_name=Sunglasses]]>:
        - title title:<&chr[f027]> targets:<player> stay:99h

xmas_world:
  type: world
  debug: false
  events:
    on player equips xmas_item:
      - inject xmas_task
    on player quits:
      - flag player xmasEffect:false
    on player joins:
      - if <player.inventory.slot[37].script.name.is[==].to[xmas_item]||false>:
        - inject xmas_task

xmas_task:
  type: task
  debug: false
  script:
    - flag player xmasEffect:true
    - playeffect <player.location> effect:snow_shovel quantity:20
    - while <player.inventory.slot[37].script.name.is[==].to[xmas_item]||false>:
      - if !<player.flag[xmasEffect]>:
        - stop
      - wait 3s
      - playeffect <player.location> effect:snow_shovel quantity:20

## Event for Spoopy Helm ##
hween_world:
  type: world
  debug: false
  events:
    on entity targets player:
      - if <context.entity.is_mythicmob> or <context.entity.health_max||0> >= 100:
        - stop
      - if <context.target.equipment_map.get[helmet].script.name.is[==].to[hween_item]||false>:
        - determine cancelled

hallowe2020_i_task:
  type: task
  debug: false
  script:
    - spawn primed_tnt[explosion_radius=1.5;fuse_ticks=0] <[shot_entities].first.location>
    - playeffect effect:lava offset:1,1,1 quantity:100 at:<[shot_entities].first.location> visibility:40
    - playsound sound:entity_wither_skeleton_death <[shot_entities].first.location> pitch:0.1 volume:3
    - remove <[shot_entities]>

hallowe2020_i_world:
  type: world
  debug: false
  events:
    on player breaks block with:grave_digger_i:
      - if <context.location.world.name> = spawn:
        - stop
      - define rando <util.random.int[1].to[600]>
      - if <[rando]> < 10:
        - actionbar "You got Tricked and received a random item"
        - determine <list[soul_soil|soul_sand|jack_o_lantern|carved_pumpkin|pumpkin|rotten_flesh|bone|glass_bottle].random>
      - if <[rando]> > 597:
        - actionbar "You got Treated and received a random item"
        - determine <list[golden_apple|enchanted_golden_apple|diamond|dragon_breath|emerald|netherite_ingot|golden_shovel|golden_hoe|golden_sword|golden_pickaxe|golden_helmet|golden_leggings|golden_chestplate|golden_boots|golden_axe|gold_ingot|gold_block|diamond_block|emerald_block].random>
    on player right clicks block with:hallowe2020_i_1:
      - ratelimit <player> 5t
      - inject check_block
      - define curr_magic <yaml[<player.uuid>].read[magicmeter]>
      - define max_magic <yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]>
      - define cost 13
      - if <[curr_magic]> < <[cost]>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&c>[Magic] <element[].pad_right[<[percent]>].with[|]><&4><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - stop

      - shoot armor_stand[invulnerable=true;visible=false;equipment=air|air|air|jack_o_lantern;is_small=true] script:hallowe2020_i_task speed:2.5

      - define new_magic <[curr_magic].sub[<[cost]>]>
      - yaml set magicmeter:<[new_magic]> id:<player.uuid>
      - while <[curr_magic]> > <[new_magic]> && <player.is_online>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - define curr_magic <[curr_magic].sub[<[cost].div[5].round_up>].max[0]>
        - wait 1t
      - define percent <[new_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
    on player right clicks block with:hallowe2020_i_2:
      - ratelimit <player> 5t
      - inject check_block
      - define curr_magic <yaml[<player.uuid>].read[magicmeter]>
      - define max_magic <yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]>
      - define cost 13
      - if <[curr_magic]> < <[cost]>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&c>[Magic] <element[].pad_right[<[percent]>].with[|]><&4><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - stop

      - shoot armor_stand[invulnerable=true;visible=false;equipment=air|air|air|jack_o_lantern;is_small=true] script:hallowe2020_i_task speed:2.5

      - define new_magic <[curr_magic].sub[<[cost]>]>
      - yaml set magicmeter:<[new_magic]> id:<player.uuid>
      - while <[curr_magic]> > <[new_magic]> && <player.is_online>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - define curr_magic <[curr_magic].sub[<[cost].div[5].round_up>].max[0]>
        - wait 1t
      - define percent <[new_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
    on player right clicks block with:hallowe2020_i_3:
      - ratelimit <player> 5t
      - inject check_block
      - define curr_magic <yaml[<player.uuid>].read[magicmeter]>
      - define max_magic <yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]>
      - define cost 13
      - if <[curr_magic]> < <[cost]>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&c>[Magic] <element[].pad_right[<[percent]>].with[|]><&4><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - stop

      - shoot armor_stand[invulnerable=true;visible=false;equipment=air|air|air|jack_o_lantern;is_small=true] script:hallowe2020_i_task speed:2.5

      - define new_magic <[curr_magic].sub[<[cost]>]>
      - yaml set magicmeter:<[new_magic]> id:<player.uuid>
      - while <[curr_magic]> > <[new_magic]> && <player.is_online>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - define curr_magic <[curr_magic].sub[<[cost].div[5].round_up>].max[0]>
        - wait 1t
      - define percent <[new_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"

#receive_prizes_c:
#  type: command
#  name: receive
#  description: lets you receive event items
#  usage: /receive
#  debug: false
#  script:
#    - if <player.location.world> != <world[s1]>:
#      - narrate "You need to be in s1 to use this command" format:zc_text
#      - stop
#    - if <player.has_flag[prize_received]>:
#      - narrate "You already received your prizes" format:zc_text
#      - stop
#    - if <player.has_flag[prize_receiving]>:
#      - narrate "You are already receiving the items" format:zc_text
#      - stop
#    - if !<player.has_flag[final_boss_done]> && !<player.has_flag[got_shovel]>:
#      - narrate "You dont seem to be able to claim any event prizes" format:zc_text
#      - stop
#    - flag player prize_receiving
#    - if <player.has_flag[got_shovel]>:
#      - give grave_digger_i
#    - if <player.has_flag[final_boss_done]>:
#      - define amount <player.flag[final_boss_done]>
#      - repeat <[amount].div[10].round_up>:
#        - if <[amount]> >= <element[<[value]>0].sub[9]>:
#          - give hallowe2020_i_1
#        - if <[amount]> >= <element[<[value]>0].sub[5]>:
#          - give hallowe2020_i_2
#        - if <[amount]> >= <element[<[value]>0]>:
#          - give hallowe2020_i_3
#      - flag player prize_received
#      - flag player prize_receiving:!
#      - narrate "Your prizes have been put in your inventory" format:zc_text

vday_items:
  type: world
  debug: false
  events:
    on player shoots cupid_bow priority:5:
      - if <player.name> != Mergu:
        - ratelimit <player> 1s
        - itemcooldown bow duration:1s
      - determine passively cancelled
      - shoot cupid_arrow origin:<player> speed:<context.force> script:cupid_arrow_land save:arrow no_rotate def:<context.projectile>
      - playsound <player.location> sound:ENTITY_FOX_SPIT volume:1 pitch:<util.random.decimal[1.15].to[1.5].add[<context.force.div[10]>]>
      - run cupid_particles def:<entry[arrow].shot_entity>|<context.force.div[10]>

    on player picks up launched arrow:
      - if <context.arrow.script.name||none> == cupid_arrow:
        - remove <context.arrow>
        - determine cancelled

    on player picks up vday_rose:
      - if <context.item.has_flag[vday_gifter]>:
        - if <context.item.flag[vday_gifter]> == <player>:
          - stop
        - determine passively cancelled
        - give <context.item.with[lore=Gifted<&sp>to<&sp><player.name||you><&sp>by<&sp><italic><red><context.item.flag[vday_gifter].name||a<&sp>secret<&sp>admirer>;enchantments=unbreaking,1;hides=enchants]>
        - playeffect <player.location.above> effect:heart quantity:<util.random.int[5].to[10]> offset:0.5,1,0.5 velocity:0,0,0 visibility:100
        - playsound <player> BLOCK_CONDUIT_AMBIENT pitch:1.5
        - flag <context.item.flag[vday_gifter]> vday_roses_gifted:++
        - flag <player> vday_roses_received:++
      - remove <context.entity>

    on player drops vday_rose:
      - if <context.item.lore> == <item[vday_rose].lore>:
        - determine passively cancelled
        - wait 1t
        - flag <context.item> vday_gifter:<player>
        - take item:vday_rose quantity:1
        - define ditem <context.item>
        - if !<server.has_flag[vday_rose_bloom]>:
          - if <context.item.is_enchanted>:
            - define wlore "<gray>This once special rose has wilted<&nl><gray>but does your bond with <context.item.lore.get[1].after[by<&sp>]||your<&sp>admirer><gray> blossom still?"
            - define ditem <item[vday_wilted_rose].with[lore=<[wlore]>;enchantments=unbreaking,1;hides=enchants].with[quantity=1]>
          - else:
            - define ditem <item[vday_wilted_rose].with[quantity=1]>
        - shoot dropped_item[item=<[ditem]>] origin:<player> destination:<player.cursor_on||player.location.forward> speed:0.3

    after player holds item item:vday_rose:
      - if !<server.has_flag[vday_rose_bloom]>:
        - if <player.item_in_hand.is_enchanted>:
          - define wlore "<gray>This once special rose has wilted<&nl><gray>but does your bond with <player.item_in_hand.lore.get[1].after[by<&sp>]||your<&sp>admirer><gray> blossom still?"
          - adjust <player> item_in_hand:<item[vday_wilted_rose].with[lore=<[wlore]>;enchantments=unbreaking,1;hides=enchants].with[quantity=<player.item_in_hand.quantity||1>]>
        - else:
          - adjust <player> item_in_hand:<item[vday_wilted_rose].with[quantity=<player.item_in_hand.quantity||1>]>
    on player shoots block with:cupid_arrow:
      - remove <context.projectile>
    on arrow hits entity:
      - if <context.hit_entity.invulnerable>:
        - remove <context.projectile>
      - else if !<context.hit_entity.visible||true> && <context.hit_entity.entity_type> == ARMOR_STAND:
        - remove <context.projectile>
    on player clicks vday_rose in inventory:
      - if <context.item.is_enchanted>:
        - define wlore "<gray>This once special rose has wilted<&nl><gray>but does your bond with <context.item.lore.get[1].after[by<&sp>]||your<&sp>admirer><gray> blossom still?"
        - determine <item[vday_wilted_rose].with[lore=<[wlore]>;enchantments=unbreaking,1;hides=enchants].with[quantity=<context.item.quantity||1>]>
      - else:
        - determine <item[vday_wilted_rose].with[quantity=<context.item.quantity||1>]>
    on player right clicks block with:vday*rose:
      - determine passively cancelled
      - ratelimit <player> 3s
      - if <context.item.is_enchanted>:
        - if <context.item.lore.after[to<&sp>].before[<&sp>by].strip_color> == <player.name||false> || <context.item.lore.after[with<&sp>].before[<&sp>blossom].strip_color> == <player.name||false>:
          - playsound <player.location> entity_fox_sniff pitch:0.2 volume:0.2
          - playeffect <player.location.above> effect:heart quantity:<util.random.int[5].to[10]> offset:0.5,1,0.5 velocity:0,0,0 visibility:100
          - if <context.item.material.name> == poppy:
            - heal <player>
            - if !<server.has_flag[vday_rose_bloom]>:
              - take item:vday_rose
              - define wlore "<gray>This once special rose has wilted<&nl><gray>but does your bond with <context.item.lore.get[1].after[by<&sp>]||your<&sp>admirer><gray> blossom still?"
              - give <item[vday_wilted_rose].with[lore=<[wlore]>;enchantments=unbreaking,1;hides=enchants]>
    after player right clicks entity with:chokehold:
      - ratelimit <player> 2t
      - determine passively cancelled
      - if <context.entity.is_leashed>:
        - leash cancel <context.entity>
      - else:
        - leash <context.entity> holder:<player>

cupid_particles:
  type: task
  debug: false
  definitions: arrow|pitch
  script:
    - define spawned <util.time_now>
    - wait 2t
    - while <[arrow].is_spawned||false> && <util.time_now.is_before[<[spawned].add[60s]>]||false>:
      - playeffect <[arrow].location> effect:heart quantity:<util.random.int[1].to[3]> offset:0,3,0 velocity:0,0,0 visibility:100
      - playsound <[arrow].location> sound:BLOCK_BUBBLE_COLUMN_BUBBLE_POP volume:2 pitch:<util.random.decimal[1.3].to[1.7].add[<[pitch]>]>
      - wait <util.random.int[1].to[3]>t
    - if <[arrow].is_spawned||false>:
      - remove <[arrow]>

cupid_arrow:
  type: entity
  debug: false
  entity_type: arrow[damage=0.1;pickup_status=CREATIVE_ONLY;potion=<item[potion].with[potion_effects=<list[instant_heal,false,false]>]>]

cupid_arrow_land:
  type: task
  debug: false
  definitions: arrow
  script:
    - playeffect <[location]> effect:heart quantity:15 offset:2,2,2 velocity:0,0,0 visibility:100
    - if <[hit_entities].size||0> <= 0:
      - playsound <[location]> sound:ENTITY_VEX_hurt volume:1.5 pitch:<util.random.decimal[1.4].to[2]>
      #- remove <[shot_entities]>
      - stop
    - playsound <player> sound:ENTITY_bee_sting volume:0.5 pitch:<util.random.decimal[1.6].to[1.8]>
    - playsound <player> sound:ENTITY_ARROW_HIT_PLAYER volume:0.1 pitch:<util.random.decimal[1.6].to[1.8]>
    - if <[hit_entities].filter[is_player].size||0> >= 1:
      - playsound <[hit_entities].filter[is_player].get[1]> sound:ENTITY_bee_sting volume:1 pitch:<util.random.decimal[1.6].to[1.8]>
      - if <[hit_entities].filter[is_player].size||0> >= 1:
        - if <[hit_entities].filter[is_player].get[1]>:
          - stop
        - flag <[hit_entities].filter[is_player].get[1]> vday_arrow_hit duration:10s
        - repeat 10:
          - playeffect <[hit_entities].filter[is_player].get[1].location.above> effect:heart quantity:<util.random.int[5].to[10]> offset:0.5,1,0.5 velocity:0,0,0 visibility:100
          - playsound <[hit_entities].filter[is_player].get[1]> BLOCK_CONDUIT_AMBIENT pitch:1.5
          - wait 1s
      - stop
    - if <[hit_entities].filter[can_breed].size||0> >= 1:
      - adjust <[hit_entities].filter[can_breed]> breed:true
      - stop

fools_gold_events:
  type: world
  debug: false
  events:
    on player right clicks block with:fools_gold:
      - ratelimit <player> 10t
      - playsound sound:zc_sfx.fools.mmmmmm-converted custom <player.location> volume:0.6 pitch:<util.random.decimal[0.8].to[1.1]>

egg_shooter_events:
  type: world
  debug: false
  events:
    on player right clicks block with:egg_shooter using:either_hand:
      - ratelimit <player> 0.2s
      - if ( <player.cursor_on[5].has_inventory||false> || <player.cursor_on[5].material.name.contains_any_text[<list[button|lever|door|sign|gate]>]||false> ):
        - stop
      - determine passively cancelled
      - itemcooldown player_head duration:0.1s
      - repeat 5:
        - shoot dropped_item[item=fake_shot_egg;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_shot_egg
        - playsound sound:entity_egg_throw pitch:<util.random.decimal[0.2].to[0.7]> at:<player.location> volume:0.03 sound_category:blocks
        - random:
          - playsound sound:entity_chicken_egg pitch:<util.random.decimal[0.8].to[1.6]> at:<player.location> volume:0.2 sound_category:blocks
          - playsound sound:entity_turtle_lay_egg pitch:<util.random.decimal[0.8].to[1.6]> at:<player.location> volume:0.09 sound_category:blocks
        - wait 1t
    on player places egg_shooter:
      - determine cancelled
    on inventory picks up fake_shot_egg:
      - determine cancelled

del_fake_shot_egg:
  debug: false
  type: task
  definitions: type
  script:
    - wait 1s
    - define location <[last_entity].location>
    - if <[type]> == shooter:
      - playeffect effect:happy_villager at:<[location]> quantity:<util.random.int[1].to[3]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playeffect effect:BLOCK_CRACK special_data:turtle_egg at:<[location]> quantity:3 offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playeffect effect:item_crack special_data:cocoa_beans at:<[location]> quantity:<util.random.int[5].to[20]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playeffect effect:item_crack special_data:brown_concrete at:<[location]> quantity:<util.random.int[5].to[12]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - random:
        - playeffect effect:falling_dust special_data:pink_concrete at:<[location]> quantity:<util.random.int[3].to[8]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:falling_dust special_data:light_blue_concrete at:<[location]> quantity:<util.random.int[3].to[8]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:falling_dust special_data:yellow_concrete at:<[location]> quantity:<util.random.int[3].to[8]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:falling_dust special_data:orange_concrete at:<[location]> quantity:<util.random.int[3].to[8]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:falling_dust special_data:lime_concrete at:<[location]> quantity:<util.random.int[3].to[8]> offset:1,1,1 velocity:0,0.01,0 visibility:100
      - random:
        - playsound sound:entity_turtle_egg_crack <[location]> pitch:<util.random.decimal[0.8].to[1.9]> volume:0.02 sound_category:blocks
        - playsound sound:entity_turtle_egg_break <[location]> pitch:<util.random.decimal[0.8].to[1.9]> volume:0.02 sound_category:blocks
      #- playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <[location].find_players_within[1].exclude[<player>]> volume:0.4 sound_category:blocks
    # - else:
    #   - playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <[location].find_players_within[1]> volume:0.4 sound_category:blocks

seashell_shooter_events:
  type: world
  debug: false
  events:
    on player right clicks block with:seashell_shooter using:either_hand:
      - ratelimit <player> 0.2s
      - if <player.cursor_on[5].has_inventory||false> || <player.cursor_on[5].material.name.contains_any_text[button|lever|door|sign|gate]||false>:
        - stop
      - determine passively cancelled
      - itemcooldown player_head duration:0.1s
      - repeat <util.random.int[5].to[9]>:
        - random:
          - shoot dropped_item[item=fake_shell_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_shell_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_shell_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_shell_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_shell_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_shell_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_scute;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_nautilus;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_nautilus;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
          - shoot dropped_item[item=fake_seashell;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_seashell
        - random:
          - playeffect effect:item_crack special_data:sand at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:item_crack special_data:nautilus_shell at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sand at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sand at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sand at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sand at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sand at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sandstone at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:sandstone at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
          - playeffect effect:block_dust special_data:quartz_block at:<player.location.above[0.8].forward[2]> quantity:1 offset:<util.random.decimal[0.6].to[1.6]> velocity:0,0.05,0 visibility:100
        - playsound sound:item_armor_equip_turtle pitch:<util.random.decimal[1.6].to[2]> at:<player.location> volume:0.04 sound_category:blocks
        - random:
          - playsound sound:block_coral_block_break pitch:<util.random.decimal[0.8].to[1.4]> at:<player.location> volume:0.2 sound_category:blocks
          - playsound sound:block_bone_block_place pitch:<util.random.decimal[1.7].to[2]> at:<player.location> volume:0.1 sound_category:blocks
          - playsound sound:entity_turtle_shamble pitch:<util.random.decimal[0.9].to[1.8]> at:<player.location> volume:0.6 sound_category:blocks
          - playsound sound:entity_turtle_shamble_baby pitch:<util.random.decimal[0.9].to[1.8]> at:<player.location> volume:0.6 sound_category:blocks
        - wait 1t
    on player places seashell_shooter:
      - determine cancelled
    on inventory picks up fake_seashell:
      - determine cancelled
    on inventory picks up fake_shell_scute:
      - determine cancelled
    on inventory picks up fake_scute:
      - determine cancelled
    on inventory picks up fake_nautilus:
      - determine cancelled
    # after player joins:
    #   - if <player.inventory.list_contents.contains_any[scute[custom_model_data=300]]>:
    #     - take scute[custom_model_data=300;quantity=2700]
    #   - if <player.inventory.list_contents.contains_any[scute[custom_model_data=400]]>:
    #     - take scute[custom_model_data=400;quantity=2700]
    #   - if <player.inventory.list_contents.contains_any[scute[custom_model_data=500]]>:
    #     - take scute[custom_model_data=500;quantity=2700]
    # on player clicks in inventory:
    #   - if <context.inventory.list_contents.contains_any[scute[custom_model_data=300]]>:
    #     - take scute[custom_model_data=300;quantity=2700]
    #   - if <context.inventory.list_contents.contains_any[scute[custom_model_data=400]]>:
    #     - take scute[custom_model_data=400;quantity=2700]
    #   - if <context.inventory.list_contents.contains_any[scute[custom_model_data=500]]>:
    #     - take scute[custom_model_data=500;quantity=2700]

del_fake_seashell:
  debug: false
  type: task
  definitions: type
  script:
    - wait 1s
    - define location <[last_entity].location>
    - if <[type]> == shooter:
      - random:
        - playeffect effect:block_dust special_data:sand at:<[location]> quantity:<util.random.int[5].to[15]> offset:1,<util.random.int[2].to[5]>,1 velocity:0,<util.random.decimal[0.5].to[3.5]>,0 visibility:100
        - playeffect effect:block_CRACK special_data:sand at:<[location]> quantity:<util.random.int[5].to[15]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
        - playeffect effect:block_dust special_data:sand at:<[location]> quantity:<util.random.int[5].to[15]> offset:1,<util.random.int[2].to[5]>,1 velocity:0,<util.random.decimal[0.5].to[3.5]>,0 visibility:100
        - playeffect effect:block_CRACK special_data:sand at:<[location]> quantity:<util.random.int[5].to[15]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
        - playeffect effect:item_CRACK special_data:quartz at:<[location]> quantity:<util.random.int[5].to[15]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
        - playeffect effect:item_CRACK special_data:nautilus_shell at:<[location]> quantity:<util.random.int[5].to[15]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - random:
        - playeffect effect:falling_dripstone_water at:<[location]> quantity:<util.random.int[1].to[3]> offset:1,<util.random.int[1].to[3]>,1 velocity:0,0,0 visibility:100
        - playeffect effect:water_splash at:<[location]> quantity:<util.random.int[10].to[25]> offset:1,<util.random.int[1].to[4]>,1 velocity:0,1,0 visibility:100
        - playeffect effect:water_drop at:<[location]> quantity:<util.random.int[10].to[25]> offset:1,<util.random.int[1].to[6]>,1 velocity:0,1.05,0 visibility:100
      - playeffect effect:water_wake at:<[location]> quantity:<util.random.int[3].to[7]> offset:1,0,1 velocity:0,0,0 visibility:100
      - random:
        - playsound sound:entity_player_swim <[location]> pitch:<util.random.decimal[1.4].to[2]> volume:0.03 sound_category:blocks
        - playsound sound:entity_generic_swim <[location]> pitch:<util.random.decimal[1.3].to[2]> volume:0.03 sound_category:blocks
        - playsound sound:entity_generic_splash <[location]> pitch:<util.random.decimal[0.6].to[2]> volume:0.02 sound_category:blocks
        - playsound sound:entity_player_splash_high_speed <[location]> pitch:<util.random.decimal[1.6].to[2]> volume:0.02 sound_category:blocks
      - random:
        - playsound sound:block_bone_block_break <[location]> pitch:<util.random.decimal[1.6].to[2]> volume:0.1 sound_category:blocks
        - playsound sound:block_coral_block_place <[location]> pitch:<util.random.decimal[0.8].to[1.4]> volume:0.1 sound_category:blocks
        - playsound sound:entity_dolphin_eat <[location]> pitch:<util.random.decimal[0.8].to[1.9]> volume:0.1 sound_category:blocks
        - playsound sound:block_sand_break <[location]> pitch:<util.random.decimal[0.8].to[1.9]> volume:0.2 sound_category:blocks

candy_shooter_events:
  type: world
  debug: false
  events:
    on player right clicks block with:candy_shooter using:either_hand:
      - ratelimit <player> 0.2s
      - if ( <player.cursor_on[5].has_inventory||false> || <player.cursor_on[5].material.name.contains_any_text[<list[button|lever|door|sign|gate]>]||false> ):
        - stop
      - determine passively cancelled
      - itemcooldown player_head duration:0.1s
      - repeat 5:
        - shoot dropped_item[item=fake_shot_candy;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_fake_shot_candy
        - playsound sound:item_bone_meal_use pitch:<util.random.decimal[0.2].to[1.7]> at:<player.location> volume:0.2 sound_category:blocks
        - wait 1t
    on player places candy_shooter:
      - determine cancelled
    on inventory picks up fake_shot_candy:
      - determine cancelled

del_fake_shot_candy:
  debug: false
  type: task
  definitions: type
  script:
    - wait 1s
    - define location <[last_entity].location>
    - if <[type]> == shooter:
      - playeffect effect:soul at:<[location]> quantity:<util.random.int[1].to[3]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playeffect effect:item_crack special_data:brown_concrete at:<[location]> quantity:<util.random.int[5].to[12]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - random:
        - playeffect effect:block_crack special_data:nether_wart_block at:<[location].above[1]> quantity:<util.random.int[1].to[5]> offset:1,1.5,1 velocity:0,<util.random.decimal[1].to[3]>,0 visibility:100
        - playeffect effect:block_crack special_data:fire_coral_block at:<[location].above[1]> quantity:<util.random.int[1].to[5]> offset:1,1.5,1 velocity:0,<util.random.decimal[1].to[3]>,0 visibility:100
        - playeffect effect:block_crack special_data:red_stained_glass at:<[location].above[1]> quantity:<util.random.int[1].to[5]> offset:1,1.5,1 velocity:0,<util.random.decimal[1].to[3]>,0 visibility:100
      - random:
        - playeffect effect:smoke at:<[location]> quantity:<util.random.int[3].to[9]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:smoke_normal at:<[location]> quantity:<util.random.int[2].to[6]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:smoke_large at:<[location]> quantity:<util.random.int[1].to[3]> offset:1,1,1 velocity:0,0.01,0 visibility:100
        - playeffect effect:soul_fire_flame at:<[location]> quantity:<util.random.int[1].to[3]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
        - playeffect effect:flame at:<[location]> quantity:<util.random.int[1].to[3]> offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playsound sound:block_campfire_crackle <[location]> pitch:<util.random.decimal[1.5].to[1.9]> volume:0.12 sound_category:blocks
      - playsound sound:BLOCK_POINTED_DRIPSTONE_DRIP_WATER_INTO_CAULDRON <[location]> pitch:<util.random.decimal[0.8].to[1.9]> volume:0.1 sound_category:blocks
      - playsound sound:particle_soul_escape <[location]> pitch:<util.random.decimal[0.5].to[1.9]> volume:0.2 sound_category:blocks
      #- playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <[location].find_players_within[1].exclude[<player>]> volume:0.4 sound_category:blocks
    # - else:
    #   - playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <[location].find_players_within[1]> volume:0.4 sound_category:blocks
