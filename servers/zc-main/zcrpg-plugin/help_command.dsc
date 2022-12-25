zc_help_command:
  type: command
  description: See info about this server.
  usage: /help
  debug: false
  name: help
  script:
    - narrate "<&nl><&a><&l>Zelda<&2><&l>Craft Help Menu"
    - choose <context.args.get[1]||null>:
      - case zcrpg:
        - choose <context.args.get[2]||null>:
          - default:
            - define dun_hover "<&e>Dungeon Points<&r> are used to unlock unique spells that transfer to the survival worlds. You gain them by right clicking Finish signs at the end of dungeons."
            - define sec_hover "<&d>Secret Points<&r> come from signs found through each dungeon, and usually require you to explore hidden areas or solve puzzles to find. Earning one will increase the maximum capacity of your Magic Meter."
            - define mag_hover "Your <&b>Magic Meter<&r> allows you to cast spells, and can be refilled by damaging mobs and players in survival."
            - narrate "The ZeldaCraft RPG system allows you to complete dungeons and unlock spells as you play!"
            - narrate "Hover over highlighted words to see more info about them."
            - narrate "Click a command to run it.<&nl>"
            - narrate "<&a><&hover[Visit the dungeons world]><&click[/dungeons]>/dungeons<&end_click><&end_hover><&r> - Visit the dungeons world"
            - narrate " Right click a sign here to start playing a dungeon."
            - narrate " Completing a dungeon will award you with a <&e><&hover[<[dun_hover]>]>Dungeon Point<&end_hover><&r>."
            - narrate " You can also find <&d><&hover[<[sec_hover]>]>Secret Points<&end_hover><&r>, which raise your <&b><&hover[<[mag_hover]>]>Magic Meter<&end_hover><&r> capacity.<&nl>"
            - narrate "<&a><&hover[Run the <&a>/zc<&r> command]><&click[/zc ].type[suggest_command]>/zc<&end_click><&end_hover><&r> - The main ZeldaCraft RPG command"
            - narrate " This command handles all interactions with the RPG, including:"
            - narrate " <&chr[BB]> Viewing your RPG progress (dungeons/secrets, pvp rank, stats)."
            - narrate " <&chr[BB]> Viewing spells and binding them to items."
            - narrate " <&chr[BB]> Changing your ZCRPG race."
            - narrate " <&chr[BB]> Teleporting to dungeon checkpoints.<&nl>"
      - case discord:
        - narrate "We have multiple links between our discord server and the minecraft server!"
        - narrate "Hover over highlighted words to see more info about them."
        - narrate "Click a command to run it.<&nl>"
        - narrate "<&hover[Gives you a invite link to our discord]><&click[/discord]><&a>/discord<&end_click><&end_hover> <&f>- Link to discord"
        - narrate "In this discord the bot also has some commands."
        - narrate "Use <&hover[<&e><&l>zc<&f> is the prefix for our bot]><&e>zc help<&end_hover><&f> in <&hover[A channel in our discord server]><&b>#bot-spam<&end_hover><&f> to get a list"
        - narrate "Of all the available commands<&nl>"
        - narrate "<&hover[Lets you place a suggestion]><&click[/suggestion]><&a>/suggestion<&end_click><&end_hover> <&f>- Post a suggestion"
        - narrate "All suggestions will be posted in <&hover[A channel in our discord server]><&b>#suggestions<&end_hover>"
        - narrate "Other players can react on a suggestion by clicking the <&hover[The bot will dm you]><&e>emoji<&end_hover><&nl>"
        - narrate "Our chat is also linked up with discord"
        - narrate "Any message you types comes up in discord"
        - narrate "And any message typed in discord comes up here<&nl>"
      - case recipes:
        - narrate "We have custom recipes for custom items, and custom recipes for exsisting items."
        - narrate "Hover over highlighted words to see more info about them."
        - narrate "Click a command to run it.<&nl>"
        - narrate "<&hover[Opens up the recipe gui]><&click[/recipes]><&a>/recipes<&end_click><&end_hover><&f> - opens up our recipe GUI<&nl>"
        - narrate "In this gui you can choose from 2 options"
        - narrate "<&hover[Items already in minecraft we just added the recipes]><&b><&chr[BB]> Modified crafting recipes<&end_hover>"
        - narrate "<&hover[All crafting recipes for our custom items]><&b><&chr[BB]> Custom item recipes<&nl><&end_hover>"
        - narrate "With our custom items there are 2 items that drop from monsters"
        - narrate "<&hover[Dropped by <&translate[entity.minecraft.villager]>]><&e><&chr[BB]> Power Dust<&end_hover>"
        - narrate "<&hover[Dropped by <&translate[entity.minecraft.ender_dragon]>]><&e><&chr[BB]> Dragon Scale<&end_hover><&nl>"
      - case ranks:
        - narrate "We have ranks you can apply for and paid ranks."
        - narrate "Hover over highlighted words to see more info about them."
        - narrate "Click a command to run it.<&nl>"
        - narrate "You can either apply for a rank on our forums or our <&hover[Click here to view the help page]><&click[/help discord]><&b>Discord<&end_click><&end_hover>"
        - narrate "Ranks you can apply for:"
        - narrate "<&chr[BB]> <&hover[Click for more info about <&color[#5390d9]>[Trusted]]><&click[/help rank_trusted]><&color[#5390d9]>[Trusted]<&end_click><&end_hover>"
        - narrate "<&chr[BB]> <&hover[Click for more info about <&color[#13eba2]>[Builder]]><&click[/help rank_builder]><&color[#13eba2]>[Builder]<&end_click><&end_hover>"
        - narrate "<&chr[BB]> <&hover[Click for more info about <&color[#bf5fff]>[Mod]]><&click[/help rank_moderator]><&color[#bf5fff]>[Mod]<&end_click><&end_hover><&nl>"
        - narrate "<&hover[Opens the donations gui]><&click[/buy]><&a>/buy<&end_click><&end_hover><&f> - opens up the donations GUI"
        - narrate "All paid ranks are purely cosmetic. Ranks you can pay for:"
        - narrate "<&chr[BB]> <&hover[Click for more info about <&color[#48bfe3]>[VIP]]><&click[/help rank_vip]><&color[#48bfe3]>[VIP]<&end_click><&end_hover>"
        - narrate "<&chr[BB]> <&hover[Click for more info about <&color[#64dfdf]>[VIP+]]><&click[/help rank_vip+]><&color[#64dfdf]>[VIP+]<&end_click><&end_hover>"
        - narrate "<&chr[BB]> <&hover[Click for more info about <&color[#80ffdb]>[SVIP]]><&click[/help rank_svip]><&color[#80ffdb]>[SVIP]<&end_click><&end_hover><&nl>"
      - case rank_trusted:
        - narrate "<&color[#5390d9]>[Trusted]<&f> Rank"
        - narrate "Best way to apply for this is in <&hover[Click here to view the help page]><&click[/help discord]><&b>Discord<&end_click><&end_hover><&nl>"
        - narrate "We suggest you play for about 2-3 weeks on the server before applying"
        - narrate "This rank is awarded to players we trust to not break rules.<&nl>"
        - narrate "The perks of this rank are:"
        - narrate "<&chr[BB]> Access to <&hover[An ender chest on the go!]><&a>/ec<&end_hover>"
        - narrate "<&chr[BB]> Access to infinite <&hover[Set more homes with <&a>/sethome (name)]><&e>home sets<&end_hover>"
        - narrate "<&chr[BB]> Access to <&hover[Shows log in information about a player]><&a>/seen (player name)<&end_hover>"
        - narrate "<&chr[BB]> Access to <&hover[Put any item in your hand on your head]><&a>/hat<&end_hover>"
        - narrate "<&chr[BB]> Access to build in <&hover[A creative world]><&b>vip2<&end_hover>"
        - narrate "<&chr[BB]> Access to build in <&hover[A protected survival world]><&b>S2<&end_hover><&nl>"
      - case rank_builder:
        - narrate "<&color[#13eba2]>[Builder]<&f> Rank"
        - narrate "For the people that like building alot and want useful tools<&nl>"
        - narrate "We suggest you to get trusted beforehand and build some things in the creative world"
        - narrate "That way we can visit those builds when you apply<&nl>"
        - narrate "The perks of this rank are:"
        - narrate "<&chr[BB]> Access to most <&hover[Commands to edit large areas easily]><&e>World edit<&f><&end_hover> commands in creative worlds"
        - narrate "<&chr[BB]> Access to our special <&hover[A seperate server where everyone is OP<&nl>So you can test stuff out that<&nl>cannot safely be tested out here]><&b>builds<&f><&end_hover> server"
        - narrate "<&chr[BB]> Access to a hidden builds chat in <&hover[Click here to view the help page]><&click[/help discord]><&b>Discord<&end_click><&end_hover>"
        - narrate "In this chat others can ask for help."
        - narrate "or we discuss some upcoming server events<&nl>"
      - case rank_moderator:
        - narrate "<&color[#bf5fff]>[Mod]<&f> Rank"
        - narrate "For the people that really like helping others<&nl>"
        - narrate "This rank has alot of authority so we seek matured people"
        - narrate "Further we suggest you to be decently active, and interact with the comunity<&nl>"
        - narrate "There are too many perks to list them all"
        - narrate "But here are a few:"
        - narrate "<&chr[BB]> Access to <&hover[makes investigating easier]><&a>/fly<&end_hover>"
        - narrate "<&chr[BB]> Access to most <&hover[Our action logging system]><&a>/co commands<&end_hover>"
        - narrate "<&chr[BB]> Access to the <&hover[/mute, /jail, /warn, /tempban and /ban]><&e>moderator<&f><&end_hover> commands"
        - narrate "<&chr[BB]> Access to our staff chat in <&hover[Click here to view the help page]><&click[/help discord]><&b>Discord<&end_click><&end_hover>"
        - narrate "Where we discuss certain topics like trusted applications, ban appeals, and other moderation stuff<&nl>"
      - case rank_vip:
        - narrate "<&color[#48bfe3]>[VIP]<&f> Rank"
        - narrate "This rank costs <&a>$5<&nl>"
        - narrate "The perks of this rank are:"
        - narrate "<&chr[BB]> Access to the <&hover[A freebuild creative world]><&b>VIP world<&end_hover>"
        - narrate "<&chr[BB]> Access to <&hover[To give yourself a nickname in chat]><&a>/nick<&end_hover>"
        - narrate "<&chr[BB]> Access to chat colors, formatting, and the ability to post URL's"
        - narrate "<&chr[BB]> A custom <&color[#48bfe3]>[VIP]<&f> chat prefix<&nl>"
      - case rank_vip+:
        - narrate "<&color[#64dfdf]>[VIP+]<&f> Rank"
        - narrate "This rank costs <&a>$10"
        - narrate "If you already have <&hover[Click for more info about <&color[#48bfe3]>[VIP]]><&click[/help rank_vip]><&color[#48bfe3]>[VIP]<&end_click><&end_hover><&f> it costs <&a>$5<&nl>"
        - narrate "The perks of this rank are:"
        - narrate "<&chr[BB]> The ability to color and style your <&hover[To give yourself some color in chat]><&a>nickname<&end_hover>"
        - narrate "<&chr[BB]> The ability to use color and format codes in signs"
        - narrate "<&chr[BB]> All rewards from the <&hover[Click for more info about <&color[#48bfe3]>[VIP]]><&click[/help rank_vip]><&color[#48bfe3]>[VIP]<&end_click><&end_hover><&f> rank"
        - narrate "<&chr[BB]> A custom <&color[#64dfdf]>[VIP+]<&f> chat prefix<&nl>"
      - case rank_svip:
        - narrate "<&color[#80ffdb]>[SVIP]<&f> Rank"
        - narrate "This rank costs <&a>$20"
        - narrate "If you already have <&hover[Click for more info about <&color[#48bfe3]>[VIP]]><&click[/help rank_vip]><&color[#48bfe3]>[VIP]<&end_click><&end_hover><&f> it costs <&a>$15"
        - narrate "If you already have <&hover[Click for more info about <&color[#64dfdf]>[VIP+]]><&click[/help rank_vip+]><&color[#64dfdf]>[VIP+]<&end_click><&end_hover><&f> it costs <&a>$10<&nl>"
        - narrate "The perks of this rank are:"
        - narrate "<&chr[BB]> The ability to style armor stands with a piece of <material[flint].translated_name>"
        - narrate "<&chr[BB]> Dozens of custom player particles with <&hover[A player particle command]><&a>/aura<&end_hover>"
        - narrate "<&chr[BB]> The ability to use color and format codes in an <material[anvil].translated_name>"
        - narrate "<&chr[BB]> A special SVIP role in our <&hover[Click here to view the help page]><&click[/help discord]><&b>Discord<&end_click><&end_hover>"
        - narrate "<&chr[BB]> All rewards from <&hover[Click for more info about <&color[#48bfe3]>[VIP]]><&click[/help rank_vip]><&color[#48bfe3]>[VIP]<&end_click><&end_hover> <&hover[Click for more info about <&color[#64dfdf]>[VIP+]]><&click[/help rank_vip+]><&color[#64dfdf]>[VIP+]<&end_click><&end_hover><&f> ranks"
        - narrate "<&chr[BB]> A custom <&color[#80ffdb]>[SVIP]<&f> chat and tab prefix"
      - default:
        - narrate "Click a section below to learn more about ZeldaCraft.<&nl>"
        - narrate " <&a><&chr[BB]> <&2><&hover[View help with the ZC RPG system.]><&click[/help zcrpg]>ZeldaCraft RPG<&end_click><&end_hover>"
        - narrate " <&a><&chr[BB]> <&2><&hover[View help with the link with discord.]><&click[/help discord]>Discord<&end_click><&end_hover>"
        - narrate " <&a><&chr[BB]> <&2><&hover[View help with our crafting recipes.]><&click[/help recipes]>Recipes<&end_click><&end_hover>"
        - narrate " <&a><&chr[BB]> <&2><&hover[View help about the ranks we have.]><&click[/help ranks]>Ranks<&end_click><&end_hover><&nl>"

dungeons_command:
  type: command
  description: Warp to the dungeons world.
  usage: /dungeons
  debug: false
  name: dungeons
  script:
    - run warp_task def:dungeons
