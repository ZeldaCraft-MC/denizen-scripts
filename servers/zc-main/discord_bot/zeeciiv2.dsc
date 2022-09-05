zc_bot_info:
  type: data
  debug: false
  group_name: ZeldaCraft
  mod_roles:
    639989463119953931: Game Master
    328558850745827329: Admin
    152499958757457921: Mod
  upvote_roles:
    639989463119953931: Game Master
    328558850745827329: Admin
    152499958757457921: Mod
    908388578692849795: Helper
  # classes list
  classes:
    hylian: https://emojipedia-us.s3.amazonaws.com/source/skype/289/crossed-swords_2694-fe0f.png
    zora: https://cdn.shopify.com/s/files/1/1061/1924/products/Big_Tuna_Iphone_Emoji_JPG_large.png?v=1571606114
    goron: https://images.emojiterra.com/google/android-pie/512px/1f30b.png
    minish: https://hotemoji.com/images/dl/i/four-leaf-clover-emoji-by-twitter.png
    yiga: https://images.emojiterra.com/google/android-10/512px/1f441.png
    twili: https://images.emojiterra.com/twitter/v13.1/512px/1f43a.png
    sheikah: https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/271/ninja_1f977.png
    rito: https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/facebook/65/bird_1f426.png
  # the prefix the bot uses in all its commands
  prefix: zc<&sp>
  # differen channels + ids of those channels.
  mcmmo_stats:
    - excavation
    - fishing
    - herbalism
    - mining
    - woodcutting
    - archery
    - axes
    - swords
    - taming
    - unarmed
    - acrobatics
    - alchemy
  mc_no_access_users:
    - no_one
  dis_no_access_users:
    - no-one
  images:
    2_chests: https://cdn.discordapp.com/attachments/614864016795238420/915239125819482122/background_2.png
    2_chests_10: https://cdn.discordapp.com/attachments/614864016795238420/915239127300063282/background_2_1_ruppee.png
    2_chests_20: https://cdn.discordapp.com/attachments/614864016795238420/915239126603796590/background_2_1_key.png
    2_chests_01: https://cdn.discordapp.com/attachments/614864016795238420/915239129057488946/background_2_2_ruppee.png
    2_chests_02: https://cdn.discordapp.com/attachments/614864016795238420/915239128176656424/background_2_2_key.png
  bot_channel:
    id: 402888223732531200
    name: bot-spam
  test_channel:
    id: 757894566413205554
    name: bot-testing
  chat_channel:
    id: 476430460965355520
    name: minecraft-chat
  live_channel:
    id: 757903718640517191
    name: live-stats
  trusted_channel:
    id: 560871671192485998
    name: trusted-apps
  bugs_channel:
    id: 473391453981376523
    name: minecraft-bugs
  suggestion_channel:
    id: 465559155940261888
    name: suggestions
  replies_channel:
    id: 618112829077192705
    name: changelog-replies
  logs_channel:
    id: 485854389655830549
    name: logs
  ban_channel:
    id: 763308613795315732
    name: reports-bans
  tickets_channel:
    id: 863540035595796490
    name: tickets
  ticket_logs:
    id: 863540131250831360
    name: ticket-logs
  helper_channel:
    id: 900894171118850128
    name: helper-apps
  builder_channel:
    id: 830123115429232650
    name: builder-apps
  mod_channel:
    id: 830123159336255538
    name: mod-apps
  appeal_channel:
    id: 907017493657321532
    name: ban-appeals
  info_channel:
    id: 859064168426110986
    name: application-info
  admin_channel:
    id: 611257990296633375
    name: secwit-admin-chat
  others_channel:
    id: 980865060077465671
    name: other-buttons
  mc_announce_channel:
    id: 985254606638571540
    name: mc-announcements

needs_name_task:
  type: task
  debug: false
  definitions: args
  script:
    - define p <server.match_offline_player[<[args].get[2]||<&sp>>]||error>
    - if <[p]> == error:
      - if !<context.new_message.author.has_flag[mc_link]>:
        - define name <[args].get[2]||<&sp>>
        - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
        - stop
      - define p <context.new_message.author.flag[mc_link]>

mclink_task:
  type: task
  debug: false
  definitions: pl|user
  script:
    - flag <[pl]> discord_link:<[user]>
    - flag <[user]> mc_link:<[pl]>
    - narrate "You and <[user].name> Have succesfully been linked" targets:<[pl]> format:zc_text
    - ~discordmessage id:zc-info user:<[user]> <discord_embed.with_map[<script[d_messages].parsed_key[linkmc_suc_msg]>]>

reply_sug_task:
  type: task
  debug: false
  definitions: u|msg|atta
  script:
    - define msg2 <[u].flag[sug_reply_msg]>
    - if !<[msg2].has_flag[reply_thread]>:
      - ~discordcreatethread id:zc-thread "name:Replies - <[msg2].embed.first.map.get[author_name]>" parent:<[msg2].channel> private save:thread
      - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
      - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>
      - define users <list[<[owners]>].include[<[admins]>].deduplicate>
      - foreach <[users]> as:user:
        - if !<[user].id.is_truthy:
          - foreach next
        - adjust <entry[thread].created_thread> add_thread_member:<[user]>
      - wait <[users].size.div[1.4]>s
      - if <[msg2].embed.first.map.contains[fields]>:
        - define embed <discord_embed.with_map[<[msg2].embed.first>]>
      - if <[msg2].embed.first.map.contains[fields]>:
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "<[embed].with[footer].as[Original message]>"
      - else:
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> "<[msg2].embed.first.with[footer].as[Original message]>"
      - flag <[msg2]> reply_thread:<entry[thread].created_thread>
    - define thread <[msg2].flag[reply_thread]>
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<[thread]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_reply]>]>
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<[thread]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_attach_pic_reply]>]>
      - else:
        - ~discordmessage id:zc-info channel:<[thread]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_attach_reply]>]>
    - ~discordmessage id:zc-info user:<[u]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_reply_suc_msg]>]>

reply_bug_task:
  type: task
  debug: false
  definitions: u|msg|atta
  script:
    - define msg2 <[u].flag[bug_reply_msg]>
    - if !<[msg2].has_flag[reply_thread]>:
      - ~discordcreatethread id:zc-thread "name:Replied - <[msg2].embed.first.map.get[author_name]>" message:<[msg2]> save:thread
      - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
      - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>=
      - define users <list[<[owners]>].include[<[admins]>].deduplicate>
      - if <[msg2].has_flag[user]>:
        - define users <[users].include[<[msg2].flag[user]>].deduplicate>
      - foreach <[users]> as:user:
        - if !<[user].id.is_truthy:
          - foreach next
        - adjust <entry[thread].created_thread> add_thread_member:<[user]>
      - wait <[users].size.div[1.4]>s
      - flag <[msg2]> reply_thread:<entry[thread].created_thread>
    - define thread <[msg2].flag[reply_thread]>
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<[thread]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_reply]>]>
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<[thread]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_attach_pic_reply]>]>
      - else:
        - ~discordmessage id:zc-info channel:<[thread]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_attach_reply]>]>
    - ~discordmessage id:zc-info user:<[u]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_reply_suc_msg]>]>

create_u_report_task:
  type: task
  debug: false
  definitions: u|msg|atta|player
  script:
    - define ruuid <util.random_uuid>
    - inject report_buttons
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[user_report_msg]>]> rows:<[buttons]> save:msg
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[user_report_attach_pic_msg]>]> save:msg rows:<[buttons]>
      - else:
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[user_report_attach_msg]>]> save:msg rows:<[buttons]>
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[report_announce].mention>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

mc_create_u_report_task:
  type: task
  debug: false
  definitions: p|msg|player
  script:
    - define ruuid <util.random_uuid>
    - inject report_buttons
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mc_user_report_msg]>]> rows:<[buttons]> save:msg
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[report_announce].mention>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

create_g_report_task:
  type: task
  debug: false
  definitions: u|msg|atta
  script:
    - define ruuid <util.random_uuid>
    - inject report_buttons
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[grief_report_msg]>]> rows:<[buttons]> save:msg
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[grief_report_attach_pic_msg]>]> save:msg rows:<[buttons]>
      - else:
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[grief_report_attach_msg]>]> save:msg rows:<[buttons]>
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[report_announce].mention>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

mc_create_g_report_task:
  type: task
  debug: false
  definitions: p|msg|loc
  script:
    - define ruuid <util.random_uuid>
    - inject report_buttons
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mc_grief_report_msg]>]> rows:<[buttons]> save:msg
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[ban_channel].get[id]> <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[report_announce].mention>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

create_bug_task:
  type: task
  debug: false
  definitions: u|msg|atta
  script:
    - define ruuid <util.random_uuid>
    - inject bugreport_buttons
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[bugs_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_msg]>]> rows:<[buttons]> save:msg
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[bugs_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[bug_attach_pic_msg]>]> save:msg rows:<[buttons]>
      - else:
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[bugs_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[bugs_attach_msg]>]> save:msg rows:<[buttons]>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>
    - flag <entry[msg].message> user:<[u]>

mc_create_bug_task:
  type: task
  debug: false
  definitions: p|msg
  script:
    - define ruuid <util.random_uuid>
    - inject bugreport_buttons
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[bugs_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mc_bug_msg]>]> rows:<[buttons]> save:msg
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

mc_create_sug_task:
  type: task
  debug: false
  definitions: p|msg|title
  script:
    - define ruuid <util.random_uuid>
    - inject suggestion_buttons
    - if <[title]> == <empty>:
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[suggestion_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mc_suggestion_msg]>]> rows:<[buttons]> save:msg
    - else:
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[suggestion_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[mc_suggestion_title_msg]>]> rows:<[buttons]> save:msg
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

create_sug_task:
  type: task
  debug: false
  definitions: u|msg|atta
  script:
    - define ruuid <util.random_uuid>
    - inject suggestion_buttons
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[suggestion_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_msg]>]> rows:<[buttons]> save:msg
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[suggestion_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_attach_pic_msg]>]> save:msg rows:<[buttons]>
      - else:
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[suggestion_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[suggestion_attach_msg]>]> save:msg rows:<[buttons]>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[msg].message>

create_ban_appeal_task:
  type: task
  debug: false
  definitions: use|u|msg|atta
  script:
    - define ruuid <util.random_uuid>
    - inject ban_appeal_buttons
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[appeal_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[ban_appeal_msg]>]> save:msg
    - ~discordcreatethread id:zc-thread "name:<[u].name>'s ban appeal" parent:<entry[msg].message.channel> private save:thread
    - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
    - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>
    - define mods <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>]>]>
    - define users <list[<[owners]>].include[<[admins]>].include[<[mods]>].include[<[use]>].deduplicate>
    - foreach <[users]> as:user:
      - adjust <entry[thread].created_thread> add_thread_member:<[user]>
    - wait <[users].size.div[1.4]>s
    - if <[atta].is_empty>:
      - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <discord_embed.with_map[<script[d_messages].parsed_key[ban_appeal_msg]>]> save:msg2 rows:<[buttons]>
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <discord_embed.with_map[<script[d_messages].parsed_key[ban_appeal_attach_pic_msg]>]> save:msg2 rows:<[buttons]>
      - else:
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <discord_embed.with_map[<script[d_messages].parsed_key[ban_appeal_attach_msg]>]> save:msg2 rows:<[buttons]>
    - flag <entry[msg2].message.channel> <[ruuid]>.msg:<entry[msg].message>
    - flag <entry[msg2].message.channel> <[ruuid]>.pl:<[u]>

create_ticket_task:
  type: task
  debug: false
  definitions: u|msg|atta
  script:
    - define num 1
    - if <[u].has_flag[bot_int]>:
      - if !<[u].flag[bot_int].filter[starts_with[ticket_]].is_empty>:
        - define num <[u].flag[bot_int].filter[starts_with[ticket_]].parse[after[ticket_]].alphanumeric.last.add[1]>
    - if <[u].has_flag[cur_int]>:
      - ~discordmessage id:zc-info user:<[u]> "<discord_embed.with[title].as[Ticket #<[num]>].with[description].as[Your current interaction with the bot has been changed to: Ticket #<[num]>].with[color].as[aqua]>"
    - flag <[u]> bot_int:->:ticket_<[num]>
    - flag <[u]> cur_int:ticket_<[num]> expire:2h
    - define ruuid <util.random_uuid>
    - define butt <discord_button.with[id].as[close_thread_<[ruuid]>].with[label].as[Close].with[style].as[secondary]>
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[tickets_channel].get[id]> <discord_embed.with_map[<script[d_messages].parsed_key[ticket_msg]>]> rows:<[butt]> save:msg
    - ~discordcreatethread id:zc-thread name:<[u].name>_ticket_<[num]> message:<entry[msg].message> save:thread
    - flag <[u]> ticket.<[num]>:<entry[thread].created_thread>
    - flag <entry[thread].created_thread> ticket.user:<[u]>
    - flag <entry[thread].created_thread> ticket.num:<[num]>
    - flag <entry[msg].message.channel> <[ruuid]>:<entry[thread].created_thread>
    - define owners <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>]>]>
    - define admins <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>]>
    - define mods <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].members.filter_tag[<[filter_value].roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>]>]>
    - define users <list[<[owners]>].include[<[admins]>].include[<[mods]>].deduplicate>
    - foreach <[users]> as:user:
      - adjust <entry[thread].created_thread> add_thread_member:<[user]>
    - wait <[users].size.div[1.4]>s
    - if <[atta].is_empty>:
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <discord_embed.with_map[<script[d_messages].parsed_key[ticket_msg]>]>
    - else:
      - if <[atta].separated_by[<&nl>].length> >= 1024:
        - define attach <[atta].separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
      - else:
        - define attach <[atta].separated_by[<&nl>]>
      - define form <[atta].first.after_last[.]||error>
      - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
        - define pic <[atta].first>
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <discord_embed.with_map[<script[d_messages].parsed_key[ticket_attach_pic_msg]>]>
      - else:
        - ~discordmessage id:zc-info channel:<entry[thread].created_thread> <discord_embed.with_map[<script[d_messages].parsed_key[ticket_attach_msg]>]>
    - ~discordmessage id:zc-info user:<[u]> "<discord_embed.with[title].as[Ticket Opened].with[footer].as[A staff member will respond to you when available]>"

bot_connect:
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
    on server start:
    - ~discordconnect id:zc-info token:<secret[zc_bot_token]>
    - ~discordconnect id:zc-thread token:<secret[zc_thread_token]>
    - ~discord id:zc-info status "over Link" status:ONLINE activity:WATCHING
    - ~discord id:zc-thread status "Over Threads" status:INVISIBLE activity:WATCHING
    on discord message received for:zc-info:
    - if <context.new_message.is_direct>:
      - stop
    - if <context.new_message.author.is_bot>:
      - stop
    ##
    # the commands that can be run in any channel
    # mostly info commands
    ##
    # minecraft announcements channel messages
    - if <context.new_message.channel.id> == <script[zc_bot_info].data_key[mc_announce_channel].get[id]>:
      - define msg "<&nl><&2><&l>New Announcement!<&nl><&nl><&r><context.new_message.text_stripped>"
      - run GLOBAL_ANNOUNCE def:<[msg]>
      - flag server last_announce:<util.time_now>
      - flag <server.online_players> last_announce:<server.flag[last_announce]>
    # suggestion channel messages
    - if <context.new_message.channel.id> == <script[zc_bot_info].data_key[suggestion_channel].get[id]>:
      - if <context.new_message.replied_to||none> == none:
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Suggestion].with[description].as[You cannot use attachments in this form of making a suggestion<&nl>either post the suggestion without an attachment<&nl>or post the suggestion through the bots DM].with[color].as[red]>"
          - adjust <context.new_message> delete
          - stop
        - else:
          - define atta <list>
        - run create_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - adjust <context.new_message> delete
      - else:
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - flag <context.new_message.author> sug_reply_msg:<context.new_message.replied_to>
        - if !<context.new_message.attachments.is_empty>:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Suggestion Reply].with[description].as[You cannot use attachments in this form of making a reply<&nl>either post the reply without an attachment<&nl>or post the reply through the bots DM].with[color].as[red]>"
          - adjust <context.new_message> delete
          - stop
        - else:
          - define atta <list>
        - run reply_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - adjust <context.new_message> delete
    # bug report channel messages
    - if <context.new_message.channel.id> == <script[zc_bot_info].data_key[bugs_channel].get[id]>:
      - if <context.new_message.replied_to||none> == none:
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - if !<context.new_message.attachments.is_empty>:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Bug report].with[description].as[You cannot use attachments in this form of making a bug report<&nl>either post the bug report without an attachment<&nl>or post the bug report through the bots DM].with[color].as[red]>"
          - adjust <context.new_message> delete
          - stop
        - else:
          - define atta <list>
        - run create_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - adjust <context.new_message> delete
      - else:
        - define u <context.new_message.author>
        - define msg <context.new_message.text_no_mentions>
        - flag <context.new_message.author> bug_reply_msg:<context.new_message.replied_to>
        - if !<context.new_message.attachments.is_empty>:
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Bug report Reply].with[description].as[You cannot use attachments in this form of making a reply<&nl>either post the reply without an attachment<&nl>or post the reply through the bots DM].with[color].as[red]>"
          - adjust <context.new_message> delete
          - stop
        - else:
          - define atta <list>
        - run reply_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
        - adjust <context.new_message> delete
    # the bot quotes message links
    - if <context.new_message.text.contains_text[https://discord.com/channels/]>:
      - foreach <context.new_message.text.split[https://discord.com/channels/]> as:link:
        - if !<[link].contains_text[/]>:
          - foreach next
        - define guild <[link].split[/].first>
        - define channel <[link].split[/].get[2]>
        - define mess <[link].split[/].get[3].split[].get[1].to[18].unseparated>
        - if <discord[zc-info].groups.parse[id]> !contains <[guild]>:
          - foreach next
        - define dmsg <discord_message[zc-info,<[channel]>,<[mess]>]>
        - if !<[dmsg].attachments.is_empty>:
          - if <[dmsg].attachments.first.after_last[.]> in <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]>:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_icon_url].as[<[dmsg].author.avatar_url>].with[author_name].as[Sent by <[dmsg].author.name>#<[dmsg].author.discriminator> in #<[dmsg].channel.name>].with[description].as[<[dmsg].text>].with[image].as[<[dmsg].attachments.first>].with[color].as[white]>" no_mention
            - foreach next
        - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_icon_url].as[<[dmsg].author.avatar_url>].with[author_name].as[Sent by <[dmsg].author.name>#<[dmsg].author.discriminator> in #<[dmsg].channel.name>].with[description].as[<[dmsg].text>].with[color].as[white]>" no_mention
    # cracks command
    - if <context.new_message.text_no_mentions> == ?cracks || <context.new_message.text_no_mentions> == ?cracked || <context.new_message.text_no_mentions> == ?crack:
      - ~discordmessage id:zc-info channel:<context.channel> <discord_embed.with_map[<script[d_messages].parsed_key[cracked_msg]>]>
      - stop
    # bedrock command
    - if <context.new_message.text_no_mentions> == ?bedrock:
      - ~discordmessage id:zc-info channel:<context.channel> <discord_embed.with_map[<script[d_messages].parsed_key[bedrock_msg]>]>
      - stop
    # greenleeuw command
    - if <context.new_message.text_no_mentions> == ?greenleeuw:
      - ~discordmessage id:zc-info channel:<context.channel> <discord_embed.with_map[<script[d_messages].parsed_key[greenleeuw_msg]>]>
      - stop
    # force_ticket command
    - if <context.new_message.text_no_mentions> == <script[zc_bot_info].parsed_key[prefix]>force_ticket:
      - if <context.new_message.replied_to.if_null[<empty>]> == <empty>:
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Force Ticket].with[description].as[No message was linked with your request].with[color].as[red]>"
        - adjust <context.new_message> delete
        - stop
      - if <context.new_message.replied_to.author.is_bot>:
        - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Force Ticket].with[description].as[I cannot start a ticket with a bot].with[color].as[red]>"
        - adjust <context.new_message> delete
        - stop
      - define u <context.new_message.replied_to.author>
      - define msg <context.new_message.replied_to.text>
      - if !<context.new_message.replied_to.attachments.is_empty>:
        - define atta <context.new_message.replied_to.attachments>
      - else:
        - define atta <list>
      - ~discordmessage id:zc-info user:<[u]> "<discord_embed.with[title].as[Forced Ticket].with[description].as[A Ticket has been forced to open.<&nl><&nl>**Ticket Message:**<&nl><&gt><&sp><[msg]>]>"
      - run create_ticket_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
      - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Force Ticket].with[description].as[Ticket opened with <[u].name>].with[color].as[lime]>"
      - adjust <context.new_message> delete
    ##
    # ticket messages on the staff team side
    # ticket channels cannot include commands
    ##
    - if <context.new_message.channel.name.advanced_matches[*_ticket_*]>:
      - define ticket <context.new_message.channel.flag[ticket]>
      - if <context.new_message.attachments.is_empty>:
        - ~discordmessage id:zc-info user:<[ticket].get[user]> "<discord_embed.with[title].as[Ticket #<[ticket].get[num]>].with[description].as[<context.new_message.text_no_mentions>].with[footer].as[<context.new_message.author.name> replied to your ticket]>"
      - else:
        - if <context.new_message.attachments.separated_by[<&nl>].length> >= 1024:
          - define attach <context.new_message.attachments.separated_by[<&nl>].split[].get[1].to[1016].unseparated>...SNIP
        - else:
          - define attach <context.new_message.attachments.separated_by[<&nl>]>
        - define form <context.new_message.attachments.first.after_last[.]||error>
        - if <list[apng|avif|jpg|jpeg|jfif|pjpeg|pjp|png|svg|webp]> contains <[form]>:
          - define pic <context.new_message.attachments.first>
          - ~discordmessage id:zc-info user:<[ticket].get[user]> "<discord_embed.with[title].as[Ticket #<[ticket].get[num]>].with[description].as[<context.new_message.text_no_mentions>].with[footer].as[<context.new_message.author.name> replied to your ticket].add_field[attachments].value[<[attach]>].with[thumbnail].as[<[pic]>]>"
        - else:
          - ~discordmessage id:zc-info user:<[ticket].get[user]> "<discord_embed.with[title].as[Ticket #<[ticket].get[num]>].with[description].as[<context.new_message.text_no_mentions>].with[footer].as[<context.new_message.author.name> replied to your ticket].add_field[attachments].value[<[attach]>]>"
    ##
    # commands that should only be able be run in the mod channel
    # this channel also supports all other commands
    ##
    - if !<context.new_message.text.starts_with[<script[zc_bot_info].parsed_key[prefix]>]>:
      - stop
    - define args <context.new_message.text.after[<script[zc_bot_info].parsed_key[prefix]>].split[<&sp>]>
    - define p error
    - if <context.new_message.channel.id> == <script[zc_bot_info].data_key[test_channel].get[id]>:
      - choose <[args].first>:
        # warnings command
        - case warnings:
          - inject needs_name_task
          - if !<[p].has_flag[moderate.warnings]>:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[list_mod_msg]>]> no_mention
            - stop
          - if <[p].flag[moderate.warnings].size> > 25:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Warnings].with[description].as[They have more then 25 warnings, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
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
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Warnings].with[description].as[<[p].name> has <[p].flag[moderate.warnings].size||0> warnings].with[color].as[yellow].with_map[<map.with[fields].as[<[warns]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
          - stop
        # tempbans command
        - case tempbans:
          - inject needs_name_task
          - if !<[p].has_flag[moderate.tempban]>:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[dis_messages].parsed_key[list_mod_msg]>]> no_mention
            - stop
          - if <[p].flag[moderate.tempban].size> > 25:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Tempbans].with[description].as[They have more then 25 tempbans, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
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
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Tempbans].with[description].as[<[p].name> has <[p].flag[moderate.tempban].size||0> tempbans].with[color].as[aqua].with_map[<map.with[fields].as[<[temps]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
          - stop
        # permbans command
        - case permbans:
          - inject needs_name_task
          - if !<[p].has_flag[moderate.permban]>:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[dis_messages].parsed_key[list_mod_msg]>]> no_mention
            - stop
          - if <[p].flag[moderate.permban].size> > 25:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Permbans].with[description].as[They have more then 25 permbans, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
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
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Permbans].with[description].as[<[p].name> has <[p].flag[moderate.permban].size||0> permbans].with[color].as[orange].with_map[<map.with[fields].as[<[perms]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
          - stop
        # unban commands
        - case unbans:
          - inject needs_name_task
          - if !<[p].has_flag[moderate.unban]>:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[dis_messages].parsed_key[list_mod_msg]>]> no_mention
            - stop
          - if <[p].flag[moderate.unban].size> > 25:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Unbans].with[description].as[They have more then 25 unbans, which is the limit of fields a embed can have.].add_inline_field[Warnings].value[<[p].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[p].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[p].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
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
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[p].name>'s Unbans].with[description].as[<[p].name> has <[p].flag[moderate.unban].size||0> Unbans].with[color].as[black].with_map[<map.with[fields].as[<[unbans]>]>].with[thumbnail].as[https://images.emojiterra.com/twitter/512px/1f4dc.png]>" no_mention
          - stop
    ##
    # all other zc commands are run in #bot-spam
    # shouldn't be possible in any other channel
    ##
    - if <context.new_message.channel.id> == <script[zc_bot_info].data_key[test_channel].get[id]> || <context.new_message.channel.id> == <script[zc_bot_info].data_key[bot_channel].get[id]>:
      - choose <[args].first>:
        # trusted & helper & builder & moderator command
        - case trusted helper builder moderator:
          - define application <[args].first>
          - define app <[args].first.to_titlecase>
          - if <[application]> == moderator:
            - define application mod
            - define app Moderator
          - if <context.new_message.author.flag[bot_int].size||0> >= 25:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg_slash]>]> no_mention
            - stop
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - flag <context.new_message.author> bot_int:->:<[application]>_1
          - if <context.new_message.author.has_flag[cur_int]>:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Bug report].with[description].as[Your current interaction with the bot has been changed to: <[app]> Application].with[color].as[aqua]>" no_mention
          - flag <context.new_message.author> cur_int:<[application]>_1
          - flag <context.new_message.author> <[application]>_app.player:<[player]>
          - define butt <discord_button.with[id].as[stop_<[application]>_app].with[label].as[Stop!].with[style].as[danger]>
          - ~discordmessage id:zc-info user:<context.new_message.author> <discord_embed.with_map[<script[d_messages].parsed_key[<[application]>_1_msg]>]> rows:<[butt]>
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
        # interactions command
        - case interactions:
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
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
        #linkmc command
        - case linkmc:
          - if <[args].size> <= 1:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Link Mc].with[description].as[You did not include a name.<&nl>A player name is requered for this command].with[color].as[red]>" no_mention
            - stop
          - if <server.match_offline_player[<[args].get[2].if_null[<empty>]>].if_null[error]> == error:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Link Mc].with[description].as[The player name you included does not seem to be valid.].with[color].as[red]>" no_mention
            - stop
          - define pl <server.match_offline_player[<[args].get[2].if_null[<empty>]>]>
          - if !<[pl].is_online>:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Link Mc].with[description].as[The player you want to link with is currently not online. They need to be online in order to link the accounts].with[color].as[red]>" no_mention
            - stop
          - if <[pl].has_flag[discord_link]>:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Link Mc].with[description].as[The player you want to link with is already linked with another discord account.].with[color].as[red]>" no_mention
            - stop
          - if <context.new_message.author.has_flag[mc_link]>:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Link Mc].with[description].as[You are already linked with a minecraft account].with[color].as[red]>" no_mention
            - stop
          - clickable mclink_task def.pl:<[pl]> def.user:<context.new_message.author> usages:1 for:<[pl]> until:1h save:mclick
          - narrate "Discord user <context.new_message.author.name>#<context.new_message.author.discriminator> wants to link this account with discord" targets:<[pl]> format:zc_text
          - narrate "If this was not you ignore this message!" targets:<[pl]> format:zc_text
          - narrate "If this was you <&e><&click[<entry[mclick].command>]><&hover[Click to link the accounts]>Click here<&end_hover><&end_click><&f>" targets:<[pl]> format:zc_text
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[linkmc_ask_msg]>]> no_mention
        # mcmmo commands
        - case mcmmostats:
          #- if <[args].get[2]> != stats:
          #  - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[mcmmo_wrong_cmd_msg]>]> no_mention
          #  - stop
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - if <[args].get[3]||<empty>> == <empty>:
            - define text <list>
            - foreach <script[zc_bot_info].data_key[mcmmo_stats]> as:skill:
              - define level <[player].mcmmo.level[<[skill]>]||0>
              - define rank <[player].mcmmo.rank[<[skill]>]||0>
              - define xp <[player].mcmmo.xp[<[skill]>]||0>
              - define max_xp <[player].mcmmo.xp[<[skill]>].to_next_level||100>
              - define text "<[text].include[**<[skill]>** <&lb>Rank #<[rank]><&rb> <&lb>Level <[level]> (<[xp]>/<[max_xp]>)<&rb>]>"
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[mcmmo_stats_msg]>]> no_mention
          - else:
            - if <[args].get[3]> !in <script[zc_bot_info].data_key[mcmmo_stats]>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[McMMO Stats].with[description].as[Could not find <[args].get[4]> in the list of skills].with[color].as[red].with[thumbnail].as[https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStagdyunL5zpU5cfCZnvS1YKvHYQH_4Vrsng&usqp=CAU]>" no_mention
              - stop
            - define skill <[args].get[3]>
            - define level <[player].mcmmo.level[<[skill]>]||0>
            - define cur <[player].mcmmo.xp[<[skill]>]||0>
            - define max <[player].mcmmo.xp[<[skill]>].to_next_level||100>
            - define percent <[cur].div[<[max]>].mul[100].round_down>
            - define bar **<element[I].repeat[50].split[].insert[**].at[<[percent].div[2].round_up>].unseparated>
            - if <[bar].starts_with[****]>:
              - define bar <[bar].after_last[*]>
            - define rank <[player].mcmmo.rank[<[skill]>]||0>
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[player].name> <[skill]> Stats].with[description].as[Ranked #<[rank]><&nl>[Level <[level]>] <[bar]> (<[cur]>/<[max]> xp) (<[percent]><&pc> to level <[level].add[1]>)].with[color].as[aqua].with[thumbnail].as[https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStagdyunL5zpU5cfCZnvS1YKvHYQH_4Vrsng&usqp=CAU]>" no_mention
        # votes command
        - case votes:
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[votes_msg]>]> no_mention
        # bal command
        - case bal:
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[bal_msg]>]> no_mention
        # times command
        - case times:
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[times_msg]>]> no_mention
        # stats command
        - case stats:
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - define uuid <[player].uuid>
          - if !<yaml.list.contains[<[uuid]>]>:
            - ~webget http://localhost:8080/players/<[uuid]> save:request
            - if <entry[request].failed>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name||error>/190.png].with[description].as[This player isn't registered to zc].with[color].as[red]>" no_mention
              - stop
            - yaml loadtext:<entry[request].result> id:<[uuid]>
            - define unload true
          - define pvp_points <yaml[<[uuid]>].read[pvppoints]>
          - define max_magic <yaml[<[uuid]>].read[completed_dungeons].size.mul[3].add[<yaml[<[uuid]>].read[completed_secrets].size>].add[100]>
          - foreach <script.list_keys[pvp_ranks].sort_by_number[].reverse> as:score:
            - if <[pvp_points]> >= <[score]>:
              - define rank <script.data_key[pvp_ranks.<[score]>]>
              - foreach stop
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[Here is all the zcrpg stats we could find].add_field[Race].value[<yaml[<[uuid]>].read[race].strip_color||error>].add_inline_field[Dungeon Points].value[<yaml[<[uuid]>].read[completed_dungeons].size><&nl>To see all completed dungeons use the finished command].add_field[Secret Points].value[<yaml[<[uuid]>].read[completed_secrets].size>].add_field[Magic Meter].value[<yaml[<[uuid]>].read[magicmeter]>/<[max_magic]>].add_inline_field[PVP Points].value[<[pvp_points]>].add_field[Rank].value[<[rank]>].with[color].as[aqua]>" no_mention
          - if <[unload]||false>:
            - yaml unload id:<[uuid]>
        # finished command
        - case finished:
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - define uuid <[player].uuid>
          - if !<yaml.list.contains[<[uuid]>]>:
            - ~webget http://localhost:8080/players/<[uuid]> save:request
            - if <entry[request].failed>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name||error>/190.png].with[description].as[This player isn't registered to zc].with[color].as[red]>" no_mention
              - stop
            - yaml loadtext:<entry[request].result> id:<[uuid]>
            - define unload true
          - define dungeons <yaml[<[uuid]>].read[completed_dungeons]>
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_name].as[<[player].name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<[player].name> has finished <[dungeons].size||0> dungeons].add_field[Dungeons].value[<[dungeons].pad_right[1].with[none].separated_by[ -|- ]>].with[color].as[aqua]>" no_mention
          - if <[unload]||false>:
            - yaml unload id:<[uuid]>
        # report command
        - case report:
          - choose <[args].get[2]||default>:
            #bug report
            - case bug:
              - if <[args].size> > 2:
                - define msg <[args].get[3].to[999999].space_separated>
                - define u <context.new_message.author>
                - if !<context.new_message.attachments.is_empty>:
                  - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Bug report].with[description].as[You cannot use attachments in this form of making a bug report<&nl>either post the bug report without an attachment<&nl>or post the bug report through the bots DM].with[color].as[red]>"
                  - adjust <context.new_message> delete
                  - stop
                - else:
                  - define atta <list>
                - run create_bug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
              - else:
                - if <context.new_message.author.flag[bot_int].contains[post_bug]>:
                  - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Bug report].with[description].as[You cannot report more then one bug at a time].with[color].as[red]>" no_mention
                  - stop
                - if <context.new_message.author.flag[bot_int].size> >= 25:
                  - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
                  - stop
                - if <context.new_message.author.has_flag[cur_int]>:
                  - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Bug report].with[description].as[Your current interaction with the bot has been changed to: Bug report].with[color].as[aqua]>"
                - flag <context.new_message.author> cur_int:post_bug expire:2h
                - flag <context.new_message.author> bot_int:->:post_bug
                - define butt <discord_button.with[id].as[stop_bug].with[label].as[Cancel!].with[style].as[danger]>
                - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Bug report].with[description].as[Type your bug in here]>" rows:<[butt]>
                - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
              - adjust <context.new_message> delete
            # user report
            - case user:
              - if <[args].size> > 2:
                - define player <[args].get[3].if_null[<empty>]>
                - define msg <[args].get[4].to[999999].space_separated>
                - define u <context.new_message.author>
                - if !<context.new_message.attachments.is_empty>:
                  - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Report].with[description].as[You cannot use attachments in this form of making a report<&nl>either post the report without an attachment<&nl>or post the report through the bots DM].with[color].as[red]>"
                  - adjust <context.new_message> delete
                  - stop
                - else:
                  - define atta <list>
                - run create_u_report_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]> def.player:<[player]>
              - else:
                - if <context.new_message.author.flag[bot_int].contains[post_u_report]>:
                  - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Report].with[description].as[You cannot report more then one user at a time].with[color].as[red]>" no_mention
                  - stop
                - if <context.new_message.author.flag[bot_int].size> >= 25:
                  - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
                  - stop
                - if <context.new_message.author.has_flag[cur_int]>:
                  - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Report].with[description].as[Your current interaction with the bot has been changed to: User report].with[color].as[aqua]>"
                - flag <context.new_message.author> cur_int:post_u_report_1 expire:2h
                - flag <context.new_message.author> bot_int:->:post_u_report_1
                - define butt <discord_button.with[id].as[stop_u_report].with[label].as[Cancel!].with[style].as[danger]>
                - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Report].with[description].as[Type the name of the user in here]>" rows:<[butt]>
                - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
              - adjust <context.new_message> delete
            # grief report
            - case grief:
              - if <[args].size> > 2:
                - define msg <[args].get[3].to[999999].space_separated>
                - define u <context.new_message.author>
                - if !<context.new_message.attachments.is_empty>:
                  - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Report].with[description].as[You cannot use attachments in this form of making a report<&nl>either post the report without an attachment<&nl>or post the report through the bots DM].with[color].as[red]>"
                  - adjust <context.new_message> delete
                  - stop
                - else:
                  - define atta <list>
                - run create_g_report_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
              - else:
                - if <context.new_message.author.flag[bot_int].contains[post_g_report]>:
                  - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Report].with[description].as[You cannot report more then one grief at a time].with[color].as[red]>" no_mention
                  - stop
                - if <context.new_message.author.flag[bot_int].size> >= 25:
                  - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
                  - stop
                - if <context.new_message.author.has_flag[cur_int]>:
                  - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Report].with[description].as[Your current interaction with the bot has been changed to: Grief report].with[color].as[aqua]>"
                - flag <context.new_message.author> cur_int:post_g_report expire:2h
                - flag <context.new_message.author> bot_int:->:post_g_report
                - define butt <discord_button.with[id].as[stop_g_report].with[label].as[Cancel!].with[style].as[danger]>
                - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Report].with[description].as[Type your grief report in here.].with[footer].as[Don't forget to include coords]>" rows:<[butt]>
                - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
              - adjust <context.new_message> delete
            - default:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Report].with[description].as[Something went wrong. Is your layout correct? Did you put `report (bug/user/grief)`?].with[color].as[red]>" no_mention
              - adjust <context.new_message> delete
        # class command
        - case class:
          - if <[args].size> > 1:
            - define class <[args].get[2].if_null[<empty>]>
            - if <[class]> !in <list[hylian|zora|goron|minish|yiga|twili|sheikah|rito|remove]>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Class Selection].with[description].as[The class provided does not seem to be a valid class].with[color].as[red]>" no_mention
              - stop
            - define roles <list[]>
            - foreach <list[Hylian|Zora|Goron|Minish|Yiga|Twili|Sheikah|Rito]> as:role:
              - define roles <[roles].include[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[role]>]>]>
            - if <context.new_message.author.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].contains_any[<[roles]>]>:
              - define r_roles <context.new_message.author.roles[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>].filter_tag[<[roles].contains[<[filter_value]>]>]>
              - foreach <[r_roles]> as:r_role:
                - ~discord id:zc-info remove_role user:<context.new_message.author> role:<[r_role]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
            - if <[class]> != remove:
              - ~discord id:zc-info add_role user:<context.new_message.author> role:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[<[class]>]> group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]>
              - define thumbnail <script[zc_bot_info].parsed_key[classes].get[<[class]>]>
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Class Select].with[description].as[Your class has been changed to <[class]>].with[thumbnail].as[<[thumbnail]>].with[color].as[aqua]>" no_mention
          - else:
            - inject class_menu
            - ~discordmessage id:zc-info reply:<context.new_message> "Pick one" rows:<[selection]> no_mention
        # suggestion command
        - case suggestion:
          - if <[args].size> > 1:
            - define msg <[args].get[2].to[999999].space_separated>
            - define u <context.new_message.author>
            - if !<context.new_message.attachments.is_empty>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Suggestion].with[description].as[You cannot use attachments in this form of making a suggestion<&nl>either post the suggestion without an attachment<&nl>or post the suggestion through the bots DM].with[color].as[red]>"
              - adjust <context.new_message> delete
              - stop
            - else:
              - define atta <list>
            - run create_sug_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
          - else:
            - if <context.new_message.author.flag[bot_int].contains[post_sug]>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Suggestion].with[description].as[You cannot have more then one suggestion creations going on at once].with[color].as[red]>" no_mention
              - stop
            - if <context.new_message.author.flag[bot_int].size> >= 25:
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
              - stop
            - if <context.new_message.author.has_flag[cur_int]>:
              - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Suggestion].with[description].as[Your current interaction with the bot has been changed to: Suggestion Creation].with[color].as[aqua]>"
            - flag <context.new_message.author> cur_int:post_sug expire:2h
            - flag <context.new_message.author> bot_int:->:post_sug
            - define butt <discord_button.with[id].as[stop_sug].with[label].as[Cancel!].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Suggestion].with[description].as[Type your suggestion in here]>" rows:<[butt]>
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
          - adjust <context.new_message> delete
        # total votes command
        - case total_votes:
          - define total_votes 0
          - foreach <server.flag[top_voters_all].keys> as:player:
            - define num <server.flag[top_voters_all].get[<[player]>]>
            - define total_votes <[total_votes].add[<[num]>]>
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[<[total_votes]> total votes found].with[color].as[aqua]>" no_mention
        # vote timer command
        - case vote_timer:
          - define player <server.match_offline_player[<[args].get[2]||<empty>>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2]||<empty>>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - define sites <list>
          - foreach <script[voting_sites].data_key[sites].keys> as:site:
            - if !<[player].has_flag[voted_<[site]>]>:
              - define sites "<[sites].include[<[site]> <&chr[BB]> **Ready to vote**]>"
            - else:
              - define sites "<[sites].include[<[site]> <&chr[BB]> **<[player].flag_expiration[voted_<[site]||error>].from_now.formatted||error> left**]>"
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_name].as[<[player].name> Vote Timers].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name||error>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name||error>/64.png].with[description].as[<[sites].separated_by[<&nl>]>].with[color].as[green]>" no_mention
        # voters command
        - case voters:
          - if <[args].get[2].is_decimal||false>:
            - define page <[args].get[2]||1>
          - else:
            - define page 1
          - define max <server.flag[top_voters_all].size.div[10].round_up>
          - if <[page]> < 1:
            - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Voters].with[description].as[You cannot go lower then 1].with[color].as[red]>"
            - stop
          - if <[page]> > <[max]>:
            - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Voters].with[description].as[You cannot go higher then the max].with[color].as[red]>"
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
          - define ruuid <util.random_uuid>
          - inject voters_buttons
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Top voters all time].with[description].as[<[voters].separated_by[<&nl>]>].with[footer].as[<[page]>/<[max]>].with[color].as[aqua]>" save:voters no_mention rows:<[buttons]>
          - flag <entry[voters].message.channel> <[ruuid]>:<entry[voters].message>
          - flag <entry[voters].message> cur_page:<[page]>
        #baltop command
        - case baltop:
          - define page_size 10
          - if <[args].get[2].is_decimal||false>:
            - define page <[args].get[2]||1>
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
          - yaml loadtext:<entry[request].result> id:<context.new_message.author>-baltop
          - foreach <yaml[<context.new_message.author>-baltop].read[result]> as:data:
            - define num <[loop_index].add[<[start].sub[1]>]>
            - define pre "#<[num]>: <[data].get[name]>"
            - define "output:|:<[pre]> <element[].pad_right[<element[140].sub[<[pre].text_width>].div_int[2]>].with[.]> <server.economy.format[<[data].get[money]>]><&r>"
          - yaml unload id:<context.new_message.author>-baltop
          - define ruuid <util.random_uuid>
          - inject baltop_buttons
          - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[author_name].as[ZeldaCraft Baltop page <[page]>].with[author_icon_url].as[<discord[zc-info].self_user.avatar_url>].with[description].as[Shows the top server balances<&nl>(potentially) type a page number after baltop (1-10)<&nl>Or use the buttons below].add_field[Top Balances].value[<[output].parse[strip_color].separated_by[<n>]>].with[color].as[aqua]>" save:baltop no_mention rows:<[buttons]>
          - flag <entry[baltop].message.channel> <[ruuid]>:<entry[baltop].message>
          - flag <entry[baltop].message> cur_page:<[page]>
        # ban appeal command
        - case ban_appeal banappeal appeal:
          - define player <server.match_offline_player[<[args].get[2].if_null[<empty>]>]||error>
          - if <[player]> == error:
            - if !<context.new_message.author.has_flag[mc_link]>:
              - define name <[args].get[2].if_null[<empty>]>
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_name_msg]>]> no_mention
              - stop
            - define player <context.new_message.author.flag[mc_link]>
          - if !<[player].is_banned>:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[no_ban_msg]>]> no_mention
            - stop
          - if <context.new_message.author.flag[bot_int].contains[ban_appeal_1]> || <context.new_message.author.flag[bot_int].contains[ban_appeal_2]> || <context.new_message.author.flag[bot_int].contains[ban_appeal_1]>:
            - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Ban Appeal].with[description].as[You cannot have more then one ban appeal creations going on at once].with[color].as[red]>" no_mention
            - stop
          - if <context.new_message.author.flag[bot_int].size> >= 25:
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
            - stop
          - if <context.new_message.author.has_flag[cur_int]>:
            - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Your current interaction with the bot has been changed to: Ban Appeal].with[color].as[aqua]>"
          - flag <context.new_message.author> cur_int:ban_appeal_1 expire:2h
          - flag <context.new_message.author> bot_int:->:ban_appeal_1
          - flag <context.new_message.author> ban_appeal.player:<[player]>
          - define butt <discord_button.with[id].as[ban_appeal_cancel].with[label].as[Cancel!].with[style].as[danger]>
          - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ban Appeal].with[description].as[Thank you for wanting to stick with our community through appealing!<&nl><&nl>**First question:**<&nl>Explain the circumstances surrounding your ban]>" rows:<[butt]>
          - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
        # help command
        - case help:
          - if <[args].size> > 1:
            - if <[args].get[2].if_null[<empty>]> !in <list[help|bal|baltop|times|stats|finished|votes|vote_timer|voters|total_votes|linkmc|class|report|suggestion|ban_appeal|ticket|trusted|helper|builder|moderator|interactions|mcmmostats]>:
              - inject help_menu
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[help_msg]>]> rows:<[selection]> no_mention
              - stop
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[help_<[args].get[2].if_null[<empty>]>_msg]>]> no_mention
          - else:
            - inject help_menu
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[help_msg]>]> rows:<[selection]> no_mention
        # ticket command
        - case ticket:
          - if <[args].size> > 1:
            - if <context.new_message.author.flag[bot_int].size||0> >= 25:
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
              - stop
            - define msg <[args].get[2].to[999999].space_separated>
            - define u <context.new_message.author>
            - if !<context.new_message.attachments.is_empty>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Ticket].with[description].as[You cannot use attachments in this form of making a suggestion<&nl>either post the suggestion without an attachment<&nl>or post the suggestion through the bots DM].with[color].as[red]>"
              - adjust <context.new_message> delete
              - stop
            - else:
              - define atta <list>
            - run create_ticket_task def.u:<[u]> def.msg:<[msg]> def.atta:<[atta]>
          - else:
            - if <context.new_message.author.flag[bot_int].contains[start_ticket]>:
              - ~discordmessage id:zc-info reply:<context.new_message> "<discord_embed.with[title].as[Ticket Creation].with[description].as[You cannot have more then one ticket creations going on at once].with[color].as[red]>" no_mention
              - stop
            - if <context.new_message.author.flag[bot_int].size> >= 25:
              - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[too_many_int_msg]>]> no_mention
              - stop
            - if <context.new_message.author.has_flag[cur_int]>:
              - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ticket Creation].with[description].as[Your current interaction with the bot has been changed to: Ticket Creation].with[color].as[aqua]>"
            - flag <context.new_message.author> cur_int:start_ticket expire:2h
            - flag <context.new_message.author> bot_int:->:start_ticket
            - define butt <discord_button.with[id].as[ticket_cancel].with[label].as[Cancel!].with[style].as[danger]>
            - ~discordmessage id:zc-info user:<context.new_message.author> "<discord_embed.with[title].as[Ticket Creation].with[description].as[Type your question/message for the staff team in here]>" rows:<[butt]>
            - ~discordmessage id:zc-info reply:<context.new_message> <discord_embed.with_map[<script[d_messages].parsed_key[dm_msg]>]> no_mention
          - adjust <context.new_message> delete

non_discord_events_w:
  type: world
  debug: false
  events:
    after player completes advancement:
    - if <context.advancement.contains_text[recipes]> || <context.advancement.contains_text[root]>:
      - stop
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[chat_channel].get[id]> "<discord_embed.with[author_name].as[<player.name> has made the advancement <context.advancement.after_last[/].replace_text[_].with[ ]>!].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[color].as[yellow]>"
    on system time secondly every:10:
    - run get_list
    on player dies:
    - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[chat_channel].get[id]> <discord_embed.with[author_name].as[<context.message.strip_color>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[color].as[black]>
    on player drops suggestions_i:
    - determine passively cancelled
    - wait 1t
    - inventory update
    - narrate "You cannot drop the suggestions book" format:zc_text
    on player clicks in inventory:
    - if <context.inventory> != <player.inventory>:
      - if <context.clicked_inventory||null> != <context.inventory||null>:
        - if <context.item.script||null> == <script[suggestions_i]>:
          - determine passively cancelled
          - wait 1t
          - inventory update
          - narrate "you cannot store the suggestions book" format:zc_text
    on player signs book:
    - if <context.book.script.name.if_null[no_script]> == suggestions_i:
      - flag player dis_sug:++ expire:1h
      - if <player.flag[dis_sug].if_null[0]> > 3:
        - narrate "You cannot post more then 3 suggestions in 1 hour" format:zc_text
        - narrate "You can post another suggestion at <player.flag_expiration[dis_sug].format>" format:zc_text
        - determine passively not_signing
        - take item:suggestions_i
        - stop
      - define title <context.title>
      - determine passively not_signing
      - if <context.book.book_pages.is_empty||false>:
        - stop
      - define msg <context.book.book_pages.separated_by[<&nl>].strip_color>
      - run mc_create_sug_task def.p:<player> def.msg:<[msg]> def.title:<[title]>
      - wait 1s
      - take item:suggestions_i
      - narrate "Suggestion posted, <&a><&hover[For real thank you, this will improve the server]>thanks<&f><&end_hover> for suggesting" format:zc_text

#---------------------#
# ingame commands that
# use discord formats
#---------------------#
report_command:
  type: command
  name: report
  description: Lets you report a player, bug, or grief
  usage: /report <&lt>(username)/bug/grief<&gt>
  debug: false
  tab_completions:
    1: bug|grief|<server.online_players.parse[name]>
  script:
  - if <script[zc_bot_info].data_key[MC_no_access_users].contains[<player.uuid>]>:
    - narrate "I'm sorry but it seems like your account is banned from using this command for a certain time." format:zc_text
    - narrate "We ask you to not mess with the bot after this ban has been lifted" format:zc_text
    - narrate "You are not able to appeal for this ban" format:zc_text
    - stop
  - choose <context.args.first>:
    - case bug:
      - if <context.args.get[2].to[last]||empty> == empty:
        - narrate "<&a><&l>Zelda<&2><&l>Craft Report Command"
        - narrate "The ZeldaCraft staff team simply cannot be online 24/7."
        - narrate "Thats why this report command is a thing<&nl> "
        - narrate "If you want to report a player type: <&a><&click[/report ].type[suggest_command]><&hover[Suggest the <&a>/report<&f> command]>/report<&end_hover> <&b><&hover[The username of the player you want to report<&nl>Don't know that because he has a nickname? use the <&a>/realname<&f> command]>[Username]<&end_hover> <&c><&hover[The reason you want to report the user for. Do not report a player without a valid reason!]>[Reason]<&end_hover><&end_click>"
        - narrate "If you want to report a grief stand close to the grief and type: <&a><&click[/report grief ].type[suggest_command]><&hover[Suggest the <&a>/report grief<&f> command]>/report grief<&end_hover> <&b><&hover[Any aditional information you would like to share.<&nl>Something like <&b>there used to be a beacon here<&f>]>[Additional notes]<&end_hover><&end_click>"
        - narrate "If you want to report a bug type: <&a><&click[/report bug ].type[suggest_command]><&hover[Suggest the <&a>/report bug<&f> command]>/report bug<&end_hover> <&b><&hover[Write a description on how you preformed that bug.<&nl>The more details the better]>[How to]<&end_hover><&end_click><&nl> "
        - narrate "Do <&4>NOT<&f> misuse this command"
        - narrate "all reports are welcome but memes/jokes are not"
        - narrate "We appreciate you supporting this comunity by reporting"
        - stop
      - define msg <context.args.get[2].to[last].space_separated.if_null[error]>
      - run mc_create_bug_task def.p:<player> def.msg:<[msg]>
      - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Report posted."
      - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Thank you for reporting we will look into it"
    - case grief:
      - if <context.args.get[2].to[last]||empty> == empty:
        - narrate "<&a><&l>Zelda<&2><&l>Craft Report Command"
        - narrate "The ZeldaCraft staff team simply cannot be online 24/7."
        - narrate "Thats why this report command is a thing<&nl> "
        - narrate "If you want to report a player type: <&a><&click[/report ].type[suggest_command]><&hover[Suggest the <&a>/report<&f> command]>/report<&end_hover> <&b><&hover[The username of the player you want to report<&nl>Don't know that because he has a nickname? use the <&a>/realname<&f> command]>[Username]<&end_hover> <&c><&hover[The reason you want to report the user for. Do not report a player without a valid reason!]>[Reason]<&end_hover><&end_click>"
        - narrate "If you want to report a grief stand close to the grief and type: <&a><&click[/report grief ].type[suggest_command]><&hover[Suggest the <&a>/report grief<&f> command]>/report grief<&end_hover> <&b><&hover[Any aditional information you would like to share.<&nl>Something like <&b>there used to be a beacon here<&f>]>[Additional notes]<&end_hover><&end_click>"
        - narrate "If you want to report a bug type: <&a><&click[/report bug ].type[suggest_command]><&hover[Suggest the <&a>/report bug<&f> command]>/report bug<&end_hover> <&b><&hover[Write a description on how you preformed that bug.<&nl>The more details the better]>[How to]<&end_hover><&end_click><&nl> "
        - narrate "Do <&4>NOT<&f> misuse this command"
        - narrate "all reports are welcome but memes/jokes are not"
        - narrate "We appreciate you supporting this comunity by reporting"
        - stop
      - define msg <context.args.get[2].to[last].space_separated.if_null[error]>
      - run mc_create_g_report_task def.p:<player> def.msg:<[msg]> def.loc:<player.location.simple>
      - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Report posted."
      - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Thank you for reporting we will look into it"
    - default:
      - if <server.match_offline_player[<context.args.first>]||invalid> == invalid:
        - narrate "<&a><&l>Zelda<&2><&l>Craft Report Command"
        - narrate "The ZeldaCraft staff team simply cannot be online 24/7."
        - narrate "Thats why this report command is a thing<&nl> "
        - narrate "If you want to report a player type: <&a><&click[/report ].type[suggest_command]><&hover[Suggest the <&a>/report<&f> command]>/report<&end_hover> <&b><&hover[The username of the player you want to report<&nl>Don't know that because he has a nickname? use the <&a>/realname<&f> command]>[Username]<&end_hover> <&c><&hover[The reason you want to report the user for. Do not report a player without a valid reason!]>[Reason]<&end_hover><&end_click>"
        - narrate "If you want to report a grief stand close to the grief and type: <&a><&click[/report grief ].type[suggest_command]><&hover[Suggest the <&a>/report grief<&f> command]>/report grief<&end_hover> <&b><&hover[Any aditional information you would like to share.<&nl>Something like <&b>there used to be a beacon here<&f>]>[Additional notes]<&end_hover><&end_click>"
        - narrate "If you want to report a bug type: <&a><&click[/report bug ].type[suggest_command]><&hover[Suggest the <&a>/report bug<&f> command]>/report bug<&end_hover> <&b><&hover[Write a description on how you preformed that bug.<&nl>The more details the better]>[How to]<&end_hover><&end_click><&nl> "
        - narrate "Do <&4>NOT<&f> misuse this command"
        - narrate "all reports are welcome but memes/jokes are not"
        - narrate "We appreciate you supporting this comunity by reporting"
        - stop
      - if <context.args.get[2].to[last]||<&4>Wrong> == <&4>Wrong:
        - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> You have to put a reason when reporting a user"
        - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Remember using the report command without good context"
        - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> <&dq>He said frick.<&dq> will not be appreciated"
        - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> We take reports seriously, if you don't we will punish you."
        - stop
      - define user <server.match_offline_player[<context.args.first>]||error>
      - if <[user]> == <player>:
        - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> You can not report yourself"
        - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> We take reports seriously, if you don't we will punish you."
        - stop
      - define msg <context.args.get[2].to[last].space_separated.if_null[error]>
      - run mc_create_u_report_task def.p:<player> def.msg:<[msg]> def.player:<[user].name>
      - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Report posted."
      - narrate "<&2>Z<&a>c <&7><&gt><&gt><&f> Thank you for reporting we will look into it"

suggestion:
  type: command
  name: suggestion
  description: Lets you post a suggestion
  usage: /suggestion <&lt>suggestion<&gt>
  debug: false
  script:
  - if <script[zc_bot_info].data_key[MC_no_access_users].contains[<player.uuid>]>:
    - narrate "I'm sorry but it seems like your account is banned from using this command for a certain time." format:zc_text
    - narrate "We ask you to not mess with the bot after this ban has been lifted" format:zc_text
    - narrate "You are not able to appeal for this ban" format:zc_text
    - stop
  - if <context.args.first.if_null[<empty>]> == <empty>:
    - if <player.inventory.contains_item[suggestions_i]>:
      - take item:suggestions_i
      - narrate "Suggestion book <&hover[Poof!]><&a>Removed!<&end_hover>" format:zc_text
      - stop
    - give suggestions_i
    - narrate "Here is a suggestion book" format:zc_text
    - narrate "Write your suggestion in that book" format:zc_text
    - narrate "When you are done <&a><&hover[Choose a fitting title!]>Sign<&end_hover><&f> The book and your suggestion will be posted" format:zc_text
  - else:
    - define msg <context.args.get[1].to[last].space_separated>
    - run mc_create_sug_task def.p:<player> def.msg:<[msg]> def.title:<empty>
    - narrate "Your suggestion was succesfully posted" format:zc_text

news_cmd:
  type: command
  name: announcements
  debug: false
  description: Shows the recent announcements
  usage: /announcements (Number)
  aliases:
  - news
  script:
    - define page <context.args.get[1].max[1].min[100]||1>
    - define messages <discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[mc_announce_channel].get[name]>].last_message.previous_messages[100]>
    - define max_page <[messages].size.add[1]||1>
    - if <[page]> > <[max_page]>:
      - narrate "<&c>You cannot view announcements this high!" format:zc_text
    - define num <[page].sub[1]>
    - if <[page]> == 1:
      - define messages <list[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[mc_announce_channel].get[name]>].last_message>]>
      - define num 1
    - narrate "<&nl><&2><&l>Announcement #<[page]><&nl>"
    - narrate <[messages].get[<[num]>].text_stripped><&nl>
    - if <[max_page]> <= 1:
      - narrate " "
      - stop
    - define left_ar "<&hover[Click here to go a page backwards]><&click[/announcements <[page].sub[1]>]><&color[#04BA04]><&chr[25C0]><&end_click><&end_hover>"
    - define right_ar "<&hover[Click here to go a page forward]><&click[/announcements <[page].add[1]>]><&color[#04BA04]><&chr[25B6]><&end_click><&end_hover>"
    - if <[page]> == 1:
      - narrate "<&nl><&color[#04BA04]><&chr[25C1]> <&r>Page <[page]>/<[max_page]> <[right_ar]><&nl>"
      - stop
    - if <[page]> == <[max_page]>:
      - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max_page]> <&color[#04BA04]><&chr[25B7]><&nl>"
      - stop
    - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max_page]> <[right_ar]><&nl>"

discord_command_den:
    type: command
    name: discord
    description: Gives you the link to our discord
    usage: /discord
    debug: false
    script:
    - narrate "Click this link to join our discord! <&click[https://discordapp.com/invite/P57m9qK].type[open_url]><&b><&n>https://discordapp.com/invite/P57m9qK<&end_click>" format:zc_text

#--------------------#
# discord role keeper
#--------------------#
discord_role_keep:
  type: world
  debug: false
  events:
    on discord user joins group:152498419569524736 for:zc-info:
    - if <context.user.has_flag[discord_roles]>:
      - announce "has roles" to_console
      - announce <context.user.flag[discord_roles].parse[name]> to_console
      - foreach <context.user.flag[discord_roles]> as:role:
        - ~discord id:zc-info group:<context.group> user:<context.user> add_role role:<discord_role[<[role]>]>
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[logs_channel].get[id]> "<discord_embed.with[author_name].as[<context.user.name> joined back].with[author_icon_url].as[<context.user.avatar_url>].with[description].as[<context.user.mention>'s roles have been automatically put back].add_field[Roles:].value[<context.user.flag[discord_roles].parse[mention].space_separated||none>].with[color].as[lime].with[footer].as[ID: <context.user.id>].with[timestamp].as[<util.time_now>]>"
      - announce finished to_console
    - else:
      - announce "No roles" to_console
    on discord user role changes group:152498419569524736 for:zc-info:
    - if <context.new_roles.is_empty>:
      - announce "no role found" to_console
      - flag <context.user> discord_roles:!
      - stop
    - announce <context.new_roles.parse[name]> to_console
    - flag <context.user> discord_roles:<context.new_roles||!>
    - announce <context.user.flag[discord_roles].parse[name]> to_console

get_list:
  type: task
  debug: false
  script:
    - define player <server.flag[global_player_data].parse[get[name]]||<list>>
    - if <[player].is_empty>:
      - define players "Nobody is currently online. Feel free to join!"
    - else:
      - foreach <[player].alphabetical>:
        - define "players:->:<&chr[BB]> **<[value].replace[_].with[\_].replace[*].with[\*]>**"
      - if <[players].is_empty||true>:
        - define players "Nobody is currently online. Feel free to join!"
      - else:
        - define amount <[players].size>
        - define players <[players].separated_by[<&nl>]>
    - ~discordmessage id:zc-info edit:757905073660755998 channel:757903718640517191 "<discord_embed.with[author_name].as[ZeldaCraft online players].with[author_url].as[https://www.zeldacraft.com/].with[color].as[aqua].with[footer].as[Last updated].with[timestamp].as[<util.time_now>].with[description].as[**<[amount]||0> player(s) online**<&nl><[players]>]>"
