streamers:
  type: data
  list:
    eyelesstenshi:
      name: Tenshi
      link: https://www.twitch.tv/eyelesstenshi
    sentisurgelius:
      name: SentisUrgelius
      link: https://www.twitch.tv/SentisUrgelius
    kutekiera:
      name: KuteKiera
      link: https://www.twitch.tv/kutekiera
    #scooteraround:
    #  name: ScooterAround
    #  link: https://www.twitch.tv/scooteraround
    sugarren:
      name: SugarRen
      link: https://www.twitch.tv/sugarren
    rex_rexington:
      name: Rex_Rexington
      link: https://www.twitch.tv/rex_rexington
    draconis:
      name: Draconis
      link: https://www.twitch.tv/draconistekton
    #mario:
    #  name: MarioVSLuigi360
    #  link: https://www.twitch.tv/mariovsluigi360
    kieran:
      name: KieranValor
      link: https://www.twitch.tv/kieranvalor
    runicchaos:
      name: RunicChaos
      link: https://www.twitch.tv/runicchaos

twitch_command:
  type: command
  description: Handles showing the twitch bossbar
  usage: /twitch [start/end] [name]
  name: twitch
  tab completions:
    1: start|end
    2: <script[streamers].list_keys[list]>
  script:
    - if !<context.args.get[2].exists>:
      - narrate "<&color[#9146ff]><&l>[Twitch] Thank you for supporting our content creators!"
      - foreach <script[streamers].data_key[list]>:
        - if <server.flag[twitch].contains[<[key]>]>:
          - narrate "<&c><&l>(Live) <&color[#d199ff]><&l><[value].get[name]>: <&7><&hover[Click to watch!]><&click[<[value].get[link].parsed>].type[open_url]><[value].get[link].parsed><&end_click><&end_hover>"
      - foreach <script[streamers].data_key[list]>:
        - if !<server.flag[twitch].contains[<[key]>]>:
          - narrate "<&7><[value].get[name]>: <&hover[Click to watch!]><&click[<[value].get[link].parsed>].type[open_url]><[value].get[link].parsed><&end_click><&end_hover>"
    - if !<player.in_group[twitch]> && !<player.has_permission[asdf]>:
      - stop
    - narrate "<&7>Use <&color[#9146ff]>/twitch start/end<&7> to display the top banner!"
    - if <context.args.get[1]||null> == start:
      - if <context.args.get[2]||null> == null || <context.args.get[2]> not in <script[streamers].data_key[list].keys>:
        - narrate "<&7>Usage: /twitch start <script[streamers].data_key[list].keys.separated_by[/]>"
        - stop
      - define name <context.args.get[2].to_lowercase>
      - if <server.flag[twitch].contains[<[name]>]>:
        - narrate "<&c>You're already streaming!"
        - stop
      - if <server.flag[twitch].is_empty||true>:
        - bossbar create id:twitch "title:<&color[#9146ff]><&l><script[streamers].data_key[list.<[name]>.name]> is now live on Twitch! Use <&f>/twitch<&color[#9146ff]><&l> to watch!" players:<server.online_players>
      - flag server twitch:->:<[name]>
    - else if <context.args.get[1]||null> == end:
      - if <context.args.get[2]||null> == null || <context.args.get[2]> not in <script[streamers].data_key[list].keys>:
        - narrate "<&7>Usage: /twitch end <script[streamers].data_key[list].keys.separated_by[/]>"
        - stop
      - define name <context.args.get[2].to_lowercase>
      - flag server twitch:<-:<[name]>
      - if <server.flag[twitch].is_empty||true>:
        - bossbar remove id:twitch

#twitch_events:
#  type: world
#  debug: false
#  events:
#    after player joins:
#      - foreach <server.flag[twitch].if_null[<list>]>:
#        - bossbar update id:twitch "title:<&color[#9146ff]><&l><script[streamers].data_key[list.<[value]>.name]> is now live on Twitch! Use <&f>/twitch<&color[#9146ff]><&l> to watch!" players:<player>

autobanner_events:
  type: world
  debug: false
  events:
    on delta time secondly every:5:
      - if <server.flag[twitch].is_empty||true>:
        - stop
      - flag server twitch_step:<server.flag[twitch_step].add[1].mod[<server.flag[twitch].size>].if_null[0]>
      - define c <&color[#9146ff]>
      #- define new_c <&color[<[c].with_brightness[<[c].brightness.sub[<server.flag[twitch_step].mul[50]>]>]>]>
      #- foreach <server.flag[twitch]>:
      - define value <server.flag[twitch].get[<server.flag[twitch_step].add[1]>]>
      - if !<server.current_bossbars.contains[twitch]>:
        - bossbar create id:twitch players:<server.online_players>
      - bossbar update id:twitch "title:<[c]><&l><script[streamers].data_key[list.<[value]>.name]> is now live on Twitch! Use <&f>/twitch<[c]><&l> to watch!" players:<server.online_players.filter[location.is_in[christmas*].not]>
    on delta time minutely every:5:
      - if <server.flag[ad]||1> == 1:
        - bossbar create id:buy color:green "title:<&7>Enjoying the server? Use <&a>/buy<&7> to donate for a rank!" players:<server.online_players.filter_tag[<[filter_value].groups.contains[svip].not||false>]>
        - repeat 100:
          - wait 2t
          - bossbar update id:buy progress:<element[1].sub[<[value].div[100]>]>
        - bossbar remove id:buy
        - flag server ad:++
      #- else if <server.flag[ad]||1> == 2:
      #  - define c <&color[#fdcede]>
      #  - bossbar create id:easter color:white "title:<[c]><&l>The Easter event is live! Talk to Ravioli at <&color[#fffcb8]>/spawn <[c]><&l>to play!" players:<server.online_players>
      #  - wait 1s
      #  - repeat 3:
      #    - define c <&color[#9ef8df]>
      #    - bossbar update id:easter "title:<[c]><&l>The Easter event is live! Talk to Ravioli at <&color[#fffcb8]>/spawn <[c]><&l>to play!"
      #    - wait 2s
      #    - define c <&color[#fdcede]>
      #    - bossbar update id:easter "title:<[c]><&l>The Easter event is live! Talk to Ravioli at <&color[#fffcb8]>/spawn <[c]><&l>to play!"
      #    - wait 2s
      #  - bossbar remove id:easter
      #  - flag server ad:++
      - if <server.flag[ad]> > 2:
        - flag server ad:1
