misc_discord_commands:
  type: world
  debug: false
  events:
    on discord message command for:zc-info:
      - choose <context.command.name>:
        - case "Reply Through Dms":
          - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
          - if <context.channel.id> == <script[zc_bot_info].data_key[bugs_channel].get[id]>:
            - if <context.interaction.target_message.embed.first.map.get[footer].after[status<&sp>-<&sp>]> != Unknown:
              - discordinteraction reply interaction:<context.interaction> "This bug report is already closed"
              - stop
            - define msg <context.interaction.target_message>
            - if <context.interaction.user.flag[bot_int]||<list>> contains reply_bug:
              - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Bug report Reply].with[description].as[You are already replying to a bug report.<&nl>Please finish that one first.].with[color].as[red]>"
              - stop
            - if <context.interaction.user.flag[bot_int].size||1> >= 25:
              - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
              - stop
            - flag <context.interaction.user> cur_int:reply_bug expire:2h
            - flag <context.interaction.user> bot_int:->:reply_bug
            - flag <context.interaction.user> bug_reply_msg:<[msg]>
            - define butt <discord_button.with[id].as[stop_reply_bug].with[label].as[Cancel].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.interaction.user> <discord_embed.with_map[<script[d_messages].parsed_key[bug_reply_msg]>]> rows:<[butt]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
          - else if <context.channel.id> == <script[zc_bot_info].data_key[suggestion_channel].get[id]>:
            - if <context.interaction.target_message.embed.first.map.get[footer].after[status<&sp>-<&sp>]> != Unknown:
              - discordinteraction reply interaction:<context.interaction> "This suggestion is already accepted/declined"
              - stop
            - define msg <context.interaction.target_message>
            - if <context.interaction.user.flag[bot_int]||<list>> contains reply_sug:
              - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Suggestion Reply].with[description].as[You are already replying to a suggestion.<&nl>Please finish that one first.].with[color].as[red]>"
              - stop
            - if <context.interaction.user.flag[bot_int].size||1> >= 25:
              - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
              - stop
            - flag <context.interaction.user> cur_int:reply_sug expire:2h
            - flag <context.interaction.user> bot_int:->:reply_sug
            - flag <context.interaction.user> sug_reply_msg:<[msg]>
            - define butt <discord_button.with[id].as[stop_reply_sug].with[label].as[Cancel].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.interaction.user> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_reply_msg]>]> rows:<[butt]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
          - else:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Reply Through Dms].with[description].as[This command cannot be used here!].with[color].as[red]>"
        - case "force ticket":
          - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
          - if <context.interaction.target_message.author.is_bot>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Force Ticket].with[description].as[I cannot start a ticket with a bot].with[color].as[red]>"
            - stop
          - define u <context.interaction.target_message.author>
          - define msg <context.interaction.target_message.text>
          - if !<context.interaction.target_message.attachments.is_empty>:
            - define atta <context.interaction.target_message.attachments>
          - else:
            - define atta <list>
          - ~discordmessage id:zc-info user:<[u]> "<discord_embed.with[title].as[Forced Ticket].with[description].as[A Ticket has been forced to open.<&nl><&nl>**Ticket Message:**<&nl><&gt><&sp><[msg]>]>"
          - run create_ticket_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Force Ticket].with[description].as[Ticket opened with <[u].name>].with[color].as[lime]>"
    on discord user command name:forcelink:
      - flag <context.interaction.user> forcelink:<context.interaction.target_user>
      - inject forcelink_modal

mcmmostats_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:mcmmostats:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define player <server.match_offline_player[<context.options.get[ign]||<empty>>]||error>
      - if <[player]> == error:
        - if !<context.interaction.user.has_flag[mc_link]>:
          - define name <context.options.get[ign]||<empty>>
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
          - stop
        - define player <context.interaction.user.flag[mc_link]>
      - if <context.options.get[skill]||<empty>> == <empty>:
        - define text <list>
        - foreach <script[zc_bot_info].data_key[mcmmo_stats]> as:skill:
          - define level <[player].mcmmo.level[<[skill]>]||0>
          - define rank <[player].mcmmo.rank[<[skill]>]||0>
          - define xp <[player].mcmmo.xp[<[skill]>]||0>
          - define max_xp <[player].mcmmo.xp[<[skill]>].to_next_level||100>
          - define text "<[text].include[**<[skill]>** <&lb>Rank #<[rank]><&rb> <&lb>Level <[level]> (<[xp]>/<[max_xp]>)<&rb>]>"
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[mcmmo_stats_msg]>]>
      - else:
        - if <context.options.get[skill]> not in <script[zc_bot_info].data_key[mcmmo_stats]>:
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[McMMO Stats].with[description].as[Could not find <context.options.get[skill]> in the list of skills].with[color].as[red].with[thumbnail].as[https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStagdyunL5zpU5cfCZnvS1YKvHYQH_4Vrsng&usqp=CAU]>"
          - stop
        - define skill <context.options.get[skill]>
        - define level <[player].mcmmo.level[<[skill]>]||0>
        - define cur <[player].mcmmo.xp[<[skill]>]||0>
        - define max <[player].mcmmo.xp[<[skill]>].to_next_level||100>
        - define percent <[cur].div[<[max]>].mul[100].round_down>
        - define bar **<element[I].repeat[25].split[].insert[**].at[<[percent].div[4].round_up>].unseparated>
        - if <[bar].starts_with[****]>:
          - define bar <[bar].after_last[*]>
        - define rank <[player].mcmmo.rank[<[skill]>]||0>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[player].name> <[skill]> Stats].with[description].as[Ranked #<[rank]><&nl>[Level <[level]>] <[bar]> (<[cur]>/<[max]> xp) (<[percent]><&pc> to level <[level].add[1]>)].with[color].as[aqua].with[thumbnail].as[https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStagdyunL5zpU5cfCZnvS1YKvHYQH_4Vrsng&usqp=CAU]>"

force_link_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:force_link:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Link Mc].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define pl <server.match_offline_player[<context.options.get[ign]>]>
      - define user <context.options.get[user]>
      - flag <[pl]> discord_link:<[user]>
      - flag <[user]> mc_link:<[pl]>
      - if <[pl].is_online>:
        - narrate "You and <[user].name> Have been forced linked" targets:<[pl]> format:zc_text
      - ~discordmessage id:zc-info user:<[user]> <discord_embed.with_map[<script[d_messages].parsed_key[linkmc_suc_force_msg]>]>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Force Link].with[description].as[<[pl].name> and <[user].name> Have succesfully been linked together].with[color].as[lime]>"

linkmc_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:linkmc:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Link Mc].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define pl <server.match_offline_player[<context.options.get[ign]>]>
      - if !<[pl].is_online>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Link Mc].with[description].as[The player you want to link with is currently not online. They need to be online in order to link the accounts].with[color].as[red]>"
        - stop
      - if <[pl].has_flag[discord_link]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Link Mc].with[description].as[The player you want to link with is already linked with another discord account.].with[color].as[red]>"
        - stop
      - if <context.interaction.user.has_flag[mc_link]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Link Mc].with[description].as[You are already linked with a minecraft account].with[color].as[red]>"
        - stop
      - clickable mclink_task def.pl:<[pl]> def.user:<context.interaction.user> usages:1 for:<[pl]> until:1h save:mclick
      - narrate "Discord user <context.interaction.user.name>#<context.interaction.user.discriminator> wants to link this account with discord" targets:<[pl]> format:zc_text
      - narrate "If this was not you ignore this message!" targets:<[pl]> format:zc_text
      - narrate "If this was you <&e><&click[<entry[mclick].command>]><&hover[Click to link the accounts]>Click here<&end_hover><&end_click><&f>" targets:<[pl]> format:zc_text
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[linkmc_ask_msg]>]>

warnings_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:warnings:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define p <server.match_offline_player[<context.options.get[ign]>]||error>
      - if !<[p].has_flag[moderate.warnings]>:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[list_mod_msg]>]>
        - stop
      - if <[p].flag[moderate.warnings].size> > 25:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Warnings].with[description].as[They have more then 25 warnings, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"
        - stop
      - define warns <list>
      - foreach <[p].flag[moderate.warnings].keys> as:num:
        - define time <[p].flag[moderate.warnings.<[num]>.time].format>
        - if "<[p].flag[moderate.warnings.<[num]>.reason].contains_all_text[You have been warned for]>":
          - define reason "<[p].flag[moderate.warnings.<[num]>.reason].after[You have been warned for]>"
        - else:
          - define reason <[p].flag[moderate.warnings.<[num]>.reason]>
        - define by <[p].flag[moderate.warnings.<[num]>.by_player].name>
        - define warns "<[warns].include[<map.with[title].as[<[reason]>].with[value].as[By: <[by]><&nl>Time: <[time]>].with[inline].as[true]>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Warnings].with[description].as[<[p].name> has <[p].flag[moderate.warnings].size||0> warnings].with[color].as[yellow].with_map[<map.with[fields].as[<[warns]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"

votes_slash_cmds:
  type: world
  debug: false
  events:
    on discord slash command name:total_votes:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define total_votes 0
      - foreach <server.flag[top_voters_all].keys> as:player:
        - define num <server.flag[top_voters_all].get[<[player]>]>
        - define total_votes <[total_votes].add[<[num]>]>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[total_votes]> total votes found].with[color].as[aqua]>"
    on discord slash command name:vote_timer:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define player <server.match_offline_player[<context.options.get[player]||nooneyoucanthinkoff>]||error>
      - if <[player]> == error:
        - if !<context.interaction.user.has_flag[mc_link]>:
          - define name <context.options.get[player]||<empty>>
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
          - stop
        - define player <context.interaction.user.flag[mc_link]>
      - define sites <list>
      - foreach <script[voting_sites].data_key[sites].keys> as:site:
        - if !<[player].has_flag[voted_<[site]>]>:
          - define sites "<[sites].include[<[site]> <&chr[BB]> **Ready to vote**]>"
        - else:
          - define sites "<[sites].include[<[site]> <&chr[BB]> **<[player].flag_expiration[voted_<[site]||error>].from_now.formatted||error> left**]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[author_name].as[<[player].name> Vote Timers].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name||error>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name||error>/64.png].with[description].as[<[sites].separated_by[<&nl>]>].with[color].as[green]>"
    on discord slash command name:voters:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.options.keys.contains[page]>:
        - define page <context.options.get[page]>
      - else:
        - define page 1
      - define max <server.flag[top_voters_all].size.div[10].round_up>
      - if <[page]> < 1:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Voters].with[description].as[You cannot go lower then 1].with[color].as[red]>"
        - stop
      - if <[page]> > <[max]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Voters].with[description].as[You cannot go higher then the max].with[color].as[red]>"
        - stop
      - define start <[page].sub[1].mul[10].add[1]>
      - if <[start]> == 0:
        - define start 1
      - define end <[page].mul[10]>
      - define voters <list>
      - foreach <server.flag[top_voters_all].sort_by_value.keys.reverse>:
        - if <[loop_index]> < <[start]>:
          - foreach next
        - if <[loop_index]> > <[end]>:
          - foreach stop
        - define voters "<[voters].include[<[loop_index]>. <[value].name> - **<server.flag[top_voters_all].get[<[value]>]>**]>"
      - if <[voters].is_empty>:
        - define voters "<list[No one voted at all, or something went wrong]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Top voters all time].with[description].as[<[voters].separated_by[<&nl>]>].with[footer].as[<[page]>/<[max]>].with[color].as[aqua]>"
    on discord slash command name:votes:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[votes_msg]>]>

baltop_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:baltop:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define page_size 10
      - if <context.options.get[page]||<empty>> != <empty>:
        - define page <context.options.get[page]||<empty>>
      - else:
        - define page 1
      - if <[page]> < 1:
        - define page 1
      - if <[page]> > 10:
        - define page 10
      - define start <[page].sub[1].mul[<[page_size]>].add[1].max[1].min[91]>
      - define end <[start].add[<[page_size]>].sub[1].max[1].min[100]>
      - define output <list[]>
      - ~webget http://localhost:8080/baltop?offset=<[start].sub[1]>&size=<[page_size].min[<element[100].sub[<[start].sub[1]>]>]> save:request
      - yaml loadtext:<entry[request].result> id:<context.interaction.user>-baltop
      - foreach <yaml[<context.interaction.user>-baltop].read[result]> as:data:
        - define num <[loop_index].add[<[start].sub[1]>]>
        - define pre "#<[num]>: <[data].get[name]>"
        - define "output:|:<[pre]> <element[].pad_right[<element[140].sub[<[pre].text_width>].div_int[2]>].with[.]> <server.economy.format[<[data].get[money]>]><&r>"
      - yaml unload id:<context.interaction.user>-baltop
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[author_name].as[ZeldaCraft Baltop page <[page]>].with[author_icon_url].as[<discord[zc-info].self_user.avatar_url>].with[description].as[Shows the top server balances<&nl>(potentially) type a page number after baltop (1-10)].add_field[Top Balances].value[<[output].parse[strip_color].separated_by[<n>]>].with[color].as[aqua]>"

times_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:times:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define player <server.match_offline_player[<context.options.get[ign]||<empty>>]||error>
      - if <[player]> == error:
        - if !<context.interaction.user.has_flag[mc_link]>:
          - define name <context.options.get[ign]||<empty>>
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
          - stop
        - define player <context.interaction.user.flag[mc_link]>
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[times_msg]>]>

stats_slash_cmd:
  type: world
  debug: false
  pvp_ranks:
    0: Deku Scrub
    100: Octorok
    300: Tektite
    600: Armos
    1000: Moblin
    1400: Wolfos
    2000: Stalfos
    2600: ReDead
    3200: Gibdo
    3800: Darknut
    4400: Iron Knuckle
    5000: Bongo Bongo
    5500: Phantom Ganon
    6000: Dark Link
    6600: Morpha
    7200: Zant
    7800: Ghirahim
    8400: Majora
    9000: Agahnim
    10000: Nightmare
    12000: Yuga Ganon
    14000: Ganondorf
    16000: Ganon
    19999: Return of Ganon
  events:
    on discord slash command name:stats:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define player <server.match_offline_player[<context.options.get[ign]||<empty>>]||error>
      - if <[player]> == error:
        - if !<context.interaction.user.has_flag[mc_link]>:
          - define name <context.options.get[ign]||<empty>>
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
          - stop
        - define player <context.interaction.user.flag[mc_link]>
      - define uuid <[player].uuid>
      - if !<yaml.list.contains[<[uuid]>]>:
        - ~webget http://localhost:8080/players/<[uuid]> save:request
        - if <entry[request].failed>:
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name||error>/190.png].with[description].as[This player isn't registered to zc].with[color].as[red]>"
          - stop
        - yaml loadtext:<entry[request].result> id:<[uuid]>
        - define unload true
      - define pvp_points <yaml[<[uuid]>].read[pvppoints]>
      - define max_magic <yaml[<[uuid]>].read[completed_dungeons].size.mul[3].add[<yaml[<[uuid]>].read[completed_secrets].size>].add[100]>
      - foreach <script.list_keys[pvp_ranks].sort_by_number[].reverse> as:score:
        - if <[pvp_points]> >= <[score]>:
          - define rank <script.data_key[pvp_ranks.<[score]>]>
          - foreach stop
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[Here is all the zcrpg stats we could find].add_field[Race].value[<yaml[<[uuid]>].read[race].strip_color||error>].add_inline_field[Dungeon Points].value[<yaml[<[uuid]>].read[completed_dungeons].size><&nl>To see all completed dungeons use the finished command].add_field[Secret Points].value[<yaml[<[uuid]>].read[completed_secrets].size>].add_field[Magic Meter].value[<yaml[<[uuid]>].read[magicmeter]>/<[max_magic]>].add_inline_field[PVP Points].value[<[pvp_points]>].add_field[Rank].value[<[rank]>].with[color].as[aqua]>"
      - if <[unload]||false>:
        - yaml unload id:<[uuid]>

finished_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:finished:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define player <server.match_offline_player[<context.options.get[ign]||<empty>>]||error>
      - if <[player]> == error:
        - if !<context.interaction.user.has_flag[mc_link]>:
          - define name <context.options.get[ign]||<empty>>
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
          - stop
        - define player <context.interaction.user.flag[mc_link]>
      - define uuid <[player].uuid>
      - if !<yaml.list.contains[<[uuid]>]>:
        - ~webget http://localhost:8080/players/<[uuid]> save:request
        - if <entry[request].failed>:
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name||error>/190.png].with[description].as[This player isn't registered to zc].with[color].as[red]>"
          - stop
        - yaml loadtext:<entry[request].result> id:<[uuid]>
        - define unload true
      - define dungeons <yaml[<[uuid]>].read[completed_dungeons]>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[player].name> has finished <[dungeons].size||0> dungeons].add_field[Dungeons].value[<[dungeons].pad_right[1].with[none].separated_by[ -|- ]>].with[color].as[aqua]>"
      - if <[unload]||false>:
        - yaml unload id:<[uuid]>

bal_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:bal:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - define player <server.match_offline_player[<context.options.get[ign]||<empty>>]||error>
      - if <[player]> == error:
        - if !<context.interaction.user.has_flag[mc_link]>:
          - define name <context.options.get[ign]||<empty>>
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
          - stop
        - define player <context.interaction.user.flag[mc_link]>
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[bal_msg]>]>

bans_slash_cmds:
  type: world
  debug: false
  events:
    on discord slash command name:tempbans:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define p <server.match_offline_player[<context.options.get[ign]>]||error>
      - if !<[p].has_flag[moderate.tempban]>:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[list_mod_msg]>]>
        - stop
      - if <[p].flag[moderate.tempban].size> > 25:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Tempbans].with[description].as[They have more then 25 tempbans, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"
        - stop
      - define temps <list>
      - foreach <[p].flag[moderate.tempban].keys> as:num:
        - define time <[p].flag[moderate.tempban.<[num]>.time_now].format>
        - define until "<[p].flag[moderate.tempban.<[num]>.time_now].add[<[p].flag[moderate.tempban.<[num]>.time_till]>].format> (<duration[<[p].flag[moderate.tempban.<[num]>.time_till]>].formatted>)"
        - define by <[p].flag[moderate.tempban.<[num]>.by_player].name>
        - define reason <[p].flag[moderate.tempban.<[num]>.reason]>
        - define ip <[p].flag[moderate.tempban.<[num]>.was_ip]>
        - if <[ip]>:
          - define ip_person <[p].flag[moderate.tempban.<[num]>.ip_person].name>
          - define temps "<[temps].include[<map.with[title].as[<[reason]>].with[value].as[Time: <[time]><&nl>Until: <[until]><&nl>By: <[by]><&nl>Was IP: <[ip]><&nl>IP Person: <[ip_person]>].with[inline].as[true]>]>"
        - else:
          - define temps "<[temps].include[<map.with[title].as[<[reason]>].with[value].as[Time: <[time]><&nl>Until: <[until]><&nl>By: <[by]><&nl>Was IP: <[ip]>].with[inline].as[true]>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Tempbans].with[description].as[<[p].name> has <[p].flag[moderate.tempban].size||0> tempbans].with[color].as[aqua].with_map[<map.with[fields].as[<[temps]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"
    on discord slash command name:permbans:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define p <server.match_offline_player[<context.options.get[ign]>]||error>
      - if !<[p].has_flag[moderate.permban]>:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[list_mod_msg]>]>
        - stop
      - if <[p].flag[moderate.permban].size> > 25:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Permbans].with[description].as[They have more then 25 permbans, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"
        - stop
      - define perms <list>
      - foreach <[p].flag[moderate.permban].keys> as:num:
        - define time <[p].flag[moderate.permban.<[num]>.time_now].format>
        - define by <[p].flag[moderate.permban.<[num]>.by_player].name>
        - define reason <[p].flag[moderate.permban.<[num]>.reason]>
        - define ip <[p].flag[moderate.permban.<[num]>.was_ip]>
        - if <[ip]>:
          - define ip_person <[p].flag[moderate.permban.<[num]>.ip_person].name>
          - define perms "<[perms].include[<map.with[title].as[<[reason]>].with[value].as[Time: <[time]><&nl>By: <[by]><&nl>Was IP: <[ip]><&nl>IP Person: <[ip_person]>].with[inline].as[true]>]>"
        - else:
          - define perms "<[perms].include[<map.with[title].as[<[reason]>].with[value].as[Time: <[time]><&nl>By: <[by]><&nl>Was IP: <[ip]>].with[inline].as[true]>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Permbans].with[description].as[<[p].name> has <[p].flag[moderate.permban].size||0> permbans].with[color].as[orange].with_map[<map.with[fields].as[<[perms]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"
    on discord slash command name:unbans:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define p <server.match_offline_player[<context.options.get[ign]>]||error>
      - if !<[p].has_flag[moderate.unban]>:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[list_mod_msg]>]>
        - stop
      - if <[p].flag[moderate.unban].size> > 25:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Unbans].with[description].as[They have more then 25 unbans, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"
        - stop
      - define unbans <list>
      - foreach <[p].flag[moderate.unban].keys> as:num:
        - define by <[p].flag[moderate.unban.<[num]>.by_player].name.if_null[<[p].flag[moderate.unban.<[num]>.by_player]>]>
        - define time <[p].flag[moderate.unban.<[num]>.time].format>
        - define valu <list>
        - if <[p].has_flag[moderate.unban.<[num]>.reason]>:
          - define valu "<[valu].include[Reason: <[p].flag[moderate.unban.<[num]>.reason]>]>"
          - define valu "<[valu].include[Source: <[p].flag[moderate.unban.<[num]>.source]>]>"
          - define valu "<[valu].include[Created: <[p].flag[moderate.unban.<[num]>.created].format>]>"
          - if <[p].has_flag[moderate.unban.<[num]>.expiration]>:
            - define valu "<[valu].include[Expiration: <[p].flag[moderate.unban.<[num]>.expiration].format> (<[p].flag[moderate.unban.<[num]>.expiration].duration_since[<[p].flag[moderate.unban.<[num]>.created]>].formatted>)]>"
          - define ip <[p].flag[moderate.unban.<[num]>.was_ip]||false>
          - if <[ip]>:
            - define ip_person <[p].flag[moderate.unban.<[num]>.ip_person].name>
            - define unbans "<[unbans].include[<map.with[title].as[<[time]>].with[value].as[By: <[by]><&nl><[valu].separated_by[<&nl>]><&nl>Was IP: <[ip]><&nl>IP Person: <[ip_person]>].with[inline].as[true]>]>"
        - else:
          - define unbans "<[unbans].include[<map.with[title].as[<[time]>].with[value].as[By: <[by]><&nl><[valu].separated_by[<&nl>]><&nl>Was IP: <[ip]>].with[inline].as[true]>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[p].name>'s Unbans].with[description].as[<[p].name> has <[p].flag[moderate.unban].size||0> Unbans].with[color].as[black].with_map[<map.with[fields].as[<[unbans]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>"

interactions_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:interactions:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if !<context.interaction.user.has_flag[bot_int]> || <context.interaction.user.flag[bot_int].is_empty>:
        - inject sug_int_menu
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_ints_msg]>]> rows:<[selection]>
        - stop
      - else:
        - define options <list>
        - foreach <context.interaction.user.flag[bot_int]> as:int:
          - define i <script[d_dm_data].data_key[id_name].get[<[int]>]||<[int].replace[_].with[<&sp>#].to_titlecase>>
          - definemap option:
              label: <[i]>
              value: <[int]>
              description: Start or close the <[i]> interaction
          - define options <[options].include[<[loop_index]>/<[option]>]>
        - define selection "<discord_selection.with[placeholder].as[Choose an interaction].with[id].as[int_menu].with[options].as[<[options].to_map>]>"
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[open_ints_msg]>]> rows:<[selection]>

trusted_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:trusted:
      - if <context.options.keys.size> <= 1:
        - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
          - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
          - stop
        - define pl <server.match_offline_player[<context.options.get[ign]>]||error>
        - flag <context.interaction.user> trusted_app.player:<[pl]>
        - inject trusted_modal
        - stop
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define pl <server.match_offline_player[<context.options.get[ign]>]||error>
      - define r_time <[pl].first_played_time>
      - define reason <context.options.get[reason]>
      - define ruuid <util.random_uuid>
      - define staff <list>
      - foreach <script[zc_bot_info].data_key[upvote_roles].values> as:role:
        - define staff <[staff].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>]>]>
      - define staff <[staff].deduplicate.size.sub[2]>
      - define half_staff <[staff].sub[1].div[2].round_down.add[1]>
      - definemap butts:
          1:
            1: <discord_button.with[id].as[trusted_up_<[ruuid]>].with[label].as[Upvote].with[style].as[success]>
            2: <discord_button.with[id].as[trusted_down_<[ruuid]>].with[label].as[Downvote].with[style].as[danger]>
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[trusted_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[trusted_posting_msg]>]> rows:<[butts]> save:app
      - flag <entry[app].message.channel> <[ruuid]>.msg:<entry[app].message>
      - flag <entry[app].message.channel> <[ruuid]>.player:<[pl]>
      - flag <entry[app].message.channel> <[ruuid]>.yesses:0
      - flag <entry[app].message.channel> <[ruuid]>.votes:0
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[trusted_post_msg]>]>

helper_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:helper:
      - if <context.options.keys.size> <= 1:
        - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
          - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
          - stop
        - define pl <server.match_offline_player[<context.options.get[ign]>]||error>
        - flag <context.interaction.user> helper_app.player:<[pl]>
        - inject helper_modal
        - stop
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define pl <server.match_offline_player[<context.options.get[ign]>]||error>
      - define age <context.options.get[age]>
      - define reason <context.options.get[reason]>
      - define helped <context.options.get[helped]>
      - define ruuid <util.random_uuid>
      - define staff <list>
      - foreach <script[zc_bot_info].data_key[upvote_roles].values> as:role:
        - define staff <[staff].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>]>]>
      - define staff <[staff].deduplicate.size.sub[2]>
      - define half_staff <[staff].sub[1].div[2].round_down.add[1]>
      - definemap butts:
          1:
            1: <discord_button.with[id].as[helper_up_<[ruuid]>].with[label].as[Upvote].with[style].as[success]>
            2: <discord_button.with[id].as[helper_down_<[ruuid]>].with[label].as[Downvote].with[style].as[danger]>
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[helper_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[helper_posting_msg]>]> rows:<[butts]> save:app
      - flag <entry[app].message.channel> <[ruuid]>.msg:<entry[app].message>
      - flag <entry[app].message.channel> <[ruuid]>.player:<[pl]>
      - flag <entry[app].message.channel> <[ruuid]>.yesses:0
      - flag <entry[app].message.channel> <[ruuid]>.votes:0
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[helper_post_msg]>]>

builder_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:builder:
      - if <context.options.keys.size> <= 1:
        - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
          - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
          - stop
        - flag <context.interaction.user> builder_app.player:<context.options.get[ign]>
        - inject builder_modal
        - stop
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.interaction.user.flag[bot_int].size> >= 25:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
        - stop
      - if <context.interaction.user.flag[bot_int].contains[builder_app_pic]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[1 interaction].with[description].as[You already have a builder application interaction going with the bot.<&nl>Please cancel that one first before continuing with this one.].with[color].as[red]>"
        - stop
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - flag <context.interaction.user> bot_int:->:builder_app_pic
      - if <context.interaction.user.has_flag[cur_int]>:
        - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Builder Application].with[description].as[Your current interaction with the bot has been changed to: Builder Application].with[color].as[aqua]>"
      - flag <context.interaction.user> cur_int:builder_app_pic expire:2h
      - flag <context.interaction.user> builder_app:<context.options>
      - flag <context.interaction.user> builder_app_attach:!
      - define butt <discord_button.with[id].as[builder_cancel].with[label].as[Cancel!].with[style].as[danger]>
      - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Builder Application].with[description].as[Please upload the pictures in here<&nl>To cancel the application click the **cancel** button].with[color].as[aqua]>" rows:<[butt]>
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>

moderator_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:moderator:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>]||error> == error:
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[noncor_name_no_link]>]>
        - stop
      - define p <server.match_offline_player[<context.options.get[ign]>]||error>
      - define age <context.options.get[age]>
      - define time <context.options.get[time_zone]>
      - define ruuid <util.random_uuid>
      - define butt <discord_button.with[id].as[close_thread_<[ruuid]>].with[label].as[Close].with[style].as[secondary]>
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[mod_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mod_app]>]> rows:<[butt]> save:msg
      - ~discordcreatethread id:zc-thread "name:<[p].name> Moderator Application" message:<entry[msg].message> save:thread
      - flag <entry[msg].message.channel> <[ruuid]>:<entry[thread].created_thread>
      - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
      - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>
      - define mods <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>]>]>
      - define users <list[<context.interaction.user>].include[<[owners]>].include[<[admins]>].include[<[mods]>].deduplicate>
      - foreach <[users]> as:user:
        - adjust <entry[thread].created_thread> add_thread_member:<[user]>
      - wait <[users].size.div[2]>s
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "Moderator Application:<&nl><&nl>In Game Name: **<[p].name>**<&nl>Time Zone: **<[time]>**<&nl>Age: **<[age]>**"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Why do you want to be mod?**<&nl><&gt><&gt><&gt> <context.options.get[reason]>"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Do you have a good understanding of the commands a mod uses?(and list them)**<&nl><&gt><&gt><&gt> <context.options.get[experience]>"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Will you be responsible, calm, mature, and trustworthy?**<&nl><&gt><&gt><&gt> <context.options.get[responsible]>"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Some users build has been griefed, what do you do?**<&nl><&gt><&gt><&gt> <context.options.get[question_1]>"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Some users are arguing, what do you do?**<&nl><&gt><&gt><&gt> <context.options.get[question_2]>"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**A user is hurling abusive language at you, what do you do?**<&nl><&gt><&gt><&gt> <context.options.get[question_3]>"
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Someone enters another person's house without their permission, what do you do?**<&nl><&gt><&gt><&gt> <context.options.get[question_4]>"
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[mod_app_post]>]>

ban_appeal_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:ban_appeal:
      - define player <server.match_offline_player[<context.options.get[ign]>]||error>
      - if <[player]> == error:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define name <context.options.get[ign]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]>
        - stop
      - if !<[player].is_banned>:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[no_ban_msg]>]>
        - stop
      - flag <context.interaction.user> ban_appeal.player:<[player]>
      - if <context.options.get[circumstances]||<empty>> == <empty> || <context.options.get[reason]||<empty>> == <empty> || <context.options.get[message]||<empty>> == <empty>:
        - inject ban_appeal_modal
        - stop
      - else:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define use <context.interaction.user>
        - define u <[player]>
        - define msg "**Explain the circumstances surrounding your ban**<&nl><context.options.get[circumstances]><&nl><&nl>**Why should we remove or reconsider your ban**<&nl><context.options.get[reason]><&nl><&nl>**Do you have anything else to say to staff or players about your ban**<&nl><context.options.get[message]>"
        - if <context.options.get[attachment]||<empty>> != <empty>:
          - define atta <list[<context.options.get[attachment]>]>
        - else:
          - define atta <list>
        - run create_ban_appeal_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]> def.use:<[use]>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Succesfully posted].with[color].as[lime]>"

ticket_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:ticket:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.options.get[message]||<empty>> == <empty>:
        - if <context.interaction.user.flag[bot_int].contains[start_ticket]>:
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ticket Creation].with[description].as[You cannot have more then one ticket creations going on at once].with[color].as[red]>"
          - stop
        - if <context.interaction.user.flag[bot_int].size> >= 25:
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
          - stop
        - if <context.interaction.user.has_flag[cur_int]>:
          - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Ticket Creation].with[description].as[Your current interaction with the bot has been changed to: Ticket Creation].with[color].as[aqua]>"
        - flag <context.interaction.user> cur_int:start_ticket expire:2h
        - flag <context.interaction.user> bot_int:->:start_ticket
        - define butt <discord_button.with[id].as[ticket_cancel].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Ticket Creation].with[description].as[Type your question/message for the stff team in here]>" rows:<[butt]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
      - else:
        - if <context.interaction.user.flag[bot_int].size> >= 25:
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
          - stop
        - define u <context.interaction.user>
        - define msg <context.options.get[message]>
        - if <context.options.get[attachment]||<empty>> != <empty>:
          - define atta <list[<context.options.get[attachment]>]>
        - else:
          - define atta <list>
        - run create_ticket_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>

help_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:help:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.options.get[command]||error> == error:
        - inject help_menu
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[help_msg]>]> rows:<[selection]>
      - else:
        - if <context.options.get[command]> !in <list[help|bal|baltop|times|stats|finished|votes|vote_timer|voters|total_votes|linkmc|class|report|suggestion|ban_appeal|ticket|trusted|helper|builder|moderator|interactions|mcmmostats]>:
          - inject help_menu
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[help_msg]>]> rows:<[selection]>
          - stop
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[help_<context.options.get[command]>_msg]>]>

report_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:report:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - choose <context.options.get[type]>:
        - case bug:
          - if <context.options.get[message]||<empty>> == <empty>:
            - if <context.interaction.user.flag[bot_int].contains[post_bug]>:
              - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Bug report].with[description].as[You cannot report more then one bug at a time].with[color].as[red]>"
              - stop
            - if <context.interaction.user.flag[bot_int].size> >= 25:
              - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
              - stop
            - if <context.interaction.user.has_flag[cur_int]>:
              - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Bug report].with[description].as[Your current interaction with the bot has been changed to: Reporting a bug].with[color].as[aqua]>"
            - flag <context.interaction.user> cur_int:post_bug expire:2h
            - flag <context.interaction.user> bot_int:->:post_bug
            - define butt <discord_button.with[id].as[stop_bug].with[label].as[Cancel!].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Bug report].with[description].as[Type your bug report in here]>" rows:<[butt]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
          - else:
            - define u <context.interaction.user>
            - define msg <context.options.get[message]>
            - if <context.options.get[attachment]||<empty>> != <empty>:
              - define atta <list[<context.options.get[attachment]>]>
            - else:
              - define atta <list>
            - run create_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[bug_suc_msg]>]>
        - case user:
          - if <context.options.get[message]||<empty>> == <empty>:
            - if <context.interaction.user.flag[bot_int].contains[post_u_report]>:
              - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Report].with[description].as[You cannot report more then one user at a time].with[color].as[red]>"
              - stop
            - if <context.interaction.user.flag[bot_int].size> >= 25:
              - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
              - stop
            - if <context.interaction.user.has_flag[cur_int]>:
              - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Report].with[description].as[Your current interaction with the bot has been changed to: User report].with[color].as[aqua]>"
            - flag <context.interaction.user> cur_int:post_u_report_1 expire:2h
            - flag <context.interaction.user> bot_int:->:post_u_report_1
            - define butt <discord_button.with[id].as[stop_u_report].with[label].as[Cancel!].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Report].with[description].as[Type the name of the user in here]>" rows:<[butt]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
          - else:
            - if <context.options.get[user]||<empty>> == <empty>:
              - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Report].with[description].as[You did not include a user in the report].with[color].as[red]>"
              - stop
            - define player <context.options.get[user]>
            - define u <context.interaction.user>
            - define msg <context.options.get[message]>
            - if <context.options.get[attachment]||<empty>> != <empty>:
              - define atta <list[<context.options.get[attachment]>]>
            - else:
              - define atta <list>
            - run create_u_report_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]> def.player:<[player]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[user_report_suc_msg]>]>
        - case grief:
          - if <context.options.get[message]||<empty>> == <empty>:
            - if <context.interaction.user.flag[bot_int].contains[post_g_report]>:
              - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Report].with[description].as[You cannot report more then one grief at a time].with[color].as[red]>"
              - stop
            - if <context.interaction.user.flag[bot_int].size> >= 25:
              - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
              - stop
            - if <context.interaction.user.has_flag[cur_int]>:
              - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Report].with[description].as[Your current interaction with the bot has been changed to: Grief report].with[color].as[aqua]>"
            - flag <context.interaction.user> cur_int:post_g_report expire:2h
            - flag <context.interaction.user> bot_int:->:post_g_report
            - define butt <discord_button.with[id].as[stop_g_report].with[label].as[Cancel!].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Report].with[description].as[Type your grief report in here.].with[footer].as[Don't forget to include coords]>" rows:<[butt]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
          - else:
            - define u <context.interaction.user>
            - define msg <context.options.get[message]>
            - if <context.options.get[attachment]||<empty>> != <empty>:
              - define atta <list[<context.options.get[attachment]>]>
            - else:
              - define atta <list>
            - run create_g_report_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[grief_report_suc_msg]>]>

class_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:class:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.options.get[role]||<empty>> != <empty>:
        - define class <context.options.get[role]>
        - define roles <list[]>
        - foreach <list[Hylian|Zora|Goron|Minish|Yiga|Twili|Sheikah|Rito]> as:role:
          - define roles <[roles].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains_any[<[roles]>]>:
          - define r_roles <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].filter_tag[<[roles].contains[<[filter_value]>]>]>
          - foreach <[r_roles]> as:r_role:
            - ~discord id:zc-info remove_role user:<context.interaction.user> role:<[r_role]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
        - if <[class]> != remove:
          - ~discord id:zc-info add_role user:<context.interaction.user> role:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[class]>]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
          - define thumbnail <script[zc_bot_info].parsed_key[classes].get[<[class]>]>
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Class Select].with[description].as[Your class has been changed to <[class]>].with[thumbnail].as[<[thumbnail]>].with[color].as[aqua]>"
      - else:
        - inject class_menu
        - ~discordinteraction reply interaction:<context.interaction> "Pick a class" rows:<[selection]>

suggestion_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:suggestion:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.options.get[message]||<empty>> == <empty>:
        - if <context.interaction.user.flag[bot_int].contains[post_sug]>:
          - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Suggestion].with[description].as[You cannot have more then one suggestion creations going on at once].with[color].as[red]>"
          - stop
        - if <context.interaction.user.flag[bot_int].size> >= 25:
          - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
          - stop
        - if <context.interaction.user.has_flag[cur_int]>:
          - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Suggestion Creation].with[description].as[Your current interaction with the bot has been changed to: Suggestion Creation].with[color].as[aqua]>"
        - flag <context.interaction.user> cur_int:post_sug expire:2h
        - flag <context.interaction.user> bot_int:->:post_sug
        - define butt <discord_button.with[id].as[stop_sug].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Suggestion].with[description].as[Type your suggestion in here]>" rows:<[butt]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
      - else:
        - define u <context.interaction.user>
        - define msg <context.options.get[message]>
        - if <context.options.get[attachment]||<empty>> != <empty>:
          - define atta <list[<context.options.get[attachment]>]>
        - else:
          - define atta <list>
        - run create_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_suc_msg]>]>

force_ticket_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:force_ticket:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <context.options.get[user].is_bot>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Force Ticket].with[description].as[I cannot start a ticket with a bot].with[color].as[red]>"
        - stop
      - define u <context.options.get[user]>
      - define msg <context.options.get[message]>
      - if <context.options.get[attachment]||<empty>> != <empty>:
        - define atta <list[<context.options.get[attachment]>]>
      - else:
        - define atta <list>
      - ~discordmessage id:zc-info user:<[u]> "<discord_embed.with[title].as[Forced Ticket].with[description].as[A Ticket has been forced to open.<&nl><&nl>**Ticket Message:**<&nl><&gt><&sp><[msg]>]>"
      - run create_ticket_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Force Ticket].with[description].as[Ticket opened with <[u].name>].with[color].as[lime]>"

tempban_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:tempban:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Tempban].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if <[player].groups.contains_any[gm|admin|moderator]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Tempban].with[description].as[You are not allowed to ban <[player].name>].with[color].as[red]>"
        - stop
      - define message <context.options.get[reason]>
      - define time_now <util.time_now>
      - define time <duration[<context.options.get[time]>]>
      - if !<context.interaction.user.has_flag[mc_link]>:
        - define by_player <server.match_offline_player[Zeldacraft]>
      - else:
        - define by_player <context.interaction.user.flag[mc_link]>
      - define num <[player].flag[moderate.tempban].size.add[1]||1>
      - flag <[player]> moderate.tempban.<[num]>.by_player:<[by_player]>
      - flag <[player]> moderate.tempban.<[num]>.reason:<[message]>
      - flag <[player]> moderate.tempban.<[num]>.time_till:<[time]>
      - flag <[player]> moderate.tempban.<[num]>.time_now:<[time_now]>
      - flag <[player]> moderate.tempban.<[num]>.was_ip:false
      - ban <[player]> reason:<[message]> duration:<[time]> source:<[by_player].name>
      - define has_perm <[player].has_flag[moderate.permban]>
      - define has_temp <[player].has_flag[moderate.tempban]>
      - define has_warn <[player].has_flag[moderate.warnings]>
      - narrate "<&1>Tempban From <&3><[by_player].name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&3>Player: <&f><[player].name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&3>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&3>Until: <&f><[time_now].add[<[time]>].format> (<[time].formatted>)" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&3>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&3><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[by_player].name> has tempbanned <[player].name>].add_field[Tempban Reason:].value[<[message]>].add_inline_field[Time of tempban:].value[<util.time_now.format>].add_inline_field[Tempban until:].value[<util.time_now.add[<[time]>].format> (<duration[<[time]>].formatted>)].add_field[Ip tempban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[<[by_player].name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<[by_player].name>/190.png].with[timestamp].as[<util.time_now>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Tempbanned].with[description].as[Succesfully tempbanned <[player].name>  for <[message]> until <[time_now].add[<[time]>].format> (<[time].formatted>)].with[color].as[aqua]>"

permban_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:permban:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Permban].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if <[player].groups.contains_any[gm|admin|moderator]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Permban].with[description].as[You are not allowed to ban <[player].name>].with[color].as[red]>"
        - stop
      - define message <context.options.get[reason]>
      - define time_now <util.time_now>
      - if !<context.interaction.user.has_flag[mc_link]>:
        - define by_player <server.match_offline_player[Zeldacraft]>
      - else:
        - define by_player <context.interaction.user.flag[mc_link]>
      - define num <[player].flag[moderate.permban].size.add[1]||1>
      - flag <[player]> moderate.permban.<[num]>.by_player:<[by_player]>
      - flag <[player]> moderate.permban.<[num]>.reason:<[message]>
      - flag <[player]> moderate.permban.<[num]>.time_now:<[time_now]>
      - flag <[player]> moderate.permban.<[num]>.was_ip:false
      - ban <[player]> reason:<[message]> source:<[by_player].name>
      - define has_perm <[player].has_flag[moderate.permban]>
      - define has_temp <[player].has_flag[moderate.tempban]>
      - define has_warn <[player].has_flag[moderate.warnings]>
      - narrate "<&4>Permban From <&c><[by_player].name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&c>Player: <&f><[player].name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&c>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&c>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&c><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[by_player].name> has permbanned <[player].name>].add_field[Permban Reason:].value[<[message]>].add_inline_field[Time of permpban:].value[<[time_now].format>].add_field[Ip tempban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[<[by_player].name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<[by_player].name>/190.png].with[timestamp].as[<util.time_now>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Permban].with[description].as[Succesfully permbanned <[player].name>  for <[message]>].with[color].as[aqua]>"

warn_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:warn:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Warn].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if <[player].groups.contains_any[gm|admin|moderator]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Warn].with[description].as[You are not allowed to warn <[player].name>].with[color].as[red]>"
        - stop
      - define message <context.options.get[reason]>
      - define time_now <util.time_now>
      - if !<context.interaction.user.has_flag[mc_link]>:
        - define by_player <server.match_offline_player[Zeldacraft]>
      - else:
        - define by_player <context.interaction.user.flag[mc_link]>
      - if <[player].is_online>:
        - clickable confirm_warn def:<[player]> save:conf_click
        - narrate "<&e>You have been <&6>warned:<&nl>" targets:<[player]>
        - narrate "<&e>Reason: <&f><[message]>" targets:<[player]>
        - narrate "<&e>Time: <&f><[time_now].format><&nl>" targets:<[player]>
        - narrate "<&e>Click <&click[<entry[conf_click].command>]><&hover[Confirm to stop the warning message from reappearing]><&a>[Confirm]<&end_hover><&end_click><&e> to confirm that you received this" targets:<[player]>
      - flag <[player]> new_warnings:->:<map.with[<[message]>].as[<[time_now]>]>
      - define num <[player].flag[moderate.warnings].size.add[1]||1>
      - flag <[player]> moderate.warnings.<[num]>.by_player:<[by_player]>
      - flag <[player]> moderate.warnings.<[num]>.reason:<[message]>
      - flag <[player]> moderate.warnings.<[num]>.time:<[time_now]>
      - define has_perm <[player].has_flag[moderate.permban]>
      - define has_temp <[player].has_flag[moderate.tempban]>
      - define has_warn <[player].has_flag[moderate.warnings]>
      - narrate "<&6>Warning From <&e><[by_player].name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e>Player: <&f><[player].name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[by_player].name> has warned <[player].name>].add_field[Warning Reason:].value[<[message]>].add_field[Time of warning:].value[<util.time_now.format>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[yellow].with[footer].as[<[by_player].name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<[by_player].name>/190.png].with[timestamp].as[<util.time_now>]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Warn].with[description].as[Succesfully warned <[player].name>  for <[message]>].with[color].as[aqua]>"

mute_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:mute:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Mute].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if <[player].groups.contains_any[gm|admin|moderator]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Mute].with[description].as[You are not allowed to mute <[player].name>].with[color].as[red]>"
        - stop
      - define dur <duration[<context.options.get[time]>]>
      - execute as_server "mute <[player].name> <context.options.get[time]>"
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Mute].with[description].as[<[player].name> has been muted for <[dur].formatted>].with[color].as[aqua]>"

jail_slash_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:jail:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Jail].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if <[player].groups.contains_any[gm|admin|moderator]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Jail].with[description].as[You are not allowed to jail <[player].name>].with[color].as[red]>"
        - stop
      - define time <context.options.get[time].as[duration]>
      - define jail cell1
      - define time_now <util.time_now>
      - if !<context.interaction.user.has_flag[mc_link]>:
        - define by_player <server.match_offline_player[Zeldacraft]>
      - else:
        - define by_player <context.interaction.user.flag[mc_link]>
      - define num <[player].flag[moderate.jail].size.add[1]||1>
      - flag <[player]> moderate.jail.<[num]>.by_player:<[by_player]>
      - flag <[player]> moderate.jail.<[num]>.jail:<[jail]>
      - flag <[player]> moderate.jail.<[num]>.time_till:<[time]>
      - flag <[player]> moderate.jail.<[num]>.time_now:<[time_now]>
      - if <[player].has_flag[jailed]>:
        - teleport <[player]> <server.flag[jails.<[jail]>]>
        - define tel <[player].flag[jailed]>
        - flag <[player]> jailed:<[tel]> expire:<[time]>
        - flag <[player]> moderate.jail.<[num]>.is_change:true
        - narrate "Your jail time has been changed to <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text targets:<[player]>
        - narrate "<[player].name>'s jail time has been changed to <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted> <&f>inside <&e><[jail]> <&f>by <[by_player].name>" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]]>
      - else:
        - define tel <[player].location>
        - teleport <[player]> <server.flag[jails.<[jail]>]>
        - flag <[player]> jailed:<[tel]> expire:<[time]>
        - flag <[player]> moderate.jail.<[num]>.is_change:false
        - narrate "<&f>You have been <&4>jailed <&f>for <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text targets:<[player]>
        - narrate "<&c>You do the crime, you do the time." format:zc_text targets:<[player]>
        - narrate "<[by_player].name> has jailed <[player].name> in <&e><[jail]> <&f>for <&a><[player].flag_expiration[jailed].duration_since[<util.time_now>].formatted>" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]]>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Jail].with[description].as[Succesfully jailed <[player].name> in <[jail]> for <[time].formatted>].with[color].as[aqua]>"
      
unjail_slash_command:
  type: world
  debug: false
  events:
    on discord slash command name:unjail:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnJail].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if !<[player].has_flag[jailed]>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnJail].with[description].as[<[player].name> does not seem to be jailed].with[color].as[red]>"
        - stop
      - define tel <[player].flag[jailed]>
      - define num <[player].flag[moderate.unjail].size.add[1]||1>
      - if !<context.interaction.user.has_flag[mc_link]>:
        - define by_player <server.match_offline_player[Zeldacraft]>
      - else:
        - define by_player <context.interaction.user.flag[mc_link]>
      - flag <[player]> moderate.unjail.<[num]>.by_player:<[by_player]>
      - flag <[player]> moderate.unjail.<[num]>.expire:<[player].flag_expiration[jailed]>
      - flag <[player]> moderate.unjail.<[num]>.time_now:<util.time_now>
      - flag <[player]> jailed:!
      - teleport <[player]> <[tel]>
      - narrate "You have been unjailed!" format:zc_text targets:<[player]>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnJail].with[description].as[You succesfully unjailed <[player].name].with[color].as[aqua]>"
      - narrate "[Discord]<context.interaction.user.name> unjailed <[player].name>" format:zc_text targets:<server.online_players.filter[has_permission[zc.mod]]>
  
 unban_slash_command:
  type: world
  debug: false
  events:
    on discord slash command name:unban:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnBan].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if !<[player].is_banned>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnBan].with[description].as[<[player].name> does not seem to be banned].with[color].as[red]>"
        - stop
      - define num <[player].flag[moderate.unban].size.add[1]||1>
      - define discord no_ban
      - define discord ban
      - define reason <[player].ban_reason>
      - define source <[player].ban_source>
      - if <[player].ban_expiration_time||never> != never:
        - define discord ban_expiration
        - define expiration <[player].ban_expiration_time>
      - define created <[player].ban_created_time>
      - if !<context.interaction.user.has_flag[mc_link]>:
        - define by_player <server.match_offline_player[Zeldacraft]>
      - else:
        - define by_player <context.interaction.user.flag[mc_link]>
      - flag <[player]> moderate.unban.<[num]>.by_player:<[by_player]>
      - flag <[player]> moderate.unban.<[num]>.time:<util.time_now>
      - flag <[player]> moderate.unban.<[num]>.reason:<[reason]>
      - flag <[player]> moderate.unban.<[num]>.source:<[source]>
      - if <[player].ban_expiration_time||never> != never:
        - flag <[player]> moderate.unban.<[num]>.expiration:<[expiration]>
      - flag <[player]> moderate.unban.<[num]>.created:<[created]>
      - flag <[player]> moderate.unban.<[num]>.was_ip:false
      - ban <[player]> remove source:<[by_player].name>
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnBan].with[description].as[<[player].name> has succesfully been unbanned].with[color].as[aqua]>"
      - choose <[discord]>:
        - case no_ban:
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[by_player].name> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<[by_player].name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<[by_player].name>/190.png].with[timestamp].as[<util.time_now>]>"
        - case ban:
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[by_player].name> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[reason]>].add_field[Ban source:].value[<[source]>].add_inline_field[Ban creation time:].value[<[created].format>].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<[by_player].name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<[by_player].name>/190.png].with[timestamp].as[<util.time_now>]>"
        - case ban_expiration:
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[by_player].name> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[reason]>].add_field[Ban source:].value[<[source]>].add_inline_field[Ban creation time:].value[<[created].format>].add_inline_field[Ban expiration time].value[<[expiration].format> (<[expiration].duration_since[<[created]>].formatted>)].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<[by_player].name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<[by_player].name>/190.png].with[timestamp].as[<util.time_now>]>"
 
unmute_slash_command:
  type: world
  debug: false
  events:
    on discord slash command name:unmute:
      - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
      - if <server.match_offline_player[<context.options.get[ign]>].if_null[error]> == error:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnMute].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
        - stop
      - define player <server.match_offline_player[<context.options.get[ign]>]>
      - if !<[player].is_muted>:
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[UnMute].with[description].as[<[player].name> does not seem to be mutes].with[color].as[red]>"
        - stop
      - adjust <[player]> is_muted:false
      - ~discordinteraction reply interaction:<context.interaction> "discord_embed.with[title].as[UnMute].with[description].as[<[player].name> has succesfully been unmuted].with[color].as[aqua]>"

