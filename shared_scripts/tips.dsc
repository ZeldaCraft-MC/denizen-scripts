tips:
  type: data
  data:
    all:
    - This server has dozens of custom crafting recipes you can learn with /recipes!
    - No space for your base? Use /rtp in a survival world to find a spot.
    - This server has a diverse levelling system called McMMO. Use /mcgui to see your progress.
    - Join our community on Discord with /discord!
    - You can choose or change your player's LoZ race/perks with /racemenu!
    - Complete dungeons with /dungeons to unlock equippable spells with /bindmenu!
    - Remember to /vote for daily rewards! You can use your vote keys at /spawn!
    - You can use /help to learn more about this server's RPG system.
    - Access the nether or end with /warp nether or /warp end.
    - Make sure to set a home at your base with /sethome. Go there with /home!
    - You can teleport to your friends at any time with /tpa (username)!
    - To earn money, hold items you would like to sell and use /worth and /sell hand.
    - You can view your current money balance with /bal!
    - Many players have shops where they buy and sell items at /warp rr.
    - This server has a party system where you can team up with your friends. Use /party to explore the commands!
    - You can place various emotes in the chat, such as /shrug, with commands. See them all with /emotes!
    - Visit a dimension with custom terrain, drops, and enemies by right-clicking a lodestone block.
    - Donators have access to a freebuild creative world at /warp vip! Use /buy to donate!
    - Have a suggestion for this server? Use /suggestion!
    - You can report players for breaking the rules or griefing with /report.
    - We are always looking for talented and mature volunteers to help us with this server! If you would like to help - whether with art, streaming, moderation, or anything else - let us know on the Discord (/discord)!
    default:
    - Griefing and stealing are not allowed on this server! If you've been griefed, contact a Mod to fix it.
    - Loving the server? Apply for the [Trusted] rank by typing "/trusted" on our Discord (/discord)!
    non_staff:
    - Enjoy helping new players? Consider applying for [Helper] by typing "/helper" on our Discord (/discord)!
    non_builder:
    - Have the building skills to help us create warps? Apply for [Builder] by typing "/builder" on our Discord (/discord)!

tips_events:
  type: world
  debug: false
  events:
    after player chats ignorecancelled:true:
    - flag server chat_messages_between_tips:++
    on delta time minutely every:2:
    - if <server.flag[chat_messages_between_tips]> < 15:
      - stop
    - flag server chat_messages_between_tips:0
    - foreach <server.online_players> as:__player:
      - define messages <script[tips].parsed_key[data.all]>
      - if !<player.groups.contains_any[admin|moderator|owner|gm|helper|builder|retired|trusted]>:
        - define messages:|:<script[tips].parsed_key[data.default]>
      - if !<player.groups.contains_any[admin|moderator|owner|gm|helper|builder|retired]>:
        - define messages:|:<script[tips].parsed_key[data.non_staff]>
      - if !<player.groups.contains_any[admin|moderator|owner|gm|builder]>:
        - define messages:|:<script[tips].parsed_key[data.non_builder]>
      - define index <player.flag[tips_index].add[1]||1>
      - if <[index]> > <[messages].size>:
        - define index 1
      - flag <player> tips_index:<[index]>
      - narrate "<&7>[<&color[#00de00]>Tip<&7>] <[messages].get[<[index]>].color_gradient[from=<&9>;to=<&b>]>"
