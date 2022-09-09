grant_bonus_claim_blocks:
  type: task
  debug: false
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
  debug: false
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

gp_admin_claim_events:
  type: world
  debug: false
  events:
    on player places block permission:!zc.bypass_admin_claims ignorecancelled:true:
      - if <context.location.griefprevention.claim.is_adminclaim||false>:
        - if <player.has_permission[griefprevention.adminclaims]>:
          - narrate "<&c>I'm sorry, you can't build in admin claims. You may only create or delete them."
          - determine cancelled
        - narrate "<&7>If this is your build, a mod/admin has locked it due to being griefed repeatedly."
        - narrate "<&7>Please reach out to a staff member via <&e>@Mod<&7> in chat and ask to have it unclaimed."
        - determine cancelled
    on player breaks block permission:!zc.bypass_admin_claims ignorecancelled:true:
      - if <context.location.griefprevention.claim.is_adminclaim||false>:
        - if <player.has_permission[griefprevention.adminclaims]>:
          - narrate "<&c>I'm sorry, you can't build in admin claims. You may only create or delete them."
          - determine cancelled
        - narrate "<&7>If this is your build, a mod/admin has locked it due to being griefed repeatedly."
        - narrate "<&7>Please reach out to a staff member via <&e>@Mod<&7> in chat and ask to have it unclaimed."
        - determine cancelled
    after gp claim created:
      - if <context.claim.is_adminclaim>:
        - if <player.exists>:
          - define name <player.name>
        - else:
          - define name ZeldaCraft
        - define loc <context.claim.cuboid.center.highest.above[1].center>
        - define loc_rd <[loc].round_down>
        - definemap embed_map:
            author_name: Admin Claim Created
            author_icon_url: https://cravatar.eu/helmavatar/<[name]>/190.png
            description: <[name]> has created an admin claim at <[loc_rd].x>, <[loc_rd].y>, <[loc_rd].z> in <[loc_rd].world.name>
            color: green
        - define button "<discord_button.with[id].as[teleport_button].with[label].as[Click to teleport].with[style].as[secondary]>"
        - ~discordmessage id:zc-info channel:329367365584158722 rows:<[button]> <discord_embed.with_map[<[embed_map]>]> save:msg
        - flag <entry[msg].message> teleport_location:<[loc]> expire:30d
    on discord button clicked id:teleport_button:
      - if !<context.interaction.user.has_flag[mc_link]>:
        - ~discordinteraction reply interaction:<context.interaction> ephemeral "You must link your Minecraft username to Discord with /linkmc first."
        - stop
      - if !<context.message.has_flag[teleport_location]>:
        - ~discordinteraction reply interaction:<context.interaction> ephemeral "I'm sorry, this teleport location has expired."
        - stop
      - define player <context.interaction.user.flag[mc_link]>
      - if !<[player].is_online>:
        - ~discordinteraction reply interaction:<context.interaction> ephemeral "You must be online to be teleported."
        - stop
      - define loc <context.message.flag[teleport_location]>
      - define loc_rd <[loc].round_down>
      - teleport <[player]> <[loc]>
      - ~discordinteraction reply interaction:<context.interaction> ephemeral "Successfully teleported you to <[loc_rd].x>, <[loc_rd].y>, <[loc_rd].z> in <[loc_rd].world.name>"
