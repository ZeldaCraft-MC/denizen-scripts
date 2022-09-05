d_modals_world:
  type: world
  debug: false
  events:
    on discord modal submitted name:ban_appeal for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - define use <context.interaction.user>
    - define u <context.interaction.user.flag[ban_appeal.player]>
    - define msg "**Explain the circumstances surrounding your ban**<&nl><context.values.get[circumstances]><&nl><&nl>**Why should we remove or reconsider your ban**<&nl><context.values.get[reason]><&nl><&nl>**Do you have anything else to say to staff or players about your ban**<&nl><context.values.get[message]>"
    - define atta <list>
    - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Ban Appeal succesfully posted].with[color].as[lime]>"
    - run create_ban_appeal_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]> def.use:<[use]>
    on discord modal submitted name:trusted_app for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - define pl <context.interaction.user.flag[trusted_app].get[player]>
    - define r_time <[pl].first_played_time>
    - foreach <context.values.keys> as:k:
      - define <[k]> <context.values.get[<[k]>]>
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
    - flag <context.interaction.user> trusted_app:!
    on discord modal submitted name:helper_app for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - define pl <context.interaction.user.flag[helper_app].get[player]>
    - foreach <context.values.keys> as:k:
      - define <[k]> <context.values.get[<[k]>]>
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
    - flag <context.interaction.user> helper_app:!
    on discord modal submitted name:builder_app for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - if <context.interaction.user.flag[bot_int].size||0> >= 25:
      - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]>
      - stop
    - if <context.interaction.user.flag[bot_int].contains[builder_app_pic]||0>:
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[1 interaction].with[description].as[You already have a builder application interaction going with the bot.<&nl>Please cancel that one first before continuing with this one.].with[color].as[red]>"
      - stop
    - flag <context.interaction.user> bot_int:->:builder_app_pic
    - if <context.interaction.user.has_flag[cur_int]>:
      - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Builder Application].with[description].as[Your current interaction with the bot has been changed to: Builder Application].with[color].as[aqua]>"
    - flag <context.interaction.user> cur_int:builder_app_pic expire:2h
    - flag <context.interaction.user> builder_app:<context.values.with[ign].as[<context.interaction.user.flag[builder_app].get[player]>]>
    - flag <context.interaction.user> builder_app_attach:!
    - define butt <discord_button.with[id].as[builder_cancel].with[label].as[Cancel!].with[style].as[danger]>
    - ~discordmessage id:zc-info user:<context.interaction.user> "<discord_embed.with[title].as[Builder Application].with[description].as[Please upload the pictures in here<&nl>To cancel the application click the **cancel** button].with[color].as[aqua]>" rows:<[butt]>
    - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
    on discord modal submitted name:sug_reply for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - define u <context.interaction.user>
    - define msg <context.values.get[msg]>
    - define atta <list>
    - run reply_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
    - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
    on discord modal submitted name:bug_reply for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - define u <context.interaction.user>
    - define msg <context.values.get[msg]>
    - define atta <list>
    - run reply_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
    - ~discordinteraction reply interaction:<context.interaction> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]>
    on discord modal submitted name:forcelink for:zc-info:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true
    - if <server.match_offline_player[<context.values.get[ign]>].if_null[error]> == error:
      - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Link Mc].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>"
      - stop
    - define pl <server.match_offline_player[<context.values.get[ign]>]>
    - define user <context.interaction.user.flag[forcelink]>
    - flag <context.interaction.user> forcelink:!
    - flag <[pl]> discord_link:<[user]>
    - flag <[user]> mc_link:<[pl]>
    - if <[pl].is_online>:
      - narrate "You and <[user].name> Have been forced linked" targets:<[pl]> format:zc_text
    - ~discordmessage id:zc-info user:<[user]> <discord_embed.with_map[<script[d_messages].parsed_key[linkmc_suc_force_msg]>]>
    - ~discordinteraction reply interaction:<context.interaction> "<discord_embed.with[title].as[Force Link].with[description].as[<[pl].name> and <[user].name> Have succesfully been linked together].with[color].as[lime]>"

trusted_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[reason].with[label].as[Why do you want to become trusted?].with[style].as[paragraph].with[placeholder].as[Type your reason in here]>
    - ~discordmodal interaction:<context.interaction> name:trusted_app "title:Trusted Application" rows:<[modal]>

helper_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[age].with[label].as[What is your age].with[style].as[short].with[placeholder].as[Type your age in here]>
        2:
          1: <discord_text_input.with[id].as[reason].with[label].as[Why do you want to become a helper?].with[style].as[paragraph].with[placeholder].as[Type your reason in here]>
        3:
          1: <discord_text_input.with[id].as[helped].with[label].as[Who have you already helped?].with[style].as[paragraph].with[placeholder].as[Please provide examples of what you did the help those players]>
    - ~discordmodal interaction:<context.interaction> name:helper_app "title:Helper Application" rows:<[modal]>

ban_appeal_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[circumstances].with[label].as[Explain the circumstance surrounding your ban].with[style].as[short].with[placeholder].as[Type your circumstances in here]>
        2:
          1: <discord_text_input.with[id].as[reason].with[label].as[Why should we remove or reconsider your ban?].with[style].as[paragraph].with[placeholder].as[Type your reason in here]>
        3:
          1: <discord_text_input.with[id].as[message].with[label].as[Do you have something else to say?].with[style].as[short].with[placeholder].as[To staff or players about your ban?]>
    - ~discordmodal interaction:<context.interaction> name:ban_appeal "title:Ban Appeal" rows:<[modal]>

builder_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[time_zone].with[label].as[What time zone are you in?].with[style].as[short].with[placeholder].as[Type something like GMT+? in here]>
        2:
          1: <discord_text_input.with[id].as[age].with[label].as[What is your age?].with[style].as[short].with[placeholder].as[Type your age in here]>
        3:
          1: <discord_text_input.with[id].as[reason].with[label].as[Why do you feel you should be builder?].with[style].as[paragraph].with[placeholder].as[Do you have any specific skills that woul help achieve this?]>
        4:
          1: <discord_text_input.with[id].as[experience].with[label].as[Do you have any experiences with worldedit?].with[style].as[paragraph].with[placeholder].as[If so, how familiar are you with its commands?]>
        5:
          1: <discord_text_input.with[id].as[responsible].with[label].as[Will you be responsible with the staff?].with[style].as[short].with[placeholder].as[This includes being respectful and co-operative]>
    - ~discordmodal interaction:<context.interaction> name:builder_app "title:Builder Application" rows:<[modal]>

sug_reply_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[msg].with[label].as[Reply message].with[style].as[short].with[placeholder].as[Put your reply to the suggestion in here]>
    - ~discordmodal interaction:<context.interaction> name:sug_reply "title:Suggestion Reply" rows:<[modal]>

bug_reply_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[msg].with[label].as[Reply message].with[style].as[short].with[placeholder].as[Put your reply to the bug report in here]>
    - ~discordmodal interaction:<context.interaction> name:bug_reply "title:Bug Report Reply" rows:<[modal]>

forcelink_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[ign].with[label].as[in game name].with[style].as[short].with[placeholder].as[Put the players name in here]>
    - ~discordmodal interaction:<context.interaction> name:forcelink "title:Forcelinking <context.interaction.target_user.name>" rows:<[modal]>
