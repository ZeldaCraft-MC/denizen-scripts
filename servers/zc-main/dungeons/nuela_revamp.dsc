mplat_c:
  type: command
  debug: false
  name: mp
  description: summons / mannages moving platforms
  usage: /mp <&lt>spawn/select/positions<&gt>
  permission: op
  script:
    - if <player.name||greenleeuw> != greenleeuw:
      - narrate "Only greenleeuw has access to this command to prevent any damage being done"
      - narrate "moving platforms are very easy to break which leads to error spam in console"
      - narrate "the 10 error messages per tick kinda spam so don't try and get yourself able to perform this command"
      - stop
    - choose <context.args.first>:
      - case no_go:
        - choose <context.args.get[2]>:
          - case 1:
            - flag <server.flag[no_go.1]> no_go:go
      - case spawn:
        - define ent_loc <player.location.center>
        - inject spawn_mov_plat1
        - if <context.args.get[2]||null> == no_go:
          - flag <[mplat]> no_go:no
          - flag server no_go.<server.flag[no_go].size.add[1]||1>:<[mplat]>
        - narrate "Moving platform spawned. This one has automatically been selected for you!"
        - if <player.has_flag[mplat]>:
          - if <player.has_flag[mp_pos]>:
            - flag player mp_pos:!
          - glow <player.flag[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[2]>].include[<player.flag[mplat].passengers.get[2]>]> false
          - flag player mplat:!
        - flag player mplat:<[mplat]>
        - glow <[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[2]>].include[<[mplat].passengers.get[2]>]>
      - case select:
        - if <player.has_flag[mplat]>:
          - if <player.has_flag[mp_pos]>:
            - flag player mp_pos:!
          - glow <player.flag[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[2]>].include[<player.flag[mplat].passengers.get[2]>]> false
          - flag player mplat:!
        - if <player.target.vehicle.has_flag[plink]>:
          - define mplat <player.target.vehicle.flag[plink]>
        - if <player.target.vehicle.has_flag[mplink]>:
          - define mplat <player.target.vehicle>
        - else:
          - narrate "You do not seem to be targeting a moving platform"
          - stop
        - flag player mplat:<[mplat]>
        - glow <[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[2]>].include[<[mplat].passengers.get[2]>]>
        - if <[mplat].has_flag[pos_1]>:
          - fakespawn ender_signal <[mplat].flag[pos_1]> d:30s players:<player>
          - fakespawn armor_stand[is_small=true;visible=false;marker=true;custom_name=Position<&sp>1;custom_name_visible=true] <[mplat].flag[pos_1].add[0,0.5,0]> d:30s players:<player>
        - if <[mplat].has_flag[pos_2]>:
          - fakespawn ender_signal <[mplat].flag[pos_2]> d:30s players:<player>
          - fakespawn armor_stand[is_small=true;visible=false;marker=true;custom_name=Position<&sp>2;custom_name_visible=true] <[mplat].flag[pos_2].add[0,0.5,0]> d:30s players:<player>
        - narrate "Moving platform selected"
      - case deselect:
        - if !<player.has_flag[mplat]>:
          - narrate "You do not have a moving platform selected"
          - stop
        - if <player.has_flag[mp_pos]>:
          - flag player mp_pos:!
        - glow <player.flag[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[2]>].include[<player.flag[mplat].passengers.get[2]>]> false
        - flag player mplat:!
        - narrate "That moving platform is no longer selected"
      - case remove:
        - if !<player.has_flag[mplat]>:
          - narrate "You do not have a moving platform selected"
          - stop
        - remove <player.flag[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[2]>]>
        - remove <player.flag[mplat].flag[mplink].parse_tag[<[parse_value].passengers.get[1]>]>
        - remove <player.flag[mplat].flag[mplink]>
        - remove <player.flag[mplat].passengers>
        - remove <player.flag[mplat]>
        - flag server test_plat:<-:<player.flag[mplat]>
        - if <server.flag[test_plat].is_empty||false>:
          - flag server test_plat:!
        - if <player.has_flag[mp_pos]>:
          - flag player mp_pos:!
        - flag player mplat:!
        - narrate "Moving platform succesfully removed"
      - case positions:
        - if !<player.has_flag[mplat]>:
          - narrate "You do not have a moving platform selected"
          - stop
        - if <player.has_flag[mp_pos]>:
          - flag player mp_pos:!
          - narrate "You are no longer selecting the moving platform positions"
          - stop
        - flag player mp_pos
        - narrate "You are now selecting the moving platform positions"
        - narrate "These can only go straight 1 direction"
        - narrate "and cannot move up or down."
        - narrate "So make sure you have either the x or z value the same, and the y value the same"
        - narrate "Left click a block to set its first position"
        - narrate "Right click a block to set its second position"
        - narrate "do /mp positions again to stop selecting the positions"
        - narrate "The moving platform will automatically tp to the right area and start moving"
      - default:
        - narrate test2

mplat_wait_re:
  type: task
  debug: false
  definitions: mplat
  script:
    - flag <[mplat]> station
    - wait 2s
    - flag <[mplat]> go:!
    - flag <[mplat]> re
    - flag <[mplat]> station:!

mplat_wait_go:
  type: task
  debug: false
  definitions: mplat
  script:
    - flag <[mplat]> station
    - wait 2s
    - if <[mplat].flag[no_go]||no> == go:
      - flag <[mplat]> no_go:no
      - modifyblock <location[mp_crystal_reset]> redstone_block
      - flag <[mplat]> re:!
      - flag <[mplat]> station:!
      - flag <[mplat]> go
      - stop
    - flag <[mplat]> go
    - flag <[mplat]> re:!
    - flag <[mplat]> station:!

mplat_safe_restart_w:
  type: world
  debug: false
  events:
    on server start:
    - flag server no_plat_move
    - chunkload add <location[mp_chunkload_1].chunk>
    - chunkload add <location[mp_chunkload_2].chunk>
    - chunkload add <location[mp_chunkload_3].chunk>
    - chunkload add <location[mp_chunkload_4].chunk>
    - chunkload add <location[mp_chunkload_5].chunk>
    after player enters mp_area:
    - if !<server.has_flag[test_plat]>:
      - stop
    - foreach <server.flag[test_plat]> as:mplat:
      - if <[mplat].has_flag[station]||false>:
        - if <[mplat].has_flag[go]>:
          - flag <[mplat]> go:!
          - flag <[mplat]> re
          - flag <[mplat]> station:!
          - goto smartskip
        - if <[mplat].has_flag[re]>:
          - flag <[mplat]> re:!
          - flag <[mplat]> go
          - flag <[mplat]> station:!
          - goto smartskip
        - mark smartskip
      - foreach <[mplat].flag[mplink]||<list>> as:plat:
        - choose <[loop_index]>:
          - case 1:
            - attach <[plat]> to:<[mplat]> offset:0,0,1 sync_server
          - case 2:
            - attach <[plat]> to:<[mplat]> offset:1,0,1 sync_server
          - case 3:
            - attach <[plat]> to:<[mplat]> offset:1,0,0 sync_server
          - case 4:
            - attach <[plat]> to:<[mplat]> offset:0,0,-1 sync_server
          - case 5:
            - attach <[plat]> to:<[mplat]> offset:1,0,-1 sync_server
          - case 6:
            - attach <[plat]> to:<[mplat]> offset:-1,0,-1 sync_server
          - case 7:
            - attach <[plat]> to:<[mplat]> offset:-1,0,0 sync_server
          - case 8:
            - attach <[plat]> to:<[mplat]> offset:-1,0,1 sync_server
    - if <server.has_flag[no_plat_move]>:
      - flag server no_plat_move:!
      - run mplat_t_move

mplat_t_move:
  type: task
  debug: false
  script:
    - if !<server.has_flag[test_plat]>:
      - stop
    - foreach <server.flag[test_plat]> as:mplat:
      - if <server.has_flag[no_plat_move]>:
        - foreach next
      - if <[mplat].flag[no_go]||go> == no:
        - foreach next
      - if <[mplat].has_flag[station]||true>:
        - foreach next
      - if <[mplat].has_flag[pos_1]||false> && <[mplat].has_flag[pos_2]||false>:
        - if <[mplat].has_flag[go]>:
          - define new_loc1 <[mplat].location.sub[<[mplat].flag[moving]>]>
          - foreach <[mplat].location.find_players_within[2]> as:player:
            - cast <[player]> speed amplifier:2 duration:1t hide_particles no_icon no_ambient
            - adjust <[player]> velocity:<[player].velocity.mul[1.8].sub[<[mplat].flag[moving]>].div[2]>
          - teleport <[mplat]> <[new_loc1]>
          - flag <[mplat]> sound:++
          - if <[mplat].flag[sound]> > 13:
            - playsound sound:entity_zombie_villager_converted <[mplat].location> pitch:1.05 volume:0.25
            - flag <[mplat]> sound:!
          - if <[new_loc1].round_to[1]> == <[mplat].flag[pos_2]>:
            - run mplat_wait_re def:<[mplat]>
          - foreach next
        - if <[mplat].has_flag[re]>:
          - define new_loc2 <[mplat].location.add[<[mplat].flag[moving]>]>
          - foreach <[mplat].location.find_players_within[2]> as:player:
            - cast <[player]> speed amplifier:2 duration:0.5s hide_particles no_icon no_ambient
            - adjust <[player]> velocity:<[player].velocity.mul[1.8].add[<[mplat].flag[moving]>].div[2]>
          - teleport <[mplat]> <[new_loc2]>
          - flag <[mplat]> sound:++
          - if <[mplat].flag[sound]> > 13:
            - playsound sound:entity_zombie_villager_converted <[mplat].location> pitch:1.05 volume:0.25
            - flag <[mplat]> sound:!
          - if <[new_loc2].round_to[1]> == <[mplat].flag[pos_1]>:
            - run mplat_wait_go def:<[mplat]>
            - foreach next
          - foreach next
        - if <[mplat].flag[pos_1].material> != <material[air]>:
          - foreach next
        - teleport <[mplat]> <[mplat].flag[pos_1]>
        - run mplat_wait_go def:<[mplat]>
        - foreach next
      - if <[mplat].has_flag[pos_1]||false>:
        - if <[mplat].location> != <[mplat].flag[pos_1]>:
          - if <[mplat].flag[pos_1].material> != <material[air]>:
            - foreach next
          - teleport <[mplat]> <[mplat].flag[pos_1]>
    - wait 1t
    - if <server.has_flag[mplats_moving]>:
      - flag server mplats_moving:!
      - stop
    - inject mplat_t_move

mov_plat_w:
  type: world
  debug: false
  events:
    on system time secondly every:20:
    - flag server mplats_moving
    - wait 2t
    - inject mplat_t_move
    on player clicks block:
    - if !<player.has_flag[mp_pos]>:
      - stop
    - determine passively cancelled
    - if <context.click_type> == left_click_air || <context.click_type> == right_click_air:
      - narrate "You have to click a block to register the position"
      - narrate "You can remove this block after selecting the position"
      - stop
    - define mplat <player.flag[mplat]>
    - if <[mplat].has_flag[pos_1]>:
      - define x1 <[mplat].flag[pos_1].x>
      - define y1 <[mplat].flag[pos_1].y>
      - define z1 <[mplat].flag[pos_1].z>
    - if <[mplat].has_flag[pos_2]>:
      - define x2 <[mplat].flag[pos_2].x>
      - define y2 <[mplat].flag[pos_2].y>
      - define z2 <[mplat].flag[pos_2].z>
    - if <context.click_type> == left_click_block:
      - if <[mplat].has_flag[pos_2]>:
        - if <[y2]> != <context.location.center.sub[0,0.5,0].y>:
          - narrate "The y levels are not the same."
          - stop
        - if <[x2]> == <context.location.center.x> && <[z2]> == <context.location.center.z>:
          - narrate "The first location cannot be the same as the second location"
          - stop
        - if <[x2]> != <context.location.center.x> && <[z2]> != <context.location.center.z>:
          - narrate "A moving platform cannot move diagonally."
          - narrate "Either the x or the z location have to be the same"
          - stop
        - if <[x2]> == <context.location.center.x>:
          - if <[z2]> > <context.location.center.z>:
            - flag <[mplat]> moving:0,0,-0.1
          - if <[z2]> < <context.location.center.z>:
            - flag <[mplat]> moving:0,0,0.1
        - if <[z2]> == <context.location.center.z>:
          - if <[x2]> > <context.location.center.x>:
            - flag <[mplat]> moving:-0.1,0,0
          - if <[x2]> < <context.location.center.x>:
            - flag <[mplat]> moving:0.1,0,0
      - flag <[mplat]> pos_1:<context.location.center.sub[0,0.5,0]>
      - fakespawn ender_signal <[mplat].flag[pos_1]> d:30s players:<player>
      - fakespawn armor_stand[is_small=true;visible=false;marker=true;custom_name=Position<&sp>1;custom_name_visible=true] <[mplat].flag[pos_1].add[0,0.5,0]> d:30s players:<player>
      - if <[mplat].has_flag[pos_2]>:
        - fakespawn ender_signal <[mplat].flag[pos_2]> d:30s players:<player>
        - fakespawn armor_stand[is_small=true;visible=false;marker=true;custom_name=Position<&sp>2;custom_name_visible=true] <[mplat].flag[pos_2].add[0,0.5,0]> d:30s players:<player>
        - narrate "positions <[mplat].flag[pos_1]> and <[mplat].flag[pos_2]> have been linked"
      - else:
        - narrate "first postion set at <[mplat].flag[pos_1]>"
    - if <context.click_type> == right_click_block:
      - if <[mplat].has_flag[pos_1]>:
        - if <[y1]> != <context.location.center.sub[0,0.5,0].y>:
          - narrate "The y levels are not the same."
          - stop
        - if <[x1]> == <context.location.center.x> && <[z1]> == <context.location.center.z>:
          - narrate "The first location cannot be the same as the second location"
          - stop
        - if <[x1]> != <context.location.center.x> && <[z1]> != <context.location.center.z>:
          - narrate "A moving platform cannot move diagonally."
          - narrate "Either the x or the z location have to be the same"
          - stop
        - if <[x1]> == <context.location.center.x>:
          - if <[z1]> > <context.location.center.z>:
            - flag <[mplat]> moving:0,0,0.1
          - if <[z1]> < <context.location.center.z>:
            - flag <[mplat]> moving:0,0,-0.1
        - if <[z1]> == <context.location.center.z>:
          - if <[x1]> > <context.location.center.x>:
            - flag <[mplat]> moving:0.1,0,0
          - if <[x1]> < <context.location.center.x>:
            - flag <[mplat]> moving:-0.1,0,0
      - flag <[mplat]> pos_2:<context.location.center.sub[0,0.5,0]>
      - fakespawn ender_signal <[mplat].flag[pos_2]> d:30s players:<player>
      - fakespawn armor_stand[is_small=true;visible=false;marker=true;custom_name=Position<&sp>2;custom_name_visible=true] <[mplat].flag[pos_2].add[0,0.5,0]> d:30s players:<player>
      - if <[mplat].has_flag[pos_1]>:
        - fakespawn ender_signal <[mplat].flag[pos_1]> d:30s players:<player>
        - fakespawn armor_stand[is_small=true;visible=false;marker=true;custom_name=Position<&sp>1;custom_name_visible=true] <[mplat].flag[pos_1].add[0,0.5,0]> d:30s players:<player>
        - narrate "positions <[mplat].flag[pos_1]> and <[mplat].flag[pos_2]> have been linked"
      - else:
        - narrate "second postion set at <[mplat].flag[pos_2]>"
    on player kicked for flying:
    - if !<player.location.find_entities[moving_platform].within[3].is_empty||true>:
      - determine passively fly_cooldown:20s
      - determine cancelled

mplat_move:
  type: task
  debug: false
  script:
    - push <server.flag[test_plat]>|<server.flag[test_plat].passengers> origin:<server.flag[test_plat].location> destination:<server.flag[test_plat].location.add[10,0,0]> force_along

spawn_mov_plat:
  type: task
  debug: false
  script:
    - define ent_loc <player.location.center>
    - inject spawn_mov_plat1

spawn_mov_plat1:
  type: task
  debug: false
  script:
    - define list <list[]>
    - repeat 8:
      - define list <[list].include[moving_platform_side]>
    - spawn moving_platform <[ent_loc]> save:mplat
    - spawn <[list]> <[ent_loc]> save:entities
    - define mplat <entry[mplat].spawned_entity>
    - flag server test_plat:->:<[mplat]>
    - foreach <entry[entities].spawned_entities> as:plat:
      - flag <[mplat]> mplink:->:<[plat]>
      - flag <[plat]> plink:<[mplat]>
      - choose <[loop_index]>:
        - case 1:
          - attach <[plat]> to:<[mplat]> offset:0,0,1 sync_server
        - case 2:
          - attach <[plat]> to:<[mplat]> offset:1,0,1 sync_server
        - case 3:
          - attach <[plat]> to:<[mplat]> offset:1,0,0 sync_server
        - case 4:
          - attach <[plat]> to:<[mplat]> offset:0,0,-1 sync_server
        - case 5:
          - attach <[plat]> to:<[mplat]> offset:1,0,-1 sync_server
        - case 6:
          - attach <[plat]> to:<[mplat]> offset:-1,0,-1 sync_server
        - case 7:
          - attach <[plat]> to:<[mplat]> offset:-1,0,0 sync_server
        - case 8:
          - attach <[plat]> to:<[mplat]> offset:-1,0,1 sync_server

moving_platform:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    passengers: falling_block[fallingblock_type=light_blue_concrete_powder;time_lived=<util.int_min>]|shulker[invulnerable=true;has_ai=false;potion_effects=invisibility,1,<util.int_max>,false,false,false]
    is_small: true
    visible: false
    persistent: true
    marker: true

moving_platform_side:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    passengers: falling_block[fallingblock_type=end_stone_bricks;time_lived=<util.int_min>]|shulker[invulnerable=true;has_ai=false;potion_effects=invisibility,1,<util.int_max>,false,false,false]
    is_small: true
    visible: false
    persistent: true
    marker: true

