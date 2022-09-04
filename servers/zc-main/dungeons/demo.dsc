dungeons_demo:
  type: command
  usage: /dungeons
  description: some demo
  permission: zc.demo
  name: dungeons
  script:
    - define s <&chr[2B50]>
    - narrate "<n><&b><player.name> (hylian) <&7>| <&e>5 DP <&7>| <&6>3 SP <&7>| <&a>42/100 Magic"
    - narrate "<&e><[s].on_hover[Complete the dungeon]> <&6><[s].on_hover[Unlock all secret points]> <&d><[s].on_hover[Complete the dungeon without a checkpoint]> <&c><[s].on_hover[Complete the dungeon within 10 mins]> <&e>kakarikop"
    - narrate "<&e><[s]> <&6><[s]> <&7><[s]> <[s]> forest"
    - narrate "<&7><[s]> <[s]> <[s]> <[s]> awakening"
