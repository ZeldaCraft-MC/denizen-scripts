track_total_players:
  type: world
  debug: false
  events:
    on delta time secondly:
      - define data <list>
      - foreach <server.online_players>:
        - definemap map:
            uuid: <[value].uuid>
            name: <[value].name>
            skin_blob: <[value].skin_blob>
            groups: <[value].groups>
            player_list_name: <[value].proc[player_list_name].escaped>
            server: <bungee.server>
        - define data:->:<[map]>
      - redis id:publisher "command:setex online_players_<bungee.server> 60 '<[data]>'"
      - wait 1t
      - redis id:publisher "command:keys online_players_*" save:keys
      - if !<entry[keys].result.is_truthy>:
        - flag server global_player_data:<list>
        - stop
      - redis id:publisher "command:mget <entry[keys].result.space_separated>" save:lists
      - flag server global_player_data:<entry[lists].result.combine.if_null[<list>]>

tablist_config:
  type: data
  debug: false
  newbie:
    - " <&7>Hi <&a><player.name><&7>! Thanks for joining! "
    - <&a>/warp s1<&7> to play survival
    - " <&a>/warp dungeons<&7> for dungeons "
    - <empty>
  other:
    - " <&7>Hi <&a><player.name><&7>! Welcome back!"
  header:
    - <empty>
    - <element[ZeldaCraft].proc[gradient].context[#00ff00|#0000ff|<&l>]>
    - <&7>[<[total_players]> Online]
    - <empty>
    - <player.groups.size.equals[1].if_true[<script[tablist_config].parsed_key[newbie].separated_by[<n>]>].if_false[<script[tablist_config].parsed_key[other].separated_by[<n>]>]>
    - " <player.formatted_money.proc[gradient].context[#ffaa00|#ffff55]><&7> / <element[<player.statistic[play_one_minute].div[20].div[3600].round_down>h played].proc[gradient].context[#ffff55|#ffaa00]> "
    - <empty>
  footer:
    - <&sp>

player_list_name:
  type: procedure
  debug: false
  definitions: player
  script:
    - if <[player].in_group[gm]>:
      - define c <script[prefixes].parsed_key[data.gm.color]>
      - determine "<&7> [<[c]>GM<&7>] <&r><[player].name>"
    - foreach admin|moderator|helper|dev|builder|svip as:rank:
      - if <[player].in_group[<[rank]>]>:
        - define d <script[prefixes].parsed_key[data.<[rank]>]>
        - determine "<&7> [<[d].get[color]><[d].get[name]><&7>] <&r><[player].name>"
    - determine "<&r> <[player].name>"

player_list_name_2:
  type: procedure
  debug: false
  definitions: player
  script:
    - if <[player].in_group[gm]>:
      - define c <script[prefixes].parsed_key[data.gm.color]>
      - define list_name "<&7> [<[c]>GM<&7>] <&r><[player].name>"
    - else:
      - define list_name "<&r> <[player].name>"
      - foreach admin|moderator|helper|dev|builder|svip as:rank:
        - if <[player].in_group[<[rank]>]>:
          - define d <script[prefixes].parsed_key[data.<[rank]>]>
          - define list_name "<&7> [<[d].get[color]><[d].get[name]><&7>] <&r><[player].name>"
          - foreach stop
    - if <player.has_flag[pronouns]>:
      - define list_name "<[list_name]><&7><player.flag[pronouns].font[superscript]>"
    - determine <[list_name]>

set_team_nameplates:
  type: task
  debug: false
  script:
    - if !<player.is_online>:
      - stop
    - adjust <player> player_list_name:<player.proc[player_list_name]>
    - foreach <server.flag[global_player_data]> as:player:
      - foreach gm|admin|moderator|helper|dev|builder|svip|default as:rank:
        - if <[player].get[groups].contains[<[rank]>]>:
          - team name:<[loop_index]><[rank]> remove:<[player].get[name]>
          - team name:<[loop_index]><[rank]> add:<[player].get[name]>
          - foreach stop

team_nameplates:
  type: world
  debug: false
  events:
    after player joins:
      - run set_team_nameplates
      #- foreach gm|admin|moderator as:rank:
        #- define v <script[prefixes].parsed_key[data.<[rank]>]>
        #- team name:<[loop_index]><[rank]> "prefix:<&7>[<[v].get[color]><[v].get[token]><&7>] "
        #- team name:<[loop_index]><[rank]> "suffix:<&7> [<[v].get[color]><[v].get[token]><&7>]"

tablist_handler:
  type: world
  debug: false
  events:
    after player joins:
      - stop if:<player.is_online.not>
      - foreach <server.flag[global_player_data]>:
        - old_tablist id:<[value].get[uuid]> name:<[value].get[name]> display_name:<[value].get[player_list_name].unescaped> skin_blob:<[value].get[skin_blob]>
    on tablist modified:
      - if <context.action> != remove_player:
        - stop
      - if <context.player_data.get[1].get[name]> == +REMOVEME:
        - stop
      - if <context.player_data.get[1].get[uuid].char_at[15]||null> == 4 || <context.player_data.get[1].get[uuid].starts_with[0000]>:
        - determine passively cancelled
    on delta time secondly every:2:
      - define curr_uuids <server.flag[global_player_data].parse[get[uuid]]>
      - define prev_uuids <server.flag[prev_global_player_data].parse[get[uuid]]>
      - flag server prev_global_player_data:<server.flag[global_player_data].if_null[<list>]>
      - define to_rem <[prev_uuids].exclude[<[curr_uuids]>].if_null[<list>]>
      - define to_add <list>
      - foreach <server.flag[global_player_data]>:
        - if <[value].get[uuid]> not in <[prev_uuids]>:
          - define to_add:->:<[value]>
      - foreach <[to_rem]>:
        - if <[value].as_player.is_online||false>:
          - foreach next
        - foreach <server.online_players> as:__player:
          - old_tablist action:remove_player id:<[value]> name:+REMOVEME
      - wait 5t
      - foreach <[to_add]>:
        - foreach <server.online_players> as:__player:
          - old_tablist id:<[value].get[uuid]> name:<[value].get[name]> display_name:<[value].get[player_list_name].unescaped> skin_blob:<[value].get[skin_blob]>
        - foreach gm|admin|moderator|helper|dev|builder|svip|default as:rank:
          - if <[value].get[groups].contains[<[rank]>]>:
            - team name:<[loop_index]><[rank]> remove:<[value].get[name]>
            - team name:<[loop_index]><[rank]> add:<[value].get[name]>
            - foreach stop
    on delta time secondly every:5:
    - if <server.online_players.is_empty>:
      - stop
    - define total_players <server.flag[global_player_data].size.if_null[?]>
    - foreach <server.online_players> as:__player:
      - define header <script[tablist_config].parsed_key[header].separated_by[<n>]>
      - define footer <script[tablist_config].parsed_key[footer].separated_by[<n>]>
      - adjust <player> tab_list_info:<[header]>|<[footer]>
