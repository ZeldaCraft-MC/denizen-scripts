spawn_world_realtime:
  type: world
  debug: false
  events:
    on delta time secondly:
      - define server_time <util.time_now.duration_since[<util.time_now.start_of_day>].in_seconds>
      - time <[server_time].mul[24000].div[86400].round_down.add[16000]>t spawn
      - foreach <world[spawn].players> as:__player:
        - if <player.has_flag[ip_info.timezone]>:
          - define zone <util.time_now.to_zone[<player.flag[ip_info.timezone]>]||null>
          - if <[zone]> == null || <[zone]> == <util.time_now>:
            - foreach next
          - define player_time <[zone].duration_since[<[zone].start_of_day>].in_seconds>
          - time player <[player_time].mul[24000].div[86400].round_down.add[16000]>t freeze
          - flag <player> fake_spawn_time
    on player changes world from spawn:
      - if <player.has_flag[fake_spawn_time]>:
        - time player reset
        - flag <player> fake_spawn_time:!
    on player changes world to spawn:
      - if <player.has_flag[ip_info.timezone]>:
        - define zone <util.time_now.to_zone[<player.flag[ip_info.timezone]>]||null>
        - if <[zone]> == null || <[zone]> == <util.time_now>:
          - stop
        - define player_time <[zone].duration_since[<[zone].start_of_day>].in_seconds>
        - time player <[player_time].mul[24000].div[86400].round_down.add[16000]>t freeze
        - flag <player> fake_spawn_time
