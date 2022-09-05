# Payout types:
# break
# place
# grow
# kill

jobs_profession_config:
  type: data
  debug: false
  order:
    - slayer
    - miner
    - lumberjack
    - digger
    - farmer
    - rancher
    - engineer
  jobs:
    slayer:
      color: 5
      item: iron_sword
      desc:
        - Earn money by slaying
        - monsters and bosses
      payouts:
        kill:
          zombie:
            item: zombie_head
            price: 0.25
          skeleton:
            item: skeleton_skull
            price: 0.25
          wither:
            item: player_head[skull_skin=<server.flag[wither_skull_skin]>]
            price: 10
          ender_dragon:
            item: dragon_head
            price: 5
    miner:
      color: b
      item: iron_pickaxe
      desc:
        - Earn money by mining
        - ores and gems
      payouts:
        break:
          diamond_ore:
            price: 1
    lumberjack:
      color: "#964B00"
      item: iron_axe
      desc:
        - Earn money by felling
        - and growing trees
      payouts:
        break:
          oak_log:
            price: 0.10
    digger:
      color: 6
      item: iron_shovel
      desc:
        - Earn money by digging
        - and terraforming
      payouts:
        break:
          gravel:
            price: 0.10
    farmer:
      color: a
      item: iron_hoe
      desc:
        - Earn money by planting
        - and harvesting crops
      payouts:
        harvest:
          beetroots:
            item: beetroot
            price: 0.50
    rancher:
      color: d
      item: saddle
      desc:
        - Earn money by taking
        - care of animals
      payouts:
        breed:
          cow:
            item: player_head[skull_skin=<server.flag[cow_skull_skin]>]
            price: 0.50
    engineer:
      color: c
      item: redstone
      desc:
        - Earn money by building
        - redstone contraptions
      payouts:
        place:
          piston:
            price: 1
