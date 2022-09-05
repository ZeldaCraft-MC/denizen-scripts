respawn_data:
  type: data
  debug: false
  spawns:
    spawn:
      - spawn
      - dungeonvip
      - newvip
    s1:
      - s1
    s2:
      - s2
    s3:
      - s3_nether
      - s3
    end:
      - theendkek
    nether:
      - newnether
    dungeon:
      - dungeons

respawn_world:
  type: world
  debug: false
  events:
    on player respawns:
      - foreach <script[respawn_data].data_key[spawns].keys> as:respawns:
        - foreach <script[respawn_data].data_key[spawns].get[<[respawns]>]> as:worlds:
          - if <[worlds].contains[<player.location.world.name>]>:
            - choose <[respawns]>:
              - case spawn:
                - determine <server.flag[warps].get[spawn]>
              - case s1:
                #- if <context.is_bed_spawn> && <context.location.world.name> == s1:
                #  - stop
                - determine <server.flag[warps].get[s1]>
              - case s2:
                #- if <context.is_bed_spawn> && <context.location.world.name> == s2:
                #  - stop
                - determine <server.flag[warps].get[s2]>
              - case s3:
                #- if <context.is_bed_spawn> && <context.location.world.name> == s3:
                #  - stop
                - determine <server.flag[warps].get[s3]>
              - case end:
                - determine <server.flag[warps].get[end]>
              - case nether:
                - determine <server.flag[warps].get[nether]>
              - case dungeon:
                - determine <server.flag[warps].get[dungeons]>
            - stop
