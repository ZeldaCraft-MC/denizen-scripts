april_fools_events:
  type: world
  debug: false
  events:
    # on delta time minutely:
    #     - if <cuboid[fools_spawn].players.size> >= 1:
    #         - foreach <cuboid[fools_spawn].players>:
    #             - if <[value].has_flag[fools_gold_cooldown]>:
    #                 - foreach next
    #             - drop fools_gold <cuboid[<[value].location.add[-50,-3,-50]>|<[value].location.add[50,6,50]>].spawnable_blocks.random> delay:5s save:gold
    #             - adjust <entry[gold].dropped_entity> hide_from_players:<server.online_players>
    #             - flag <[value]> fools_gold_cooldown duration:<util.random.int[1].to[2]>m
    # on delta time secondly:
    #     - if <cuboid[fools_spawn].players.size> >= 1:
    #         - foreach <cuboid[fools_spawn].players> as:p:
    #             - if <[p].location.find.entities[dropped_item].within[50].filter[item.scriptname.is[==].to[fools_gold]].size> >= 1:
    #                 - foreach <[p].location.find.entities[dropped_item].within[50].filter[item.scriptname.is[==].to[fools_gold]]> as:gold:
    #                     - if <[p].has_flag[mmm_cooldown_<[gold]>]>:
    #                         - foreach next
    #                     - playsound sound:zc_sfx.fools.mmmmmm-converted custom <[gold].as_entity.location.center> pitch:<util.random.decimal[0.9].to[1.1]> volume:<element[1].sub[<[p].location.distance[<[gold].location>].div[19]>]> sound_category:blocks
    #                     - playeffect effect:fireworks_spark at:<[p].location.find.entities[dropped_item].within[50].filter[item.scriptname.is[==].to[fools_gold]].parse[location.center]> quantity:<util.random.int[1].to[3]> offset:0.2,0.5,0.2 targets:<[p]>
    #                     - if <element[1].sub[<[p].location.distance[<[gold].location>].div[15]>]> >= 0.8:
    #                         - flag <[p]> mmm_cooldown_<[gold]> duration:<util.random.decimal[0.3].to[0.8]>s
    #                     - else if <element[1].sub[<[p].location.distance[<[gold].location>].div[15]>]> >= 0.5:
    #                         - flag <[p]> mmm_cooldown_<[gold]> duration:<util.random.int[1].to[3]>s
    #                     - else:
    #                         - flag <[p]> mmm_cooldown_<[gold]> duration:<util.random.int[2].to[5]>s
    on player enters fools_pipe_2:
      - ratelimit <player> 1s
      - playsound sound:zc_sfx.fools.super-mario-bros-converted custom <location[fools_pipe_exit_2]> pitch:1 volume:1 sound_category:master
      - shoot <player> origin:<location[fools_pipe_exit_1]> destination:<location[fools_pipe_exit_1].sub[0,0,25]>
      - wait 0.s
      - playsound sound:zc_sfx.fools.super-mario-bros-converted custom <location[fools_pipe_exit_1]> pitch:1 volume:0.9 sound_category:master
    on player enters fools_pipe_1:
      - ratelimit <player> 1s
      - playsound sound:zc_sfx.fools.super-mario-bros-converted custom <location[fools_pipe_exit_1]> pitch:1 volume:1 sound_category:master
      - shoot <player> origin:<location[fools_pipe_exit_2]> destination:<location[fools_pipe_exit_2].add[<util.random.int[-20].to[20]>,10,<util.random.int[-20].to[20]>]>
      - wait 0.5s
      - playsound sound:zc_sfx.fools.super-mario-bros-converted custom <location[fools_pipe_exit_2]> pitch:1 volume:0.9 sound_category:master
    #after player enters fools_spawn:
    #    - adjust <player.as_player> resource_pack:https://download.mc-packs.net/pack/9e59cc8a9b673ae027e08acf3427034c1c5277a0.zip|9e59cc8a9b673ae027e08acf3427034c1c5277a0
    #    - wait 10s
    #    - adjust <player> stop_sound:music
    #    - playsound sound:zc_sfx.music.groose_theme custom <location[groose_sound_orig]> <player> pitch:1 volume:15 sound_category:music
    on player damaged:
      - if <util.random.int[1].to[5]> >= 5:
        - random:
          - playsound sound:zc_sfx.fools.classic_hurt-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
          - playsound sound:zc_sfx.fools.roblox-death-sound_1-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
    on player dies in:fools_spawn:
      - if <context.cause> == lava:
        - playsound sound:zc_sfx.fools.hektan_dies custom <player.location> pitch:1 volume:0.9 sound_category:master
        - stop
      - random:
        # - playsound sound:zc_sfx.fools.die-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
        - playsound sound:zc_sfx.loz.loz_link_die custom <player.location> pitch:1 volume:0.9 sound_category:master
        - playsound sound:zc_sfx.fools.you_must_die custom <player.location> pitch:1 volume:0.9 sound_category:master
    # on player enters skyloft:
    #     - wait 5t
    #     - teleport <player> <location[fools_spawn_loc]>
    on player enters fools_spawn:
      - title title:<&chr[f021]> "subtitle:<red>GET FOOLED!" stay:1t fade_out:1s fade_in:1t targets:<player>
      - wait 1.2s
      - title "title:<red>GET FOOLED!" "subtitle:<gold>Sounds on, Gamer!" stay:3s fade_out:2s fade_in:1s targets:<player>
    on player enters pickle_rick:
      - playsound sound:zc_sfx.fools.pickle_rick-converted custom <player> pitch:1 volume:10 sound_category:master
    # on player joins:
    # - wait 2s
    # - playsound sound:zc_sfx.ww.ww_beedle_ohhh custom <player.location> volume:1
    on player quits:
      - adjust <player> vision
    # - playsound sound:zc_sfx.ww.ww_beedle_bye custom <player.location> volume:1
    after player jumps in:fools_spawn:
      - playsound sound:zc_sfx.fools.maro-jump-converted custom <player.location> volume:0.04
    on player toggles sneaking in:choco_chimp:
      - if <util.random.int[1].to[15]> >= 13:
        - random:
          - playsound sound:zc_sfx.fools.mmm-monkey-converted custom <player.location> volume:0.8
          - playsound sound:zc_sfx.fools.the-monkey-converted custom <player.location> volume:0.8
    on player enters fools_caff_portal:
      - teleport <player> grooseland
      - adjust <player> vision:enderman
      - playsound sound:zc_sfx.fools.anime-wow-converted custom <player.location> volume:0.8
      - wait 1s
      - adjust <player> stop_sound:music
      - playsound sound:zc_sfx.music.silly_groose custom <player> pitch:1 volume:200 sound_category:music
      - wait 5m
      - adjust <player> vision
    #on player exits fools_spawn:
    #    - adjust <player> vision
    #    - adjust <player.as_player> resource_pack:https://download.mc-packs.net/pack/e8555875c1470b1384f1fec8070eb30aecc6ff56.zip|e8555875c1470b1384f1fec8070eb30aecc6ff56
    on player enters vip_caff_portal:
      - teleport <player> caff_portal_spawn_exit
    on player enters spawn_caff_portal:
      - teleport <player> caff_portal_vip_exit
    on player damages armor_stand in:sus_button:
      - determine cancelled
    on player right clicks armor_stand in:sus_button:
      - determine passively cancelled
      - ratelimit <player.location.find_entities[player].within[20]> 1.15m
      - playsound sound:zc_sfx.music.when_the_imposter_is_sus custom <player.location> volume:4
    on player enters battle_bus:
      - adjust <player> stop_sound:music
      - playsound sound:zc_sfx.music.chug_jug custom <player> pitch:1 volume:2 sound_category:music
    after player enters rave_box:
      - if <cuboid[rave_box].players.size> > 1:
        - stop
      - while <cuboid[rave_box].players.size> >= 1:
        - define ravers <cuboid[rave_box].players>
        - adjust <player> stop_sound:music
        - title "title:<gold>CRAB RAVE" "subtitle:TURN UP YOUR MUSIC!" targets:<[ravers]> stay:3s
        - playsound sound:zc_sfx.fools.crab_rave-converted custom <cuboid[rave_box].center> <[ravers]> pitch:1 volume:2 sound_category:music
        - wait 1s
        - modifyblock <location[rave_glass]> red_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> blue_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> lime_stained_glass
        - wait 1s
        - title title:<&chr[f024]> stay:1t fade_out:1s fade_in:1s targets:<[ravers]>
        - modifyblock <location[rave_glass]> yellow_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> purple_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> green_stained_glass
        - wait 1s
        - title title:<&chr[f024]> stay:1t fade_out:1s fade_in:1s targets:<[ravers]>
        - modifyblock <location[rave_glass]> light_blue_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> pink_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> blue_stained_glass
        - wait 1s
        - title title:<&chr[f024]> stay:1t fade_out:1s fade_in:1s targets:<[ravers]>
        - modifyblock <location[rave_glass]> yellow_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> red_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> orange_stained_glass
        - wait 1s
        - title title:<&chr[f024]> stay:1t fade_out:1s fade_in:1s targets:<[ravers]>
        - modifyblock <location[rave_glass]> purple_stained_glass
        - wait 1s
        - modifyblock <location[rave_glass]> yellow_stained_glass
        - wait 1s
    #on player enters choco_chimp:
    #    - playsound sound:zc_sfx.fools.goback-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
    #    - wait 1.5s
    #    - playsound sound:zc_sfx.fools.return_to_monke-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
    #    - adjust <player> skin:monkey
    #after player exits choco_chimp:
    #    - adjust <player> skin:<player.name>
    on player enters amogus:
      - random:
        - playsound sound:zc_sfx.fools.amogus-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
        - playsound sound:zc_sfx.fools.among_us_kill-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
        - playsound sound:zc_sfx.fools.among-us-converted custom <player.location> pitch:1 volume:0.9 sound_category:master
        - playsound sound:zc_sfx.fools.report_bobdy-converted custom <player.location> pitch:1 volume:0.9 sound_category:master

morshu_assignment:
  type: assignment
  debug: false
  actions:
    on assignment:
    - trigger name:click state:true
  interact scripts:
  - morshu_int

morshu_int:
  type: interact
  debug: false
  steps:
    1:
      click trigger:
        script:
          - ratelimit <player> 7s
          - if <player.item_in_hand.script.name||null> == FOOLS_GOLD:
            - narrate "<gold>You want it?? It's YOURS my friend!" targets:<player>
            - playsound sound:zc_sfx.fools.you-want-it-converted custom <player> volume:0.2
            - take scriptname:fools_gold quantity:1
            - wait 5s
            - if <util.random.int[1].to[100]> <= 80:
              - playeffect effect:cloud quantity:<util.random.int[10].to[20]> offset:0.1,0.2,0.7 <location[morshu_prize_loc]>
              - random:
                - playsound sound:zc_sfx.fools.dry-fart-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart_1-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart_2-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart_direction-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart3-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart-meme-sound-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart-squeak-01-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart-with-reverb-converted custom <player> volume:10
                - playsound sound:zc_sfx.fools.fart-with-extra-reverb-converted custom <player> volume:10
                - playsound sound:zc_sfx.fools.perfect-fart-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.sory_i_farted-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart-squeak-01-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.fart-with-reverb-converted custom <player> volume:10
                - playsound sound:zc_sfx.fools.fart-with-extra-reverb-converted custom <player> volume:10
                - playsound sound:zc_sfx.fools.wet-fart_1-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.mario-meme-converted custom <player> volume:0.5
            - else:
              - random:
                - playsound sound:zc_sfx.fools.air-horn-sad-violin-preview-3-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.bruh-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.crab_rave-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.dinner_2-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.drip-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.ma_boi-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.spaghetti-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.swaggityswagger-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.well_excuse_me_princess-converted custom <player> volume:0.5
                - playsound sound:zc_sfx.fools.thanos-beatbox custom <player> volume:0.5
              - random:
                - drop dirt[display=Dirty<&sp>blocks] quantity:21 <location[morshu_prize_loc]>
                - drop lantern <location[morshu_prize_loc]>
                - drop potion[display=Lamp<&sp>Oil;color=<color[yellow]>;potion_effects=<list[awkward,false,false,<color[yellow]>]>] <location[morshu_prize_loc]>
                - drop lead[display=Rope] <location[morshu_prize_loc]>
                - drop bomb_item <location[morshu_prize_loc]>
                - drop soup_ladle <location[morshu_prize_loc]>
          - else:
            - narrate "<red>I'm sorry <player.name>, I can't GIVE credit. Come back when you got MMMMMM more fool's gold!" targets:<player>
            - playsound sound:zc_sfx.fools.mmmmmm-converted custom <player>

slippy_items:
  type: task
  debug: false
  script:
    - define item <util.random.int[1].to[<player.inventory.map_slots.size>]>
    - fakeitem air slot:<[item]> duration:<util.random.int[1].to[3]>m player_only
    - fakespawn dropped_item[item=<player.inventory.map_slots.get[<[item]>]>] location:<cuboid[<player.location.add[-3,1,-3]>|<player.location.add[3,1,3]>].spawnable_blocks.random> players:<player>
