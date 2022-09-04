jobs_config:
  type: data
  data:
    default:
        colors:
          chat: #ffffff
          bossbar: blue
        income_eqn: <[base_price].mul[<element[1.05].power[<[level].sub[1]>]>]>
        exp_eqn: <[base_exp].mul[<element[1.05].power[<[level].sub[1]>]>]>
        leveling_eqn: <element[1.13].power[<[level].sub[1]>].mul[100]>
    lumberjack:
        name: Lumberjack
        description: Earn money by cutting and planting trees.
        colors:
          chat: #ffffff
          bossbar: blue
        income_eqn: <[base_price].mul[<element[1.05].power[<[level].sub[1]>]>]>
        exp_eqn: <[base_exp].mul[<element[1.05].power[<[level].sub[1]>]>]>
        leveling_eqn: <element[1.13].power[<[level].sub[1]>].mul[100]>
        break:
          log:
            income: 0.20
            exp: 0.20
    #miner:
    #builder:
    #terraformer:
    #farmer:
    #rancher:
    #- hunter:
    #- monster_slayer:
    #- adventurer:
    #- artisan:
    #- fisherman:
    #- blacksmith:
    #- alchemist:
    #- sorcerer:
    #- butcher:
    #- stonemason:
    #- armorer:
    #- weaponsmith:
    #- botanist:
    #- chef:

jobs_bossbar_command:
  type: command
  name: testbb
  permission: asdkasld
  usage: /testbb
  description: Test
  script:
    - define total 100
    - define curr 0
    - bossbar <player>_skill "title:<&a><&l>Woodcutting <&b>[Level 1]" progress:0 color:blue style:segmented_20
    - wait 2s
    - while <[curr]> < <[total]>:
      - define curr:+:1
      - bossbar update <player>_skill progress:<[curr].div[<[total]>].min[1]>
      - wait 1t
    - wait 2s
    - bossbar remove <player>_skill
