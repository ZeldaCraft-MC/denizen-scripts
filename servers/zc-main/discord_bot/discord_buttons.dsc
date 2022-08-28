suggestion_buttons:
    type: task
    debug: false
    definitions: ruuid
    script:
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[deny_suggestion_<[ruuid]>].with[label].as[Deny].with[style].as[danger]>
                2: <discord_button.with[id].as[reply_suggestion_<[ruuid]>].with[label].as[Reply].with[style].as[secondary]>
                3: <discord_button.with[id].as[accept_suggestion_<[ruuid]>].with[label].as[Accept].with[style].as[success]>

report_buttons:
    type: task
    debug: false
    definitions: ruuid
    script:
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[cleared_report_<[ruuid]>].with[label].as[Cleared].with[style].as[success]>
                2: <discord_button.with[id].as[report_notif_role].with[label].as[Notify].with[style].as[secondary]>

bugreport_buttons:
    type: task
    debug: false
    definitions: ruuid
    script:
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[deny_bug_<[ruuid]>].with[label].as[Not a Bug].with[style].as[danger]>
                2: <discord_button.with[id].as[reply_bug_<[ruuid]>].with[label].as[Reply].with[style].as[secondary]>
                3: <discord_button.with[id].as[accept_bug_<[ruuid]>].with[label].as[Fixed].with[style].as[success]>

voters_buttons:
    type: task
    debug: false
    definitions: ruuid
    script:
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[voters_left_<[ruuid]>].with[label].as[Previous].with[style].as[secondary].with[emoji].as[⬅️]>
                2: <discord_button.with[id].as[voters_right_<[ruuid]>].with[label].as[Next].with[style].as[secondary].with[emoji].as[➡️]>

baltop_buttons:
    type: task
    debug: false
    definitions: ruuid
    script:
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[baltop_left_<[ruuid]>].with[label].as[Previous].with[style].as[secondary].with[emoji].as[⬅️]>
                2: <discord_button.with[id].as[baltop_right_<[ruuid]>].with[label].as[Next].with[style].as[secondary].with[emoji].as[➡️]>

ban_appeal_buttons:
    type: task
    debug: false
    definitions: ruuid
    script:
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[ban_appeal_unban_<[ruuid]>].with[label].as[Unban].with[style].as[success]>
                2: <discord_button.with[id].as[ban_appeal_check_<[ruuid]>].with[label].as[Check ban].with[style].as[primary]>
                3: <discord_button.with[id].as[ban_appeal_close_<[ruuid]>].with[label].as[Close].with[style].as[danger]>

sug_int_menu:
    type: task
    debug: false
    script:
        - definemap options:
            1:
                label: Ticket
                value: ticket
                description: Start a ticket with the staff team
            2:
                label: Suggestion
                value: sug
                description: Post a suggestion for the server
            3:
                label: Bug report
                value: bug_report
                description: Report a bug you have found
            4:
                label: Applications
                value: apply
                description: Apply for one of our ranks
        - define selection "<discord_selection.with[placeholder].as[Interaction Suggestions].with[id].as[sug_int_menu].with[options].as[<[options]>]>"

help_menu:
    type: task
    debug: false
    script:
        - definemap options:
            1:
                label: help [command]
                value: help
                description: Get more info about the help command
            2:
                label: times [player name]
                value: times
                description: Get more info about the time command
            3:
                label: bal [player name]
                value: bal
                description: Get more info about the time command
            4:
                label: baltop [page number]
                value: baltop
                description: Get more info about the baltop command
            5:
                label: stats [player name]
                value: stats
                description: Get more info about the stats command
            6:
                label: finished [player name]
                value: finished
                description: Get more info about the finished command
            7:
                label: votes
                value: votes
                description: Get more info about the votes command
            8:
                label: vote_timer [player name]
                value: vote_timer
                description: Get more info about the vote timer command
            9:
                label: voters [page number]
                value: voters
                description: Get more info about the voters commmand
            10:
                label: total_votes
                value: total_votes
                description: Get more info about the total_votes command
            11:
                label: linkmc (player name)
                value: linkmc
                description: Get more info about the linkmc command
            12:
                label: class [class]
                value: class
                description: Get more info about the class command
            13:
                label: report (bug/user/grief) [user] [message]
                value: report
                description: Get more info about the report command
            14:
                label: suggestion [message]
                value: suggestion
                description: Get more info about the suggestion command
            15:
                label: ban_appeal [player name] [message]
                value: ban_appeal
                description: Get more info about the ban appeal command
            16:
                label: ticket [message]
                value: ticket
                description: Get more info about the ticket command
            17:
                label: trusted [player name]
                value: trusted
                description: Get more info about the trusted application command
            18:
                label: helper [player name]
                value: helper
                description: Get more info about the helper application command
            19:
                label: builder [player name]
                value: builder
                description: Get more info about the builder application command
            20:
                label: moderator [player name]
                value: moderator
                description: Get more info about the moderator application command
            21:
                label: interactions
                value: interactions
                description: Shows you all the interactions you have with the bot
            22:
                label: mcmmostats [player name] [skill]
                value: mcmmostats
                description: Get more info about the McMMOstats command
        - define selection "<discord_selection.with[placeholder].as[All commands].with[id].as[help_menu].with[options].as[<[options]>]>"

class_menu:
    type: task
    debug: false
    script:
        - definemap options:
            1:
                label: Hylian
                value: role_hylian
                description: Become a Hylian
                emoji: ⚔️
            2:
                label: Zora
                value: role_zora
                description: Become a Zora
                emoji: 🐟
            3:
                label: Goron
                value: role_goron
                description: Become a Goron
                emoji: 🌋
            4:
                label: Minish
                value: role_minish
                description: Become a Minish
                emoji: 🍀
            5:
                label: Yiga
                value: role_yiga
                description: Become a Yiga
                emoji: 👁️
            6:
                label: Twili
                value: role_twili
                description: Become a Twili
                emoji: 🐺
            7:
                label: Sheikah
                value: role_sheikah
                description: Become a Sheikah
                emoji: 🥷
            8:
                label: Rito
                value: role_rito
                description: Become a Rito
                emoji: 🐦
            9:
                label: Remove
                value: role_remove
                description: Remove your class
                emoji: 🚫
        - define selection "<discord_selection.with[placeholder].as[Pick a class].with[id].as[class_select].with[options].as[<[options]>]>"

d_butt_w:
    type: world
    debug: false
    events:
        on discord selection used id:sug_int_menu for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - choose <context.option.get[value]>:
            - case ticket:
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
                - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Ticket Creation].with[description].as[Type your question/message for the staff team in here]>" rows:<[butt]>
                - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
            - case sug:
                - if <context.interaction.user.flag[bot_int].contains[post_sug]>:
                    - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Suggestion].with[description].as[You cannot have more then one suggestion creations going on at once].with[color].as[red]>"
                    - stop
                - if <context.interaction.user.flag[bot_int].size> >= 25:
                    - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
                    - stop
                - if <context.interaction.user.has_flag[cur_int]>:
                    - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Suggestion].with[description].as[Your current interaction with the bot has been changed to: Suggestion Creation].with[color].as[aqua]>"
                - flag <context.interaction.user> cur_int:post_sug expire:2h
                - flag <context.interaction.user> bot_int:->:post_sug
                - define butt <discord_button.with[id].as[stop_sug].with[label].as[Cancel!].with[style].as[danger]>
                - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Suggestion].with[description].as[Type your suggestion in here]>" rows:<[butt]>
                - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
            - case bug_report:
                - if <context.interaction.user.flag[bot_int].contains[post_bug]>:
                    - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Bug report].with[description].as[You cannot report more then one bug at a time].with[color].as[red]>"
                    - stop
                - if <context.interaction.user.flag[bot_int].size> >= 25:
                    - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
                    - stop
                - if <context.interaction.user.has_flag[cur_int]>:
                    - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Bug report].with[description].as[Your current interaction with the bot has been changed to: Bug report].with[color].as[aqua]>"
                - flag <context.interaction.user> cur_int:post_bug expire:2h
                - flag <context.interaction.user> bot_int:->:post_bug
                - define butt <discord_button.with[id].as[stop_bug].with[label].as[Cancel!].with[style].as[danger]>
                - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Bug report].with[description].as[Type your bug in here]>" rows:<[butt]>
                - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
            - case apply:
                - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[int_apply_msg]>]>
        on discord selection used id:int_menu for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.interaction.user.has_flag[bot_int]>:
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[smt_wrong_int_msg]>]>
            - stop
        - if !<context.interaction.user.flag[bot_int].contains[<context.option.get[value]>]>:
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[smt_wrong_int_msg]>]>
            - stop
        - definemap buttons:
            1:
                1: <discord_button.with[id].as[start_int_<context.option.get[value]>].with[label].as[Start].with[style].as[success]>
                2: <discord_button.with[id].as[close_int_<context.option.get[value]>].with[label].as[Close].with[style].as[danger]>
        - define i <script[d_dm_data].data_key[id_name].get[<context.option.get[value]>]||<context.option.get[value].replace[_].with[<&sp>#].to_titlecase>>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[i]> Interaction].with[description].as[Choose what you want to do with <[i]><&nl><&nl>**Start** will put you back into the interaction where you left off<&nl>**Close** Will stop the interaction and remove it.]>" rows:<[buttons]>
        on discord button clicked id:start_int_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:<context.button.map.get[id].after[start_int_]>
        - define i <script[d_dm_data].data_key[id_name].get[<context.button.map.get[id].after[start_int_]>]||<context.button.map.get[id].after[start_int_].replace[_].with[<&sp>#].to_titlecase>>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[i]> Interaction].with[description].as[<[i]> Has been resumed].with[color].as[lime]>"
        on discord button clicked id:close_int_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if <context.button.map.get[id].after[close_int_].starts_with[ticket_]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ticket Interaction].with[description].as[Only staff members can close this ticket!<&nl><&nl>I've sent a message in their chat notifying them you wish for it to be closed!].with[color].as[red]>"
            - ~discordmessage id:zc-info channel:<context.interaction.user.flag[ticket.<context.button.map.get[id].after[close_int_ticket_]>]> "<discord_embed.with[author_name].as[<context.interaction.user.name>].with[author_icon_url].as[<context.interaction.user.avatar_url>].with[description].as[Wishes this ticket to be closed!].with[color].as[red]>"
            - stop
        - flag <context.interaction.user> bot_int:<-:<context.button.map.get[id].after[close_int_]>
        - define i <script[d_dm_data].data_key[id_name].get[<context.button.map.get[id].after[close_int_]>]||<context.button.map.get[id].after[close_int_].replace[_].with[<&sp>#].to_titlecase>>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[i]> Interaction].with[description].as[<[i]> Has been closed].with[color].as[red]>"
        on discord selection used id:help_menu for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[help_<context.option.get[value]>_msg]>]>
        on discord selection used id:class_select for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define roles <list[]>
        - foreach <list[Hylian|Zora|Goron|Minish|Yiga|Twili|Sheikah|Rito]> as:role:
            - define roles <[roles].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains_any[<[roles]>]>:
            - define r_roles <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].filter_tag[<[roles].contains[<[filter_value]>]>]>
            - foreach <[r_roles]> as:r_role:
                - ~discord id:zc-info remove_role user:<context.interaction.user> role:<[r_role]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
        - choose <context.option.get[value].after[role_]>:
            - case remove:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<context.option.get[emoji]> Class Selection <context.option.get[emoji]>].with[description].as[Your class has been remove].with[color].as[aqua]>"
            - default:
                - ~discord id:zc-info add_role user:<context.interaction.user> role:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<context.option.get[value].after[role_]>]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<context.option.get[emoji]> Class Selection <context.option.get[emoji]>].with[description].as[You have chosen to become a<&nl><context.option.get[label]> <context.option.get[emoji]>].with[color].as[aqua]>"
        on discord button clicked id:report_notif_role for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]> contains report_announce:
            - ~discord id:zc-info remove_role user:<context.interaction.user> role:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[report_announce]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
            - ~discordinteraction interaction:<context.interaction> reply "<discord_embed.with[title].as[Announcements].with[description].as[You will no longer receive a ping when a report comes in!<&nl><&nl>If you want to receive a ping again simply click the button again.].with[color].as[red]>"
        - else:
            - ~discord id:zc-info add_role user:<context.interaction.user> role:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[report_announce]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
            - ~discordinteraction interaction:<context.interaction> reply "<discord_embed.with[title].as[Announcements].with[description].as[You will now receive a ping when a report comes in!<&nl><&nl>If you want to stop receiving these pings simply click the button again.].with[color].as[lime]>"
        on discord button clicked id:baltop_left_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define msg <context.channel.flag[<context.button.map.get[id].after[baltop_left_]>]>
        - define page <[msg].flag[cur_page].sub[1]||1>
        - define page_size 10
        - if <[page]> < 1:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Baltop].with[description].as[The page number cannot go below 1!].with[color].as[red]>"
            - stop
        - if <[page]> > 10:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Baltop].with[description].as[The page number cannot go above 10!].with[color].as[red]>"
            - stop
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
        - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with[author_name].as[ZeldaCraft Baltop page <[page]>].with[author_icon_url].as[<discord[zc-info].self_user.avatar_url>].with[description].as[Shows the top server balances<&nl>(potentially) type a page number after baltop (1-10)<&nl>Or use the buttons below].add_field[Top Balances].value[<[output].parse[strip_color].separated_by[<n>]>].with[color].as[aqua]>"
        - flag <[msg]> cur_page:<[page]>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Baltop].with[description].as[Page has been changed].with[color].as[lime]>"
        on discord button clicked id:baltop_right_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define msg <context.channel.flag[<context.button.map.get[id].after[baltop_right_]>]>
        - define page <[msg].flag[cur_page].add[1]||1>
        - if <[page]> < 1:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Baltop].with[description].as[The page number cannot go below 1!].with[color].as[red]>"
            - stop
        - if <[page]> > 10:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Baltop].with[description].as[The page number cannot go above 10!].with[color].as[red]>"
            - stop
        - define page_size 10
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
        - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with[author_name].as[ZeldaCraft Baltop page <[page]>].with[author_icon_url].as[<discord[zc-info].self_user.avatar_url>].with[description].as[Shows the top server balances<&nl>(potentially) type a page number after baltop (1-10)<&nl>Or use the buttons below].add_field[Top Balances].value[<[output].parse[strip_color].separated_by[<n>]>].with[color].as[aqua]>"
        - flag <[msg]> cur_page:<[page]>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Baltop].with[description].as[Page has been changed].with[color].as[lime]>"
        on discord button clicked id:voters_left_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define msg <context.channel.flag[<context.button.map.get[id].after[voters_left_]>]>
        - define page <[msg].flag[cur_page].sub[1]||1>
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
        - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with[title].as[Top voters all time].with[description].as[<[voters].separated_by[<&nl>]>].with[footer].as[<[page]>/<[max]>].with[color].as[aqua]>"
        - flag <[msg]> cur_page:<[page]>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Voters].with[description].as[Page has been changed].with[color].as[lime]>"
        on discord button clicked id:voters_right_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define msg <context.channel.flag[<context.button.map.get[id].after[voters_right_]>]>
        - define page <[msg].flag[cur_page].add[1]||1>
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
        - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with[title].as[Top voters all time].with[description].as[<[voters].separated_by[<&nl>]>].with[footer].as[<[page]>/<[max]>].with[color].as[aqua]>"
        - flag <[msg]> cur_page:<[page]>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Voters].with[description].as[Page has been changed].with[color].as[lime]>"
        on discord button clicked id:reply_bug_* for:zc-info:
        - if !<context.channel.has_flag[<context.button.map.get[id].after[reply_bug_]>]>:
            - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
            - discordinteraction reply interaction:<context.interaction> "This suggestion is already accepted/declined"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[reply_bug_]>]>
        - flag <context.interaction.user> bug_reply_msg:<[msg]>
        - inject bug_reply_modal
        on discord button clicked id:trusted_up_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define ruuid <context.button.map.get[id].after[trusted_up_]>
        - if !<context.channel.has_flag[<[ruuid]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Voting].with[description].as[This trusted application is no longer active!].with[color].as[red]>"
            - stop
        - define pl <context.channel.flag[<[ruuid]>].get[player]>
        - if !<context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[id].contains_any[<script[zc_bot_info].data_key[upvote_roles].keys>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Voting].with[description].as[You do not have permission to vote!].with[color].as[red]>"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Wrong Vote].with[description].as[<context.interaction.user.name> tried to vote on a trusted application].with[footer].as[<[pl].name>'s app'].with[color].as[red]>"
            - stop
        - define msg <context.channel.flag[<[ruuid]>].get[msg]>
        - define changed false
        - if <context.interaction.user.flag[voted_on].keys.if_null[<list>]> contains <[ruuid]>:
            - define changed true
            - flag <context.channel> <[ruuid]>.votes:--
            - if <context.interaction.user.flag[voted_on.<[ruuid]>]> == yes:
                - flag <context.channel> <[ruuid]>.yesses:--
        - flag <context.interaction.user> voted_on.<[ruuid]>:yes
        - define staff <list>
        - foreach <script[zc_bot_info].data_key[upvote_roles].values> as:role:
            - define staff <[staff].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>]>]>
        - flag <context.channel> <[ruuid]>.votes:++
        - flag <context.channel> <[ruuid]>.yesses:++
        - define staff <[staff].deduplicate.size.sub[2]>
        - define amount <[staff].sub[1].div[2].round_down>
        - define half_staff <[amount].add[1]>
        - define new_msg <[msg].embed.first.map>
        - if <context.channel.flag[<[ruuid]>.yesses]> > <[amount]>:
            - execute as_server "lp user <[pl].name> parent add trusted"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Auto trusted upgrade].with[description].as[<[pl].name> has been automatically upgraded to trusted with <context.channel.flag[<[ruuid]>.yesses]> votes<&nl>Final vote by: <context.interaction.user.name> | <&lb>Link<&rb>(<[msg].url>)].with[color].as[lime]>"
            - if <[changed]>:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Upvote].with[description].as[Your vote has been changed<&nl><&nl>Thanks to your vote <[pl].name> has been upgraded to trusted!].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - else:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Upvote].with[description].as[Thanks to your vote <[pl].name> has been upgraded to trusted!].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes].with[color].as[lime]>"
            - flag <context.channel> <[ruuid]>:!
        - else:
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Trusted upvote from <context.interaction.user.name>].with[description].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes | <&lb>Link<&rb>(<[msg].url>)].with[color].as[yellow].with[footer].as[<[pl].name>'s app]>"
            - if <[changed]>:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Upvote].with[description].as[Your vote has been changed].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - else:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Upvote].with[description].as[Thank you for voting].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        on discord button clicked id:trusted_down_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define ruuid <context.button.map.get[id].after[trusted_down_]>
        - if !<context.channel.has_flag[<[ruuid]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Voting].with[description].as[This trusted application is no longer active!].with[color].as[red]>"
            - stop
        - define pl <context.channel.flag[<[ruuid]>].get[player]>
        - if !<context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[id].contains_any[<script[zc_bot_info].data_key[upvote_roles].keys>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Voting].with[description].as[You do not have permission to vote!].with[color].as[red]>"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Wrong Vote].with[description].as[<context.interaction.user.name> tried to vote on a trusted application].with[footer].as[<[pl].name>'s app'].with[color].as[red]>"
            - stop
        - define msg <context.channel.flag[<[ruuid]>].get[msg]>
        - define changed false
        - if <context.interaction.user.flag[voted_on].keys.if_null[<list>]> contains <[ruuid]>:
            - define changed true
            - flag <context.channel> <[ruuid]>.votes:--
            - if <context.interaction.user.flag[voted_on.<[ruuid]>]> == yes:
                - flag <context.channel> <[ruuid]>.yesses:--
        - flag <context.interaction.user> voted_on.<[ruuid]>:no
        - define staff <list>
        - foreach <script[zc_bot_info].data_key[upvote_roles].values> as:role:
            - define staff <[staff].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>]>]>
        - flag <context.channel> <[ruuid]>.votes:++
        - define staff <[staff].deduplicate.size.sub[2]>
        - define amount <[staff].sub[1].div[2].round_down>
        - define half_staff <[amount].add[1]>
        - define new_msg <[msg].embed.first.map>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Trusted downvote from <context.interaction.user.name>].with[description].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes | <&lb>Link<&rb>(<[msg].url>)].with[color].as[yellow].with[footer].as[<[pl].name>'s app]>"
        - if <[changed]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Downvote].with[description].as[Your vote has been changed].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        - else:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Trusted Downvote].with[description].as[Thank you for voting].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        - if <context.channel.flag[<[ruuid]>.votes]> > <[amount].sub[<context.channel.flag[<[ruuid]>.yesses]||0>]>:
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes].with[color].as[red]>"
            - flag <context.channel> <[ruuid]>:!
        - else:
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        on discord button clicked id:helper_up_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define ruuid <context.button.map.get[id].after[helper_up_]>
        - if !<context.channel.has_flag[<[ruuid]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Voting].with[description].as[This helper application is no longer active!].with[color].as[red]>"
            - stop
        - define pl <context.channel.flag[<[ruuid]>].get[player]>
        - if !<context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[id].contains_any[<script[zc_bot_info].data_key[upvote_roles].keys>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Voting].with[description].as[You do not have permission to vote!].with[color].as[red]>"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Wrong Vote].with[description].as[<context.interaction.user.name> tried to vote on a helper application].with[footer].as[<[pl].name>'s app].with[color].as[red]>"
            - stop
        - define msg <context.channel.flag[<[ruuid]>].get[msg]>
        - define changed false
        - if <context.interaction.user.flag[voted_on].keys.if_null[<list>]> contains <[ruuid]>:
            - define changed true
            - flag <context.channel> <[ruuid]>.votes:--
            - if <context.interaction.user.flag[voted_on.<[ruuid]>]> == yes:
                - flag <context.channel> <[ruuid]>.yesses:--
        - flag <context.interaction.user> voted_on.<[ruuid]>:yes
        - define staff <list>
        - foreach <script[zc_bot_info].data_key[upvote_roles].values> as:role:
            - define staff <[staff].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>]>]>
        - flag <context.channel> <[ruuid]>.votes:++
        - flag <context.channel> <[ruuid]>.yesses:++
        - define staff <[staff].deduplicate.size.sub[2]>
        - define amount <[staff].sub[1].div[2].round_down>
        - define half_staff <[amount].add[1]>
        - define new_msg <[msg].embed.first.map>
        - if <context.channel.flag[<[ruuid]>.yesses]> > <[amount]>:
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[admin_channel].get[id]> "<discord_embed.with[title].as[Helper Upgrade].with[description].as[<[pl].name> can now be upgraded to helper].with[color].as[lime]>"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Helper Upgrade].with[description].as[<[pl].name> can now be upgraded to helper with <context.channel.flag[<[ruuid]>.yesses]> votes<&nl>Final vote by: <context.interaction.user.name> | <&lb>Link<&rb>(<[msg].url>)].with[color].as[lime]>"
            - if <[changed]>:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Upvote].with[description].as[Your vote has been changed<&nl><&nl>Thanks to your vote <[pl].name> can be upgraded to helper!].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - else:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Upvote].with[description].as[Thanks to your vote <[pl].name> can be upgraded to helper!].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes].with[color].as[lime]>"
            - flag <context.channel> <[ruuid]>:!
        - else:
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Helper upvote from <context.interaction.user.name>].with[description].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes | <&lb>Link<&rb>(<[msg].url>)].with[color].as[yellow].with[footer].as[<[pl].name>'s app]>"
            - if <[changed]>:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Upvote].with[description].as[Your vote has been changed].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - else:
                - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Upvote].with[description].as[Thank you for voting].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        on discord button clicked id:helper_down_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - define ruuid <context.button.map.get[id].after[helper_down_]>
        - if !<context.channel.has_flag[<[ruuid]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Voting].with[description].as[This helper application is no longer active!].with[color].as[red]>"
            - stop
        - define pl <context.channel.flag[<[ruuid]>].get[player]>
        - if !<context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[id].contains_any[<script[zc_bot_info].data_key[upvote_roles].keys>]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Voting].with[description].as[You do not have permission to vote!].with[color].as[red]>"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Wrong Vote].with[description].as[<context.interaction.user.name> tried to vote on a helper application].with[footer].as[<[pl].name>'s app].with[color].as[red]>"
            - stop
        - define msg <context.channel.flag[<[ruuid]>].get[msg]>
        - define changed false
        - if <context.interaction.user.flag[voted_on].keys.if_null[<list>]> contains <[ruuid]>:
            - define changed true
            - flag <context.channel> <[ruuid]>.votes:--
            - if <context.interaction.user.flag[voted_on.<[ruuid]>]> == yes:
                - flag <context.channel> <[ruuid]>.yesses:--
        - flag <context.interaction.user> voted_on.<[ruuid]>:no
        - define staff <list>
        - foreach <script[zc_bot_info].data_key[upvote_roles].values> as:role:
            - define staff <[staff].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>]>]>
        - flag <context.channel> <[ruuid]>.votes:++
        - define staff <[staff].deduplicate.size.sub[2]>
        - define amount <[staff].sub[1].div[2].round_down>
        - define half_staff <[amount].add[1]>
        - define new_msg <[msg].embed.first.map>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[info_channel].get[id]> "<discord_embed.with[title].as[Helper downvote from <context.interaction.user.name>].with[description].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes | <&lb>Link<&rb>(<[msg].url>)].with[color].as[yellow].with[footer].as[<[pl].name>'s app]>"
        - if <[changed]>:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Downvote].with[description].as[Your vote has been changed].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        - else:
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Helper Downvote].with[description].as[Thank you for voting].with[color].as[lime].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        - if <context.channel.flag[<[ruuid]>.votes]> > <[amount].sub[<context.channel.flag[<[ruuid]>.yesses]||0>]>:
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes].with[color].as[red]>"
            - flag <context.channel> <[ruuid]>:!
        - else:
            - ~discordmessage id:zc-info edit:<[msg]> "<discord_embed.with_map[<[new_msg]>].with[footer].as[<context.channel.flag[<[ruuid]>.yesses]>/<[half_staff]> Yesses | <context.channel.flag[<[ruuid]>.votes]>/<[staff]> votes]>"
        on discord button clicked id:stop_trusted_app for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> trusted_app:!
        - repeat 2:
            - flag <context.interaction.user> bot_int:<-:trusted_<[value]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[trusted_app_stop_msg]>]>
        on discord button clicked id:stop_helper_app for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> helper_app:!
        - repeat 3:
            - flag <context.interaction.user> bot_int:<-:helper_<[value]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[helper_app_stop_msg]>]>
        on discord button clicked id:stop_builder_app for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> builder_app:!
        - repeat 5:
            - flag <context.interaction.user> bot_int:<-:builder_<[value]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app_stop_msg]>]>
        on discord button clicked id:stop_mod_app for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> mod_app:!
        - repeat 9:
            - flag <context.interaction.user> bot_int:<-:mod_<[value]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[mod_app_stop_msg]>]>
        on discord button clicked id:stop_u_report for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> bot_int:<-:post_u_report_1
        - flag <context.interaction.user> bot_int:<-:post_u_report_2
        - flag <context.interaction.user> user_report_u:!
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[user_report_cancel_msg]>]>
        on discord button clicked id:stop_g_report for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> bot_int:<-:post_g_report
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[grief_report_cancel_msg]>]>
        on discord button clicked id:stop_bug for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> bot_int:<-:post_bug
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[bug_cancel_msg]>]>
        on discord button clicked id:stop_reply_bug for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> bot_int:<-:reply_bug
        - flag <context.interaction.user> bug_reply_msg:!
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[bug_reply_cancel_msg]>]>
        on discord button clicked id:ban_appeal_unban_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[ban_appeal_unban_]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "This ban appeal is closed!"
            - stop
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains Mod && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains Admin && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains "Game Master":
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[You cannot click this button!].with[color].as[red]>"
            - stop
        - define pl <context.channel.flag[<context.button.map.get[id].after[ban_appeal_unban_]>].get[pl]>
        - define msg <context.channel.flag[<context.button.map.get[id].after[ban_appeal_unban_]>].get[msg]>
        - define num <[pl].flag[moderate.unban].size.add[1]||1>
        - flag <[pl]> moderate.unban.<[num]>.by_player:server
        - flag <[pl]> moderate.unban.<[num]>.time:<util.time_now>
        - flag <[pl]> moderate.unban.<[num]>.reason:<[pl].ban_reason>
        - define discord ban
        - if <[pl].ban_expiration_time.is_truthy>:
            - flag <[pl]> moderate.unban.<[num]>.expiration:<[pl].ban_expiration_time>
            - define discord ban_expiration
        - flag <[pl]> moderate.unban.<[num]>.source:<[pl].ban_source>
        - flag <[pl]> moderate.unban.<[num]>.created:<[pl].ban_created_time>
        - flag <[pl]> moderate.unban.<[num]>.was_ip:false
        - choose <[discord]>:
            - case ban:
                - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[pl].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[pl].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[pl].name>/190.png].with[description].as[<context.interaction.user.name> has unbanned <[pl].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[pl].ban_reason>].add_field[Ban source:].value[<[pl].ban_source>].add_inline_field[Ban creation time:].value[<[pl].ban_created_time.format>].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[pl].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[pl].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[pl].flag[moderate.permban].size||0> Permbans].with[color].as[gray]>"
            - case ban_expiration:
                - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[pl].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[pl].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[pl].name>/190.png].with[description].as[<context.interaction.user.name> has unbanned <[pl].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[pl].ban_reason>].add_field[Ban source:].value[<[pl].ban_source>].add_inline_field[Ban creation time:].value[<[pl].ban_created_time.format>].add_inline_field[Ban expiration time:].value[<[pl].ban_expiration_time.format> (<[pl].ban_expiration_time.duration_since[<[pl].ban_created_time>].formatted>)].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[pl].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[pl].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[pl].flag[moderate.permban].size||0> Permbans].with[color].as[gray]>"
        - ban <[pl]> remove source:server
        - ~discordmessage id:zc-info edit:<[msg]> <[msg].embed.first.with[color].as[lime]>
        - flag <context.channel> <context.button.map.get[id].after[ban_appeal_unban_]>:!
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Closed succesfully].with[color].as[lime]>"
        - adjust <context.channel> is_thread_archived:true
        - adjust <context.channel> is_thread_locked:true
        #- ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]>
        on discord button clicked id:ban_appeal_check_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[ban_appeal_check_]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "This ban appeal is closed!"
            - stop
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains Mod && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains Admin && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains "Game Master":
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[You cannot click this button!].with[color].as[red]>"
            - stop
        - define pl <context.channel.flag[<context.button.map.get[id].after[ban_appeal_check_]>].get[pl]>
        - if !<[pl].is_banned>:
            - ~discordinteraction reply interaction:<context.interaction> "Something went wrong!"
            - stop
        - if <[pl].ban_expiration_time.is_truthy>:
            - define time <[pl].ban_expiration_time.format>
        - else:
            - define time Never
        - define created <[pl].ban_created_time.format>
        - define reason <[pl].ban_reason>
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[<[pl].name>'s ban].add_inline_field[Created at].value[<[created]>].add_inline_field[Expires at].value[<[time]>].add_field[Reason].value[<[reason]>]>"
        on discord button clicked id:ban_appeal_close_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[ban_appeal_close_]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "This ban appeal is closed!"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[ban_appeal_close_]>].get[msg]>
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains Mod && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains Admin && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].parse[name]||empty> !contains "Game Master":
            - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[You cannot click this button!].with[color].as[red]>"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Ban Appeal Close].with[description].as[<context.interaction.user.name> Tried to close an application<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[red]>"
            - stop
        - ~discordmessage id:zc-info edit:<[msg]> <[msg].embed.first.with[color].as[red]>
        - flag <context.channel> <context.button.map.get[id].after[ban_appeal_close_]>:!
        - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Closed succesfully].with[color].as[lime]>"
        - adjust <context.channel> is_thread_archived:true
        - adjust <context.channel> is_thread_locked:true
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Ban Appeal Close].with[description].as[<context.interaction.user.name> has closed a Ban Appeal<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[lime]>"
        on discord button clicked id:cleared_report_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[cleared_report_]>]>:
            - discordinteraction reply interaction:<context.interaction> "This report is already cleared"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[cleared_report_]>]>
        - flag <context.channel> <context.button.map.get[id].after[cleared_report_]>:!
        - ~discordmessage id:zc-info edit:<[msg]> <[msg].embed.first.with[color].as[lime]>
        - ~discordinteraction reply interaction:<context.interaction> "The report has been marked as cleared!"
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Cleared Report].with[description].as[<context.interaction.user.name> marked a report as cleared<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[lime]>"
        on discord button clicked id:deny_bug_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[deny_bug_]>]>:
            - discordinteraction reply interaction:<context.interaction> "This bug report is already closed"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[deny_bug_]>]>
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]> && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>:
            - ~discordinteraction reply interaction:<context.interaction> "You cannot close a bug report!"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Denied Bug Report].with[description].as[<context.interaction.user.name> tried to deny a bug report<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[red]>"
            - stop
        - flag <context.channel> <context.button.map.get[id].after[deny_bug_]>:!
        - ~discordmessage id:zc-info edit:<[msg]> "<[msg].embed.first.with[footer].as[status - Not a Bug].with[color].as[red]>"
        - ~discordinteraction reply interaction:<context.interaction> "The bug report has been set to Not a Bug!"
        - adjust <[msg].flag[reply_thread]> is_thread_archived:true
        - adjust <[msg].flag[reply_thread]> is_thread_locked:true
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Denied Bug Report].with[description].as[<context.interaction.user.name> Denied a bug report<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[lime]>"
        on discord button clicked id:accept_bug_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[accept_bug_]>]>:
            - discordinteraction reply interaction:<context.interaction> "This bug report is already closed"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[accept_bug_]>]>
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]> && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>:
            - ~discordinteraction reply interaction:<context.interaction> "You cannot close a bug report!"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Accept Bug Report].with[description].as[<context.interaction.user.name> tried to accept a bug report<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[red]>"
            - stop
        - flag <context.channel> <context.button.map.get[id].after[accept_bug_]>:!
        - adjust <[msg].flag[reply_thread]> is_thread_archived:true
        - adjust <[msg].flag[reply_thread]> is_thread_locked:true
        - ~discordmessage id:zc-info edit:<[msg]> "<[msg].embed.first.with[footer].as[status - Fixed].with[color].as[lime]>"
        - ~discordinteraction reply interaction:<context.interaction> "Suggestion accepted."
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Accept Bug Report].with[description].as[<context.interaction.user.name> marked a bug report as fixed<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[lime]>"
        on discord button clicked id:deny_suggestion_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.channel.has_flag[<context.button.map.get[id].after[deny_suggestion_]>]>:
            - discordinteraction reply interaction:<context.interaction> "This suggestion is already accepted/declined"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[deny_suggestion_]>]>
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]> && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>:
            - ~discordinteraction reply interaction:<context.interaction> "You cannot deny a suggestion!"
            - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Denied Suggestion].with[description].as[<context.interaction.user.name> tried to mark a suggestion as denied<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[red]>"
            - stop
        - adjust <[msg].flag[reply_thread]> is_thread_archived:true
        - adjust <[msg].flag[reply_thread]> is_thread_locked:true
        - flag <context.channel> <context.button.map.get[id].after[deny_suggestion_]>:!
        - ~discordmessage id:zc-info edit:<[msg]> "<[msg].embed.first.with[footer].as[status - Denied].with[color].as[red]>"
        - ~discordinteraction reply interaction:<context.interaction> "The suggestion has been denied!"
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[others_channel].get[id]> "<discord_embed.with[title].as[Denied Suggestion].with[description].as[<context.interaction.user.name> marked a suggestion as denied<&nl><&lb>Message Link<&rb>(<[msg].url>)].with[color].as[lime]>"
        on discord button clicked id:reply_suggestion_* for:zc-info:
        - if !<context.channel.has_flag[<context.button.map.get[id].after[reply_suggestion_]>]>:
            - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
            - discordinteraction reply interaction:<context.interaction> "This suggestion is already accepted/declined"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[reply_suggestion_]>]>
        - flag <context.interaction.user> sug_reply_msg:<[msg]>
        - inject sug_reply_modal
        on discord button clicked id:stop_sug for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> bot_int:<-:post_sug
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_cancel_msg]>]>
        on discord button clicked id:stop_reply_sug for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> bot_int:<-:reply_sug
        - flag <context.interaction.user> sug_reply_msg:!
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_reply_cancel_msg]>]>
        on discord button clicked id:accept_suggestion_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]> && <context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>]> not contains <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>:
            - ~discordinteraction reply interaction:<context.interaction> "You cannot accept a suggestion!"
            - stop
        - if !<context.channel.has_flag[<context.button.map.get[id].after[accept_suggestion_]>]>:
            - discordinteraction reply interaction:<context.interaction> "This suggestion is already accepted/declined"
            - stop
        - define msg <context.channel.flag[<context.button.map.get[id].after[accept_suggestion_]>]>
        - adjust <[msg].flag[reply_thread]> is_thread_archived:true
        - adjust <[msg].flag[reply_thread]> is_thread_locked:true
        - flag <context.channel> <context.button.map.get[id].after[accept_suggestion_]>:!
        - ~discordmessage id:zc-info edit:<[msg]> "<[msg].embed.first.with[footer].as[status - Accepted].with[color].as[lime]>"
        - ~discordinteraction reply interaction:<context.interaction> "Suggestion accepted."
        on discord button clicked id:builder_post for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction>
        - if !<context.interaction.user.has_flag[builder_app_attach]> || !<context.interaction.user.has_flag[builder_app]>:
            - ~discordinteraction reply interaction:<context.interaction> "Something went wrong while posting your application, please start it again"
            - stop
        - define attachs <context.interaction.user.flag[builder_app_attach]>
        - define app <context.interaction.user.flag[builder_app]>
        - define has_img false
        - if <[attachs]> != 1:
            - define has_img false
            - define album "<map.with[title].as[<context.interaction.user.name>].with[description].as[<context.interaction.user.name>'s images]>"
            - ~webget https://api.imgur.com/3/album data:<[album].to_json> method:POST headers:<map.with[Authorization].as[<secret[imgur_api]>]> save:alb
            - define inc_img false
            - foreach <[attachs]> as:attach:
                - define form <[attach].after_last[.].to_lowercase>
                - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
                    - ~webget https://api.imgur.com/3/image data:image=<[attach]> method:POST headers:<map.with[Authorization].as[<secret[imgur_api]>]> save:req
                    - if !<util.parse_yaml[<entry[req].result>].get[success]>:
                        - ~discordinteraction reply interaction:<context.interaction> "Uploading `<[attach]>` **Failed**. Skipping..."
                        - foreach next
                    - define has_img true
                    - if !<[inc_img]>:
                      - define inc_img true
                      - define img <[attach]>
                    - ~webget https://api.imgur.com/3/album/<util.parse_yaml[<entry[alb].result>].get[data].get[id]>/add data:ids<&lb><&rb>=<util.parse_yaml[<entry[req].result>].get[data].get[id]> method:POST headers:<map.with[Authorization].as[<secret[imgur_api]>]>
            - if !<[has_img]>:
                - define butt <discord_button.with[id].as[builder_cancel].with[label].as[Cancel!].with[style].as[destructive]>
                - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app_no_pic_msg]>]> rows:<[butt]>
                - flag <context.interaction.user> builder_app_attach:!
                - stop
            - ~webget https://api.imgur.com/3/gallery/album/<util.parse_yaml[<entry[alb].result>].get[data].get[id]> data:title=<context.interaction.user.name> method:POST headers:<map.with[Authorization].as[<secret[imgur_api]>]> save:gal
            - define out https://imgur.com/gallery/<util.parse_yaml[<entry[alb].result>].get[data].get[id]>
            - define style link
        - else:
            - if <[attachs].first.after_last[.].to_lowercase> in <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]>:
                - define has_img true
                - define img <[attachs].first>
                - define out <[attachs].first>
                - define style img
        - if !<[has_img]>:
            - define butt <discord_button.with[id].as[builder_cancel].with[label].as[Cancel!].with[style].as[danger]>
            - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app_no_pic_msg]>]> rows:<[butt]>
            - flag <context.interaction.user> builder_app_attach:!
            - stop
        - define p <server.match_offline_player[<[app].get[ign]>]||error>
        - define ruuid <util.random_uuid>
        - define butt <discord_button.with[id].as[close_thread_<[ruuid]>].with[label].as[Close].with[style].as[secondary]>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[builder_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app]>]> rows:<[butt]> save:msg
        - ~discordcreatethread id:zc-thread "name:<[p].name> Builder Application" message:<entry[msg].message> save:thread
        - flag <entry[msg].message.channel> <[ruuid]>:<entry[thread].created_thread>
        - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
        - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>
        - define mods <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>]>]>
        - define builders <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Builder]>]>]>
        - define users <list[<context.interaction.user>].include[<[owners]>].include[<[admins]>].include[<[mods]>].include[<[builders]>].deduplicate>
        - foreach <[users]> as:user:
            - adjust <entry[thread].created_thread> add_thread_member:<[user]>
        - wait <[users].size.div[2]>s
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "Builder Application:<&nl><&nl>In Game Name: **<[p].name>**<&nl>Time Zone: **<[app].get[time_zone]>**<&nl>Age: **<[app].get[age]>**"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Why do you feel you should be builder? Do you have any specific skills that would help achieve this?**<&nl><&gt><&gt><&gt> <[app].get[reason]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Do you have any previous experiencee with worldedit? if so, how familiar are you with its commands?**<&nl><&gt><&gt><&gt> <[app].get[experience]>"
        - if <[style]> == link:
            - define butt <discord_button.with[id].as[<[out]>].with[label].as[Images].with[style].as[link]>
            - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Will you be responsible, respectful and co-operative with the staff and other builders?**<&nl><&gt><&gt><&gt> <[app].get[responsible]>" rows:<[butt]>
        - else:
            - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Will you be responsible, respectful and co-operative with the staff and other builders?**<&nl><&gt><&gt><&gt> <[app].get[responsible]>"
            - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <[out]>
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app_post]>]>
        - flag <context.interaction.user> bot_int:<-:builder_app_pic
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> builder_app:!
        - flag <context.interaction.user> builder_app_attach:!
        on discord button clicked id:builder_cancel for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction>
        - flag <context.interaction.user> bot_int:<-:builder_app_pic
        - flag <context.interaction.user> cur_int:!
        - flag <context.interaction.user> builder_app:!
        - flag <context.interaction.user> builder_app_attach:!
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app_cancel_msg]>]>
        on discord button clicked id:ban_appeal_cancel for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction>
        - flag <context.interaction.user> bot_int:<-:start_ban_appeal
        - flag <context.interaction.user> cur_int:!
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[ban_appeal_cancel_msg]>]>
        on discord button clicked id:ticket_cancel for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction>
        - flag <context.interaction.user> bot_int:<-:start_ticket
        - flag <context.interaction.user> cur_int:!
        - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[start_ticket_cancel_msg]>]>
        on discord button clicked id:close_thread_* for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if !<context.interaction.user.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains_any[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[admin]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "You don't have permission to use this!"
            - stop
        - if !<context.channel.has_flag[<context.button.map.get[id].after[close_thread_]>]>:
            - ~discordinteraction reply interaction:<context.interaction> "something went wrong! <context.button>"
            - stop
        - define thread <context.channel.flag[<context.button.map.get[id].after[close_thread_]>]>
        - if <[thread].is_thread_archived> && <[thread].is_thread_locked>:
            - ~discordinteraction reply interaction:<context.interaction> "This thread is alread locked!"
            - stop
        - if <[thread].is_thread_archived> && !<[thread].is_thread_locked>:
            - adjust <[thread]> is_thread_locked:true
            - ~discordinteraction reply interaction:<context.interaction> "This thread is now locked!"
            - stop
        - if <context.interaction.channel.id> == <script[zc_bot_info].data_key[tickets_channel].get[id]>:
            - define ticket <[thread].flag[ticket]>
            - if <[ticket].get[user].flag[cur_int]||error> == ticket_<[ticket].get[num]>:
                - flag <[ticket].get[user]> cur_int:!
            - flag <[ticket].get[user]> bot_int:<-:ticket_<[ticket].get[num]>
            - ~discordmessage id:zc-info user:<discord_user[<[ticket].get[user]>]> "<discord_embed.with[title].as[Ticket #<[ticket].get[num]>].with[description].as[Your ticket has been closed!]>"
            - ~discordmessage id:zc-info channel:<[thread]> "<discord_embed.with[title].as[Ticket Closed].with[description].as[This ticket was closed by <context.interaction.user.name>]>"
        - adjust <[thread]> is_thread_archived:true
        - adjust <[thread]> is_thread_locked:true
        - ~discordinteraction reply interaction:<context.interaction> "Thread closed succesfully!"
        on discord button clicked id:announce_role for:zc-info:
        - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
        - if <context.interaction.user.roles[<discord[zc-info].group[ZeldaCraft]>].parse[name]> contains announcements:
            - ~discord id:zc-info remove_role user:<context.interaction.user> role:<discord[zc-info].group[ZeldaCraft].role[announcements]> group:<discord[zc-info].group[ZeldaCraft]>
            - ~discordinteraction interaction:<context.interaction> reply "<discord_embed.with[title].as[Announcements].with[description].as[You will no longer receive a ping when we announce something!<&nl><&nl>If you want to receive a ping again simply click the button again.].with[color].as[red]>"
        - else:
            - ~discord id:zc-info add_role user:<context.interaction.user> role:<discord[zc-info].group[ZeldaCraft].role[announcements]> group:<discord[zc-info].group[ZeldaCraft]>
            - ~discordinteraction interaction:<context.interaction> reply "<discord_embed.with[title].as[Announcements].with[description].as[You will now receive a ping when we announce something!<&nl><&nl>If you want to stop receiving these pings simply click the button again.].with[color].as[lime]>"