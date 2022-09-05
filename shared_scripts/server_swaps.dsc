swap_server:
  type: task
  debug: false
  definitions: server|location
  script:
    - waituntil max:5s <player.has_flag[inv_save_ready]>
    - if !<player.has_flag[inv_save_ready]>:
      - narrate "<&c>There was an issue moving to this server, please contact an admin."
      - stop

    - flag <player> swapping_servers
    - flag <player> inv_save_ready:!
    - define worldname <player.world.name>
    - define gamemode <player.gamemode>
    - inject save_inventory
    - ~yaml savefile:inventories/<player.uuid>.yml id:<player.uuid>_inventories

    #- if <player.has_flag[global_flags]>:
    #  - define route "PUT /players/<player.uuid>?wm=upsert"
    #  - define data <player.flag[global_flags]>
    #  - inject mongo_webget

    - if !<player.is_online>:
      - flag <player> swapping_servers:!
      - stop

    - definemap msg:
        from: <bungee.server>
        to: <[server]>
        uuid: <player.uuid>
        loc: <[location]||null>
    - redis id:publisher publish:global_server_swap_request message:<[msg]>

    - waituntil max:5s !<player.is_online>
    - wait 1t
    - flag <player> inv_save_ready
    - flag <player> swapping_servers:!
    - if !<player.is_online>:
      - yaml unload id:<player.uuid>_inventories

skyblock_command:
  type: command
  debug: false
  description: Play some skyblock!
  usage: /skyblock
  name: skyblock
  script:
    - if !<player.has_permission[server.skyblock]>:
      - narrate "<&c>I'm sorry, but you don't have access to go there!"
      - stop
    - if <bungee.server> in dev|skyblock:
      - execute as_player spawn
      - stop
    - ~run swap_server def:dev|0.5,100.5,0.5,0,90,skyblock_hub

server_command:
  type: command
  debug: false
  description: Swaps to a server
  usage: /server (server)
  name: server
  tab completions:
    1: lobby|zc-main|builds
  script:
    - ratelimit <player> 5s
    - if !<player.has_permission[server.<context.args.first.if_null[null]>]>:
      - narrate "<&c>I'm sorry, but you don't have access to go there!"
      - stop
    - define server <context.args.first>
    - ~run swap_server def:<[server]>

server_swap_events:
  type: world
  debug: false
  events:
    on redis pubsub message channel:global_server_swap_request:
      - announce to_console "got server_swap_request, <context.message>, <context.message.as[map]>"
      - define map <context.message.as[map]>
      - if <bungee.server> != <[map].get[to]>:
        - stop
      - flag <player[<[map].get[uuid]>]> from_server_swap duration:5s
      - if <[map].contains[loc]> && <[map].get[loc]> != null:
        - chunkload <location[<[map].get[loc]>].chunk> duration:5m
        - define loc <location[<[map].get[loc]>]>
        - flag server tp_on_join.<[map].get[uuid]>:<[loc].highest.center.above[2].with_pose[<[loc].pitch>,<[loc].yaw>]||null> duration:5s
      - if !<util.has_file[inventories/<[map].get[uuid]>.yml]>:
        - yaml create id:<[map].get[uuid]>_inventories
      - else:
        - ~yaml load:inventories/<[map].get[uuid]>.yml id:<[map].get[uuid]>_inventories
      - definemap msg:
          from: <bungee.server>
          to: <[map].get[from]>
          uuid: <[map].get[uuid]>
      - redis id:publisher publish:global_server_swap_accept message:<[msg]>

    on redis pubsub message channel:global_server_swap_accept:
      - define map <context.message.as[map]>
      - if <bungee.server> != <[map].get[to]>:
        - stop
      - define player <player[<[map].get[uuid]>]>
      - if <[player].is_online>:
        - adjust <[player]> send_to:<[map].get[from]>

    on player joins bukkit_priority:highest:
      - determine passively none

      # In the case of S3, tp them to a loc on join
      - if <server.has_flag[tp_on_join.<player.uuid>]>:
        - teleport <player> <server.flag[tp_on_join.<player.uuid>]>
        - flag server tp_on_join.<player.uuid>:!

      # Load their global flags
      - define route "GET /players/<player.uuid>"
      - inject mongo_webget
      - if <[status_code]> == 200:
        - flag <player> global_flags:<[result]>
      - else if <[status_code]> == 404:
        - flag <player> global_flags:<map>
        - define route "PUT /players/<player.uuid>?wm=upsert"
        - define data <player.flag[global_flags]>
        - inject mongo_webget
      - else:
        - narrate "<&c>Unable to load player data. Please contact Mergu."
        - announce to_console "MERGU: <[status_code]> - <[result]> (<player.name> - <player.uuid>)"

    on player quits bukkit_priority:highest:
      - determine passively none
      - if !<player.has_flag[swapping_servers]> && <player.has_flag[global_flags]>:
        - define route "PUT /players/<player.uuid>?wm=upsert"
        - define data <player.flag[global_flags]>
        - inject mongo_webget
