xmas_prizes:
  type: world
  debug: false
  events:
    on player right clicks block with:Present_shooter using:either_hand:
        - ratelimit <player> 0.2s
        - if ( <player.cursor_on[5].has_inventory||false> || <player.cursor_on[5].material.name.contains_any_text[button|lever|door|sign|gate]||false> ):
          - stop
        - determine passively cancelled
        - itemcooldown player_head duration:0.1s
        - repeat 5:
            - shoot dropped_item[item=fake_present;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<player.location.above[0.8]> destination:<player.eye_location.ray_trace[range=10]||<player.location.above[0.8].forward[1]>> speed:<util.random.decimal[0.6].to[3]> spread:<util.random.decimal[5].to[8]> def:shooter script:del_present_prize
            - playsound sound:item_armor_equip_elytra pitch:<util.random.decimal[0.2].to[0.7]> at:<player.location> volume:0.2 sound_category:blocks
            - playsound sound:block_wool_place pitch:<util.random.decimal[0.1].to[0.5]> at:<player.location> volume:0.2 sound_category:blocks
            - wait 1t
    on player right clicks block with:infinite_snowball using:either_hand:
        - ratelimit <player> 2t
        - determine passively cancelled
        - itemcooldown snowball duration:2t
        - shoot snowball origin:<player.eye_location> destination:<player.eye_location.ray_trace[range=10]||<player.eye_location.forward[1]>> speed:<util.random.decimal[1.2].to[2]> spread:1 script:infinite_snowball_land
        - playsound sound:entity_snowball_throw pitch:<util.random.decimal[0.4].to[0.8]> at:<player.location> volume:0.5 sound_category:blocks
    on snowball breaks hanging:
      - determine cancelled
    on snowball damages item_frame:
      - determine cancelled
    on player places Present_shooter:
      - determine cancelled
    on player places Bokoblin_head|Moblin_head|Chilfos_head:
      - determine cancelled
    on player consumes reekfish|hyrule_bass:
      - determine cancelled
    on furnace smelts reekfish|hyrule_bass:
      - determine cancelled
    on inventory picks up fake_present:
      - determine cancelled
    on liquid spreads:
      - foreach <context.destination>:
        - if <[value].has_flag[xmas_present_loc]> || <[value].has_flag[xmas_bag_loc]> || <[value].has_flag[xmas_snow_loc]>:
          - determine cancelled
    on entity explodes:
      - determine <context.blocks.filter[has_flag[xmas_present_loc].not].filter[has_flag[xmas_bag_loc].not].filter[has_flag[xmas_snow_loc].not]>

    on player places xmas*prize:
      - ratelimit <player> 1t
      - if <context.item_in_hand.script.name||none> == xmas_present_prize:
        - flag <context.location> xmas_present_loc:5
      - if <context.item_in_hand.script.name||none> == xmas_present_bag_prize:
        - flag <context.location> xmas_bag_loc:5
      - if <context.item_in_hand.script.name||none> == xmas_snow_block_prize:
        - flag <context.location> xmas_snow_loc:5
    on dropped_item damaged:
      - if <context.entity.item.script.name||null> != null:
        - determine cancelled

    on player breaks player_head|player_wall_head:
      - ratelimit <player> 1t
      - if <context.location.has_flag[xmas_present_loc]>:
        - flag <context.location> xmas_present_loc:!
        - drop xmas_present_prize <context.location.center>
        - determine nothing
      - if <context.location.has_flag[xmas_bag_loc]>:
        - flag <context.location> xmas_bag_loc:!
        - drop xmas_present_bag_prize <context.location.center>
        - determine nothing
      - if <context.location.has_flag[xmas_snow_loc]>:
        - flag <context.location> xmas_snow_loc:!
        - drop xmas_snow_block_prize <context.location.center>
        - determine nothing

    on piston extends:
      - foreach <context.blocks>:
        - if <[value].has_flag[xmas_present_loc]> || <[value].has_flag[xmas_bag_loc]> || <[value].has_flag[xmas_snow_loc]>:
          - determine cancelled

    on block dispenses infinite_snowball:
      - determine cancelled

    on player picks up fake_present:
      - determine passively cancelled

    on player right clicks player_head|player_wall_head:
      - determine passively cancelled
      - ratelimit <player> 1t
      - if <context.location.has_flag[xmas_present_loc]>:
        - define loc xmas_present_loc
      - else if <context.location.has_flag[xmas_bag_loc]>:
        - define loc xmas_bag_loc
      - else if <context.location.has_flag[xmas_snow_loc]>:
        - define loc xmas_snow_loc
      - else:
        - determine CANCELLED:FALSE
      - if <player.is_sneaking>:
        - choose <context.location.flag[<[loc]>]>:
          - case 5:
            - define range 10
          - case 10:
            - define range 20
          - case 20:
            - define range 0
          - default:
            - define range 5
        - flag <context.location> <[loc]>:<[range]>
        - narrate "<gold>Particles Range: <green><[range]>" targets:<player>
        - stop
      - else:
        - choose <[loc]>:
          - case xmas_present_loc:
            - playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <context.location> sound_category:blocks
            - wait 2t
            - playsound sound:entity_pig_saddle pitch:1.5 volume:<util.random.decimal[0.1].to[0.4]> <context.location> sound_category:blocks
            - define lo <context.location>
            - define range <context.location.flag[<[loc]>]||5>
            - if <[range]> != 0:
              - ratelimit <player> 4s
              - repeat 20:
                - playeffect <[lo]> effect:cloud quantity:2 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.02,0 visibility:100
                - playeffect <[lo]> effect:end_rod quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.02,0 visibility:100
                - playeffect <[lo]> effect:BLOCK_CRACK special_data:ice quantity:3 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.01,0 visibility:100
                - playeffect <[lo]> effect:ITEM_CRACK special_data:snowball quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.03,0 visibility:100
                - playeffect <[lo]> effect:ITEM_CRACK special_data:snow_block quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:BLOCK_CRACK special_data:snow_block quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:snow_shovel quantity:5 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:falling_dust special_data:snow_block quantity:3 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.05,0 visibility:100
                - playeffect <[lo]> effect:spit quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:EXPLOSION_normal quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.01,0 visibility:100
                - playeffect <[lo]> effect:SPELL_INSTANT quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - wait 4t
          - case xmas_snow_loc:
            - playsound sound:block_snow_place pitch:<util.random.decimal[1.2].to[1.8]> <context.location> sound_category:blocks
            - define lo <context.location>
            - define range <context.location.flag[<[loc]>]||5>
            - if <[range]> != 0:
              - ratelimit <player> 1s
              - repeat 5:
                - playeffect <[lo]> effect:cloud quantity:2 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.02,0 visibility:100
                - playeffect <[lo]> effect:BLOCK_CRACK special_data:ice quantity:3 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.01,0 visibility:100
                - playeffect <[lo]> effect:ITEM_CRACK special_data:snowball quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.03,0 visibility:100
                - playeffect <[lo]> effect:ITEM_CRACK special_data:snow_block quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:BLOCK_CRACK special_data:snow_block quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:snow_shovel quantity:5 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:spit quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:EXPLOSION_normal quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.01,0 visibility:100
                - wait 4t
          - case xmas_bag_loc:
            - if <context.location.material.name> == player_head:
              - define o <context.location.center>
            - else:
              - define o <context.location.above.center>
            - define lo <context.location>
            - define range <context.location.flag[<[loc]>]||5>
            - ratelimit <player> 4s
            - repeat 20:
              - define offset <util.random.decimal[0.2].to[0.5]>
              - repeat <util.random.int[2].to[6]>:
                - shoot dropped_item[item=fake_present;pickup_delay=<util.int_max>;time_lived=4.98m] origin:<[o]> destination:<[o].add[0,<[offset].mul[2]>,0]> speed:<util.random.decimal[0.4].to[0.7]> spread:<util.random.decimal[15].to[30]> def:head script:del_present_prize
              - playeffect effect:fireworks_spark at:<[o]> quantity:3 offset:<[offset]>,1,<[offset]> velocity:<util.random.decimal[-0.2].to[0.2]>,<util.random.decimal[0.1].to[0.3]>,<util.random.decimal[-0.2].to[0.2]>
              - playsound sound:ENTITY_guardian_attack <context.location> pitch:0.7 volume:0.3 sound_category:blocks
              - if <[range]> != 0:
                - playeffect <[lo]> effect:cloud quantity:2 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.02,0 visibility:100
                - playeffect <[lo]> effect:end_rod quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.02,0 visibility:100
                - playeffect <[lo]> effect:BLOCK_CRACK special_data:ice quantity:3 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.01,0 visibility:100
                - playeffect <[lo]> effect:ITEM_CRACK special_data:snowball quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.03,0 visibility:100
                - playeffect <[lo]> effect:ITEM_CRACK special_data:snow_block quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:BLOCK_CRACK special_data:snow_block quantity:9 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:snow_shovel quantity:5 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:falling_dust special_data:snow_block quantity:3 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.05,0 visibility:100
                - playeffect <[lo]> effect:spit quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
                - playeffect <[lo]> effect:EXPLOSION_normal quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,-0.01,0 visibility:100
                - playeffect <[lo]> effect:SPELL_INSTANT quantity:1 offset:-<[range]>,<[range]>,<[range]> velocity:0,0,0 visibility:100
              - wait 4t
          - default:
            - stop

del_present_prize:
  debug: false
  type: task
  definitions: type
  script:
    - wait 1s
    - define location <[last_entity].location>
    - if <[type]> == shooter:
      - playeffect effect:snow_shovel at:<[location]> quantity:10 offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playeffect effect:end_rod at:<[location]> quantity:3 offset:0.5,1,0.5 velocity:0,0,0 visibility:100
      - playeffect effect:BLOCK_CRACK special_data:packed_ice at:<[location]> quantity:2 offset:1,1.5,1 velocity:0,0.05,0 visibility:100
      - playeffect effect:falling_dust special_data:snow_block at:<[location]> quantity:2 offset:1,1,1 velocity:0,0.01,0 visibility:100
      - playsound sound:ENTITY_PLAYER_LEVELUP <[location]> pitch:<util.random.decimal[1.4].to[1.9]> volume:0.01 sound_category:blocks
      - playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <[location].find_players_within[1].exclude[<player>]> volume:0.4 sound_category:blocks
    - else:
      - playsound sound:entity_puffer_fish_blow_up pitch:<util.random.decimal[1.2].to[1.8]> <[location].find_players_within[1]> volume:0.4 sound_category:blocks

infinite_snowball_land:
  debug: false
  type: task
  script:
    - playeffect effect:snow_shovel at:<[location]> quantity:10 offset:1,1.5,1 velocity:0,0.05,0 visibility:100
    - playeffect effect:BLOCK_CRACK special_data:packed_ice at:<[location]> quantity:10 offset:1,1.5,1 velocity:0,0.05,0 visibility:100
    - playeffect effect:BLOCK_CRACK special_data:snow_block at:<[location]> quantity:10 offset:1,1.5,1 velocity:0,0.05,0 visibility:100
    - playeffect effect:falling_dust special_data:snow_block at:<[location]> quantity:5 offset:1,1,1 velocity:0,0.01,0 visibility:100
    - cast slow <[hit_entities]> amplifier:0.1 duration:0.2s
    - playsound <[hit_entities]> sound:block_snow_break volume:0.8 pitch:0.8 sound_category:blocks

# claim_cmd:
#     type: command
#     name: claim
#     debug: flase
#     description: Claim your event rewards!
#     usage: /claim
#     script:
#     - ratelimit <player> 1s
#     - if !<list[s1|s2|s3|spawn].contains[<player.world.name>]||true> || <player.gamemode> != Survival:
#       - narrate "You must be in a survival world to claim these gifts"
#       - stop
#     - execute as_player "prefixes update"
#     - wait 5t
#     - define unlocks 0
#     - define won_scoreboard false
#     - define prizes <list[]>
#     - if !<player.has_flag[xmas2021_prizes]>:
#       - flag <player> xmas2021_prizes:<list[]>
#     - if <player.flag[contributed_presents]||0> >= 1:
#       - define prizes:->:<item[infinite_snowball]>
#       - define prizes:->:<item[jolly_cap].with[lore=<item[jolly_cap].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - if <server.flag[xmas_prize_list].contains[<player>]||false>:
#       - define pos <server.flag[xmas_prize_list].find[<player>]||100>
#       - define place <proc[xmas_place_formatter].context[<[pos]>]>
#       - if <[pos]> <= 2:
#         - define prizes:->:<item[xmas_present_bag_prize].with[lore=<item[xmas_present_bag_prize].lore><&1>Earned<&sp>by<&sp><&6><player.name><&1>,<&sp>who<&sp>came<&sp><bold><[place]><&sp><&1>in<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#       - if <[pos]> <= 6:
#         - define prizes:->:<item[xmas_present_prize].with[lore=<item[xmas_present_prize].lore><&1>Earned<&sp>by<&sp><&6><player.name><&1>,<&sp>who<&sp>came<&sp><bold><[place]><&sp><&1>in<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#       - if <[pos]> <= 11:
#         - define won_scoreboard true
#         - define prizes:->:<item[xmas_snow_block_prize].with[lore=<item[xmas_snow_block_prize].lore><&1>Earned<&sp>by<&sp><&6><player.name><&1>,<&sp>who<&sp>came<&sp><bold><[place]><&sp><&1>in<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - if <player.has_advancement[denizen:xmas2021_bokoblin4]>:
#       - define prizes:->:<item[bokoblin_head].with[lore=<item[bokoblin_head].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - else:
#       - define unlocks:++
#     - if <player.has_advancement[denizen:xmas2021_moblin4]>:
#       - define prizes:->:<item[moblin_head].with[lore=<item[moblin_head].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - else:
#       - define unlocks:++
#     - if <player.has_advancement[denizen:xmas2021_chilfos4]>:
#       - define prizes:->:<item[chilfos_head].with[lore=<item[chilfos_head].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - else:
#       - define unlocks:++
#     - if <player.has_advancement[denizen:xmas2021_reekfish2]>:
#       - define prizes:->:<item[reekfish].with[lore=<item[reekfish].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - else:
#       - define unlocks:++
#     - if <player.has_advancement[denizen:xmas2021_bass2]>:
#       - define prizes:->:<item[hyrule_bass].with[lore=<item[hyrule_bass].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
#     - else:
#       - define unlocks:++
#     - if <player.has_advancement[denizen:xmas2021_nice]> || <[won_scoreboard]>:
#       - define prizes:->:<item[Present_shooter]>
#     - else:
#       - define unlocks:++
#     - if <player.inventory.empty_slots> < <[prizes].exclude[<player.flag[xmas2021_prizes]>].size||1>:
#       - narrate "<red>You do not have enough space to claim all gifts, please come back with <bold><[prizes].size||1> empty slots" targets:<player>
#       - stop
#     - else:
#       - if <[prizes].size||0> >= 1:
#         - foreach <[prizes]>:
#           - if <player.flag[xmas2021_prizes].contains[<[value].display>]>:
#             - foreach next
#           - give <[value].as_item>
#           - flag <player> xmas2021_prizes:|:<[value].display>
#           - narrate "<yellow>You got a <gold><[value].display>!"
#         - wait 0.5s
#       - if <[unlocks]> == 0:
#         - narrate "<yellow><bold>Congratulations! <aqua>You've unlocked all available Christmas rewards! <light_purple>See you next year"
#         - stop
#       - if <[unlocks]> > 1:
#         - narrate "<aqua>You can still earn <bold><red><[unlocks]><aqua> more prizes by completing advancements, talk to buddy in Santa's grotto!"
#         - stop
#       - if <[unlocks]> == 1:
#         - narrate "<aqua>You can still earn <bold><red>one more<aqua> amazing prize by completing <bold><gold>all 68 <aqua>advancements, talk to buddy in Santa's grotto!"

xmas_place_formatter:
  type: procedure
  debug: false
  definitions: posi
  script:
    - if <[posi]> <= 2:
      - determine <&color[#FFD700]>1st
    - if <[posi]> == 3:
      - determine <&color[#C0C0C0]>2nd
    - if <[posi]> == 4:
      - determine <&color[#C0C0C0]>3rd
    - else:
      - determine <&color[#cd7f32]><[posi].sub[1]>th

xmas_claim_cmd:
    type: command
    name: xmas_claim
    debug: false
    description: Claim your event rewards!
    usage: /xmas_claim
    # permission: zc.xmas_claim
    script:
    # - narrate "This command is temporarily disabled, please try again later"
    # - if <player.name> != DCaff95:
    #   - stop
    - ratelimit <player> 1s
    - if <player.name> != DCaff95:
      - if !<list[s1|s2|spawn].contains[<player.world.name>]||true> || <player.gamemode> != Survival:
        - narrate "You must be in a survival world to claim these gifts"
        - stop
    - execute as_player "prefixes update"
    - wait 5t
    - define prizes <list[]>
    - if !<player.has_flag[xmas_claimed]>:
      - flag <player> xmas_claimed:<list[]>
    - if <player.flag[contributed_presents]||0> >= 1:
      - define prizes:->:<item[infinite_snowball]>
      - define prizes:->:<script[Xmas_data].data_key[rare_unlock_2].get[1]>
      - define prizes:->:<script[Xmas_data].data_key[rare_unlock_2].get[2]>
      - define prizes:->:<script[Xmas_data].data_key[rare_unlock_2].get[3]>
      - define prizes:->:<script[Xmas_data].data_key[rare_unlock_2].get[4]>
      - if !<player.has_flag[got_xmas_poster]>:
        - define prizes:->:<script[Xmas_data].data_key[rare_unlock_1].random>
        - flag <player> got_xmas_poster duration:200d
    #   - define prizes:->:<item[jolly_cap].with[lore=<item[jolly_cap].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
    - if <player.has_advancement[denizen:xmas2021_bokoblin4]>:
      - define prizes:->:<item[bokoblin_head].with[lore=<item[bokoblin_head].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
    - else:
      - define unlocks:++
    - if <player.has_advancement[denizen:xmas2021_moblin4]>:
      - define prizes:->:<item[moblin_head].with[lore=<item[moblin_head].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
    - else:
      - define unlocks:++
    - if <player.has_advancement[denizen:xmas2021_chilfos4]>:
      - define prizes:->:<item[chilfos_head].with[lore=<item[chilfos_head].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
    # - else:
    #   - define unlocks:++
    # - if <player.has_advancement[denizen:xmas2021_reekfish2]>:
    #   - define prizes:->:<item[reekfish].with[lore=<item[reekfish].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
    # - else:
    #   - define unlocks:++
    # - if <player.has_advancement[denizen:xmas2021_bass2]>:
    #   - define prizes:->:<item[hyrule_bass].with[lore=<item[hyrule_bass].lore><&1>Earned<&sp>as<&sp>part<&sp>of<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
    - else:
      - define unlocks:++
    # - if <player.has_advancement[denizen:xmas2021_nice]>:
    #   - define prizes:->:<item[Xmas_crown]>
    - else:
      - define unlocks:++
    - if <player.inventory.empty_slots> < <[prizes].exclude[<player.flag[xmas_claimed]>].include[<player.flag[xmas_earned_prizes]||<list[]>>].size||1>:
      - narrate "<red>You do not have enough space to claim all gifts, please come back with <bold><[prizes].include[<player.flag[xmas_earned_prizes]||<list[]>>].size||1> empty slots" targets:<player>
    - if <server.flag[xmas_prize_list].contains[<player>]||false> && !<player.has_flag[claimed_top_xmasp_2021]>:
      - define pos <server.flag[xmas_prize_list].find[<player>]||100>
      - define place <proc[xmas_place_formatter].context[<[pos]>]>
      - if <[pos]> <= 1:
        - define prizes:->:<item[xmas_present_bag_prize].with[lore=<item[xmas_present_bag_prize].lore><&1>Earned<&sp>by<&sp><&6><player.name><&1>,<&sp>who<&sp>came<&sp><bold><[place]><&sp><&1>in<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
      - if <[pos]> <= 5:
        - define prizes:->:<item[xmas_present_prize].with[lore=<item[xmas_present_prize].lore><&1>Earned<&sp>by<&sp><&6><player.name><&1>,<&sp>who<&sp>came<&sp><bold><[place]><&sp><&1>in<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
      - if <[pos]> <= 10:
        - define prizes:->:<item[xmas_snow_block_prize].with[lore=<item[xmas_snow_block_prize].lore><&1>Earned<&sp>by<&sp><&6><player.name><&1>,<&sp>who<&sp>came<&sp><bold><[place]><&sp><&1>in<&sp>the<&sp><&b>2021<&sp>Xmas<&sp>Event]>
      - flag <player> claimed_top_xmasp_2021
    - if <[prizes].size||0> >= 1:
      - foreach <[prizes]>:
        - if <player.inventory.empty_slots> <= 0:
          - stop
        - if <player.flag[xmas_claimed].contains[<[value].as[item].display>]>:
          - foreach next
        - give <[value].as[item]>
        - flag <player> xmas_claimed:|:<[value].as[item].display>
        - narrate "<yellow>You got a <gold><[value].as[item].display>!"
      - wait 0.5s
    - if <player.flag[xmas_earned_prizes].size||0> >= 1:
      - foreach <player.flag[xmas_earned_prizes]>:
        - if <[value].as[item].script.name> == frozen_hyrule_custom_record:
          - if <player.has_flag[got_frozen_hyrule]>:
            - foreach next
          - else:
            - flag <player> got_frozen_hyrule duration:200d
        - if <player.inventory.empty_slots> <= 0:
          - stop
        - give <[value].as[item]>
        - flag <player> xmas_earned_prizes:<-:<[value]>
        - narrate "<yellow>You got a <gold><[value].as[item].display>!"
      - wait 0.5s
    # - if <[unlocks]> == 0:
    #   - narrate "<yellow><bold>Congratulations! <aqua>You've unlocked all available Christmas rewards! <light_purple>See you next year"
    #   - stop
    # - if <[unlocks]> > 1:
    #   - narrate "<aqua>You can still earn <bold><red><[unlocks]><aqua> more prizes by completing advancements, talk to buddy in Santa's grotto!"
    #   - stop
    # - if <[unlocks]> == 1:
    #   - narrate "<aqua>You can still earn <bold><red>one more<aqua> amazing prize by completing <bold><gold>all 68 <aqua>advancements, talk to buddy in Santa's grotto!"

xmas_data:
  type: data
  debug: false
  textures:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNDA3ZDMyMjQxOWNhMGNjMTlmZmFiNzBkMTVhMTU0NTQ4MTM0YWEwMjEwNjdmN2NjMTBkYjUxN2EwMjc4Mzc4MiJ9fX0=
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTA5MTZmNjQzODQ3YjU2YmE2NGVhMjgzMzcxZjQ4OTU1ZDYyZmE0YTgxYmY3MzA1MDE3YWVlOGVlODIzOTlkIn19fQ==
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNGM5YjI5NGJhYzY5NmE3MmE4YjRmYzg5Y2M2ZDIwOTVlZTM3YTc3NzFiZjJjMzhkOWFkNTMyZGIyNDMzNDk0ZSJ9fX0=
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOWU5OGMwZTBkMzYxZDJlYTdhY2I2NzJkNGY3ZjhlZTJiZGFiMTNjZjRlMzgyOGE3ZGQ4NGNkY2NmYTZmNTA4MCJ9fX0=
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNmNlZjlhYTE0ZTg4NDc3M2VhYzEzNGE0ZWU4OTcyMDYzZjQ2NmRlNjc4MzYzY2Y3YjFhMjFhODViNyJ9fX0=
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMWI2NzMwZGU3ZTViOTQxZWZjNmU4Y2JhZjU3NTVmOTQyMWEyMGRlODcxNzU5NjgyY2Q4ODhjYzRhODEyODIifX19
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDA4Y2U3ZGViYTU2YjcyNmE4MzJiNjExMTVjYTE2MzM2MTM1OWMzMDQzNGY3ZDVlM2MzZmFhNmZlNDA1MiJ9fX0=
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYjNiYTdiYzhlM2MwOTNiZDQ4YzFmNzdiZjQ4ZTM1YmZhMGVhYzlhYjQ4ZDBhZDEzZWJkOWUzYzIyZjcxYWZhIn19fQ==
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTNjZmJmMmJkZmQ0ODUxNGJmYmFjZTk1MThjNzY2NDExMmRmMmMxNzNlOGM3YWQ5MmIzZTY1NjIxYTllZDZlMCJ9fX0=
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYmRhYzlhNTE4MTNhYmNiNjY2ZWUyYzJjYTg0Y2VmY2ZiMjFlNThiN2IwMWFlMGVhN2U5OWQzNWYzMjNhIn19fQ==
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOWY1YjUyYmRiMjU1NmZkN2Q0NmM1Yzg0OGEzOGM4YjhlZjE1M2FmZTdkNTZkYjE3NzZkOTliNTMzYmQwIn19fQ==
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2U4YzI0MmMwNTFjODk0MTk5Yzg1MTBkYWQ1YWFjZTk2YzJjNGNmMmUzNGY0ZTg1YThlMTg0NTgzMWVkNWVkIn19fQ==
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzJmMDQ4OWNhMTI2YTZlOWY5YWZhNTllYjQ5MWIxODUzMzk1YjU4MmI0NTRmYzJhZDQ4MDI3MjI2MjUyZDEyMSJ9fX0=
  bag_lore:
    - <&f><gold><player.flag[player_presents]||0> <red>Presents
    - <&f>Any presents you find will be added here
  santa:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTRlNDI0YjE2NzZmZWVjM2EzZjhlYmFkZTllN2Q2YTZmNzFmNzc1NmE4NjlmMzZmN2RmMGZjMTgyZDQzNmUifX19
  warp2:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOThkZGMzZmM5OGI5MjQ2NWY2MGI1YzgzZTc0YWJmZWI1YzNiMWQ5NDQ1YjkyNDIwNmZlMmMzYTNkMzFlYWI4NSJ9fX0=
  warp2b:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmIyMTYxN2QyNzU1YmMyMGY4ZjdlMzg4ZjQ5ZTQ4NTgyNzQ1ZmVjMTZiYjE0Yzc3NmY3MTE4Zjk4YzU1ZTgifX19
  warp3:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmU3MGJmNTdkNmYyNDI5NTY3NmRlMGFhODRmODM0NjkyYzQyZTJiMzcyNDRjYWY4NzY1NThjMjFjN2Q3Njc2ZSJ9fX0=
  warp4:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZWViZDJhNWM3NTFiN2M2OWE4NzIyY2Q0YzE1ZWFhY2ZiZjI0MWY3NzNkZTZlNDYzYjM1ZDM0YTM1NzAifX19
  warp5:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmM1MDk3OTE2YmMwNTY1ZDMwNjAxYzBlZWJmZWIyODcyNzdhMzRlODY3YjRlYTQzYzYzODE5ZDUzZTg5ZWRlNyJ9fX0=
  warp6:
    - eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjZlNDI5YzYwOTMyZWJjMzY2ZTc5MWE0MmUxODZhZjg4OGRlMDhlNWQ4ZWI4YWM2ZjViNmY0ZDQ0MGRiNDg2YyJ9fX0=
  shield_color:
    - BLACK
    - BLUE
    - BROWN
    - CYAN
    - GRAY
    - GREEN
    - LIGHT_BLUE
    - LIGHT_GRAY
    - LIME
    - MAGENTA
    - ORANGE
    - PINK
    - PURPLE
    - RED
    - WHITE
    - YELLOW
  shield_pattern:
    - BASE
    - BORDER
    - BRICKS
    - CIRCLE_MIDDLE
    - CREEPER
    - CROSS
    - CURLY_BORDER
    - DIAGONAL_LEFT
    - DIAGONAL_LEFT_MIRROR
    - DIAGONAL_RIGHT
    - DIAGONAL_RIGHT_MIRROR
    - FLOWER
    - GLOBE
    - GRADIENT
    - GRADIENT_UP
    - HALF_HORIZONTAL
    - HALF_HORIZONTAL_MIRROR
    - HALF_VERTICAL
    - HALF_VERTICAL_MIRROR
    - MOJANG
    - PIGLIN
    - RHOMBUS_MIDDLE
    - SKULL
    - SQUARE_BOTTOM_LEFT
    - SQUARE_BOTTOM_RIGHT
    - SQUARE_TOP_LEFT
    - SQUARE_TOP_RIGHT
    - STRAIGHT_CROSS
    - STRIPE_BOTTOM
    - STRIPE_CENTER
    - STRIPE_DOWNLEFT
    - STRIPE_DOWNRIGHT
    - STRIPE_LEFT
    - STRIPE_MIDDLE
    - STRIPE_RIGHT
    - STRIPE_SMALL
    - STRIPE_TOP
    - TRIANGLE_BOTTOM
    - TRIANGLE_TOP
    - TRIANGLES_BOTTOM
    - TRIANGLES_TOP
  firework_color:
    - white
    - yellow
    - purple
    - red
    - aqua
    - green
    - blue
    - gray
    - orange
    - lime
    - fuchsia
    - black
    - maroon
    - navy
    - olive
    - silver
    - teal
  rare_unlock_1:
    - paper[custom_model_data=13147;display_name=Breath of the Wild Poster]
    - paper[custom_model_data=13148;display_name=Ocarina of Time Poster]
    - paper[custom_model_data=13149;display_name=The Legend of Zelda Poster]
    - paper[custom_model_data=13150;display_name=Ghirahim & Fi Poster]
    - paper[custom_model_data=13151;display_name=A Link to the Past Poster]
    - paper[custom_model_data=13152;display_name=Twilight Princess Poster]
  rare_unlock_2:
    - paper[custom_model_data=13163;display_name=Santa Hat]
    - paper[custom_model_data=13164;display_name=Orange Santa Hat]
    - paper[custom_model_data=13165;display_name=Green Santa Hat]
    - paper[custom_model_data=13166;display_name=Blue Santa Hat]
