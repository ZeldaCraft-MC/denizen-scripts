dungeon_command:
  type: command
  name: setup_dungeon
  description: gives you the blocks to setup a dungeon
  usage: /setup_dungeon
  debug: false
  permission: zc.admin
  tab completions:
    1: <yaml[zcrpg_config].read[dungeons].keys>
  script:
    - if <player.we_selection||none> == none:
      - narrate "You need to select the area of the dungeon"
      - stop
    - define a <context.args.first||empty_arg>
    - if <[a]> == empty_arg:
      - narrate "You need to put in a valid dungeon name"
      - stop
    - if !<yaml[zcrpg_config].contains[dungeons.<[a]>]>:
      - narrate "You need to put in a valid dungeon name"
      - narrate "Are you sure <[a]> is a valid dungeon?"
      - stop
    - note <player.we_selection> as:<[a]>_dungeon
    - give finish_block[flag=dungeon:<[a]>]
    - give timer_block[flag=dungeon:<[a]>]
    - give scoreboard_block[flag=dungeon:<[a]>]

dungeon_block_events:
  type: world
  debug: false
  events:
    on player places finish_block:
    - flag <context.location> finish_block:<context.item_in_hand.flag[dungeon]>
    on player places timer_block:
    - flag <context.location> timer_block:<context.item_in_hand.flag[dungeon]>
    on player places scoreboard_block:
    - flag <context.location> scoreboard_block:<context.item_in_hand.flag[dungeon]>
    on player breaks emerald_block location_flagged:finish_block:
    - flag <context.location> finish_block:!
    on player breaks gold_block location_flagged:timer_block:
    - flag <context.location> timer_block:!
    on player breaks diamond_block location_flagged:scoreboard_block:
    - flag <context.location> scoreboard_block:!
    on delta time secondly:
    - define players <server.online_players>
    - if <[players].is_empty>:
      - stop
    - define valid_fi_locs <[players].filter[location.find_blocks_flagged[finish_block].within[8].is_empty.not]>
    - define valid_ti_locs <[players].filter[location.find_blocks_flagged[timer_block].within[8].is_empty.not]>
    - define valid_sc_locs <[players].filter[location.find_blocks_flagged[scoreboard_block].within[8].is_empty.not]>
    - if <[valid_fi_locs].is_empty> && <[valid_ti_locs].is_empty> && <[valid_sc_locs].is_empty>:
      - stop
    - foreach <[valid_ti_locs]> as:player:
      - define locs <[player].location.find_blocks_flagged[timer_block].within[8]>
      - foreach <[locs]> as:loc:
        - define dungeon <[loc].flag[timer_block]||error>
        - fakespawn timer_block_holo1 <[loc].above[0.3]> players:<[player]> d:20t
        - fakespawn "timer_block_holo2[custom_name=<&e><&l>Your previous time was <[player].flag[times.<[dungeon]>.best]||00:00:000>!]" <[loc]> players:<[player]> d:20t
        - playeffect effect:villager_happy at:<[loc].above[1.8]> quantity:3 offset:0.6,0.6,0.6 targets:<[player]>
    - foreach <[valid_fi_locs]> as:player:
      - define locs <[player].location.find_blocks_flagged[finish_block].within[8]>
      - foreach <[locs]> as:loc:
        - define dungeon <[loc].flag[finish_block]||error>
        - fakespawn "finish_block_holo1[custom_name=<&a><&l>You finished <&e><&l><[dungeon]><&a><&l>]" <[loc].above[0.3]> players:<[player]> d:20t
        - fakespawn finish_block_holo2 <[loc]> players:<[player]> d:20t
        - playeffect effect:villager_happy at:<[loc].above[1.8]> quantity:3 offset:0.6,0.6,0.6 targets:<[player]>
    - foreach <[valid_sc_locs]> as:player:
      - define locs <[player].location.find_blocks_flagged[scoreboard_block].within[8]>
      - foreach <[locs]> as:loc:
        - define dungeon <[loc].flag[scoreboard_block]||error>
        - define top_10 <list[]>
        - if <server.flag[times.<[dungeon]>].keys||error> == error:
          - goto smartskip
        - foreach <server.flag[times.<[dungeon]>].keys> as:f_player:
          - if <[f_player]> == <[player]>:
            - define top_10 <[top_10].include[<&a><[f_player].flag[times.<[dungeon]>.best]><&sp><&7>-<&sp><&5><&l><[f_player].name>]>
          - else:
            - define top_10 <[top_10].include[<&a><[f_player].flag[times.<[dungeon]>.best]||00:00:000><&sp><&7>-<&sp><[f_player].name>]>
        - mark smartskip
        - if <[top_10].size> < 10:
          - repeat 10:
            - define top_10 <[top_10].include[<&c>22:59:59:999<&sp><&7>-<&sp>No<&sp>one]>
        - define loc <[loc].add[0,0.5,0]>
        - foreach <[top_10]> as:t:
          - if "<[t].strip_color.before[ ].split[].size>" > 9:
            - define <[player]>_3rd:->:<[t].strip_color.before[<&sp>]>-<[loop_index]>
          - else:
            - if "<[t].strip_color.before[ ].starts_with[00:]>":
              - define <[player]>_1st:->:<[t].strip_color.before[<&sp>]>-<[loop_index]>
            - else:
              - define <[player]>_2nd:->:<[t].strip_color.before[<&sp>]>-<[loop_index]>
          - if <[<[player]>_3rd].size||0> > 1:
            - define <[player]>_3rd <[<[player]>_3rd].alphabetical>
          - if <[<[player]>_2nd].size||0> > 1:
            - define <[player]>_2nd <[<[player]>_2nd].alphabetical>
          - if <[<[player]>_1st].size||0> > 1:
            - define <[player]>_1st <[<[player]>_1st].alphabetical>
        - define toppers <list.include[<[<[player]>_1st]||<empty>>].include[<[<[player]>_2nd]||<empty>>].include[<[<[player]>_3rd]||<empty>>]>
        - define toppers <[toppers].parse[after_last[-]]>
        - foreach <[toppers]> as:top:
          - choose <[loop_index]>:
            - case 1:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[3.0]> players:<[player]> duration:20t
            - case 2:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[2.7]> players:<[player]> duration:20t
            - case 3:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[2.4]> players:<[player]> duration:20t
            - case 4:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[2.1]> players:<[player]> duration:20t
            - case 5:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[1.8]> players:<[player]> duration:20t
            - case 6:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[1.5]> players:<[player]> duration:20t
            - case 7:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[1.2]> players:<[player]> duration:20t
            - case 8:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[0.9]> players:<[player]> duration:20t
            - case 9:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[0.6]> players:<[player]> duration:20t
            - case 10:
              - fakespawn scoreboard_block_holo[custom_name=<[top_10].get[<[top]>]>] <[loc].above[0.3]> players:<[player]> duration:20t
            - default:
              - foreach stop

    on delta time secondly every:2:
    - if !<server.has_flag[timer]>:
      - stop
    - repeat 40:
      - foreach <server.flag[timer]> as:map:
        - define dungeon <[map].values.first>
        - define player <[map].keys.first>
        - if <[player].location.world.name> != dungeons || <[player].location.in_region[dungeon_spawn]> || !<[player].is_online>:
          - flag <[player]> times.<[dungeon]>.start:!
        - if !<[player].location.cuboids.parse[note_name].filter_tag[<[filter_value].advanced_matches[*_dungeon]>].parse[before[_dungeon]].contains[<[dungeon]>]||false>:
          - flag <[player]> times.<[dungeon]>.start:!
        - if !<[player].has_flag[times.<[dungeon]>.start]>:
          - flag server timer:<-:<[map]>
          - stop
        - define time <time[2001/08/23_00:00:00:0000].add[<[player].flag[times.<[dungeon]>.start].from_now>]>
        - if <[time].hour||0> >= 23:
          - flag server timer:<-:<[map]>
          - stop
        - if <[time].hour||0> <= 0:
          - define time <[time].format[mm:ss:SSS]>
        - else:
          - define time <[time].format[HH:mm:ss:SSS]>
        - actionbar "Current time: <&a><[time]>" targets:<[player]>
      - wait 1t

    on player steps on gold_block location_flagged:timer_block:
    - define dungeon <context.location.flag[timer_block]>
    - yaml set checkpoint_x:0 id:<player.uuid>
    - yaml set checkpoint_y:0 id:<player.uuid>
    - yaml set checkpoint_z:0 id:<player.uuid>
    - yaml set checkpoint_world:dungeons id:<player.uuid>
    - if <player.has_flag[times.<[dungeon]>.start]>:
      - narrate "<&7>Your timer for <&b><[dungeon]><&7> has been reset to <&a>00:00:000<&nl>"
      - narrate "<&7>Time to beat: <&a><player.flag[times.<[dungeon]>.best]||00:00:000><&nl>"
    - else:
      - narrate "<&7>Your timer for <&b><[dungeon]><&7> has started<&nl>"
      - narrate "<&7>Time to beat: <&a><player.flag[times.<[dungeon]>.best]||00:00:000><&nl>"
    - flag player times.<[dungeon]>.start:<util.time_now>
    - flag server timer:->:<map[].with[<player>].as[<[dungeon]>]>

    on player steps on emerald_block location_flagged:finish_block:
    - define dungeon <context.location.flag[finish_block]>
    - if <player.has_flag[times.<[dungeon]>.start]>:
      - define finish_time <time[2001/08/23_00:00:00:0000].add[<player.flag[times.<[dungeon]>.start].from_now>]>
      - if <[finish_time].hour||0> <= 0:
        - define finish_time <[finish_time].format[mm:ss:SSS]>
      - else:
        - define finish_time <[finish_time].format[HH:mm:ss:SSS]>
      - if <player.has_flag[times.<[dungeon]>.best]>:
        - define best_time <player.flag[times.<[dungeon]>.best]>
        - if <[finish_time].replace[:]> > <[best_time].replace[:]>:
          - narrate "<&a>Time recorded"
          - narrate "<&7>This was <&c>not<&7> your best time<&nl>"
          - narrate "<&7>Current time: <&a><[finish_time]>"
          - narrate "<&7>Best time: <&a><[best_time]><&nl>"
          - flag player times.<[dungeon]>.start:!
          - flag server timer:<-:<map[].with[<player>].as[<[dungeon]>]>
          - ~discordmessage id:zc-info channel:859064112198058036 "<discord_embed.with[author_name].as[<player.name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[title].as[<[finish_time]>].with[description].as[time recorded on <[dungeon]>].with[color].as[red].with[timestamp].as[<util.time_now>]>"
          - stop
      - narrate "<&a><&l>New Record!<&nl>"
      - narrate "<&7>Your new record is: <&a><[finish_time]>"
      - if <player.has_flag[time.<[dungeon]>.best]>:
        - narrate "<&7>Your old record was: <&a><[best_time]>"
      - narrate " "
      - flag player times.<[dungeon]>.best:<[finish_time]>
      - flag server times.<[dungeon]>.<player>:<[finish_time].replace[:].with[,]>
      - flag player times.<[dungeon]>.start:!
      - flag server timer:<-:<map[].with[<player>].as[<[dungeon]>]>
      - ~discordmessage id:zc-info channel:859064112198058036 "<discord_embed.with[author_name].as[<player.name>].with[author_icon_url].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[title].as[<[finish_time]>].with[description].as[New record on <[dungeon]>].with[color].as[lime].with[timestamp].as[<util.time_now>]>"
    - teleport <player> <essentials.warp[dungeons]>
    #- yaml set 'statsd.player~event~zcrpg~dungeons~<[dungeon].to_lowercase>~completed:++' id:stats_log
    - if !<yaml[<player.uuid>].read[completed_dungeons].contains[<[dungeon]>]>:
      - title "title:<green>Dungeon Complete!" "subtitle:<yellow>You earned 1 Dungeon Point" stay:1s fade_out:2s
      - yaml set completed_dungeons:->:<[dungeon]> id:<player.uuid>
    - else:
      - title "title:<green>Dungeon Complete!" stay:1s fade_out:2s
    - playeffect at:<player.location> effect:end_rod quantity:50 offset:0.5,1,0.5 data:0.25
    - playeffect at:<player.location> effect:fireworks_spark quantity:20 offset:0.5,1,0.5 data:0.25
    - playsound <player> sound:ENTITY_PLAYER_LEVELUP pitch:1.5 volume:100
    - playsound <player> sound:ENTITY_PLAYER_LEVELUP pitch:1.1 volume:60
    - playsound <player> sound:ENTITY_PLAYER_LEVELUP pitch:0.3 volume:80
    - stop

timer_block:
  type: item
  material: gold_block
  debug: false
  display name: <&e><&l>Timer Block
  lore:
    - <&7>Place to mark a timer location!
    - <&7>Marking timer for <&b><[a]>

timer_block_holo1:
  type: entity
  entity_type: armor_stand
  debug: false
  mechanisms:
    visible: false
    custom_name: <&a><&l>Step here to start the timer!
    custom_name_visible: true

timer_block_holo2:
  type: entity
  entity_type: armor_stand
  debug: false
  mechanisms:
    visible: false
    custom_name: <&e><&l>Your previous time was 00:00:000!
    custom_name_visible: true

finish_block:
  type: item
  material: emerald_block
  debug: false
  display name: <&a><&l>Finish Block
  lore:
    - <&7>Place to mark a finish location!
    - <&7>Marking finish for <&b><[a]>

finish_block_holo1:
  type: entity
  entity_type: armor_stand
  debug: false
  mechanisms:
    visible: false
    custom_name: <&a><&l>You finished <&e><&l>dungeon name<&a><&l>!
    custom_name_visible: true

finish_block_holo2:
  type: entity
  entity_type: armor_stand
  debug: false
  mechanisms:
    visible: false
    custom_name: <&e><&l>Stand here to earn <&c><&l>1<&e><&l> Dungeon Point!
    custom_name_visible: true

scoreboard_block:
  type: item
  material: diamond_block
  debug: false
  display name: <&3><&l>Scoreboard Block
  lore:
    - <&7>Place to mark a scoreboard location!
    - <&7>Marking scoreboard for <&b><[a]>

scoreboard_block_holo:
  type: entity
  entity_type: armor_stand
  debug: false
  mechanisms:
    visible: false
    custom_name: <&3><&l>1.
    custom_name_visible: true
    marker: true

get_best_times:
  type: task
  debug: false
  script:
    - if !<server.has_flag[times]>:
      - stop
    - define pages <list[]>
    - foreach <server.flag[times].keys> as:dungeon:
      - define blist <list[]>
      - foreach <server.flag[times.<[dungeon]>].keys> as:player:
        - define blist <[blist].include[<&a><[player].flag[times.<[dungeon]>.best]><&sp><&7><[player].name>]>
      - define pages <[pages].include[<[dungeon]><p><[blist].parse[replace[:].with[,]].alphabetical.parse[replace[,].with[:]].separated_by[<n>]>]>
    - give writable_book[book_pages=<[pages]>]

stop_time_tab_complete:
  type: world
  debug: false
  events:
    on tab complete:
      - if <context.command> != stop_timer:
        - stop
      - define tab <list[]>
      - foreach <player.flag[times].keys> as:dungeon:
        - if <player.flag[times.<[dungeon]>].keys.contains[start]>:
          - define tab <[tab].include[<[dungeon]>]>
      - determine <[tab]>

stop_time_c:
  type: command
  name: stop_timer
  debug: false
  description: Lets you stop a current timer
  usage: /stop_timer (dungeon)
  script:
    - if <context.args.first||empty> == empty:
      - narrate "Use a valid dungeon name"
      - stop
    - if !<yaml[zcrpg_config].read[dungeons].keys.contains[<context.args.first>]>:
      - narrate "Use a valid dungeon name"
      - stop
    - flag player times.<context.args.first>.start:!
