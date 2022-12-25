# replace[*].with[\*].replace[_].with[\_].replace[~].with[\~].replace[`].with[\`].replace[<&gt>].with[\<&gt>]
blocked_words:
  type: data
  debug: false
  ban_words:
    - <binary[6e6967676572].utf8_decode>
    - <binary[6e696767657273].utf8_decode>
  temp_words:
    - <binary[6e69676761].utf8_decode>
    - <binary[6e6967676173].utf8_decode>
    - <binary[666167676f74].utf8_decode>
    - <binary[666167676f7473].utf8_decode>
    - <binary[666167].utf8_decode>
    - <binary[66616773].utf8_decode>
  warn_words:
    - <binary[726574617264].utf8_decode>
  exceptions:
    - fagyistefi
  ascii_letters:
    - abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!<&dq>#$<&sq>()*+,-./:;<&lt>=<&gt>?@[\]^_`{}~

chat_blocker_events:
  type: world
  debug: false
  events:
    on command:
      - if <context.source_type> == player:
        - if <context.raw_args.contains_any_text[<script[blocked_words].parsed_key[ban_words]>]> || <context.raw_args.contains_any_text[<script[blocked_words].parsed_key[temp_words]>]> || <context.raw_args.contains_any_text[<script[blocked_words].parsed_key[warn_words]>]>:
          - if <context.raw_args.split[<&sp>].contains_any[<script[blocked_words].parsed_key[exceptions]>]>:
            - stop
          - ~discordmessage id:zc-info channel:618112829077192705 <discord[zc-info].group[ZeldaCraft].role[Admin].mention>
          - ~discordmessage id:zc-info channel:618112829077192705 "<discord_embed.with[author_name].as[<player.name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[description].as[<player.name> used a blocked word in a command].add_field[Used command:].value[<context.command> <context.raw_args>].with[color].as[red].with[footer].as[server].with[footer_icon].as[https://cravatar.eu/helmavatar/Loopsplz/190.png].with[timestamp].as[<util.time_now>]>"
    on player chats bukkit_priority:low:
      - define msg <context.message>
      - if <[msg].strip_color.split[<&sp>].contains_any[<script[blocked_words].parsed_key[ban_words]>]>:
        - if <[msg].strip_color.split[<&sp>].contains_any[<script[blocked_words].parsed_key[exceptions]>]>:
          - stop
        - determine passively cancelled
        - define num <player.flag[moderate.permban].size||1>
        - define message "Usage of racial slurs. - auto ban"
        - flag player moderate.permban.<[num]>.by_player:server
        - flag player moderate.permban.<[num]>.reason:<[message]>
        - flag player moderate.permban.<[num]>.time_now:<util.time_now>
        - flag player moderate.permban.<[num]>.was_ip:false
        - ban <player> reason:<[message]> source:server
        - define has_perm <player.has_flag[moderate.permban]>
        - define has_temp <player.has_flag[moderate.tempban]>
        - define has_warn <player.has_flag[moderate.warnings]>
        - narrate "<&4>Permban From <&c><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&c>Player: <&f><player.name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&c>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&c>Time: <&f><util.time_now.format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&c><player.name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <player.name>]><&hover[Click to show their warning(s)]><&e>[<player.flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <player.name>]><&hover[Click to show their Tempban(s)]><&3>[<player.flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <player.name>]><&hover[Click to show their permban(s)]><&c>[<player.flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - announce "<player.name> got auto banned. Message:<&nl><[msg]>" to_console
        - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<player.name>].with[author_url].as[https://minecraft-statistic.net/en/player/<player.name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[description].as[Server has permbanned <player.name>].add_field[Permban Reason:].value[<[message]>].add_inline_field[Time of permban:].value[<util.time_now.format>].add_field[Ip permban].value[false].add_inline_field[Warnings].value[<player.flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<player.flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<player.flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[server].with[footer_icon].as[https://cravatar.eu/helmavatar/Loopsplz/190.png].with[timestamp].as[<util.time_now>]>"
        - stop
      - if <[msg].strip_color.split[<&sp>].contains_any[<script[blocked_words].parsed_key[temp_words]>]>:
        - if <[msg].strip_color.split[<&sp>].contains_any[<script[blocked_words].parsed_key[exceptions]>]>:
          - stop
        - determine passively cancelled
        - define time 7d
        - define num <player.flag[moderate.tempban].size||1>
        - define message "Usage of racial slurs. - auto ban"
        - flag player moderate.tempban.<[num]>.by_player:server
        - flag player moderate.tempban.<[num]>.reason:<[message]>
        - flag player moderate.tempban.<[num]>.time_till:<[time]>
        - flag player moderate.tempban.<[num]>.time_now:<util.time_now>
        - flag player moderate.tempban.<[num]>.was_ip:false
        - ban <player> reason:<[message]> duration:<[time]> source:server
        - define has_perm <player.has_flag[moderate.permban]>
        - define has_temp <player.has_flag[moderate.tempban]>
        - define has_warn <player.has_flag[moderate.warnings]>
        - narrate "<&1>Tempban From <&c><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&3>Player: <&f><player.name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&3>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&3>Until: <&f><util.time_now.add[<[time]>].format> (<[time].as[duration].formatted>)" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&3>Time: <&f><util.time_now.format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&3><player.name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <player.name>]><&hover[Click to show their warning(s)]><&e>[<player.flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <player.name>]><&hover[Click to show their Tempban(s)]><&3>[<player.flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <player.name>]><&hover[Click to show their permban(s)]><&c>[<player.flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - announce "<player.name> got auto banned. Message:<&nl><[msg]>" to_console
        - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<player.name>].with[author_url].as[https://minecraft-statistic.net/en/player/<player.name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[description].as[Server has tempbanned <player.name>].add_field[Tempban Reason:].value[<[message]>].add_inline_field[Time of tempban:].value[<util.time_now.format>].add_inline_field[Tempban untill:].value[<util.time_now.add[<[time]>].format> (<[time].as[duration].formatted>)].add_field[Ip tempban].value[false].add_inline_field[Warnings].value[<player.flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<player.flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<player.flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[server].with[footer_icon].as[https://cravatar.eu/helmavatar/Loopsplz/190.png].with[timestamp].as[<util.time_now>]>"
        - stop
      - if <[msg].strip_color.split[<&sp>].contains_any[<script[blocked_words].parsed_key[warn_words]>]>:
        - if <[msg].strip_color.split[<&sp>].contains_any[<script[blocked_words].parsed_key[exceptions]>]>:
          - stop
        - determine passively cancelled
        - define message "Usage of racial slurs. - auto warning"
        - if <player.is_online>:
          - clickable confirm_warn def:<player> save:conf_click
          - narrate "<&e>You have been <&6>warned:<&nl>" targets:<player>
          - narrate "<&e>Reason: <&f><[message]>" targets:<player>
          - narrate "<&e>Time: <&f><util.time_now.format><&nl>" targets:<player>
          - narrate "<&e>Click <&click[<entry[conf_click].command>]><&hover[Confirm to stop the warning message from reappearing]><&a>[Confirm]<&end_hover><&end_click><&e> to confirm that you received this" targets:<player>
        - flag player new_warnings:->:<map.with[<[message]>].as[<util.time_now>]>
        - define num <player.flag[moderate.warnings].size.add[1]||1>
        - flag player moderate.warnings.<[num]>.by_player:server
        - flag player moderate.warnings.<[num]>.reason:<[message]>
        - flag player moderate.warnings.<[num]>.time:<util.time_now>
        - define has_perm <player.has_flag[moderate.permban]>
        - define has_temp <player.has_flag[moderate.tempban]>
        - define has_warn <player.has_flag[moderate.warnings]>
        - narrate "<&6>Auto warning From <&e>Server recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&e>Player: <&f><player.name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&e>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&e>Time: <&f><util.time_now.format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<&e><player.name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <player.name>]><&hover[Click to show their warning(s)]><&e>[<player.flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <player.name>]><&hover[Click to show their Tempban(s)]><&3>[<player.flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <player.name>]><&hover[Click to show their permban(s)]><&c>[<player.flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
        - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<player.name>].with[author_url].as[https://minecraft-statistic.net/en/player/<player.name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[description].as[Server has warned <player.name>].add_field[Warning Reason:].value[<[message]>].add_field[Time of warning:].value[<util.time_now.format>].add_inline_field[Warnings].value[<player.flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<player.flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<player.flag[moderate.permban].size||0> Permbans].with[color].as[yellow].with[footer].as[server].with[footer_icon].as[https://cravatar.eu/helmavatar/server/190.png].with[timestamp].as[<util.time_now>]>"
        - announce "<player.name> got auto warned. Message:<&nl><[msg]>" to_console
        - stop
      - foreach <server.online_players.filter_tag[<context.message.contains[regex:\b<[filter_value].name>\b]>]> as:player:
        - if <player.name> == <[player].name>:
          - foreach next
        - narrate targets:<[player]> "<&6><player.name><&b> mentioned you!"
        - playsound <[player]> sound:zc_sfx.ss.zss_heart custom
        - toast targets:<[player]> "<&6><player.name><&b> mentioned you!" frame:goal
      - if <[msg].strip_color.contains_text[:)]> || <[msg].strip_color.contains_text[<&lt>3]> || <[msg].strip_color.contains_text[:(]> || <[msg].strip_color.contains_text[:/]> || <[msg].strip_color.contains_text[:D]>:
        - if !<player.has_permission[zc.aura]>:
          - goto smartskip
        - if !<player.has_flag[emojis]>:
          - goto smartskip
        - define msg <[msg].replace[:)].with[<&e><&chr[263A]><&f>]>
        - define msg <[msg].replace[:(].with[<&e><&chr[2639]><&f>]>
        - define msg <[msg].replace[:/].with[<&e><&chr[30C4]><&f>]>
        - define msg <[msg].replace[<&lt>3].with[<&c><&chr[2764]><&f>]>
        - define msg <[msg].replace[:D].with[<&e><&chr[263B]><&f>]>
        - determine passively <[msg]>
        - define msg <[msg]>
        - mark smartskip
      - if <[msg].strip_color.contains_text[&]> && <player.has_permission[zc.vip]>:
        - foreach <[msg].split[&]>:
          - if <[value].to_lowercase.split[].first> not in <list[a|b|c|d|e|f|1|2|3|4|5|6|7|8|9|0|k|l|m|n|o|p|r|#]>:
            - foreach next
          - if <[value].starts_with[#]>:
            - define num <[value].split[].get[2].to[7].unseparated>
            - if !<&color[#<[num]>].exists>:
              - foreach next
            - define msg <[msg].replace_text[&#<[num]>].with[<&color[#<[num]>]>]>
          - else:
            - if <[value].split[].first> == k && !<player.has_permission[zc.admind]>:
              - foreach next
            - define n <[value].split[].first>
            - define msg <[msg].replace_text[&<[n]>].with[<element[<&lt>&<[n]><&gt>].parsed>]>
        - determine passively <[msg]>
      #----------------------------------#
      # SECTION MOVED TO global_chat.dsc #
      #----------------------------------#
      #- if <[msg].strip_color.contains_text[@]>:
      #  - define num 0
      #  - define out <empty>
      #  - define server <discord[zc-info].group[ZeldaCraft]>
      #  - foreach "<[msg].split[ ]>":
      #    - if <[value].contains_all_text[@everyone]> || <[value].contains_all_text[@here]>:
      #      - define out "<[out]> <[value].replace[@]>"
      #      - goto smartskip
      #    - if <[value].contains_all_text[@mod]>:
      #      - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Mod].mention>"
      #      - define num:++
      #      - goto smartskip
      #    - if <[value].contains_all_text[@admin]>:
      #      - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Admin].mention>"
      #      - define num:++
      #      - goto smartskip
      #    - if <[value].contains_all_text[@helper]>:
      #      - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Helper].mention>"
      #      - define num:++
      #      - goto smartskip
      #    - if <[value].contains_all_text[@gm]>:
      #      - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Game Master].mention>"
      #      - define num:++
      #      - goto smartskip
      #    - if <[num]> < 3 && <[value].starts_with[@]> && <[value].length> >= 4 && !<[value].contains_text[/]>:
      #      - define i <server.flag[discord_user_names].find_partial[<[value].after[@]>]>
      #      - if <[i]> != -1:
      #        - define out "<[out]> <&lt>@<discord_user[<server.flag[discord_user_objs].get[<[i]>]>].id><&gt>"
      #        - define num:++
      #      - else:
      #        - define out "<[out]> <[value]>"
      #    - else:
      #      - define out "<[out]> <[value]>"
      #    - mark smartskip
      #  - define msg <[out]>

      - if <player.groups.size||1> == 1:
        #- ~discordmessage id:zc-info channel:476430460965355520 "**<&lt><player.name.replace_text[_].with[\_]><&gt>** <[msg].strip_color>"
        - announce "<&7><&lt><player.name.replace_text[_].with[\_]><&gt> <[msg].strip_color>" to_console
      - else:
        #- ~discordmessage id:zc-info channel:476430460965355520 "**<&lt><player.proc[chat_prefix_simple].strip_color> <player.name.replace_text[_].with[\_]><&gt>** <[msg].strip_color>"
        - announce "<&7><&lt><player.proc[chat_prefix_simple].strip_color> <player.name.replace_text[_].with[\_]><&gt> <[msg].strip_color>" to_console
    on discord message received channel:476430460965355520 for:zc-info:
      - if <context.new_message.author.is_bot>:
        - stop
      - if <context.new_message.author.name.matches_character_set[<script[blocked_words].parsed_key[ascii_letters].first.split[]>]>:
        - define author <context.new_message.author.name>
      - else:
        - define author "<&hover[This name was not ASCII<&nl>All non ASCII characters have been removed]><&lb>ASCII<&rb><context.new_message.author.name.trim_to_character_set[<script[blocked_words].parsed_key[ascii_letters].first.split[]>]><&end_hover>"
      - if <context.new_message.text||<empty>> == <empty>:
        - if <context.new_message.attachments.is_empty>:
          - define link https://discord.com/channels/<context.new_message.channel.group.id>/<context.new_message.channel.id>/<context.new_message.id>
        - else:
          - define link <context.new_message.attachments.first>
        - define msg "<&7>[<&color[#7896ff]>Discord<&7>] <&f><[author]><&7> <&chr[BB]> <&click[<[link]>].type[open_url]><[link]><&end_click>"
      - else:
        - define msg "<&7>[<&color[#7896ff]>Discord<&7>] <&f><[author]><&7> <&chr[BB]> <&color[#bbbbbb]><context.new_message.text_display>"
      - run global_announce def:<[msg]>
      - announce <[msg]> to_console
      - foreach <server.online_players.filter_tag[<context.new_message.text_display.contains[regex:\b<[filter_value].name>\b]>]> as:player:
        - narrate targets:<[player]> "<&6><context.new_message.author.name><&b> mentioned you!"
        - playsound <[player]> sound:zc_sfx.ss.zss_heart custom
        - toast targets:<[player]> "<&6><context.new_message.author.name><&b> mentioned you!" frame:goal
    on redis pubsub message channel:global_chat_*:
      - if !<context.channel.ends_with[<bungee.server>]>:
        - define map <context.message.as[map]>
        - define msg <[map].get[message]>
        - define out <list>
        - foreach "<[msg].split[ ]>":
          - if <[value]> == hmm:
            - define out:->:hmmm
          - else:
            - define out:->:<[value]>
        - define msg "<[out].separated_by[ ]>"

        - if <[msg].strip_color.contains_text[@]>:
          - define num 0
          - define out <empty>
          - define server <discord[zc-info].group[ZeldaCraft]>
          - foreach "<[msg].split[ ]>":
            - if <[value].contains_all_text[@everyone]> || <[value].contains_all_text[@here]>:
              - define out "<[out]> <[value].replace[@]>"
            - else if <[value].contains_all_text[@mod]>:
              - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Mod].mention>"
              - define num:++
            - else if <[value].contains_all_text[@admin]>:
              - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Admin].mention>"
              - define num:++
            - else if <[value].contains_all_text[@helper]>:
              - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Helper].mention>"
              - define num:++
            - else if <[value].contains_all_text[@gm]>:
              - define out "<[out]> <discord[zc-info].group[ZeldaCraft].role[Game Master].mention>"
              - define num:++
            - else if <[num]> < 3 && <[value].starts_with[@]> && <[value].length> >= 4 && !<[value].contains_text[/]>:
              - define i <server.flag[discord_user_names].find_partial[<[value].after[@]>]>
              - if <[i]> != -1:
                - define out "<[out]> <&lt>@<discord_user[<server.flag[discord_user_objs].get[<[i]>]>].id><&gt>"
                - define num:++
              - else:
                - define out "<[out]> <[value]>"
            - else:
              - define out "<[out]> <[value]>"
          - define msg <[out]>
        - define skin_data <[map.skin_blob].proc[skin_id]>
        - define params ?uniq=<util.time_now.format[yyyy_MM_dd_HH]>
        - if <[skin_data].get[slim]> == slim:
          - define params <[params]>&slim
        - definemap data:
            username: <[map.name]>
            avatar_url: http://play.zeldacraft.com:8080/portrait/<[skin_data].get[id]><[params]>
        - define data <[data].with[content].as[<[msg].strip_color.replace[*].with[\*].replace[_].with[\_].replace[~].with[\~].replace[`].with[\`]>]>
        - webget <secret[minecraft_chat_webhook]> headers:<map[Content-Type=application/json]> data:<[data].to_json>
        #- else:
        #  - if <[map].get[prefix_simple].length> > 0:
        #    - ~discordmessage id:zc-info channel:476430460965355520 "**<&lt><[map].get[prefix_simple].strip_color> <[map].get[name].strip_color.replace[_].with[\_]><&gt>** <[msg].strip_color.replace[*].with[\*].replace[_].with[\_].replace[~].with[\~].replace[`].with[\`]>"
        #  - else:
        #    - ~discordmessage id:zc-info channel:476430460965355520 "**<&lt><[map].get[name].strip_color.replace[_].with[\_]><&gt>** <[msg].strip_color.replace[*].with[\*].replace[_].with[\_].replace[~].with[\~].replace[`].with[\`]>"
    on delta time minutely:
      - define discord_server <discord[zc-info].group[ZeldaCraft]>
      - define discord_user_objs <[discord_server].members>
      - flag server discord_user_objs:!|:<[discord_user_objs]>
      - flag server discord_user_names:!|:<[discord_user_objs].parse_tag[<[parse_value].name>/<[parse_value].nickname[<[discord_server]>]||>]>
