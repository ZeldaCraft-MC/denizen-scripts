Builds_events:
    type: world
    debug: false
    events:
        on player right clicks spruce_door in:tp_house_1_outside:
            - determine passively cancelled
            - teleport <player> tp_inside_1_loc
        on player right clicks spruce_door in:tp_house_1_inside:
            - determine passively cancelled
            - teleport <player> tp_outside_1_loc
        on player right clicks *door in:tp_fishing_entrance:
          - if !<player.has_flag[gm_debug]>:
            - determine cancelled
        on player right clicks *trapdoor in:tp_fishing_hole:
          - if !<player.has_flag[gm_debug]>:
            - determine cancelled
        on player right clicks item_frame in:tp_fishing_hole:
          - if !<player.has_flag[gm_debug]>:
            - determine cancelled
        on player breaks hanging in:tp_fishing_hole:
          - if !<player.has_flag[gm_debug]>:
            - determine cancelled
        on player right clicks armor_stand in:tp_fishing_hole:
            - determine cancelled
        on player damages armor_stand in:tp_fishing_hole:
            - determine cancelled
        on player breaks lily_pad in:tp_fishing_hole:
            - determine cancelled
        on vehicle collides with lily_pad in:tp_fishing_hole:
            - determine cancelled
        on player takes item from lectern in:vday_winners:
            - determine cancelled
        on player shoots block in:clocktown_balloon:
          - remove <context.projectile>
          - modifyblock <cuboid[clocktown_balloon].blocks> air
          - modifyblock clocktown_ladder_replace ladder[direction=west]
          - wait 30s
          - if !<schematic.list.contains[clowcktown_balloon]>:
            - schematic load name:clocktown_balloon
          - teleport <cuboid[clocktown_balloon].players> clocktown_balloon_origin
          - schematic paste name:clocktown_balloon <location[clocktown_balloon_origin]> noair
        on player right clicks armor_stand in:clocktown_sewers:
            - determine cancelled
        on player damages armor_stand in:clocktown_sewers:
            - determine cancelled
        on player right clicks *trapdoor in:clocktown_sewers:
            - determine cancelled
        on player right clicks item_frame in:clocktown_sewers:
          - if !<player.has_flag[gm_debug]>:
            - determine cancelled
        on player breaks hanging in:clocktown_sewers:
            - determine cancelled
        on player right clicks *door in:inside_milkbardoor:
            - determine passively cancelled
            - teleport <player> outside_milkbar
        on player right clicks *door in:outside_milkbardoor:
            - determine passively cancelled
            - teleport <player> milkbar
        after player enters zora_domain_exit:
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> lakehylia_entrance
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_out custom pitch:1 volume:0.8
        after player enters lakehylia_exit:
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> zora_domain_entrance
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_in custom pitch:1 volume:0.8
        after player enters zora_river_exit:
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> kokiri_river_entrance
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_out custom pitch:1 volume:0.8
        after player enters kokiri_river_exit:
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> zora_river_entrance
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_in custom pitch:1 volume:0.8
        on player right clicks *door in:ordon_link_door:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_link_inside
        on player right clicks *door in:ordon_link_door_inside:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_link_outside
        on player right clicks *door in:ordon_house_1_inside_door:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_1_outside
        on player right clicks *door in:ordon_house_1_outside_door:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_1_inside
        on player right clicks *door in:ordon_house_2_inside_door:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_2_outside
        on player right clicks *door in:ordon_house_2_outside_door:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_2_inside
        on player right clicks *door in:ordon_house_3_inside_door:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_3_outside
        on player right clicks *door in:ordon_house_3_outside_door:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_3_inside
        on player right clicks *door in:ordon_house_4_inside_door:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_4_outside
        on player right clicks *door in:ordon_house_4_outside_door:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> ordon_house_4_inside
        after player enters lost_woods_wrong_*:
            - determine passively cancelled
            - title title:<&chr[f024]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> lost_woods_wrong_exit
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_out custom pitch:1 volume:0.8
        after player enters lost_woods_correct_*:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> lost_woods_correct_exit_<context.area.note_name.after[lost_woods_correct_]>
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_in custom pitch:1 volume:0.8
        after player enters sacred_meadow_entrance_area:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> sacred_meadow_exit_1
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_out custom pitch:1 volume:0.8
        after player enters sacred_meadow_exit_area:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> sacred_meadow_entrance_1
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_in custom pitch:1 volume:0.8
        after player enters sacred_meadow_ff_entrance_area:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> sacred_meadow_ff_entrance
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_out custom pitch:1 volume:0.8
        after player enters sacred_meadow_ff_exit_area:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> sacred_meadow_ff_exit
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_in custom pitch:1 volume:0.8
        on player enters skyloft_ladder_fix_area:
          - modifyblock <location[skyloft_ladder_fix]> redstone_block
        on player exits skyloft_ladder_fix_area:
          - modifyblock <location[skyloft_ladder_fix]> air
        after player enters skyloft_music_start:
          - stop
          - if <player.has_flag[playing_skyloft]>:
            - stop
          - while <player.is_online> && <player.location.is_within[<cuboid[skyloft]>]>:
            - adjust <player> stop_sound:music
            - playsound sound:zc_sfx.music.skyloft custom <player.location> volume:20 players:<player> sound_category:music
            ##- playsound sound:zc_sfx.halloween.palace_of_twilight custom <player.location> volume:1 players:<player> sound_category:music
            - flag <player> playing_skyloft duration:3.5m
            - wait 3.5m
            ##- flag <player> playing_skyloft duration:3.35m
            ##- wait 3.35m
        # after player enters hallow2021_kakariko:
        #   - if <player.has_flag[playing_shadowtemple]>:
        #     - stop
        #   - while <player.is_online> && <player.location.is_within[<cuboid[hallow2021_kakariko]>]>:
        #     - adjust <player> stop_sound:music
        #     - wait 1t
        #     - playsound sound:zc_sfx.halloween.shadow_temple custom <player.location> volume:1 players:<player> sound_category:music
        #     - flag <player> playing_shadowtemple duration:3.04m
        #     - wait 3.04m
        # after player enters hallow2021_lonlon:
        #   - if <player.has_flag[playing_aliens]>:
        #     - stop
        #   - while <player.is_online> && <player.location.is_within[<cuboid[hallow2021_lonlon]>]>:
        #     - adjust <player> stop_sound:music
        #     - wait 1t
        #     - playsound sound:zc_sfx.halloween.aliens_attack custom <player.location> volume:1 players:<player> sound_category:music
        #     - flag <player> playing_aliens duration:1.04m
        #     - wait 1.04m
        # after player enters hallow2021_zorasriver:
        #   - if <player.has_flag[playing_ghost_ship]>:
        #     - stop
        #   - while <player.is_online> && <player.location.is_within[<cuboid[hallow2021_zorasriver]>]>:
        #     - adjust <player> stop_sound:music
        #     - wait 1t
        #     - playsound sound:zc_sfx.halloween.ghost_ship custom <player.location> volume:1 players:<player> sound_category:music
        #     - flag <player> playing_ghost_ship duration:1.56m
        #     - wait 1.56m
        # after player enters hallow2021_animal_village:
        #   - if <player.has_flag[playing_face_shrine]>:
        #     - stop
        #   - while <player.is_online> && <player.location.is_within[<cuboid[hallow2021_animal_village]>]>:
        #     - adjust <player> stop_sound:music
        #     - wait 1t
        #     - playsound sound:zc_sfx.halloween.face_shrine custom <player.location> volume:1 players:<player> sound_category:music
        #     - flag <player> playing_face_shrine duration:5.10m
        #     - wait 5.10m
        # after player enters hallow2021_castletown:
        #   - if <player.has_flag[playing_lost_woods]>:
        #     - stop
        #   - while <player.is_online> && <player.location.is_within[<cuboid[hallow2021_castletown]>]>:
        #     - adjust <player> stop_sound:music
        #     - wait 1t
        #     - playsound sound:zc_sfx.halloween.st_lost_woods custom <player.location> volume:1 players:<player> sound_category:music
        #     - flag <player> playing_lost_woods duration:1.05m
        #     - wait 1.05m
        # after player enters hallow2021_clocktown:
        #   - if <player.has_flag[playing_song_of_healing]>:
        #     - stop
        #   - while <player.is_online> && <player.location.is_within[<cuboid[hallow2021_clocktown]>]>:
        #     - adjust <player> stop_sound:music
        #     - wait 1t
        #     - playsound sound:zc_sfx.halloween.song_of_healing custom <player.location> volume:1 players:<player> sound_category:music
        #     - flag <player> playing_song_of_healing duration:2.46m
        #     - wait 2.46m
        on player flagged:playing_skyloft changes world:
          - flag <player> playing_skyloft:!
        #on player enters sshd_celeb:
        #  - ratelimit <player> 10s
        #  - playsound sound:zc_sfx.ss.zss_fanfare_item custom <player.location> volume:20 players:<player> sound_category:blocks
        #  - repeat 3:
        #    - firework <cuboid[sshd_celeb].spawnable_blocks[grass_block].random> power:0.02 <list[ball|star|burst].random> primary:yellow fade:<list[white|aqua].random>
        #    - wait 0.6s
        #    - animate <npc[2076]> arm_swing
        #    - adjust <npc[2077]> set_sneaking:true
        #    - teleport <npc[1823]> <location[link_loc].add[0,1,0]>
        #    - animate <npc[1823]> arm_swing_offhand
        #  - adjust <npc[2077]> set_sneaking:false
        after player enters av_entrance_rabbit:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_exit_rabbit_loc
        after player enters av_exit_rabbit:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_entrance_rabbit_loc
        after player enters av_entrance_painter:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_exit_artist_loc
        after player enters av_exit_artist:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_entrance_painter_loc
        after player enters av_entrance_bear:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_exit_bear_loc
        after player enters av_exit_bear:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_entrance_bear_loc
        after player enters av_entrance_zora:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_exit_zora_loc
        after player enters av_exit_zora:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_entrance_zora_loc
        after player enters av_entrance_christine:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_exit_christine_loc
        after player enters av_exit_christine:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_entrance_christine_loc
        after player enters av_entrance_credits:
            - determine passively cancelled
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_exit_credits_loc
        after player enters av_exit_credits:
            - determine passively cancelled
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> av_entrance_credits_loc
# new ordon
        on player right clicks *door in:no_link_door_o:
          - determine passively cancelled
          - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_link_door_i_l
        on player right clicks *door in:no_link_door_i:
          - determine passively cancelled
          - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_link_door_o_l
        on player right clicks *door in:no_shop_door_o:
          - determine passively cancelled
          - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_shop_door_i_l
        on player right clicks *door in:no_shop_door_i:
          - determine passively cancelled
          - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_shop_door_o_l
        on player right clicks *door in:no_mayor_door_o:
          - determine passively cancelled
          - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_mayor_door_i_l
        on player right clicks *door in:no_mayor_door_i:
          - determine passively cancelled
          - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_mayor_door_o_l
        on player right clicks *door in:no_parents_door_o:
          - determine passively cancelled
          - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_parents_door_i_l
        on player right clicks *door in:no_parents_door_i:
          - determine passively cancelled
          - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_parents_door_o_l
        on player right clicks *door in:no_colin_door_o:
          - determine passively cancelled
          - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_colin_door_i_l
        on player right clicks *door in:no_colin_door_i:
          - determine passively cancelled
          - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_colin_door_o_l
        after player enters no_crawl_1:
          - ratelimit <player> 2t
          - if <player.location.direction> == south && !<context.from.is_in[no_crawl_tunnel]>:
            - teleport <player> <location[no_crawl_block_1]>
            - cast speed 4 no_ambient no_icon hide_particles duration:1h
        after player enters no_crawl_2:
          - ratelimit <player> 2t
          - if <player.location.direction> == west && !<context.from.is_in[no_crawl_tunnel]>:
            - teleport <player> <location[no_crawl_block_2]>
            - cast speed 4 no_ambient no_icon hide_particles duration:1h
        on player exits no_crawl_tunnel:
          - cast speed remove
        on player quits:
          - if <player.vehicle.has_flag[ordon_epona]||false>:
            - mount cancel <player>
        on player enters no_fog:
          - if <context.entity.is_player>:
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
          - wait 5t
          - teleport <context.entity> no_fog_respawn
        #on horse enters no_fog:
        #  - wait 5t
        #  - teleport <context.entity> no_fog_respawn
        on player enters no_credits_i:
          - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
          - wait 3t
          - teleport <player> no_credits_o_l
        # on player exits vehicle:
        #   - define epona <context.vehicle>
        #   - flag <[epona]> epona_cooldown duration:2m
        #   - if <[epona].has_flag[ordon_epona]||false>:
        #     - wait 5m
        #     - chunkload <[epona].location.chunk> duration:1m
        #     - wait 5t
        #     - if !<[epona].has_passenger||false> && !<[epona].has_flag[epona_cooldown]>:
        #       - teleport <[epona]> ordon_epona_respawn
        #       - flag <[epona]> epona_cooldown:!
        # on horse despawns:
        #   - if <context.entity.has_flag[ordon_epona]||false>:
        #     - determine passively cancelled
        #     - teleport <context.entity> ordon_epona_respawn
        on player shoots bee_nest location_flagged:no_beehive with:arrow:
          - modifyblock <location[no_beehive_fall].above[6]> air
          - spawn falling_block[fallingblock_type=<material[bee_nest[direction=EAST]]>] <context.location.center>
          - remove <context.projectile>
          - wait 1s
          - modifyblock no_beehive_fall air
          - spawn bee[anger=5m]|bee[anger=5m]|bee[anger=5m] <location[no_beehive_fall].add[1,6,0]> save:bees
          - attack <entry[bees].spawned_entities> target:<player>
          - wait 1m
          - modifyblock <location[no_beehive_fall].above[6]> bee_nest[direction=east]
          - remove <entry[bees].spawned_entities>
        # on goat exits no_goat_ranch:
        #   - determine passively cancelled
        #   - push <context.entity> origin:<context.entity.location.add[0,0,1]> destination:<location[no_goat_center]> speed:0.3
        on player right clicks goat in:no_goat_ranch:
          - determine passively cancelled
#clocktown
        after player enters clocktown_playground_entrance:
            - title title:<&chr[f020]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - teleport <player> clocktown_playground_exit_loc
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_out custom pitch:1 volume:0.8
        after player enters clocktown_playground_exit:
            - cast levitation duration:4s hide_particles no_ambient no_icon
            - wait 4s
            - title title:<&chr[f021]> stay:2t fade_out:1s fade_in:3t
            - wait 3t
            - shoot <player> origin:<location[clocktown_playground_entrance_loc]> destination:<location[clocktown_playground_entrance_loc].add[2,4,-2]>
            - playsound <player> sound:zc_sfx.oot.oot_warp_portal_in custom pitch:1 volume:0.8
        after entity exits entity_tether_*:
          - if !<context.entity.has_flag[tether_location]>:
            - stop
          - ratelimit <context.entity> 1s
          - define te <context.entity>
          - flag <[te]> tethered_respawn duration:4.5m
          - wait 5m
          - chunkload <[te].location.chunk> duration:1m
          - wait 5t
          - if !<[te].has_passenger||false> && !<[te].has_flag[tethered_respawn]>:
              - teleport <[te]> <[te].flag[tether_location]>
              - flag <[te]> tethered_respawn:!
        on player exits vehicle:
          - if !<context.vehicle.has_flag[tether_location]>:
            - stop
          - define te <context.vehicle>
          - flag <[te]> tethered_respawn duration:4.5m
          - wait 5m
          - chunkload <[te].location.chunk> duration:1m
          - wait 5t
          - if !<[te].has_passenger||false> && !<[te].has_flag[tethered_respawn]>:
              - teleport <[te]> <[te].flag[tether_location]>
              - flag <[te]> tethered_respawn:!
        on entity despawns:
          - if !<context.entity.has_flag[tether_location]>:
            - stop
          - determine passively cancelled
          - chunkload <context.entity.location.chunk> duration:1m
          - wait 5t
          - teleport <context.entity> <context.entity.flag[tether_location]>


