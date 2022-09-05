skin_command:
  type: command
  name: skin
  usage: /skin [args]
  description: Test
  permission: zcrpg.skin
  script:
  - choose <context.args.get[1]||help>:
    - case help:
      - narrate hmm
    - case gui:
      - inventory open d:skin_inventory

skin_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: Test
  size: <player.flag[saved_skins].size.div_int[9].add[2].mul[9].min[54]>
  procedural items:
  - define list <list>
  - define uuid <util.random_uuid>
  - define size <player.flag[saved_skins].size.div_int[9].add[2].mul[9].min[54]>
  - foreach <player.flag[saved_skins]||<list>> as:skin:
    - define enc_skin <[skin].replace[;].with[.]>
    - define head player_head[skull_skin=<[uuid]>|<[skin]>]
    - define list <[list].include[<[head]>]>
  - determine <[list]>

#skin_events:
#  type: world
#  events:
#    on player clicks player_head in skin_inventory:
#    - determine passively cancelled
#    - adjust <player> skin_blob:<context.item.nbt[skin].replace[.].with[;]>
