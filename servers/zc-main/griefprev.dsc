grant_bonus_claim_blocks:
  type: task
  script:
    - define hours_played <player.statistic[play_one_minute].div[72000].round_down>
    - define bonus_blocks <[hours_played].mul[30]>
    - if <[hours_played]> <= 1 or <player.has_flag[received_bonus_blocks]>:
      - stop
    - flag <player> received_bonus_blocks
    - narrate "<n><&c><&l>!! Important !!"
    - narrate "<&gradient[from=<&a>;to=<&b>]>Hey! Thanks for joining! This server has added a land claims plugin since the last time you joined, so now you can protect your entire base from grief instead of just your doors/chests. To use land claims, simply right click with a golden shovel at the corners of your build. See this video for some more info - <&e>https://bit.ly/mcgpuser"
    - narrate "<&d>To get you started, here's a <&e>Golden Shovel<&d> and <&e><[bonus_blocks].format_number>x <&d>bonus claim blocks for your previous playtime!<n>"
    - adjust <player> bonus_blocks:<player.griefprevention.blocks.bonus.add[<[bonus_blocks]>]>
    - give golden_shovel

grant_bonus_claim_blocks_events:
  type: world
  events:
    after player joins:
    - if <player.statistic[play_one_minute].div[72000].round_down||0> <= 1:
      # Ignore first-time players by flagging them as received
      - flag <player> received_bonus_blocks
    - if <player.has_flag[received_bonus_blocks]>:
      - stop
    - wait 10s
    - if !<player.is_online>:
      - stop
    - run grant_bonus_claim_blocks
