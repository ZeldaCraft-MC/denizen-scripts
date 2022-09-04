random_donut:
  type: procedure
  debug: false
  definitions: worldsize
  script:
    - define noise 3.5
    - define angle <util.random.decimal[0].to[360].to_radians>
    - define offset <location[1,0,0].rotate_around_y[<[angle]>]>
    - determine <[offset].add[<util.random.gauss.div[3.5]>,0,<util.random.gauss.div[3.5]>].mul[<[worldsize]>]>

rtp_command:
  type: command
  debug: false
  name: rtp
  usage: /rtp
  description: Randomly teleports to somewhere in a survival world.
  script:
    - if !<list[s1|s2].contains[<player.world.name>]>:
      - narrate "<&c>You can only use the <&e>/rtp<&c> command in <&e>/warp s1<&c> or <&e>/warp s2"
      - stop
    - if <player.is_inside_vehicle>:
      - narrate "<&c>You can not be riding anything when using <&e>/rtp"
      - stop
    - if <player.has_flag[rtp_cooldown]> && <player.flag[rtp_cooldown].from_now.in_hours> < 1:
      - narrate "<&c>You must wait <&e><duration[1h].sub[<player.flag[rtp_cooldown].from_now>].formatted> <&c>before using <&e>/rtp <&c>again!"
      - stop
    - flag <player> rtp_cooldown:<util.time_now>
    - define offset <element[10000].proc[random_donut]>
    - define loc <essentials.warp[<player.world.name>].add[<[offset]>]>
    - chunkload <[loc].chunk> duration:5s
    - define highest <[loc].highest>
    - teleport <player> <[highest].center.above[1]>
    - if <[highest].material.name> == water:
      - wait 1t
      - mount <player>|boat
