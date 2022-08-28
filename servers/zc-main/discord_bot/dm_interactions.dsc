d_dm_data:
  type: data
  debug: false
  id_name:
    post_u_report_1: User Report
    post_u_report_2: User Report
    post_g_report: Grief Report
    post_bug: Bug Report
    reply_bug: Bug Report Reply
    post_sug: Suggestion
    reply_sug: Suggestion Reply
    start_ticket: Start Ticket
    start_ban_appeal: Ban Appeal
    trusted_1: Trusted Application
    helper_1: Helper Application
    helper_2: Helper Application
    helper_3: Helper Application
    builder_1: Builder Application
    builder_2: Builder Application
    builder_3: Builder Application
    builder_4: Builder Application
    builder_5: Builder Application
    builder_app_pic: Builder Application Pictures
    mod_1: Moderator Application
    mod_2: Moderator Application
    mod_3: Moderator Application
    mod_4: Moderator Application
    mod_5: Moderator Application
    mod_6: Moderator Application
    mod_7: Moderator Application
    mod_8: Moderator Application
    mod_9: Moderator Application
d_dm_int_w:
  type: world
  debug: false
  events:
    on discord message received for:zc-info:
    - if <context.new_message.author.is_bot>:
      - stop
    - if !<context.new_message.is_direct>:
      - stop
    - if <context.new_message.author.flag[cur_int].starts_with[ticket_]||false>:
      - define num <context.new_message.author.flag[cur_int].after[ticket_]>
      - if <context.new_message.attachments.is_empty>:
        - ~discordmessage id:zc-info channel:<context.new_message.author.flag[ticket.<[num]>]> <discord_embed.with[author_name].as[<context.new_message.author.name>].with[author_icon_url].as[<context.new_message.author.avatar_url>].with[description].as[<context.new_message.text_no_mentions>]>
      - else:
        - if <context.new_message.attachments.separated_by[<&nl>].length> >= 1024:
          - define attach <context.new_message.attachments.separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
        - else:
          - define attach <context.new_message.attachments.separated_by[<&nl>]>
        - define form <context.new_message.attachments.first.after_last[.]||error>
        - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
          - define pic <context.new_message.attachments.first>
          - ~discordmessage id:zc-info channel:<context.new_message.author.flag[ticket.<[num]>]> <discord_embed.with[author_name].as[<context.new_message.author.name>].with[author_icon_url].as[<context.new_message.author.avatar_url>].with[description].as[<context.new_message.text_no_mentions>].add_field[attachments].value[<[attach]>].with[thumbnail].as[<[pic]>]>
        - else:
          - ~discordmessage id:zc-info channel:<context.new_message.author.flag[ticket.<[num]>]> <discord_embed.with[author_name].as[<context.new_message.author.name>].with[author_icon_url].as[<context.new_message.author.avatar_url>].with[description].as[<context.new_message.text_no_mentions>].add_field[attachments].value[<[attach]>]>
      - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ticket #<[num]>].with[footer].as[your reply has been posted]>"
      - stop
    - choose <context.new_message.author.flag[cur_int]||default>:
      - case post_u_report_1:
        - flag <context.new_message.author> cur_int:post_u_report_2 expire:2h
        - flag <context.new_message.author> bot_int:->:post_u_report_2
        - flag <context.new_message.author> bot_int:<-:post_u_report_1
        - define player <context.new_message.text_no_mentions>
        - flag <context.new_message.author> user_report_u:<[player]>
        - define butt <discord_button.with[id].as[stop_u_report].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Reporting <[player]>].with[description].as[Type your report below here].with[color].as[aqua]>" save:msg rows:<[butt]>
      - case post_u_report_2:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:post_u_report_2
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - define player <context.new_message.author.flag[user_report_u]>
        - flag <context.new_message.author> user_report_u:!
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run create_u_report_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]> def.player:<[player]>
        - ~discordmessage id:zc-info user:<[u]> <discord_embed.with_map[<script[d_messages].parsed_key[user_report_suc_msg]>]>
      - case post_g_report:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:post_g_report
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run create_g_report_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - ~discordmessage id:zc-info user:<[u]> <discord_embed.with_map[<script[d_messages].parsed_key[grief_report_suc_msg]>]>
      - case post_bug:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:post_bug
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run create_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - ~discordmessage id:zc-info user:<[u]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_suc_msg]>]>
      - case reply_bug:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:reply_bug
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run reply_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
      - case post_sug:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:post_sug
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run create_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - ~discordmessage id:zc-info user:<[u]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_suc_msg]>]>
      - case reply_sug:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:reply_sug
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run reply_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
      - case start_ticket:
        - if <context.new_message.author.flag[bot_int].size> >= 26:
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
          - stop
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:start_ticket
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run create_ticket_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
      - case ban_appeal_1:
        - flag <context.new_message.author> cur_int:ban_appeal_2
        - flag <context.new_message.author> bot_int:<-:ban_appeal_1
        - flag <context.new_message.author> bot_int:->:ban_appeal_2
        - flag <context.new_message.author> ban_appeal.circumstances:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[ban_appeal_cancel].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ban Appeal].with[description].as[**Second question:**<&nl>Why should we remove or reconsider your ban].with[color].as[aqua]>" rows:<[butt]>
      - case ban_appeal_2:
        - flag <context.new_message.author> cur_int:ban_appeal_3
        - flag <context.new_message.author> bot_int:<-:ban_appeal_2
        - flag <context.new_message.author> bot_int:->:ban_appeal_3
        - flag <context.new_message.author> ban_appeal.reason:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[ban_appeal_cancel].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ban Appeal].with[description].as[**Last question:**<&nl>Do you have anything else to say to staff or players about your ban<&nl><&nl>You can also add attachments to this message].with[color].as[aqua]>" rows:<[butt]>
      - case ban_appeal_3:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:ban_appeal_3
        - define u <context.new_message.author.flag[ban_appeal.player]>
        - define msg "**Explain the circumstances surrounding your ban**<&nl><context.new_message.author.flag[ban_appeal].get[circumstances]><&nl><&nl>**Why should we remove or reconsider your ban**<&nl><context.new_message.author.flag[ban_appeal].get[reason]><&nl><&nl>**Do you have anything else to say to staff or players about your ban**<&nl><context.new_message.text_no_mentions>"
        - define use <context.new_message.author>
        - if !<context.new_message.attachments.is_empty>:
          - define atta <context.new_message.attachments>
        - else:
          - define atta <list>
        - run create_ban_appeal_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]> def.use:<[use]>
        - flag <context.new_message.author> ban_appeal:!
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Succesfully posted].with[color].as[lime]>"
      - case trusted_1:
        - flag <context.new_message.author> bot_int:<-:trusted_1
        - flag <context.new_message.author> cur_int:!
        - define pl <context.new_message.author.flag[trusted_app].get[player]>
        - define r_time <context.new_message.author.flag[trusted_app.player].first_played_time>
        - define reason <context.new_message.text_no_mentions>
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
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[trusted_post_msg]>]>
        - flag <context.new_message.author> trusted_app:!
      - case helper_1:
        - if <context.new_message.text.length> > 1024:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Limitations].with[description].as[You have gone over the character limit of 1000 chars, please trim your post down.].with[color].as[red]>"
          - stop
        - flag <context.new_message.author> cur_int:helper_2 expire:2h
        - flag <context.new_message.author> bot_int:<-:helper_1
        - flag <context.new_message.author> bot_int:->:helper_2
        - flag <context.new_message.author> helper_app.age:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_helper_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[helper_2_msg]>]> rows:<[butt]>
      - case helper_2:
        - if <context.new_message.text.length> > 1024:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Limitations].with[description].as[You have gone over the character limit of 1000 chars, please trim your post down.].with[color].as[red]>"
          - stop
        - flag <context.new_message.author> cur_int:helper_3 expire:2h
        - flag <context.new_message.author> bot_int:<-:helper_2
        - flag <context.new_message.author> bot_int:->:helper_3
        - flag <context.new_message.author> helper_app.reason:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_helper_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[helper_3_msg]>]> rows:<[butt]>
      - case helper_3:
        - if <context.new_message.text.length> > 1024:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Limitations].with[description].as[You have gone over the character limit of 1000 chars, please trim your post down.].with[color].as[red]>"
          - stop
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:helper_3
        - define pl <context.new_message.author.flag[helper_app].get[player]>
        - define age <context.new_message.author.flag[helper_app].get[age]>
        - define reason <context.new_message.author.flag[helper_app].get[reason]>
        - define helped <context.new_message.text_no_mentions>
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
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[helper_post_msg]>]>
        - flag <context.new_message.author> helper_app:!
      - case builder_1:
        - flag <context.new_message.author> cur_int:builder_2 expire:2h
        - flag <context.new_message.author> bot_int:<-:builder_1
        - flag <context.new_message.author> bot_int:->:builder_2
        - flag <context.new_message.author> builder_app.time_zone:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_builder_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[builder_2_msg]>]> rows:<[butt]>
      - case builder_2:
        - flag <context.new_message.author> cur_int:builder_3 expire:2h
        - flag <context.new_message.author> bot_int:<-:builder_2
        - flag <context.new_message.author> bot_int:->:builder_3
        - flag <context.new_message.author> builder_app.age:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_builder_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[builder_3_msg]>]> rows:<[butt]>
      - case builder_3:
        - flag <context.new_message.author> cur_int:builder_4 expire:2h
        - flag <context.new_message.author> bot_int:<-:builder_3
        - flag <context.new_message.author> bot_int:->:builder_4
        - flag <context.new_message.author> builder_app.reason:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_builder_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[builder_4_msg]>]> rows:<[butt]>
      - case builder_4:
        - flag <context.new_message.author> cur_int:builder_5 expire:2h
        - flag <context.new_message.author> bot_int:<-:builder_4
        - flag <context.new_message.author> bot_int:->:builder_5
        - flag <context.new_message.author> builder_app.experience:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_builder_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[builder_5_msg]>]> rows:<[butt]>
      - case builder_5:
        - flag <context.new_message.author> cur_int:builder_app_pic expire:2h
        - flag <context.new_message.author> bot_int:<-:builder_5
        - flag <context.new_message.author> bot_int:->:builder_app_pic
        - flag <context.new_message.author> builder_app.responsible:<context.new_message.text_no_mentions>
        - flag <context.new_message.author> builder_app.ign:<context.new_message.author.flag[builder_app.player].name>
        - flag <context.new_message.author> builder_app_attach:!
        - define butt <discord_button.with[id].as[builder_cancel].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Builder Application].with[description].as[Please upload any pictures in here<&nl>To cancel the application click the **cancel** button].with[color].as[aqua]>" rows:<[butt]>
      - case builder_app_pic:
        - if <context.new_message.attachments.is_empty>:
          - ~discordmessage id:zc-info user:<context.new_message.author> "No attachment"
          - stop
        - define attach <list>
        - if <context.new_message.author.has_flag[builder_app_attach]>:
          - define attach <context.new_message.author.flag[builder_app_attach]>
        - define attach <[attach].include[<context.new_message.attachments>]>
        - flag <context.new_message.author> builder_app_attach:<[attach]> expire:2h
        - definemap butts:
            1:
              1: <discord_button.with[id].as[builder_post].with[label].as[Post!].with[style].as[success]>
              2: <discord_button.with[id].as[builder_cancel].with[label].as[Cancel!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[builder_app_pic_msg]>]> rows:<[butts]>
      - case mod_1:
        - flag <context.new_message.author> cur_int:mod_2 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_1
        - flag <context.new_message.author> bot_int:->:mod_2
        - flag <context.new_message.author> mod_app.time_zone:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_2_msg]>]> rows:<[butt]>
      - case mod_2:
        - flag <context.new_message.author> cur_int:mod_3 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_2
        - flag <context.new_message.author> bot_int:->:mod_3
        - flag <context.new_message.author> mod_app.age:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_3_msg]>]> rows:<[butt]>
      - case mod_3:
        - flag <context.new_message.author> cur_int:mod_4 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_3
        - flag <context.new_message.author> bot_int:->:mod_4
        - flag <context.new_message.author> mod_app.reason:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_4_msg]>]> rows:<[butt]>
      - case mod_4:
        - flag <context.new_message.author> cur_int:mod_5 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_4
        - flag <context.new_message.author> bot_int:->:mod_5
        - flag <context.new_message.author> mod_app.experience:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_5_msg]>]> rows:<[butt]>
      - case mod_5:
        - flag <context.new_message.author> cur_int:mod_6 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_5
        - flag <context.new_message.author> bot_int:->:mod_6
        - flag <context.new_message.author> mod_app.responsible:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_6_msg]>]> rows:<[butt]>
      - case mod_6:
        - flag <context.new_message.author> cur_int:mod_7 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_6
        - flag <context.new_message.author> bot_int:->:mod_7
        - flag <context.new_message.author> mod_app.case_1:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_7_msg]>]> rows:<[butt]>
      - case mod_7:
        - flag <context.new_message.author> cur_int:mod_8 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_7
        - flag <context.new_message.author> bot_int:->:mod_8
        - flag <context.new_message.author> mod_app.case_2:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_8_msg]>]> rows:<[butt]>
      - case mod_8:
        - flag <context.new_message.author> cur_int:mod_9 expire:2h
        - flag <context.new_message.author> bot_int:<-:mod_8
        - flag <context.new_message.author> bot_int:->:mod_9
        - flag <context.new_message.author> mod_app.case_3:<context.new_message.text_no_mentions>
        - define butt <discord_button.with[id].as[stop_mod_app].with[label].as[Stop!].with[style].as[danger]>
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_9_msg]>]> rows:<[butt]>
      - case mod_9:
        - flag <context.new_message.author> cur_int:!
        - flag <context.new_message.author> bot_int:<-:mod_9
        - define p <context.new_message.author.flag[mod_app].get[player]>
        - define age <context.new_message.author.flag[mod_app].get[age]>
        - define time <context.new_message.author.flag[mod_app].get[time_zone]>
        - define ruuid <util.random_uuid>
        - define butt <discord_button.with[id].as[close_thread_<[ruuid]>].with[label].as[Close].with[style].as[secondary]>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[mod_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mod_app_msg]>]> rows:<[butt]> save:msg
        - ~discordcreatethread id:zc-thread "name:<[p].name> Moderator Application" message:<entry[msg].message> save:thread
        - flag <entry[msg].message.channel> <[ruuid]>:<entry[thread].created_thread>
        - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
        - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>
        - define mods <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>]>]>
        - define users <list[<context.new_message.author>].include[<[owners]>].include[<[admins]>].include[<[mods]>].deduplicate>
        - foreach <[users]> as:user:
          - adjust <entry[thread].created_thread> add_thread_member:<[user]>
        - wait <[users].size.div[2]>s
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "Moderator Application:<&nl><&nl>In Game Name: **<[p].name>**<&nl>Time Zone: **<[time]>**<&nl>Age: **<[age]>**"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Why do you want to be mod?**<&nl><&gt><&gt><&gt> <context.new_message.author.flag[mod_app].get[reason]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Do you have a good understanding of the commands a mod uses?(and list them)**<&nl><&gt><&gt><&gt> <context.new_message.author.flag[mod_app].get[experience]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Will you be responsible, calm, mature, and trustworthy?**<&nl><&gt><&gt><&gt> <context.new_message.author.flag[mod_app].get[responsible]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Some users build has been griefed, what do you do?**<&nl><&gt><&gt><&gt> <context.new_message.author.flag[mod_app].get[case_1]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Some users are arguing, what do you do?**<&nl><&gt><&gt><&gt> <context.new_message.author.flag[mod_app].get[case_2]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**A user is hurling abusive language at you, what do you do?**<&nl><&gt><&gt><&gt> <context.new_message.author.flag[mod_app].get[case_3]>"
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "**Someone enters another person's house without their permission, what do you do?**<&nl><&gt><&gt><&gt> <context.new_message.text_no_mentions>"
        - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[mod_app_post]>]>
        - flag <context.new_message.author> mod_app:!
      - default:
        - if !<context.new_message.author.has_flag[bot_int]> || <context.new_message.author.flag[bot_int].is_empty>:
          - inject sug_int_menu
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_ints_msg]>]> rows:<[selection]> no_mention
          - stop
        - else:
          - define options <list>
          - foreach <context.new_message.author.flag[bot_int]> as:int:
            - define i <script[d_dm_data].data_key[id_name].get[<[int]>]||<[int].replace[_].with[<&sp>#].to_titlecase>>
            - definemap option:
                label: <[i]>
                value: <[int]>
                description: Start or close the <[i]> interaction
            - define options <[options].include[<[loop_index]>/<[option]>]>
          - define selection "<discord_selection.with[placeholder].as[Choose an interaction].with[id].as[int_menu].with[options].as[<[options].to_map>]>"
          - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[open_ints_msg]>]> rows:<[selection]>
