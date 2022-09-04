spawn_events:
    type: world
    debug: false
    events:
        on player enters bomb_demo_loc:
        - foreach <context.area.entities[armor_stand]>:
            - if <[value].has_flag[spawn_bombs]||false> && <[value].equipment.get[4].custom_model_data||false> == 100:
                - playsound sound:zc_sfx.tp.tp_bomb_fuse_loop custom <[value].location> volume:0.6
                - playeffect <[value].location.add[0,0.2,0]> effect:smoke visibility:20 quantity:10 offset:0.05,0.3,0.05
                - adjust <[value]> equipment:air|air|air|clay_ball[custom_model_data=300]
                # - if <context.projectile||null> != null:
                #     - remove <context.projectile>
        - wait 1.2s
        - foreach <context.area.entities[armor_stand]>:
            - if <[value].has_flag[spawn_bombs]||false> && <[value].equipment.get[4].custom_model_data||false> == 300:
                - adjust <[value]> equipment:air|air|air|clay_ball[custom_model_data=100]
        on player enters beedle_shop:
        - playsound sound:zc_sfx.ww.ww_beedle_ohhh custom <player> volume:0.6
        on player exits beedle_shop:
        - playsound sound:zc_sfx.ww.ww_beedle_bye custom <player> volume:0.6
        after player joins:
        - playsound sound:zc_sfx.botw.botw_interact_sound custom <server.online_players> volume:0.1 sound_category:players
        on player quit:
        - playsound sound:zc_sfx.alttp.lttp_savequit custom <server.online_players> volume:0.1 sound_category:players
        on resource pack status status:SUCCESSFULY_LOADED:
        - playsound <player> sound:zc_sfx.botw.botw_interact_sound custom volume:0.4 sound_category:players
        # after player enters skyloft_music_start:
        # - teleport <player> xmas_skyloft
        # after player enters skyloft_shops:
        # - teleport <player> xmas_spawn_shops
        # after player enters xmas_spawn_gate:
        # - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
        # - wait 3t
        # - teleport <player> xmas_spawn_tree
        # after player enters xmas_spawn_igloo:
        # - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
        # - wait 19t
        # - teleport <player> xmas2021_tut
        on entity breaks hanging in:skyloft_xmas2021:
        - if <context.breaker.is_player>:
            - if <player.has_permission[op]>:
                - stop
        - determine cancelled
        on projectile hits item_frame in:skyloft_xmas2021:
        - determine cancelled
