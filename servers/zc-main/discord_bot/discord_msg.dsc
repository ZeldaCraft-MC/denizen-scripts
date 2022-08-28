d_messages:
  type: data
  debug: false
  help_msg:
    title: Command info
    description: This bot has about 20 commands you can do.<&nl><&nl>Normal commands can only be executed within <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention>.<&nl>This bots prefix is `<script[zc_bot_info].parsed_key[prefix]>`and should be used infront of all commands.
    fields:
      - <map.with[title].as[Slash commands].with[value].as[All commands are also slash commands, these slash commands can be used in any channel. Any slash commands you use are only visible for you.]>
      - <map.with[title].as[Minecraft link].with[value].as[You can also link your minecraft account to this discord command. Doing this will make any command requiring [player name] autofill it in (if no name is provided).]>
      - <map.with[title].as[Commands].with[value].as[Underneath is a list of all commands, select an option to get more info about that command.]>
    color: aqua
  help_help_msg:
    title: Help command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>help [command]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/help [command]`<&nl><&nl>Brings up the help menu with a list of all the commands<&nl>Optionally name a specific command you want to show more info for.
    color: aqua
  help_times_msg:
    title: Times command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>times [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/times [player name]`<&nl><&nl>Gives relevant timings of the given player.<&nl>The latest date these timings can go to is 2016/07/05 09:21:55<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  help_bal_msg:
    title: Bal command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>bal [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/bal [player name]`<&nl><&nl>Gives the given player's current balance<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  help_baltop_msg:
    title: Baltop command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>baltop [page number]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/baltop [page number]`<&nl><&nl>Shows the top 100 of player balances, 10 player balances per page.<&nl><&nl>The slash command does not come with next/previous page buttons, due to some technical problems.
    color: aqua
  help_stats_msg:
    title: Stats command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>stats [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/stats [player name]`<&nl><&nl>Gives the given player's ZeldaCraft statistics<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  help_finished_msg:
    title: Finished command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>finished [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/finished [player name]`<&nl><&nl>Gives a list of the given player's completed dungeons<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  help_votes_msg:
    title: Votes command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>votes` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/votes`<&nl><&nl>Gives links to the 5 voting websites we use.
    color: aqua
  help_vote_timer_msg:
    title: vote_timer command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>vote_timer [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/vote_timer [player name]`<&nl><&nl>Gives the time left until the given player can vote again for each voting website.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  help_voters_msg:
    title: Voters command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>voters [page number]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/voters [page number]`<&nl><&nl>Shows the top vote amounts of players, 10 players per page<&nl><&nl>The slash command does not come with next/previous page buttons, due to some technical problems.
    color: aqua
  help_total_votes_msg:
    title: Total_votes command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>total_votes` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/total_votes`<&nl><&nl>Gives the amount of total votes the server has recieved.
    color: aqua
  help_linkmc_msg:
    title: Linkmc command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>linkmc (player name)` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/linkmc (player name)`<&nl><&nl>Messages you ingame to confirm you are linking the correct accounts.<&nl><&nl>This command requires a valid player name to work.<&nl>The account you are trying to link has to be online during the process.<&nl><&nl>With linking your minecraft account to your discord account, the bot will automatically grab your name on commands that require a player name (if you didn't put one in)<&nl>This link cannot be undone. Only 1 discord account can be linked to 1 minecraft account.
    fields:
      - <map.with[title].as[forced].with[value].as[If a staff member deems it necesary they can force a link between your minecraft account and your discord account.]>
    color: aqua
  help_class_msg:
    title: Class command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>class [class]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/class [class]`<&nl><&nl>If no class is specified it shows you a selection menu of the classes.<&nl>If a class is specified it changes you to that class.
    color: aqua
  help_interactions_msg:
    title: Interactions command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>interactions` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/interactions` this slash command can also be done in your dms with the bot.<&nl><&nl>Shows all the interactions you currently have with the bot.<&nl>allowing you to change to or close one of those interactions
    color: aqua
  help_report_msg:
    title: Report command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>report (bug/user/grief) [name] [message]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/report (bug/user/grief) [name] [message] [attachment]` or type any bugs directly into <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bugs_channel].get[name]>].mention>.<&nl><&nl>The report command needs 1 of 3 inputs (bug/user/grief), optionally you can also include a user (if the report is a user report) or a message. If no message/user is used the bot will ask these in the dms.<&nl><&nl>Any reports sent through the bots dm can include pictures or other attachments.<&nl>Or if you input them in the attachment option.
    fields:
      - <map.with[title].as[Bug report].with[value].as[Bug reports will be posted into <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bugs_channel].get[name]>].mention> with the proper formatting. Staff members are able to mark these as `not a bug` and `fixed`. Anyone can reply to these reports.]>
      - <map.with[title].as[Bug report reply].with[value].as[To reply to a bug report you can click the reply button or reply directly to the message sent in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bugs_channel].get[name]>].mention> or right click a bug report and click reply through dms button. If you click the reply button the bot will pop up a window you can write the reply in. Inside your dms you can add images and other attachments to your replies.]>
      - <map.with[title].as[User report].with[value].as[User reports will be sent to a staff only channel, these will be properly formatted. The staff will decide what to do with this report.]>
      - <map.with[title].as[Grief report].with[value].as[Grief reports will be sent to a staff only channel, these will be properly formatted. When the staff has fixed the grief they can mark it as `cleared`.]>
    color: aqua
  help_suggestion_msg:
    title: Suggestion command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>suggestion [message]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/suggestion [message] [attachment]` or type your suggestion directly into <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[suggestion_channel].get[name]>].mention>.<&nl><&nl>If a message is included it will post it in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[suggestion_channel].get[name]>].mention> with the proper format. If no message was included, the bot will take it to your dms. Inside your dms you can include images and other attachments into your suggestion.<&nl>Or you can input them into the attachment option.
    fields:
      - <map.with[title].as[Suggestion reply].with[value].as[To reply to a suggestion you can click the reply button, or reply directly to the message sent in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[suggestion_channel].get[name]>].mention>, or right click a suggestion message and use the reply through dms button. If you click the reply button the bot will pop up a window you can write your reply in. If you go through the dms you can include attachments in your reply.]>
    color: aqua
  help_ban_appeal_msg:
    title: Ban_appeal command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>ban_appeal [player name] message]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/ban_appeal (player name) [message] [attachment]`<&nl><&nl>Posts a ban appeal for the given player in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[appeal_channel].get[name]>].mention>. if no message is included in the command the bot will take the appeal to your dms, in your dms you can add images and other attachments to the appeal.<&nl>Or you can put them into the attachment option.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  help_ticket_msg:
    title: Ticket command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>ticket [message]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/ticket [message] [attachment]`<&nl><&nl>Opens a ticket for you in a channel only staff members can see.<&nl>With this ticket all staff members will be able to talk with you through your dms.<&nl><&nl>If you do not include a message with your command the bot will take the ticket making process to your dms, in your dms you can add images and other attachments to your message.<&nl>Or you can input them into the attachment option.
    fields:
      - <map.with[title].as[Forced].with[value].as[If a staff member deems it necessary they can force a ticket open with you.]>
    color: aqua
  help_trusted_msg:
    title: Trusted command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>trusted [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/trusted (player name) [reason]`<&nl><&nl>If done through the slash command with all optional options filled in it posts the application in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[trusted_channel].get[name]>].mention>.<&nl>Otherwise the application process will be continued in your dms. Or through a pop up form you need to fill in.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    fields:
      - <map.with[title].as[Reason].with[value].as[Give us your reason you want to be trusted.]>
    color: aqua
  help_helper_msg:
    title: Helper command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>helper [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/helper (player name) [age] [reason] [helped]`<&nl><&nl>If done through the slash command with all optional options filled in it posts the application in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[helper_channel].get[name]>].mention>.<&nl>Otherwise the application process will be continued in your dms. Or through a pop up form you need to fill in.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    fields:
      - <map.with[title].as[age].with[value].as[Please provide your age in the application, this allows us to estimate your maturity]>
      - <map.with[title].as[reason].with[value].as[Give us the reason you want to become helper]>
      - <map.with[title].as[helped].with[value].as[Give us a list of people you have helped in the past, and what you did to help them.]>
    color: aqua
  help_builder_msg:
    title: Builder command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>builder [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/builder (player name) [time zone] [age] [reason] [experience] [responsible]`<&nl><&nl>If done through the slash command with all optional options filled in the bot will dm you to upload some pictures, after that the application will be posted in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[builder_channel].get[name]>].mention>.<&nl>Otherwise the application process will be continued in your dms. Or through a pop up form you need to fill in.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    fields:
      - <map.with[title].as[Time zone].with[value].as[Tell us what timezone you live in.]>
      - <map.with[title].as[age].with[value].as[Please provide your age in the application, this allows us to estimate your maturity.]>
      - <map.with[title].as[reason].with[value].as[Give us the reason you wish to be builder for this server.]>
      - <map.with[title].as[experience].with[value].as[Please say wether or not you have any experience with world edit.]>
      - <map.with[title].as[responsibility].with[value].as[We ask this question because we need to be able to trust you. So be honest with your answer.]>
    color: aqua
  help_moderator_msg:
    title: Moderator command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>moderator [player name]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/moderator (player name) (time zone) (age) (reason) (experience) (responsible) (4 questions)`<&nl><&nl>If you used the slash command it posts the application in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[mod_channel].get[name]>].mention>. Otherwise the application process will be continued in your dms.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    fields:
      - <map.with[title].as[Time zone].with[value].as[Tell us what timezone you live in.]>
      - <map.with[title].as[age].with[value].as[Please provide your age in the application, this allows us to estimate your maturity.]>
      - <map.with[title].as[reason].with[value].as[Give us the reason you wish to be moderator for this server.]>
      - <map.with[title].as[Experience].with[value].as[Please say wether you have a good understanding of the commands a mod uses, and list them.]>
      - <map.with[title].as[responsible].with[value].as[We ask this question because we need to be able to trust you. So be honest with your answer.]>
      - <map.with[title].as[Questions].with[value].as[We now ask you 4 questions, please answer them with as much detail as possible.<&nl>What commands would you use, what punishments would you give. etc. etc.]>
    color: aqua
  help_mcmmostats_msg:
    title: McMMOstats command
    description: **Usage:** `<script[zc_bot_info].parsed_key[prefix]>mcmmostats [player name] [skill]` in <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[bot_channel].get[name]>].mention> or `/mcmmostats [player name] [skill]`<&nl><&nl>If no skill was put in it will show all skills, otherwise it shows only the specified skill.<&nl><&nl>The playername is required unless you have your discord and minecraft account linked.
    color: aqua
  dm_msg:
    title: Direct Message
    description: I have sent you a direct message(DM)
    fields:
      - <map.with[title].as[Didn't recieve it.].with[value].as[If you didn't recieve a dm, make sure you allow direct messages from server members.]>
    color: aqua
  too_many_int_msg:
    title: Interactions
    description: You already have 25 interactions with the bot<&nl>This is the maximum 1 user can have, please finish some before making more
    color: red
  too_many_int_msg_slash:
    title: Interactions
    description: You already have 25 interactions with the bot<&nl>This is the maximum 1 user can have, please finish some before making more.<&nl>You can still use the slash command version of this command.
    color: red
  builder_app_pic_msg:
    title: Builder Application
    description: You now have <[attach].size> images that will be posted in your builder application<&nl>At this moment you can upload even more by posting them here!<&nl><&nl>To post your builder application hit the **post** button<&nl><&nl>To cancel your builder application hit the cancel button!
    color: aqua
  trusted_app_stop_msg:
    title: Trusted Application
    description: Your trusted application has been stopped!
    color: red
  helper_app_stop_msg:
    title: Helper Application
    description: Your helper application has been stopped!
    color: red
  builder_app_stop_msg:
    title: Builder Application
    description: Your builder application has been stopped!
    color: red
  mod_app_stop_msg:
    title: Moderator Application
    description: Your moderator application has been stopped!
    color: red
  builder_app_cancel_msg:
    title: Builder Application
    description: Your builder application has been cancelled
    color: red
  builder_app_no_pic_msg:
    title: Builder Application
    description: You did not seem to have attached any images?<&nl><&nl>You cannot upload video files, if you tried that please upload images<&nl><&nl>You can cancel the builder application by clicking the **cancel** button
    color: red
  builder_app:
    author_name: <[p].name> Builder Application
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[p].name>.html
    description: View the thread for the application
    image: <[img]>
    color: aqua
    footer: Posted by <context.interaction.user.name>
  no_name_msg:
    author_name: No player found
    description: Could not find <[name]> in our player data base.<&nl>This can have multiple reasons:<&nl>- playername was spelled wrong<&nl>- player changed their ign and you used their old name<&nl>- player hasn't been online since 2016/04/25<&nl><&nl>You can prevent this error by linking your discord account with your minecraft account<&nl>Use <script[zc_bot_info].parsed_key[prefix]>linkmc (player name) to get it setup
    color: red
  link_no_name_msg:
    author_name: No player found
    description: Could not find <[name]> in our player data base.<&nl>This can have multiple reasons:<&nl>- playername was spelled wrong<&nl>- player changed their ign and you used their old name<&nl>- player hasn't been online since 2016/04/25
    footer_icon: <context.new_message.author.avatar_url>
    footer: requested by <context.new_message.author.name>
    color: red
  noncor_name_no_link:
    title: Incorrect name
    description: The name you used was not found on our server, try again with a correct ign.
    color: red
  builder_app_post:
    title: Builder Application
    description: Your builder application has been posted succesfully
    color: lime
  mod_app_post:
    title: Moderator Application
    description: Your moderator application has been posted succesfully
    color: lime
  mod_app:
    author_name: <[p].name> Moderator Application
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[p].name>.html
    description: Time Zone<&co> **<[time]>**<&nl>Age<&co> **<[age]>**<&nl>Total time played<&co> **<[p].statistic[play_one_minute].div[20].as_duration.formatted||error>**<&nl>First login<&co> **<[p].first_played_time.format||error>**
    color: aqua
    footer: Posted by <context.interaction.user.name>
  mod_app_msg:
    author_name: <[p].name> Moderator Application
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[p].name>.html
    description: Time Zone<&co> **<[time]>**<&nl>Age<&co> **<[age]>**<&nl>Total time played<&co> **<[p].statistic[play_one_minute].div[20].as_duration.formatted||error>**<&nl>First login<&co> **<[p].first_played_time.format||error>**
    color: aqua
    footer: Posted by <context.new_message.author.name>
  cracked_msg:
    title: Cracked
    description: Cracked users will not be able to join this server.<&nl>There are multiple reasons we do not allow or support cracked users.<&nl>Below is the most relevant info about cracks.
    fields:
      - <map.with[title].as[Piracy].with[value].as[Using a cracked minecraft account is software piracy. **Software piracy is illegal**, as is supporting other people involved in software piracy. We will not willingly put our server in offline mode to let cracked players join.].with[inline].as[false]>
      - <map.with[title].as[Security].with[value].as[There are also fundamental issues with how cracked servers work internally that lead to significant security issues.].with[inline].as[false]>
      - <map.with[title].as[Plugins].with[value].as[And the last big problem. Cracked servers can mess up some key plugins we are using to maintain the server. Not to mention we would lose support on our most important plugin.].with[inline].as[false]>
    thumbnail: https://media.scoutwiki.org/images/thumb/2/28/Information.svg/256px-Information.svg.png
    color: black
  bedrock_msg:
    title: Bedrock
    description: Our server also allows bedrock minecraft accounts to join!<&nl><&co>video_game<&co> That means you can join with the Windows 10 edition, pocket edition, and console versions such as on xbox, ps4, and switch.<&nl><&nl>To join on Bedrock, the IP is still `play.zeldacraft.com` but the port you should join on is `19132`<&nl>Bedrock accounts will start with a `*` to differentiate themselves from java accounts.
    color: black
    fields:
      - <map.with[title].as[<&co>warning<&co>Please Note].with[value].as[This server has many bits and pieces that are designed to work for java clients that may break for Bedrock clients!<&nl>Despite this the core gameplay of the server should not change much when on Bedrock.].with[inline].as[false]>
    thumbnail: https://media.scoutwiki.org/images/thumb/2/28/Information.svg/256px-Information.svg.png
  greenleeuw_msg:
    title: greenleeuw
    description: greenleeuw was the developer of this bot.<&nl>Sadly as of 7/15/2022 he decided to leave the development team
    color: black
    thumbnail: https://media.scoutwiki.org/images/thumb/2/28/Information.svg/256px-Information.svg.png
  list_mod_msg:
    title: <[p].name>'s current warnings, tempbans and permbans
    description: If you got this message it means the player does not have the thing you tried to check
    thumbnail: https://images.emojiterra.com/twitter/512px/1f4dc.png
    fields:
      - <map.with[title].as[Warnings].with[value].as[<[p].flag[moderate.warnings].size||0> Warnings].with[inline].as[true]>
      - <map.with[title].as[Tempbans].with[value].as[<[p].flag[moderate.tempban].size||0> Tempbans].with[inline].as[true]>
      - <map.with[title].as[Permbans].with[value].as[<[p].flag[moderate.permban].size||0> Permbans].with[inline].as[true]>
      - <map.with[title].as[Unbans].with[value].as[<[p].flag[moderate.unban].size||0> Unbans].with[inline].as[true]>
    color: red
  ticket_msg:
    title: <[u].name>#<[u].discriminator> Ticket
    description: <[msg]>
    footer: Ticket #<[num]>
    timestamp: <util.time_now>
    thumbnail: <[u].avatar_url>
    color: aqua
  ticket_attach_msg:
    title: <[u].name>#<[u].discriminator> Ticket
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    footer: Ticket #<[num]>
    thumbnail: <[u].avatar_url>
    timestamp: <util.time_now>
    color: aqua
  ticket_attach_pic_msg:
    title: <[u].name>#<[u].discriminator> Ticket
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    footer: Ticket #<[num]>
    thumbnail: <[pic]>
    timestamp: <util.time_now>
    color: aqua
  start_ticket_cancel_msg:
    title: Starting a Ticket
    description: Your ticket start has been cancelled
    color: red
  mc_bug_msg:
    author_name: Bug report by <[p].name>
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name>/190.png
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
  mc_grief_report_msg:
    author_name: Report by <[p].name>
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name>/190.png
    description: <[msg]>
    fields:
      - <map.with[title].as[Location of report].with[value].as[<[loc]>].with[inline].as[false]>
    footer: Grief Report
  mc_user_report_msg:
    author_name: Report by <[p].name>
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name>/190.png
    description: <[p].name> reported <[player]><&nl><&nl>**Report**<&nl> <[msg]>
    footer: User report
  bug_msg:
    author_name: Bug report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
  bug_attach_msg:
    author_name: Bug report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  bug_attach_pic_msg:
    author_name: Bug report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inlinde].as[false]>
    thumbnail: <[pic]>
  mc_suggestion_title_msg:
    author_name: Suggestion by <[p].name>
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name>/190.png
    description: **<[title]>**<&nl><&nl><[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
  mc_suggestion_msg:
    author_name: Suggestion by <[p].name>
    author_icon_url: https://cravatar.eu/helmavatar/<[p].name>/190.png
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
  suggestion_msg:
    author_name: Suggestion by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
  suggestion_attach_msg:
    author_name: Suggestion by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: status - Unknown
    timestamp: <util.time_now>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  suggestion_attach_pic_msg:
    author_name: Suggestion by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    timestamp: <util.time_now>
    footer: status - Unknown
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    thumbnail: <[pic]>
  user_report_msg:
    author_name: Report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[u].name> reported <[player]><&nl><&nl>**Report**<&nl> <[msg]>
    footer: User report
  user_report_attach_msg:
    author_name: Report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[u].name> reported <[player]><&nl><&nl>**Report**<&nl> <[msg]>
    footer: User report
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  user_report_attach_pic_msg:
    author_name: Report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[u].name> reported <[player]><&nl><&nl>**Report**<&nl> <[msg]>
    footer: User report
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    thumbnail: <[pic]>
  user_report_suc_msg:
    title: Report
    description: Your user report has been posted succesfully
    color: lime
  user_report_cancel_msg:
    title: Report
    description: Your user report has been cancelled
    color: red
  grief_report_msg:
    author_name: Report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: Grief report
  grief_report_attach_msg:
    author_name: Report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: Grief report
    fields:
    - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  grief_report_attach_pic_msg:
    author_name: Report by <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    footer: Grief report
    fields:
    - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    thumbnail: <[pic]>
  grief_report_suc_msg:
    title: Report
    description: Your grief report has been posted succesfully
    color: lime
  grief_report_cancel_msg:
    title: Report
    description: Your grief report has been cancelled
    color: red
  bug_reply:
    author_name: <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
  bug_attach_reply:
    author_name: <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  bug_attach_pic_reply:
    author_name: <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    thumbnail: <[pic]>
  bug_reply_cancel_msg:
    title: Bug report reply
    description: Your reply on a bug report has been cancelled
    color: red
  bug_cancel_msg:
    title: Bug report
    description: Your bug report has been cancelled
    color: red
  bug_reply_msg:
    title: Bug report reply
    description: Type your reply out in here. It will be posted in a separate channel and can be discussed there.
    color: aqua
  bug_reply_suc_msg:
    title: Bug report reply
    description: Your reply on the bug report has been posted succesfully.
    color: lime
  bug_suc_msg:
    title: Bug report
    description: Your Bug has been reported succesfully
    color: lime
  suggestion_reply:
    author_name: <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
  suggestion_attach_reply:
    author_name: <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  suggestion_attach_pic_reply:
    author_name: <[u].name>
    author_icon_url: <[u].avatar_url>
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    thumbnail: <[pic]>
  suggestion_reply_cancel_msg:
    title: Suggestion reply
    description: Your reply on the suggestion has been cancelled
    color: red
  suggestion_cancel_msg:
    title: Suggestion
    description: Your suggestion creation has been cancelled
    color: red
  suggestion_reply_msg:
    title: Suggestion reply
    description: Type your reply out in here. It will be posted in a separate channel and will be taken in consideration.
    color: aqua
  suggestion_reply_suc_msg:
    title: Suggestion reply
    description: Your reply on the suggestion has been posted succesfully.
    color: lime
  suggestion_suc_msg:
    title: Suggestion
    description: Your Suggestion has been posted succesfully
    color: lime
  votes_msg:
    title: Votes
    description: <&chr[BB]> <&lb>TopG<&rb>(https://topg.org/minecraft-servers/server-627786)<&nl><&chr[BB]> <&lb>Minecraft MP<&rb>(https://minecraft-mp.com/server/284225/vote/)<&nl><&chr[BB]> <&lb>Minecraft Servers<&rb>(https://minecraftservers.org/server/612670)<&nl><&chr[BB]> <&lb>Minecraft List<&rb>(https://minecraftlist.org/vote/23456)<&nl><&chr[BB]> <&lb>Planet Minecraft<&rb>(https://www.planetminecraft.com/server/zeldacraft-5068967/vote/)
    footer: Do note we cannot control anything that happens on the websites end
    color: aqua
  no_ban_msg:
    title: Ban Appeal
    description: <[player].name> Does not seem to be banned
    color: red
  ban_appeal_cancel_msg:
    title: Ban Appeal
    description: Your ban appeal has been cancelled
    color: red
  ban_appeal_msg:
    author_name: <[u].name>'s Ban Appeal
    author_icon_url: https://cravatar.eu/helmavatar/<[u].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[u].name>.html
    description: <[msg]>
  ban_appeal_attach_msg:
    author_name: <[u].name>'s Ban Appeal
    author_icon_url: https://cravatar.eu/helmavatar/<[u].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[u].name>.html
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
  ban_appeal_attach_pic_msg:
    author_name: <[u].name>'s Ban Appeal
    author_icon_url: https://cravatar.eu/helmavatar/<[u].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[u].name>.html
    description: <[msg]>
    fields:
      - <map.with[title].as[Attachments].with[value].as[<[attach]>].with[inline].as[false]>
    thumbnail: <[pic]>
  trusted_1_msg:
    title: Trusted Application
    description: Thank you for wanting to apply for the trusted rank <context.new_message.author.flag[trusted_app.player].name>!<&nl><&nl>**First question<&co>** Why do you want to become trusted?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  trusted_post_msg:
    title: Trusted Application
    description: Thank you for applying for trusted.<&nl>Your application has been posted and the staff team will vote on it.<&nl>Updates on the voting can be seen in the application message
    fields:
      - <map.with[title].as[Trusted users get priveleges:].with[value].as[:large_blue_diamond: Access to /ec<&nl>`An Ender Chest on the go!`<&nl><&nl>:large_blue_diamond: Infinite home sets<&nl>`Set infinite home points with the usage of /sethome [name]`<&nl><&nl>:large_blue_diamond: Access to build in /warp vip2<&nl>`Creative world`<&nl><&nl>:large_blue_diamond: Access to build in /warp s2<&nl>`Protected survival world`<&nl><&nl>:large_blue_diamond: Access to use /craft<&nl>`A Workbench anywhere you go`].with[inline].as[false]>
    color: lime
  trusted_posting_msg:
    author_name: Trusted Application
    author_icon_url: https://cravatar.eu/helmavatar/<[pl].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[pl].name>.html
    fields:
      - <map.with[title].as[Players ign.].with[value].as[<[pl].name>].with[inline].as[false]>
      - <map.with[title].as[First Login].with[value].as[<[r_time].format>].with[inline].as[true]>
      - <map.with[title].as[Why do you want to become trusted?].with[value].as[<[reason]>].with[inline].as[false]>
    color: aqua
    footer: 0/<[half_staff]> Yesses | 0/<[staff]> Total votes
  helper_1_msg:
    title: Helper Application
    description: Thank you for wanting to apply for the helper rank <context.new_message.author.flag[helper_app.player].name>!<&nl><&nl>**First question<&co>** What is your age?
    color: aqua
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
  helper_2_msg:
    title: Helper Application
    description: **Second question<&co>** Why do you want to become a helper?
    color: aqua
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
  helper_3_msg:
    title: Helper Application
    description: **Third question<&co>** Who have you already helped? Please provide examples of what you did to help those players.
    color: aqua
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
  helper_post_msg:
    title: Helper Application
    description: Thank you for applying to become a helper.<&nl>Your application has been posted and will be voted on by the staff team.<&nl>Updates on the vorting can be seen in the application message
    fields:
      - <map.with[title].as[Helpers get priveleges:].with[value].as[:large_blue_diamond: Access to /tpo<&nl>`Teleport to anyone anytime!`<&nl><&nl>:large_blue_diamond: Limited access to /co<&nl>`Our logging system`].with[inline].as[false]>
      - <map.with[title].as[Helpers should follow the same rules as Mods].with[value].as[:large_orange_diamond: Rules<&nl>`Make sure you know the server rules.`<&nl><&nl>:large_orange_diamond: Respect<&nl>`Be respectful to other players - don't bully/abuse them.`<&nl><&nl>:large_orange_diamond: UNbiased<&nl>`Be impartial (i.e. unbiased) towards players.`<&nl><&nl>:large_orange_diamond: Mature<&sp>`Be mature and repsonsible`]>
    color: lime
  helper_posting_msg:
    author_name: Helper Application
    author_icon_url: https://cravatar.eu/helmavatar/<[pl].name||error>/190.png
    author_url: https://minecraft-statistic.net/en/player/<[pl].name>.html
    fields:
      - <map.with[title].as[Players ign].with[value].as[<[pl].name>].with[inline].as[true]>
      - <map.with[title].as[Age].with[value].as[<[age]>].with[inline].as[true]>
      - <map.with[title].as[Why would you like to be a helper?].with[value].as[<[reason]>].with[inline].as[false]>
      - <map.with[title].as[Previous new players helped].with[value].as[<[helped]>].with[inline].as[true]>
    color: aqua
    footer: 0/<[half_staff]> Yesses | 0/<[staff]> Total votes
  builder_1_msg:
    title: Builder Application
    description: Thank you for wanting to apply for the builder rank <context.new_message.author.flag[builder_app.player].name>!<&nl><&nl>**First question<&co>** In what timezone do you live? (GMT+1)
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  builder_2_msg:
    title: Builder Application
    description: **Second question<&co>** What is your age?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  builder_3_msg:
    title: Builder Application
    description: **Third question<&co>** Why do you feel you should be builder? Do you have any specific skills that would help achieve this?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  builder_4_msg:
    title: Builder Application
    description: **Fourth question<&co>** Do you have any experience with worldedit? If so, how familiar are you with its commands?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  builder_5_msg:
    title: Builder Application
    description: **Fifth question<&co>** Will you be responsible, respectful and co-operative with the staff and other builders?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_1_msg:
    title: Moderator Application
    description: Thank you for wanting to apply for the moderator rank <context.new_message.author.flag[mod_app.player].name>!<&nl><&nl>**First question<&co>** In what timezone do you live? (GMT+1)
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_2_msg:
    title: Moderator Application
    description: **Second question<&co>** What is your age? If you are under 18 we suggest you go for a helper application
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_3_msg:
    title: Moderator Application
    description: **Third question<&co>** Why do you want to be moderator?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_4_msg:
    title: Moderator Application
    description: **Fourth question<&co>** Do you have a good understanding of the commands a mod uses? If so, can you list a few
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_5_msg:
    title: Moderator Application
    description: **Fifth question<&co>** Will you be responsible, calm, mature and trustworthy?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_6_msg:
    title: Moderator Application
    description: Now we will describe four possible scenarios a mod can encounter.<&nl>Please answer them as detailed as possible!<&nl><&nl>**Case 1<&co>** Some users build has been griefed, what do you do?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_7_msg:
    title: Moderator Application
    description: **Case 2<&co>** Some users are arguing, what do you do?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_8_msg:
    title: Moderator Application
    description: **Case 3<&co>** A user is hurling abusive language at you, what do you do?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  mod_9_msg:
    title: Moderator Application
    description: **Case 4<&co>** Someone enters another person's house without their permission, what do you do?
    fields:
      - <map.with[title].as[Stop].with[value].as[You can stop this application by clicking the stop button]>
    color: aqua
  open_ints_msg:
    title: Open interactions
    description: You still have 1 or more open interactions with the bot.<&nl><&nl>Click on one of them to start or close it
    color: aqua
  smt_wrong_int_msg:
    title: Interaction
    description: Something went wrong while choosing the interaction, please try again
    color: red
  no_ints_msg:
    title: Interactions
    description: Seems like you don't have any interactions with the bot.<&nl><&nl>If you want to start one you can use one of our commands.<&nl>Or choose one of the suggested interactions below.
    color: aqua
  int_apply_msg:
    title: Applications
    description: We have 4 ranks a user can apply for.<&nl><&nl><&gt> trusted<&nl><&gt> helper<&nl><&gt> builder<&nl><&gt> moderator<&nl><&nl>You can apply for any of these ranks through their respective commands.
    color: aqua
  linkmc_ask_msg:
    title: Link Mc
    description: <[pl].name> was send an ingmae message, please check this out to complete the account linking
    color: aqua
  linkmc_suc_msg:
    title: Link Mc
    description: You and <[pl].name> Have succesfully been linked! Enjoy all the benefits this gives you.
    color: lime
  linkmc_suc_force_msg:
    title: Force Link Mc
    description: You and <[pl].name> Have been forcefully linked! Enjoy all the benefits this gives you.
    color: lime
  bal_msg:
    author_name: <[player].name>
    author_icon_url: https://cravatar.eu/helmavatar/<[player].name||error>/190.png
    title: <server.economy.format[<[player].money||0>]||error>
    color: aqua
  times_msg:
    author_icon_url: https://cravatar.eu/helmavatar/<[player].name>/190.png
    author_name: <[player].name>
    description: Underneath are all the relevant timings we could find.<&nl>The latest date we can go to is 2016/07/05 09:21:55
    fields:
      - <map.with[title].as[Total time played:].with[value].as[<[player].statistic[play_one_minute].div[20].as_duration.formatted||error>].with[inline].as[false]>
      - <map.with[title].as[First login:].with[value].as[<[player].first_played_time.format||error>].with[inline].as[false]>
      - <map.with[title].as[Last login:].with[value].as[<[player].last_played_time.format||error>].with[inline].as[false]>
      - <map.with[title].as[Time between first & last login].with[value].as[<[player].last_played_time.duration_since[<[player].first_played_time>].formatted||error>].with[inline].as[false]>
    color: aqua
  mcmmo_wrong_cmd_msg:
    title: McMMO
    description: We did not recognize this command please use one of the valid options.
    thumbnail: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStagdyunL5zpU5cfCZnvS1YKvHYQH_4Vrsng&usqp=CAU
    color: red
  mcmmo_stats_msg:
    author_name: <[player].name> McMMO Stats
    author_icon_url: https://cravatar.eu/helmavatar/<[player].name||error>/190.png
    description: <[text].separated_by[<&nl>]>
    thumbnail: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStagdyunL5zpU5cfCZnvS1YKvHYQH_4Vrsng&usqp=CAU
    color: aqua