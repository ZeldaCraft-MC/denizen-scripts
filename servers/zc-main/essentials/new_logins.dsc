joinleave_messages:
  type: data
  debug: false
  data:
    join: <&a>+ <&7><player.name><&7> joined the server <&a>+
    leave: <&c>- <&7><player.name> left the server <&c>-

new_login_events:
  type: world
  debug: false
  events:
    on bungee player joins network:
      - if !<player.exists> || !<player.has_flag[has_logged_in]>:
        - stop
      - flag <player> show_normal_join duration:1m
      - flag <player> show_normal_leave:!
    on player joins:
      - ratelimit <player> 5t
      - if !<player.has_flag[has_logged_in]>:
        - flag <player> has_logged_in
        - run global_announce "def:<&e><&chr[2605]> <&7>Everyone welcome <&e><player.name><&7> to ZeldaCraft! <&e><&chr[2605]>"
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[chat_channel].get[id]> "<discord_embed.with[author_name].as[<&chr[2605]> Everyone welcome <player.name> to ZeldaCraft! <&chr[2605]>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[color].as[orange]>"
        - wait 1t
        - teleport <player> faq_spawn
      - else if <player.has_flag[show_normal_join]>:
        - flag <player> show_normal_join:!
        - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[chat_channel].get[id]> <discord_embed.with[author_name].as[<context.message.strip_color>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[color].as[lime]>
        - run global_announce def:<script[joinleave_messages].parsed_key[data.join]>
        - if <player.flag[last_announce]||0> != <server.flag[last_announce]>:
          - flag <player> last_announce:<server.flag[last_announce]>
          - narrate "<&nl><&2><&l>New Announcement!<&nl><&nl><&r><discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].channel[<script[zc_bot_info].data_key[mc_announce_channel].get[name]>].last_message.text_stripped>"
      - flag <player> show_normal_leave
    on bungee player leaves network:
      - if !<player.exists> || !<player.has_flag[show_normal_leave]>:
        - stop
      - flag <player> show_normal_leave:!
      - run global_announce def:<script[joinleave_messages].parsed_key[data.leave]>
      - ~discordmessage id:zc-info channel:<script[zc_bot_info].data_key[chat_channel].get[id]> "<discord_embed.with[author_name].as[<player.name> left the game].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[color].as[red]>"
