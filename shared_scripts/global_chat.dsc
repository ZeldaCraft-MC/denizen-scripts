skin_id:
  type: procedure
  debug: false
  definitions: skin_blob
  script:
    - define data <util.parse_yaml[<[skin_blob].before[;].base64_to_binary.utf8_decode>].get[textures].get[skin]||null>
    - if <[data]> == null:
      - determine <map[id=BEDROCK;slim=false]>
    - definemap skin:
        id: <[data].get[url].after_last[/]>
        slim: <[data].get[metadata].get[model]||null>
    - determine <[skin]>

zc_text:
  type: format
  debug: false
  format: <&2>Z<&a>C <&7><&gt><&gt><&f> <[text]>

global_announce:
  type: task
  debug: false
  definitions: message
  script:
    - announce <[message]>
    - redis id:publisher publish:global_announce_<bungee.server> message:<[message]>

global_reload:
  type: task
  debug: false
  script:
    - reload
    - redis id:publisher publish:global_reload_<bungee.server> message:reloading

prefixes:
  type: data
  debug: false
  data:
    gm:
      name: Game Master
      color: <&color[#9a32ef]>
      token: <&chr[2605]>
    admin:
      name: Admin
      color: <&c>
      token: <&chr[2726]>
    moderator:
      name: Mod
      color: <&color[#ffa505]>
      token: <&chr[25B2]>
    retired:
      name: Retired
      color: <&color[#108715]>
    cutie:
      name: Cutie
      color: <&color[#ff6ba4]>
    builder:
      name: Builder
      color: <&color[#13eba2]>
    dev:
      name: Dev
      color: <&color[#EFB9C0]>
    helper:
      name: Helper
      color: <&e>
    svip:
      name: SVIP
      color: <&color[#80ffdb]>
    vipplus:
      name: VIP+
      color: <&color[#64dfdf]>
    vip:
      name: VIP
      color: <&color[#48bfe3]>
    trusted:
      name: Trusted
      color: <&color[#5390d9]>

chat_prefix_simple:
  type: procedure
  debug: false
  definitions: player
  script:
    - foreach gm|admin|moderator|helper|dev|cutie|builder|retired as:rank:
      - if <[player].in_group[<[rank]>]>:
        - define v <script[prefixes].parsed_key[data.<[rank]>]>
        - determine [<[v].get[name]>]

    - define ranks <list[]>
    - if <[player].in_group[svip]>:
      - define ranks:->:svip
    - else if <[player].in_group[vipplus]>:
      - define ranks:->:vipplus
    - else if <[player].in_group[vip]>:
      - define ranks:->:vip
    - if <[player].in_group[trusted]>:
      - define ranks:->:trusted

    - if <[ranks].is_empty>:
      - determine <empty>

    - foreach <[ranks]> as:rank:
      - define v <script[prefixes].parsed_key[data.<[rank]>]>
      - define prefixes:->:[<[v].get[name]>]
    - determine "<[prefixes].separated_by[ ]>"

chat_prefix:
  type: procedure
  debug: false
  definitions: player
  script:
    - foreach gm|admin|moderator as:rank:
      - if <[player].in_group[<[rank]>]>:
        - define v <script[prefixes].parsed_key[data.<[rank]>]>
        - determine "<&7>[<[v].get[color]><[v].get[token]><&7>] <[v].get[color]><[v].get[name]> <&7>[<[v].get[color]><[v].get[token]><&7>]<&r>"

    - foreach helper|dev|cutie|builder|retired as:rank:
      - if <[player].in_group[<[rank]>]>:
        - define v <script[prefixes].parsed_key[data.<[rank]>]>
        - if <[rank]> == helper && <[player].in_group[builder]>:
          - define v2 <script[prefixes].parsed_key[data.builder]>
          - determine "<&7>[<[v].get[color]><[v].get[name]><&7>] [<[v2].get[color]><[v2].get[name]><&7>]<&r>"
        - determine <&7>[<[v].get[color]><[v].get[name]><&7>]<&r>

    - define ranks <list>
    - if <[player].in_group[svip]>:
      - define ranks:->:svip
    - else if <[player].in_group[vipplus]>:
      - define ranks:->:vipplus
    - else if <[player].in_group[vip]>:
      - define ranks:->:vip
    - if <[player].in_group[trusted]>:
      - define ranks:->:trusted

    - if <[ranks].is_empty>:
      - determine <empty>

    - foreach <[ranks]> as:rank:
      - define v <script[prefixes].parsed_key[data.<[rank]>]>
      - define prefixes:->:<&7>[<[v].get[color]><[v].get[name]><&7>]<&r>
    - determine "<[prefixes].separated_by[ ]>"

global_chat_events:
  type: world
  debug: false
  events:
    after server start:
      - announce to_console "WE ARE NOW CONNECTING TO REDIS"
      - ~redis id:chat_rank connect:localhost
      - ~redis id:subscriber connect:localhost
      - ~redis id:publisher connect:localhost
      - redis id:subscriber subscribe:global_*
    on player chats:
      - if !<player.has_flag[chat_rank_d]>:
        - redis id:chat_rank "command:zincrby chat_leaderboard 1 <player.uuid>"
        - flag player chat_rank_d expire:15s
        - redis id:chat_rank "command:zscore chat_leaderboard <player.uuid>" save:xp
        - define xp <entry[xp].result>
        - define level <[xp].div[30].sqrt.round_up>
        - define xp_req <[level].power[2].mul[30]>
        - if <[xp]> >= <[xp_req]>:
          - if <[level]> >= 1:
            - run global_announce "def:<&b><&chr[25Cf]><&7> Congratulations <player.name>! Your chat level increased to <&a>level <[level]><&7>.<n><&7>To see your rank and where you stand, use <&b>/chatrank <&7>and <&b>/chattop<&7>."
      - determine passively cancelled
      - choose <player.flag[cur_chat]||default>:
        - case staff:
          - foreach <server.online_players> as:p:
            - if <[p].in_group[gm]> || <[p].in_group[admin]> || <[p].in_group[moderator]>:
              - define targets:->:<[p]>
          - definemap map:
              uuid: <player.uuid>
              name: <player.name>
              message: <context.message.utf8_encode>
          - narrate STAFF_MESSAGE=<[map]> targets:<[targets]>
          - redis id:publisher publish:global_staff_chat_<bungee.server> message:<[map]>
          - stop
        - case party:
          - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>].first>
          - define targets <server.flag[parties].get[<[party]>].get[members].keys.parse_tag[<player[<[parse_value]>]>]>
          - definemap map:
              uuid: <player.uuid>
              name: <player.name>
              message: <context.message.utf8_encode>
              party: <[party]>
              rank: <server.flag[parties].get[<[party]>].get[members].get[<player.uuid>].get[rank]>
          - narrate PARTY_MESSAGE=<[map]> targets:<[targets]>
          - redis id:publisher publish:global_party_chat_<bungee.server> message:<[map]>
          - stop
        - case default:
          - define targets <server.online_players>
          - definemap map:
              uuid: <player.uuid>
              name: <player.name>
              message: <context.message>
              prefix: <player.proc[chat_prefix]>
              prefix_simple: <player.proc[chat_prefix_simple]>
              suffix: <player.chat_suffix.trim.parse_color>
              display_name: <player.display_name>
              flair_style: <player.flag[flair_style].if_null[<&r>]>
              skin_blob: <player.skin_blob>
          - narrate PLAYER_MESSAGE=<[map]> targets:<[targets]>
          - redis id:publisher publish:global_chat_<bungee.server> message:<[map]>
      - if <bungee.server> == zc-main:
        - define msg <[map].get[message]>
        - if <[msg].strip_color.contains_text[@]>:
          - define num 0
          - define out <empty>
          - define server <discord[zc-info].group[ZeldaCraft]>
          - foreach "<[msg].split[ ]>":
            - if <[value].contains_all_text[@everyone]> || <[value].contains_all_text[@here]>:
              - define out "<[out]> <[value].replace[@]>"
              - foreach next
            - if <[value].contains_all_text[@mod]>:
              - define out "<[out]> <discord[zc-info].group[Zeldacraft].role[Mod].mention>"
              - define num:++
              - foreach next
            - if <[value].contains_all_text[@admin]>:
              - define out "<[out]> <discord[zc-info].group[Zeldacraft].role[Admin].mention>"
              - define num:++
              - foreach next
            - if <[value].contains_all_text[@helper]>:
              - define out "<[out]> <discord[zc-info].group[Zeldacraft].role[Helper].mention>"
              - define num:++
              - foreach next
            - if <[value].contains_all_text[@gm]>:
              - define out "<[out]> <discord[zc-info].group[Zeldacraft].role[Game Master].mention>"
              - define num:++
              - foreach next
            - if <[num]> < 3 && <[value].starts_with[@]> && <[value].length> >= 4 && !<[value].contains_text[/]>:
              - define i <server.flag[discord_user_names].find_partial[<[value].after[@]>]>
              - if <[i]> != -1:
                - define out "<[out]> <&lt>@<discord_user[<server.flag[discord_user_objs].get[<[i]>]>].id><&gt>"
                - define num:++
              - else:
                - define out "<[out]> <[value]>"
            - else:
              - define out "<[out]> <[value]>"
          - define msg <[out]>
        - define skin_data <player.skin_blob.proc[skin_id]>
        - define params ?uniq=<util.time_now.format[yyyy_MM_dd_HH]>
        - if <[skin_data].get[slim]> == slim:
          - define params <[params]>&slim
        - definemap data:
            username: <player.name>
            avatar_url: http://88.99.71.100:8080/portrait/<[skin_data].get[id]><[params]>
        - define data <[data].with[content].as[<[msg].strip_color.replace[*].with[\*].replace[_].with[\_].replace[~].with[\~].replace[`].with[\`]>]>
        - webget <secret[minecraft_chat_webhook]> headers:<map[Content-Type=application/json]> data:<[data].to_json>
    on redis pubsub message channel:global_reload_*:
      - wait 1s
      - if !<context.channel.ends_with[<bungee.server>]>:
        - reload
    on redis pubsub message channel:global_private_msg_*:
      - if <context.channel.ends_with[<bungee.server>]>:
        - define map <context.message.as[map]>
        - define target <server.match_player[<[map].get[to_player]>]||error>
        - narrate RECEIVE_PRIVATE_MESSAGE=<context.message> targets:<[target]>
        - announce to_console "(<[map].get[name]> -<&gt> <[map].get[to_player]>) <[map].get[message].utf8_decode>"
        - redis id:publisher publish:global_change_msg_<[target].uuid> message:<[map].get[name]>
    on redis pubsub message channel:global_private_console:
      - define map <context.message.as[map]>
      - announce "(<[map].get[name]> -<&gt> Me) <[map].get[message].utf8_decode>" to_console
      - flag server replying_to:<[map].get[name]>
    on redis pubsub message channel:global_change_msg_*:
      - define uuid <context.channel.after[change_msg_]>
      - if <[uuid]> == console:
        - flag server replying_to:<context.message> expire:2h
        - stop
      - if <player[<[uuid]>].first_played_time||error> == error:
        - stop
      - flag <player[<[uuid]>]> replying_to:<context.message> expire:2h
    on redis pubsub message channel:global_change_chat_*:
      - define uuid <context.channel.after[change_chat_]>
      - if <player[<[uuid]>].first_played_time||error> == error:
        - stop
      - flag <player[<[uuid]>]> cur_chat:<context.message>
    on redis pubsub message channel:global_party_chat_*:
      - if !<context.channel.ends_with[<bungee.server>]>:
        - define map <context.message.as[map]>
        - define targets <server.flag[parties].get[<[map].get[party]>].get[members].keys.parse_tag[<player[<[parse_value]>]>]>
        - narrate PARTY_MESSAGE=<context.message.utf8_encode> targets:<[targets]>
        - announce to_console "(Server<&co> <context.channel.after[party_chat_]> - <[map].get[party]>) <&lt><[map].get[name]><&gt> <[map].get[message]>"
    on redis pubsub message channel:global_staff_chat_*:
      - if !<context.channel.ends_with[<bungee.server>]>:
        - define map <context.message.as[map]>
        - foreach <server.online_players> as:p:
          - if <[p].in_group[gm]> || <[p].in_group[admin]> || <[p].in_group[moderator]>:
            - define targets:->:<[p]>
        - narrate STAFF_MESSAGE=<context.message.utf8_encode> targets:<[targets]>
        - announce to_console "(Server<&co> <context.channel.after[staff_chat_]> - Staff) <&lt><[map].get[name]><&gt> <[map].get[message].utf8_decode>"
    on redis pubsub message channel:global_chat_*:
      - if !<context.channel.ends_with[<bungee.server>]>:
        - narrate PLAYER_MESSAGE=<context.message> targets:<server.online_players>
        - define map <context.message.as[map]>
        - announce to_console "(Server<&co> <context.channel.after[global_chat_]>) <&lt><[map].get[name]><&gt> <[map].get[message]>"
    on redis pubsub message channel:global_announce_*:
      - if !<context.channel.ends_with[<bungee.server>]>:
        - announce <context.message>
    on player receives message:
      - define message <context.message>
      - define special_messages:|:PLAYER_MESSAGE|PARTY_MESSAGE|STAFF_MESSAGE|RECEIVE_PRIVATE_MESSAGE|SEND_PRIVATE_MESSAGE
      - if <[special_messages].filter_tag[<[message].strip_color.starts_with[<[filter_value]>]>].is_empty>:
        - stop
      - define map <[message].after[=].as[map]>
      - if <[message].starts_with[PLAYER_MESSAGE]>:
        - define prefix <[map].get[prefix]>
        - if <[prefix].length> > 0:
          - define prefix "<[prefix]> "
        - define suffix <[map].get[suffix]>
        - if <[suffix].length> > 0:
          - define suffix "<[suffix]> "
        - define name <[map].get[display_name]>
        - determine "message:<[prefix]><[name]> <[map].get[flair_style]><[suffix]><&7><&chr[BB]> <&f><[map].get[message]>"
      - if <[message].starts_with[PARTY_MESSAGE]>:
        - choose <[map].get[rank]>:
          - case Admin:
            - define c <&e>
          - case Leader:
            - define c <&l><&c>
          - case Mod:
            - define c <&a>
          - default:
            - define c <&7>
        - determine "message:<&b><&lb>Party<&rb> <[c]><[map].get[rank]> <&7><[map].get[name]><&co> <[map].get[message].utf8_decode>"
      - if <[message].starts_with[STAFF_MESSAGE]>:
        - determine "message:<&a><&lb>Staff<&rb> <&7><[map].get[name]><&co> <[map].get[message].utf8_decode>"
      - if <[message].starts_with[RECEIVE_PRIVATE_MESSAGE]>:
        - determine "message:<&6><&lb><&c><[map].get[name]> <&6><&chr[BB]> <&c>me<&6><&rb><&f> <&f><[map].get[message].utf8_decode>"
      - if <[message].starts_with[SEND_PRIVATE_MESSAGE]>:
        - determine "message:<&6><&lb><&c>me <&6><&chr[BB]> <&c><[map].get[to_player]><&6><&rb><&f> <[map].get[message].utf8_decode>"

#---------------------------------#
# Chat rank commands + leaderboard
#---------------------------------#
g_chat_ranking_c:
  type: command
  debug: false
  usage: /chatrank (player name)
  description: shows you current chat rank
  name: chatrank
  script:
    - if !<context.args.first.is_truthy> || <server.match_offline_player[<context.args.first>]||error> == error:
      - define p <player>
    - else:
      - define p <server.match_offline_player[<context.args.first>]>
    - redis id:chat_rank "command:zscore chat_leaderboard <[p].uuid>" save:xp
    - define xp <entry[xp].result||0>
    - define level <element[<[xp]>].div[30].sqrt.round_down||0>
    - define xp_req <element[30].mul[<element[<[level].add[1]>].power[2]>]>
    - define lvl_xp <element[30].mul[<element[<[level]>].power[2]>]>
    - define cur <[xp].sub[<[lvl_xp]>]>
    - define max <[xp_req].sub[<[lvl_xp]>]>
    - define percent <[cur].div[<[max]>].mul[100].round_down>
    - define bar <&a><element[|].repeat[50].split[].insert[<&7>].at[<[percent].div[2].round_up>].unseparated>
    #- define bar <&a><element[].pad_right[<[percent].div[2].round_down>].with[|]><&f><element[].pad_right[<element[100].sub[<[percent]>].div[2].round_down>].with[|]>
    - narrate "<&a><&l><[p].name>'s chat rank:"
    #- narrate <&3>~~~~~~~~~~~~~~~~~~~~~~~
    - narrate "<&7>[<&a>Level <[level]><&7>] <[bar]> <&7>(<&a><[cur]>/<[max]> xp<&7>) <&7>(<&a><[percent]><&pc> to level <[level].add[1]><&7>)"
    #- narrate <&3>~~~~~~~~~~~~~~~~~~~~~~~

g_chat_top_ranks_c:
  type: command
  debug: false
  usage: /chattop (number)
  description: Lists the top chat players
  name: chattop
  script:
    - if <context.args.get[1].is_decimal||false>:
      - define page <context.args.get[1]||1>
    - else:
      - define page 1
    - redis id:chat_rank "command:zcount chat_leaderboard -inf +inf" save:count
    - define max <entry[count].result.div[10].round_up>
    - if <[page]> < 1:
      - narrate "<&c>The page number cannot go lower than 1" format:zc_text
      - stop
    - if <[page]> > <[max]>:
      - narrate "<&c>The page number cannot be higher than <[max]>" format:zc_text
      - stop
    - define start <[page].sub[1].mul[10].add[1]>
    - if <[start]> == 0:
      - define start 1
    - define end <[page].mul[10]>
    - define top_chat <list>
    - redis id:chat_rank "command:zrevrange chat_leaderboard <[start].sub[1]> <[end].sub[1]> withscores" save:res
    - define players <map>
    - foreach <entry[res].result.sub_lists[2]>:
      - define players <[players].with[<[value].first>].as[<[value].get[2]>]>
    - foreach <[players].keys> as:uuid:
      - define p <player[<[uuid]>]>
      - define xp <[players].get[<[uuid]>]>
      - define level <element[<[xp]>].div[30].sqrt.round_down||0>
      - define xp_req <element[30].mul[<element[<[level].add[1]>].power[2]>]>
      - define lvl_xp <element[30].mul[<element[<[level]>].power[2]>]>
      - define cur <[xp].sub[<[lvl_xp]>]>
      - define max2 <[xp_req].sub[<[lvl_xp]>]>
      - define percent <[cur].div[<[max2]>].mul[100].round_down>
      - define bar <&a><element[<&chr[2503]>].repeat[50].split[].insert[<&7>].at[<[percent].div[2].round_up>].unseparated>
      #- define bar <&a><element[].pad_right[<[percent].div[2].round>].with[<&chr[2503]>]><&f><element[].pad_right[<element[100].sub[<[percent]>].div[2].round>].with[<&chr[2503]>]>
      - if <[p]> == <player>:
        - define top_chat "<[top_chat].include[#<[start].sub[1].add[<[loop_index]>]>: (<&2><[level]><&f>) <&hover[<[percent]><&pc>]><[bar]><&end_hover> (<&2><[level].add[1]><&f>) - <&5><&l><[p].name><&f>]>"
      - else:
        - define top_chat "<[top_chat].include[#<[start].sub[1].add[<[loop_index]>]>: (<&2><[level]><&f>) <&hover[<[percent]><&pc>]><[bar]><&end_hover> (<&2><[level].add[1]><&f>) - <[p].name>]>"
    - if <[top_chat].is_empty>:
      - define top_chat "<list[No one talked at all, or something went wrong]>"
    - define left_ar "<&hover[Click here to go a page backwards]><&click[/chattop <[page].sub[1]>]><&color[#04BA04]><&chr[25C0]><&end_click><&end_hover>"
    - define right_ar "<&hover[Click here to go a page forward]><&click[/chattop <[page].add[1]>]><&color[#04BA04]><&chr[25B6]><&end_click><&end_hover>"
    - narrate "<&a><&l>Zelda<&2><&l>Craft Top Chatters<&nl>"
    - narrate <[top_chat].separated_by[<&nl>]>
    - if <[page]> == 1 && <[page]> == <[max]>:
      - narrate "<&nl><&color[#04BA04]><&chr[25C1]> <&r>Page <[page]>/<[max]> <&color[#04BA04]><&chr[25B7]><&nl>"
      - stop
    - if <[page]> == 1:
      - narrate "<&nl><&color[#04BA04]><&chr[25C1]> <&r>Page <[page]>/<[max]> <[right_ar]><&nl>"
      - stop
    - if <[page]> == <[max]>:
      - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max]> <&color[#04BA04]><&chr[25B7]><&nl>"
      - stop
    - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max]> <[right_ar]><&nl>"
