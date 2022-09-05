event_prefix_w:
  type: world
  debug: false
  events:
    on player joins:
    # - if <player.flag[e_prefixes].contains_any_text[hopped]||null> != null:
    #   - inject define_prefixes
    #   - foreach <player.flag[e_prefixes].filter[contains_any_text[hopped]]||null>:
    #     - flag <player> e_prefix:<-:<[value]>
    # use <player.flag[easterpref_8]> to track, and reflag
    - if <player.has_flag[e_prefix_join]>:
      - determine passively <player.flag[e_prefix_join].as_element>
    - else:
      - determine passively "<&e><element[<player.name> joined the game]>"
    on player quits:
    - if <player.has_flag[e_prefix_quit]>:
      - determine passively <player.flag[e_prefix_quit].as_element>
    - else:
      - determine passively "<&e><element[<player.name> left the game]>"
    on player clicks in event_prefix_i:
    - determine passively cancelled
    - if <context.clicked_inventory||null> == <player.open_inventory>:
      - if <context.item.script.name||none> == no_item:
        - stop
      - if <context.item.script.name||none> == ep_page_back:
        - if "<context.item.lore.first.after[Page ]>" < 1:
          - narrate "cannot go to that page"
          - stop
        - else:
          - define page "<context.item.lore.first.after[Page ]>"
          - flag player e_prefix_page:<[page]> duration:1s
          - inventory open d:event_prefix_i
          - stop
      - if <context.item.script.name||none> == ep_page_forward:
        - if "<context.item.lore.first.after[Page ]>" > <player.flag[e_prefixes].size.div[45].round_up||1>:
          - narrate "cannot go to that page"
          - stop
        - else:
          - define page "<context.item.lore.first.after[Page ]>"
          - flag player e_prefix_page:<[page]> duration:1s
          - inventory open d:event_prefix_i
          - stop
      - if <context.item.display.strip_color.starts_with[Prefix]>:
        - if <context.item.lore.first.strip_color.contains_any_text[joined]> || "<context.item.lore.first.strip_color.contains_any_text[spooked into]>" || "<context.item.lore.first.strip_color.contains_any_text[jingled into]>" || "<context.item.lore.first.strip_color.contains_any_text[swooned into]>" || "<context.item.lore.first.strip_color.contains_any_text[hopped into]>" || "<context.item.lore.first.strip_color.contains_any_text[splashed into]>":
          - flag player e_prefix_join:<context.item.lore.first>
          - narrate "Your join message has been set to:<&nl><&sp><&sp><&sp><&sp><&7><&gt><&gt><&f><&sp><player.flag[e_prefix_join]>" format:zc_text
        - if <context.item.lore.first.strip_color.contains_any_text[left]> || "<context.item.lore.first.strip_color.contains_any_text[spooked out of]>" || "<context.item.lore.first.strip_color.contains_any_text[jingled out of]>" || "<context.item.lore.first.strip_color.contains_any_text[swooned out of]>" || "<context.item.lore.first.strip_color.contains_any_text[hopped out of]>" || "<context.item.lore.first.strip_color.contains_any_text[splashed out of]>":
          - flag player e_prefix_quit:<context.item.lore.first>
          - narrate "Your leave message has been set to:<&nl><&sp><&sp><&sp><&sp><&7><&gt><&gt><&f><&sp><player.flag[e_prefix_quit]>" format:zc_text
    on player drags in event_prefix_i:
    - determine passively cancelled

event_prefix_i:
  type: inventory
  inventory: chest
  title: Your prefixes
  debug: false
  size: 54
  procedural items:
    - if <player.has_flag[e_prefixes]>:
      - if <player.flag[e_prefixes].size> > 45:
        - define items <list[]>
        - define page <player.flag[e_prefix_page]||1>
        - choose <[page]||1>:
          - case 1:
            - define prefixes <player.flag[e_prefixes].get[1].to[45]>
            - define add 0
          - case 2:
            - define prefixes <player.flag[e_prefixes].get[46].to[90]>
            - define add 45
          - case 3:
            - define prefixes <player.flag[e_prefixes].get[91].to[135]>
            - define add 90
          - case 4:
            - define prefixes <player.flag[e_prefixes].get[136].to[180]>
            - define add 135
          - case 5:
            - define prefixes <player.flag[e_prefixes].get[181].to[225]>
            - define add 180
          - case 6:
            - define prefixes <player.flag[e_prefixes].get[226].to[270]>
            - define add 225
          - case 7:
            - define prefixes <player.flag[e_prefixes].get[271].to[315]>
            - define add 270
          - case 8:
            - define prefixes <player.flag[e_prefixes].get[316].to[360]>
            - define add 315
          - case 9:
            - define prefixes <player.flag[e_prefixes].get[361].to[405]>
            - define add 360
          - case 10:
            - define prefixes <player.flag[e_prefixes].get[406].to[450]>
            - define add 405
        - foreach <[prefixes]>:
          - define item paper[display_name=Prefix<&sp><[loop_index].add[<[add]>]>;lore=<[value]>]
          - define items <[items].include[<[item]>]>
        - determine <[items]>
      - define items <list[]>
      - foreach <player.flag[e_prefixes]>:
        - define item paper[display_name=Prefix<&sp><[loop_index]>;lore=<[value]>]
        - define items <[items].include[<[item]>]>
      - determine <[items]>
    - else:
      - define items <list[]>
      - repeat 45:
        - define item "black_stained_glass_pane[display_name=<&e>No prefixes found;lore=<&a>Type /prefix update to update this list]"
        - define items <[items].include[<[item]>]>
      - determine <[items]>
  slots:
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [no_item] [no_item] [ep_page_back] [no_item] [no_item] [no_item] [ep_page_forward] [no_item] [no_item]

#this is the command which handles gifting players their prefixes.
#simply use - inject (your script name) to inject a task script you make further down

event_prefix_c:
  type: command
  name: prefixes
  description: Shows you event prefixes you have
  usage: /prefixes <&lt>update/set/clear (join/leave)<&gt>
  tab completions:
    1: <list[update|set|clear]>
  debug: false
  aliases:
  - prefix
  - eprefix
  - eprefixes
  script:
    - choose <context.args.first||default>:
      - case clear:
        - if <context.args.get[2]||null> == join:
          - flag player e_prefix_join:!
          - narrate "Your join prefix message has been cleared!" format:zc_text
          - stop
        - if <context.args.get[2]||null> == leave:
          - flag player e_prefix_quit:!
          - narrate "Your leave prefix message has been cleared!" format:zc_text
          - stop
        - flag player e_prefix_join:!
        - flag player e_prefix_quit:!
        - narrate "Your prefix messages have been cleared!" format:zc_text
      - case update:
        - inject define_prefixes
        - inject hallowe2020
        - inject xmas2020_prefixes
        - inject vday2021_prefixes
        - inject easter2021_prefixes
        - inject summer2021_prefixes
        - narrate "Your prefixes have been updated, type /prefix set to set your prefix" format:zc_text
      - case set:
        - inventory open d:event_prefix_i
      - default:
        - narrate "<&a><&l>Zelda<&2><&l>Craft Prefix Command"
        - narrate "This command is used to set/load players their event prefixes."
        - narrate "Event prefixes can be gathered by playing server events.<&nl> "
        - narrate "If you want to update the list of your event prefixes use<&nl><&hover[click here to run /prefix update]><&click[/prefix update]><&a>/prefix <&b>update<&end_click><&end_hover>"
        - narrate "If you want to set your event prefix use<&nl><&hover[click here to run /prefix set]><&click[/prefix set]><&a>/prefix <&b>set<&end_click><&end_hover>"
        - narrate "No longer want a prefix you can clear a prefix with<&nl><&a><&hover[Click here so we can suggest the correct command]><&click[/prefix clear ].type[suggest_command]>/prefix <&b>clear <&e>(join/leave)<&end_click><&end_hover>"
        - narrate "If you do not specify either join or leave it will clear both of them."

#put below here all the prefixes want

hallowe2020:
  type: task
  debug: false
  script:
    - if <player.flag[e_prefixes].contains[<[hallowe2020_1]>]||false>:
      - goto skip1
    - if <player.flag[riddle].size||0> >= 8:
      - flag player e_prefixes:->:<[hallowe2020_1]>
      - flag player e_prefixes:->:<[hallowe2020_2]>
    - mark skip1
    - if <player.flag[e_prefixes].contains[<[hallowe2020_3]>]||false>:
      - goto skip2
    - if <player.flag[red_candy].add[<player.flag[green_candy]||0>].add[<player.flag[purple_candy]||0>]||0> >= 250:
      - flag player e_prefixes:->:<[hallowe2020_3]>
      - flag player e_prefixes:->:<[hallowe2020_4]>
    - mark skip2
    - if <player.flag[e_prefixes].contains[<[hallowe2020_5]>]||false>:
      - goto skip3
    - if <player.has_flag[final_boss_done]>:
      - flag player e_prefixes:->:<[hallowe2020_5]>
      - flag player e_prefixes:->:<[hallowe2020_6]>
    - mark skip3
    - if <player.flag[e_prefixes].contains[<[hallowe2020_7]>]||false>:
      - goto skip4
    - if <player.flag[final_boss_done]||0> >= 10:
      - flag player e_prefixes:->:<[hallowe2020_7]>
      - flag player e_prefixes:->:<[hallowe2020_8]>
    - mark skip4

xmas2020_prefixes:
  type: task
  debug: false
  script:
    - define earned_new 0
    - if <player.flag[contributed_presents]||0> >= 1 && !<player.flag[e_prefixes].contains[<[xmas2020_1a]>]||false>:
      - flag player e_prefixes:->:<[xmas2020_1a]>
      - flag player e_prefixes:->:<[xmas2020_1b]>
      - flag player e_prefixes:->:<[xmas2020_2a]>
      - flag player e_prefixes:->:<[xmas2020_2b]>
      - flag player e_prefixes:->:<[xmas2020_3a]>
      - flag player e_prefixes:->:<[xmas2020_3b]>
      - flag player e_prefixes:->:<[xmas2020_4a]>
      - flag player e_prefixes:->:<[xmas2020_4b]>
      - flag player e_prefixes:->:<[xmas2020_5a]>
      - flag player e_prefixes:->:<[xmas2020_5b]>
      - define earned_new:++
    - if <server.flag[xmas_prize_list].contains[<player>]||false> && !<player.flag[e_prefixes].contains[<[xmas2020_6a]>]||false>:
      - define pos <server.flag[xmas_prize_list].find[<player>]>
      - if <[pos]> <= 16:
        - flag player e_prefixes:->:<[xmas2020_6a]>
        - flag player e_prefixes:->:<[xmas2020_6b]>
        - define earned_new:++
      - if <[pos]> <= 11:
        - flag player e_prefixes:->:<[xmas2020_7a]>
        - flag player e_prefixes:->:<[xmas2020_7b]>
        - define earned_new:++
      - if <[pos]> <= 6:
        - flag player e_prefixes:->:<[xmas2020_8a]>
        - flag player e_prefixes:->:<[xmas2020_8b]>
        - define earned_new:++
      - if <[pos]> <= 2:
        - flag player e_prefixes:->:<[xmas2020_9a]>
        - flag player e_prefixes:->:<[xmas2020_9b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_bokoblin4]> && !<player.flag[e_prefixes].contains[<[xmas2020_10a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_10a]>
        - flag player e_prefixes:->:<[xmas2020_10b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_moblin4]> && !<player.flag[e_prefixes].contains[<[xmas2020_12a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_12a]>
        - flag player e_prefixes:->:<[xmas2020_12b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_chilfos4]> && !<player.flag[e_prefixes].contains[<[xmas2020_11a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_11a]>
        - flag player e_prefixes:->:<[xmas2020_11b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_reekfish2]> && <player.has_advancement[denizen:xmas2020_bass2]> && <player.has_advancement[denizen:xmas2020_presfish2]>  && !<player.flag[e_prefixes].contains[<[xmas2020_14a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_14a]>
        - flag player e_prefixes:->:<[xmas2020_14b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_geyser3]> && !<player.flag[e_prefixes].contains[<[xmas2020_13a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_13a]>
        - flag player e_prefixes:->:<[xmas2020_13b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_icelord]> && !<player.flag[e_prefixes].contains[<[xmas2020_15a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_15a]>
        - flag player e_prefixes:->:<[xmas2020_15b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_deposite1000]> && !<player.flag[e_prefixes].contains[<[xmas2020_16a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_16a]>
        - flag player e_prefixes:->:<[xmas2020_16b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_jackpot]> && <player.has_advancement[denizen:xmas2020_chest3]> && !<player.flag[e_prefixes].contains[<[xmas2020_17a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_17a]>
        - flag player e_prefixes:->:<[xmas2020_17b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_secretsanta]> && !<player.flag[e_prefixes].contains[<[xmas2020_18a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_18a]>
        - flag player e_prefixes:->:<[xmas2020_18b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_tree_parkour]> && <player.has_advancement[denizen:xmas2020_tower_parkour]> && !<player.flag[e_prefixes].contains[<[xmas2020_19a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_19a]>
        - flag player e_prefixes:->:<[xmas2020_19b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_lookout_chest]> && <player.has_advancement[denizen:xmas2020_campfire_parkour]> && !<player.flag[e_prefixes].contains[<[xmas2020_20a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_20a]>
        - flag player e_prefixes:->:<[xmas2020_20b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_pres10000]> && !<player.flag[e_prefixes].contains[<[xmas2020_21a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_21a]>
        - flag player e_prefixes:->:<[xmas2020_21b]>
        - define earned_new:++
    - if <player.has_advancement[denizen:xmas2020_nice]> && !<player.flag[e_prefixes].contains[<[xmas2020_22a]>]||false>:
        - flag player e_prefixes:->:<[xmas2020_22a]>
        - flag player e_prefixes:->:<[xmas2020_22b]>
        - define earned_new:++
    - if <[earned_new]> > 1:
      - narrate "<&e>You earned <&c><[earned_new]> <&e>new xmas 2020 prefixes!" targets:<player>
      - stop
    - if <[earned_new]> == 1:
      - narrate "<&e>You earned a new xmas 2020 prefix!" targets:<player>
      - stop

vday2021_prefixes:
  type: task
  debug: false
  script:
    - define new_vday_prefix 0
    - if <player.has_flag[finished_vday]||false> && !<player.flag[e_prefixes].contains[<[vday2021_1a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_1a]>
        - flag player e_prefixes:->:<[vday2021_1b]>
        - define new_vday_prefix:++
    - if <player.flag[finished_vday]||0> >= 5 && !<player.flag[e_prefixes].contains[<[vday2021_2a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_2a]>
        - flag player e_prefixes:->:<[vday2021_2b]>
        - define new_vday_prefix:++
    - if <player.flag[finished_vday]||0> >= 10 && !<player.flag[e_prefixes].contains[<[vday2021_3a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_3a]>
        - flag player e_prefixes:->:<[vday2021_3b]>
        - define new_vday_prefix:++
    - if <player.has_flag[vday_roses_gifted]||false> && !<player.flag[e_prefixes].contains[<[vday2021_4a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_4a]>
        - flag player e_prefixes:->:<[vday2021_4b]>
        - define new_vday_prefix:++
    - if <player.flag[vday_roses_gifted]||0> >= 10 && !<player.flag[e_prefixes].contains[<[vday2021_5a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_5a]>
        - flag player e_prefixes:->:<[vday2021_5b]>
        - define new_vday_prefix:++
    - if <player.flag[vday_roses_gifted]||0> >= 30 && !<player.flag[e_prefixes].contains[<[vday2021_6a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_6a]>
        - flag player e_prefixes:->:<[vday2021_6b]>
        - define new_vday_prefix:++
    - if <player.has_flag[vday_roses_received]||false> && !<player.flag[e_prefixes].contains[<[vday2021_7a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_7a]>
        - flag player e_prefixes:->:<[vday2021_7b]>
        - define new_vday_prefix:++
    - if <player.flag[vday_roses_received]||0> >= 5 && !<player.flag[e_prefixes].contains[<[vday2021_8a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_8a]>
        - flag player e_prefixes:->:<[vday2021_8b]>
        - define new_vday_prefix:++
    - if <player.flag[vday_roses_received]||0> >= 20 && !<player.flag[e_prefixes].contains[<[vday2021_9a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_9a]>
        - flag player e_prefixes:->:<[vday2021_9b]>
        - define new_vday_prefix:++
    - if <list[DarkLordSentis|Zazzan|BurntIndigo|LordKakashki_|DCaff95].contains[<player.name>]||false> && !<player.flag[e_prefixes].contains[<[vday2021_10a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_10a]>
        - flag player e_prefixes:->:<[vday2021_10b]>
        - define earned_new:++
    - if <player.name> == DarkLordSentis && !<player.flag[e_prefixes].contains[<[vday2021_11a]>]||false>:
        - flag player e_prefixes:->:<[vday2021_11a]>
        - flag player e_prefixes:->:<[vday2021_11b]>
        - define earned_new:++
    - define olda "<&e>[<&color[#DD0E29]>L<&color[#CF1267]>o<&color[#CF1267]>v<&color[#B51BE4]>e <&color[#B51BE4]>B<&color[#CF1267]>i<&color[#CF1267]>r<&color[#DD0E29]>d<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define oldb "<&e>[<&color[#DD0E29]>L<&color[#CF1267]>o<&color[#CF1267]>v<&color[#B51BE4]>e <&color[#B51BE4]>B<&color[#CF1267]>i<&color[#CF1267]>r<&color[#DD0E29]>d<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define oldc "<&e>[<&color[#DD0E29]>L<&color[#CF1267]>o<&color[#CF1267]>v<&color[#CF1267]>e <&color[#CF1267]>B<&color[#CF1267]>i<&color[#CF1267]>r<&color[#DD0E29]>d<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define oldd "<&e>[<&color[#DD0E29]>L<&color[#CF1267]>o<&color[#CF1267]>v<&color[#CF1267]>e <&color[#CF1267]>B<&color[#CF1267]>i<&color[#CF1267]>r<&color[#DD0E29]>d<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - flag player e_prefixes:<-:<[olda]>
    - flag player e_prefixes:<-:<[oldb]>
    - flag player e_prefixes:<-:<[oldc]>
    - flag player e_prefixes:<-:<[oldd]>
    - if <[earned_new]> > 1:
      - narrate "<&e>You earned <&c><[earnew_vday_prefixned_new]> <&e>new Valentines prefixes!" targets:<player>
      - stop
    - if <[earned_new]> == 1:
      - narrate "<&e>You earned a new Valentines 2021 prefix!" targets:<player>
      - stop

easter2021_prefixes:
  type: task
  debug: false
  script:
    - define easter_earned 0
    - if <player.has_flag[easterpref_1]> && !<player.flag[e_prefixes].contains[<[easter2021_1a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_1a]>
      - flag player e_prefixes:->:<[easter2021_1b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_2]> && !<player.flag[e_prefixes].contains[<[easter2021_2a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_2a]>
      - flag player e_prefixes:->:<[easter2021_2b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_3]> && !<player.flag[e_prefixes].contains[<[easter2021_3a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_3a]>
      - flag player e_prefixes:->:<[easter2021_3b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_4]> && !<player.flag[e_prefixes].contains[<[easter2021_4a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_4a]>
      - flag player e_prefixes:->:<[easter2021_4b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_5]> && !<player.flag[e_prefixes].contains[<[easter2021_5a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_5a]>
      - flag player e_prefixes:->:<[easter2021_5b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_6]> && !<player.flag[e_prefixes].contains[<[easter2021_6a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_6a]>
      - flag player e_prefixes:->:<[easter2021_6b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_7]> && !<player.flag[e_prefixes].contains[<[easter2021_7a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_7a]>
      - flag player e_prefixes:->:<[easter2021_7b]>
      - define easter_earned:++
    - if <player.has_flag[easterpref_8]> && !<player.flag[e_prefixes].contains[<[easter2021_8a]>]||false>:
      - flag player e_prefixes:->:<[easter2021_8a]>
      - flag player e_prefixes:->:<[easter2021_8b]>
      - define easter_earned:++
    - if <[easter_earned]> > 1:
      - narrate "<&e>You earned <&c><[easter_earned]> <&e>new Easter prefixes!" targets:<player>
      - stop
    - if <[easter_earned]> == 1:
      - narrate "<&e>You earned a new Easter 2021 prefix!" targets:<player>
      - stop

summer2021_prefixes:
  type: task
  debug: false
  script:
    - define summer_earned 0
    - if <player.has_flag[summerpref_1]> && !<player.flag[e_prefixes].contains[<[summer2021_1a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_1a]>
      - flag player e_prefixes:->:<[summer2021_1b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_2]> && !<player.flag[e_prefixes].contains[<[summer2021_2a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_2a]>
      - flag player e_prefixes:->:<[summer2021_2b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_3]> && !<player.flag[e_prefixes].contains[<[summer2021_3a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_3a]>
      - flag player e_prefixes:->:<[summer2021_3b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_4]> && !<player.flag[e_prefixes].contains[<[summer2021_4a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_4a]>
      - flag player e_prefixes:->:<[summer2021_4b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_5]> && !<player.flag[e_prefixes].contains[<[summer2021_5a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_5a]>
      - flag player e_prefixes:->:<[summer2021_5b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_6]> && !<player.flag[e_prefixes].contains[<[summer2021_6a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_6a]>
      - flag player e_prefixes:->:<[summer2021_6b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_7]> && !<player.flag[e_prefixes].contains[<[summer2021_7a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_7a]>
      - flag player e_prefixes:->:<[summer2021_7b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_8]> && !<player.flag[e_prefixes].contains[<[summer2021_8a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_8a]>
      - flag player e_prefixes:->:<[summer2021_8b]>
      - define summer_earned:++
    - if <player.has_flag[summerpref_9]> && !<player.flag[e_prefixes].contains[<[summer2021_9a]>]||false>:
      - flag player e_prefixes:->:<[summer2021_9a]>
      - flag player e_prefixes:->:<[summer2021_9b]>
      - define summer_earned:++
    - if <[summer_earned]> > 1:
      - narrate "<&e>You earned <&c><[summer_earned]> <&e>new Summer prefixes!" targets:<player>
      - stop
    - if <[summer_earned]> == 1:
      - narrate "<&e>You earned a new Summer 2021 prefix!" targets:<player>
      - stop
#define what your prefixes should look like with a fitting name you use in your get prefix task(same as done with hallowe2020)
#these messages must contain joined, left, spooked into, spooked out of. you can always add another join and leave word above.

define_prefixes:
  type: task
  debug: false
  script:
    - define hallowe2020_1 "<&e>[<&8>Soul <&7>Seeker<&e>] <player.name> <&4>Spooked<&e> into the server"
    - define hallowe2020_2 "<&e>[<&8>Soul <&7>Seeker<&e>] <player.name> <&4>Spooked<&e> out of the server"
    - define hallowe2020_3 "<&e>[<&5>Candy <&d>Hoarder<&e>] <player.name> <&4>Spooked<&e> into the server"
    - define hallowe2020_4 "<&e>[<&5>Candy <&d>Hoarder<&e>] <player.name> <&4>Spooked<&e> out of the server"
    - define hallowe2020_5 "<&e>[<&color[#FC6400]>Pumpkin <&0>Breaker<&e>] <player.name> <&4>Spooked<&e> into the server"
    - define hallowe2020_6 "<&e>[<&color[#FC6400]>Pumpkin <&0>Breaker<&e>] <player.name> <&4>Spooked<&e> out of the server"
    - define hallowe2020_7 "<&e>[<&color[#FC6400]>P<&color[#F5741E]>u<&color[#F28136]>m<&color[#F28F4D]>p<&color[#EF9C65]>k<&color[#F0B288]>i<&color[#EFCCB5]>n <&color[#E2D0C4]>D<&color[#C7C3C0]>e<&color[#ABABAB]>s<&color[#A1A1A1]>t<&color[#8D8D8D]>r<&color[#737373]>o<&color[#5A5A5A]>y<&color[#3F3F3F]>e<&color[#242424]>r<&e>] <player.name> <&4>Spooked<&e> into the server"
    - define hallowe2020_8 "<&e>[<&color[#FC6400]>P<&color[#F5741E]>u<&color[#F28136]>m<&color[#F28F4D]>p<&color[#EF9C65]>k<&color[#F0B288]>i<&color[#EFCCB5]>n <&color[#E2D0C4]>D<&color[#C7C3C0]>e<&color[#ABABAB]>s<&color[#A1A1A1]>t<&color[#8D8D8D]>r<&color[#737373]>o<&color[#5A5A5A]>y<&color[#3F3F3F]>e<&color[#242424]>r<&e>] <player.name> <&4>Spooked<&e> out of the server"
    #Xmas2020 progression prefixes
    - define xmas2020_1a "<&e>[<&c>Santa<&sq>s <&f>Helper<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_1b "<&e>[<&c>Santa<&sq>s <&f>Helper<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_2a "<&e>[<&5>Gift <&6>Grabber<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_2b "<&e>[<&5>Gift <&6>Grabber<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_3a "<&e>[<&b>Winter <&color[#e0c031]>Wonder] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_3b "<&e>[<&b>Winter <&color[#e0c031]>Wonder] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_4a "<&e>[<&color[#219c2b]>Holiday <&color[#9e2810]>Hero<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_4b "<&e>[<&color[#219c2b]>Holiday <&color[#9e2810]>Hero<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_5a "<&e>[<&color[#ff0000]>C<&color[#ff3333]>h<&color[#ff6666]>r<&color[#ff9999]>i<&color[#ffcccc]>s<&color[#ffffff]>t<&color[#ccffcc]>m<&color[#99ff99]>a<&color[#66ff66]>s <&color[#33ff33]>S<&color[#00ff00]>a<&color[#33ff33]>v<&color[#66ff66]>i<&color[#99ff99]>o<&color[#ccffcc]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_5b "<&e>[<&color[#ff0000]>C<&color[#ff3333]>h<&color[#ff6666]>r<&color[#ff9999]>i<&color[#ffcccc]>s<&color[#ffffff]>t<&color[#ccffcc]>m<&color[#99ff99]>a<&color[#66ff66]>s <&color[#33ff33]>S<&color[#00ff00]>a<&color[#33ff33]>v<&color[#66ff66]>i<&color[#99ff99]>o<&color[#ccffcc]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"

    #Xmas2020 Top scoreboard prefixes
    - define xmas2020_6a "<&e>[<&color[#b42dcc]>H<&color[#b33cce]>e<&color[#b24bd0]>l<&color[#b15ad2]>p<&color[#ae69d6]>f<&color[#b377ae]>u<&color[#b88586]>l<&color[#bd935e]> <&color[#c4a233]>E<&color[#c8b02e]>l<&color[#ccbe29]>f<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_6b "<&e>[<&color[#b42dcc]>H<&color[#b33cce]>e<&color[#b24bd0]>l<&color[#b15ad2]>p<&color[#ae69d6]>f<&color[#b377ae]>u<&color[#b88586]>l<&color[#bd935e]> <&color[#c4a233]>E<&color[#c8b02e]>l<&color[#ccbe29]>f<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_7a "<&e>[<&color[#8827e3]>M<&color[#852cca]>a<&color[#8231b1]>s<&color[#7e3696]>t<&color[#6c3182]>e<&color[#5a2c6e]>r <&color[#c4a233]>E<&color[#c8b02e]>l<&color[#ccbe29]>f<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_7b "<&e>[<&color[#8827e3]>M<&color[#852cca]>a<&color[#8231b1]>s<&color[#7e3696]>t<&color[#6c3182]>e<&color[#5a2c6e]>r <&color[#c4a233]>E<&color[#c8b02e]>l<&color[#ccbe29]>f<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_8a "<&e>[<&color[#ff0000]>C<&color[#ff3333]>h<&color[#ff6666]>r<&color[#ff9999]>i<&color[#ffcccc]>s<&color[#ffffff]>t<&color[#ccffcc]>m<&color[#99ff99]>a<&color[#66ff66]>s <&color[#0cb6cc]>C<&color[#3ec2d3]>h<&color[#70ceda]>a<&color[#a2dae1]>m<&color[#d5e8eb]>p<&color[#a3dce4]>i<&color[#71d0dd]>o<&color[#3fc4d6]>n<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_8b "<&e>[<&color[#ff0000]>C<&color[#ff3333]>h<&color[#ff6666]>r<&color[#ff9999]>i<&color[#ffcccc]>s<&color[#ffffff]>t<&color[#ccffcc]>m<&color[#99ff99]>a<&color[#66ff66]>s <&color[#0cb6cc]>C<&color[#3ec2d3]>h<&color[#70ceda]>a<&color[#a2dae1]>m<&color[#d5e8eb]>p<&color[#a3dce4]>i<&color[#71d0dd]>o<&color[#3fc4d6]>n<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_9a "<&e>[<&color[#ff0000]>C<&color[#ff3333]>h<&color[#ff6666]>r<&color[#ff9999]>i<&color[#ffcccc]>s<&color[#ffffff]>t<&color[#ccffcc]>m<&color[#99ff99]>a<&color[#66ff66]>s <bold><&color[#f0f024]>K<&color[#d8cf20]>i<&color[#c0ae1c]>n<&color[#a88d18]>g<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_9b "<&e>[<&color[#ff0000]>C<&color[#ff3333]>h<&color[#ff6666]>r<&color[#ff9999]>i<&color[#ffcccc]>s<&color[#ffffff]>t<&color[#ccffcc]>m<&color[#99ff99]>a<&color[#66ff66]>s <bold><&color[#f0f024]>K<&color[#d8cf20]>i<&color[#c0ae1c]>n<&color[#a88d18]>g<&e>] <player.name> <&b>Jingled<&e> out of the server"
    #Xmas2020 Advancements Prefixes
    - define xmas2020_10a "<&e>[<&color[#c90a0a]>B<&color[#a90707]>a<&color[#870404]>n<&color[#660000]>e <&color[#660000]>o<&color[#660000]>f <&color[#396307]>B<&color[#3e7004]>o<&color[#7b7b08]>k<&color[#b8860b]>o<&color[#b8860b]>b<&color[#b8860b]>l<&color[#b8860b]>i<&color[#b8860b]>n<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_10b "<&e>[<&color[#c90a0a]>B<&color[#a90707]>a<&color[#870404]>n<&color[#660000]>e <&color[#660000]>o<&color[#660000]>f <&color[#396307]>B<&color[#3e7004]>o<&color[#7b7b08]>k<&color[#b8860b]>o<&color[#b8860b]>b<&color[#b8860b]>l<&color[#b8860b]>i<&color[#b8860b]>n<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_11a "<&e>[<&color[#c90a0a]>B<&color[#a90707]>a<&color[#870404]>n<&color[#660000]>e <&color[#660000]>o<&color[#660000]>f <&color[#23b0b0]>C<&color[#3cb7b7]>h<&color[#55bebe]>i<&color[#6ec5c5]>l<&color[#87cccc]>f<&color[#a0d3d3]>o<&color[#b9dada]>s<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_11b "<&e>[<&color[#c90a0a]>B<&color[#a90707]>a<&color[#870404]>n<&color[#660000]>e <&color[#660000]>o<&color[#660000]>f <&color[#23b0b0]>C<&color[#3cb7b7]>h<&color[#55bebe]>i<&color[#6ec5c5]>l<&color[#87cccc]>f<&color[#a0d3d3]>o<&color[#b9dada]>s<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_12a "<&e>[<&color[#c90a0a]>B<&color[#a90707]>a<&color[#870404]>n<&color[#660000]>e <&color[#660000]>o<&color[#660000]>f <&color[#396307]>M<&color[#637410]>o<&color[#8d8519]>b<&color[#b89723]>l<&color[#a07f21]>i<&color[#88671f]>n<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_12b "<&e>[<&color[#c90a0a]>B<&color[#a90707]>a<&color[#870404]>n<&color[#660000]>e <&color[#660000]>o<&color[#660000]>f <&color[#396307]>M<&color[#637410]>o<&color[#8d8519]>b<&color[#b89723]>l<&color[#a07f21]>i<&color[#88671f]>n<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_13a "<&e>[<&color[#1641b8]>P<&color[#2858bd]>r<&color[#3a6fc2]>e<&color[#4c86c7]>s<&color[#5e9dcc]>e<&color[#70b6d4]>n<&color[#84c1d8]>t<&color[#98ccdc]> <&color[#acd7e0]>E<&color[#c0e2e4]>x<&color[#d5edea]>c<&color[#d1d7be]>a<&color[#cdc192]>v<&color[#c9ab66]>a<&color[#c5953a]>t<&color[#bf7d0a]>o<&color[#be7b0e]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_13b "<&e>[<&color[#1641b8]>P<&color[#2858bd]>r<&color[#3a6fc2]>e<&color[#4c86c7]>s<&color[#5e9dcc]>e<&color[#70b6d4]>n<&color[#84c1d8]>t<&color[#98ccdc]> <&color[#acd7e0]>E<&color[#c0e2e4]>x<&color[#d5edea]>c<&color[#d1d7be]>a<&color[#cdc192]>v<&color[#c9ab66]>a<&color[#c5953a]>t<&color[#bf7d0a]>o<&color[#be7b0e]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_14a "<&e>[<&color[#14cfd9]>A<&color[#2ed0d9]>r<&color[#48d1d9]>c<&color[#62d3d9]>t<&color[#88d9dd]>i<&color[#aedfe1]>c<&color[#d5e5e6]> <&color[#aed6df]>A<&color[#87c7d8]>n<&color[#5eb6d1]>g<&color[#47a6c4]>l<&color[#3096b7]>e<&color[#1886a8]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_14b "<&e>[<&color[#14cfd9]>A<&color[#2ed0d9]>r<&color[#48d1d9]>c<&color[#62d3d9]>t<&color[#88d9dd]>i<&color[#aedfe1]>c<&color[#d5e5e6]> <&color[#aed6df]>A<&color[#87c7d8]>n<&color[#5eb6d1]>g<&color[#47a6c4]>l<&color[#3096b7]>e<&color[#1886a8]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_15a "<&e>[<&color[#14cfd9]>F<&color[#2ed0d9]>r<&color[#48d1d9]>o<&color[#62d3d9]>s<&color[#88d9dd]>t<&color[#aedfe1]>b<&color[#d5e5e6]>i<&color[#aed6df]>t<&color[#87c7d8]>e <&color[#e1ebe9]>C<&color[#e6e2a0]>o<&color[#ebd957]>n<&color[#f2d00c]>q<&color[#ebd010]>u<&color[#e4d014]>e<&color[#dbd21a]>r<&color[#dbcc1a]>o<&color[#dbc61a]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_15b "<&e>[<&color[#14cfd9]>F<&color[#2ed0d9]>r<&color[#48d1d9]>o<&color[#62d3d9]>s<&color[#88d9dd]>t<&color[#aedfe1]>b<&color[#d5e5e6]>i<&color[#aed6df]>t<&color[#87c7d8]>e <&color[#e1ebe9]>C<&color[#e6e2a0]>o<&color[#ebd957]>n<&color[#f2d00c]>q<&color[#ebd010]>u<&color[#e4d014]>e<&color[#dbd21a]>r<&color[#dbcc1a]>o<&color[#dbc61a]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_16a "<&e>[<&color[#b55bd9]>J<&color[#b154cc]>o<&color[#ad4dbf]>l<&color[#a745b2]>l<&color[#9e458f]>y<&color[#95456c]> <&color[#8c4348]>D<&color[#96554b]>o<&color[#a0674e]>n<&color[#aa7b52]>a<&color[#b48e55]>t<&color[#bea158]>o<&color[#c9b55d]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_16b "<&e>[<&color[#b55bd9]>J<&color[#b154cc]>o<&color[#ad4dbf]>l<&color[#a745b2]>l<&color[#9e458f]>y<&color[#95456c]> <&color[#8c4348]>D<&color[#96554b]>o<&color[#a0674e]>n<&color[#aa7b52]>a<&color[#b48e55]>t<&color[#bea158]>o<&color[#c9b55d]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_17a "<&e>[<&color[#8f7d06]>H<&color[#a2900a]>o<&color[#b5a30e]>l<&color[#c9b712]>i<&color[#d2c22f]>d<&color[#dbcd4c]>a<&color[#e6d96a]>y<&color[#e8de8b]> <&color[#eae3ac]>H<&color[#ede8ce]>i<&color[#e1d890]>g<&color[#d5c852]>h<&color[#c9b712]> <&color[#d2c22f]>R<&color[#dbcd4c]>o<&color[#e6d96a]>l<&color[#e8de8b]>l<&color[#eae3ac]>e<&color[#ede8ce]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_17b "<&e>[<&color[#8f7d06]>H<&color[#a2900a]>o<&color[#b5a30e]>l<&color[#c9b712]>i<&color[#d2c22f]>d<&color[#dbcd4c]>a<&color[#e6d96a]>y<&color[#e8de8b]> <&color[#eae3ac]>H<&color[#ede8ce]>i<&color[#e1d890]>g<&color[#d5c852]>h<&color[#c9b712]> <&color[#d2c22f]>R<&color[#dbcd4c]>o<&color[#e6d96a]>l<&color[#e8de8b]>l<&color[#eae3ac]>e<&color[#ede8ce]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_18a "<&e>[<&color[#c41b08]>G<&color[#f2eae9]>i<&color[#c41b08]>f<&color[#f2eae9]>t<&color[#c41b08]> <&color[#f2eae9]>W<&color[#c41b08]>r<&color[#f2eae9]>a<&color[#c41b08]>p<&color[#f2eae9]>p<&color[#c41b08]>e<&color[#f2eae9]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_18b "<&e>[<&color[#c41b08]>G<&color[#f2eae9]>i<&color[#c41b08]>f<&color[#f2eae9]>t<&color[#c41b08]> <&color[#f2eae9]>W<&color[#c41b08]>r<&color[#f2eae9]>a<&color[#c41b08]>p<&color[#f2eae9]>p<&color[#c41b08]>e<&color[#f2eae9]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_19a "<&e>[<&color[#1b8001]>T<&color[#1b8001]>r<&color[#3bba1a]>e<&color[#5bd43b]>e<&color[#dbd80d]> <&color[#ada00c]>T<&color[#d9ca1e]>o<&color[#d1c211]>p<&color[#decf26]>p<&color[#e6d845]>e<&color[#f7ea63]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_19b "<&e>[<&color[#1b8001]>T<&color[#1b8001]>r<&color[#3bba1a]>e<&color[#5bd43b]>e<&color[#dbd80d]> <&color[#ada00c]>T<&color[#d9ca1e]>o<&color[#d1c211]>p<&color[#decf26]>p<&color[#e6d845]>e<&color[#f7ea63]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_20a "<&e>[<&color[#f2eae9]>G<&color[#c41b08]>i<&color[#f2eae9]>f<&color[#c41b08]>t<&color[#f2eae9]> <&color[#c41b08]>O<&color[#f2eae9]>p<&color[#c41b08]>e<&color[#f2eae9]>n<&color[#c41b08]>e<&color[#f2eae9]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_20b "<&e>[<&color[#f2eae9]>G<&color[#c41b08]>i<&color[#f2eae9]>f<&color[#c41b08]>t<&color[#f2eae9]> <&color[#c41b08]>O<&color[#f2eae9]>p<&color[#c41b08]>e<&color[#f2eae9]>n<&color[#c41b08]>e<&color[#f2eae9]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_21a "<&e>[<&color[#db0d4b]>P<&color[#d80d45]>r<&color[#d50d3f]>e<&color[#d20d39]>s<&color[#cf0d33]>e<&color[#c91029]>n<&color[#c41733]>t<&color[#bf1e3d]> <&color[#ba2547]>C<&color[#b52c51]>o<&color[#b0355e]>l<&color[#bd587a]>l<&color[#ca7b96]>e<&color[#d79eb2]>c<&color[#e4c1ce]>t<&color[#f2e6ea]>o<&color[#f2e6ea]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_21b "<&e>[<&color[#db0d4b]>P<&color[#d80d45]>r<&color[#d50d3f]>e<&color[#d20d39]>s<&color[#cf0d33]>e<&color[#c91029]>n<&color[#c41733]>t<&color[#bf1e3d]> <&color[#ba2547]>C<&color[#b52c51]>o<&color[#b0355e]>l<&color[#bd587a]>l<&color[#ca7b96]>e<&color[#d79eb2]>c<&color[#e4c1ce]>t<&color[#f2e6ea]>o<&color[#f2e6ea]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    - define xmas2020_22a "<&e>[<&color[#FF0A0A]>F<&color[#FF2828]>e<&color[#FF4747]>s<&color[#FF6565]>t<&color[#FF8484]>i<&color[#FFA3A3]>v<&color[#FFC1C1]>e <&color[#FFFFFF]>A<&color[#E6F6E2]>c<&color[#CDEDC6]>h<&color[#B4E5AA]>i<&color[#9BDC8E]>e<&color[#82D372]>v<&color[#69CB56]>e<&color[#50C23A]>r<&e>] <player.name> <&b>Jingled<&e> into the server"
    - define xmas2020_22b "<&e>[<&color[#FF0A0A]>F<&color[#FF2828]>e<&color[#FF4747]>s<&color[#FF6565]>t<&color[#FF8484]>i<&color[#FFA3A3]>v<&color[#FFC1C1]>e <&color[#FFFFFF]>A<&color[#E6F6E2]>c<&color[#CDEDC6]>h<&color[#B4E5AA]>i<&color[#9BDC8E]>e<&color[#82D372]>v<&color[#69CB56]>e<&color[#50C23A]>r<&e>] <player.name> <&b>Jingled<&e> out of the server"
    #Vday Advancements Prefixes
    - define vday2021_1a "<&e>[<&color[#DD17EE]>F<&color[#E214D4]>i<&color[#E712BA]>r<&color[#EC0FA0]>s<&color[#F20D86]>t <&color[#EC0FA0]>D<&color[#E712BA]>a<&color[#E214D4]>t<&color[#DD17EE]>e<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_1b "<&e>[<&color[#DD17EE]>F<&color[#E214D4]>i<&color[#E712BA]>r<&color[#EC0FA0]>s<&color[#F20D86]>t <&color[#EC0FA0]>D<&color[#E712BA]>a<&color[#E214D4]>t<&color[#DD17EE]>e<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_2a "<&e>[<&color[#CF1267]>L<&color[#CF1267]>o<&color[#CF1267]>v<&color[#CF1267]>e <&color[#CF1267]>B<&color[#CF1267]>i<&color[#CF1267]>r<&color[#CF1267]>d<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_2b "<&e>[<&color[#CF1267]>L<&color[#CF1267]>o<&color[#CF1267]>v<&color[#CF1267]>e <&color[#CF1267]>B<&color[#CF1267]>i<&color[#CF1267]>r<&color[#CF1267]>d<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_3a "<&e>[<&color[#CF0BF4]>D<&color[#AB0BEF]>r<&color[#870BEA]>e<&color[#630BE5]>a<&color[#5413D8]>m <&color[#630BE5]>B<&color[#870BEA]>o<&color[#AB0BEF]>a<&color[#CF0BF4]>t<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_3b "<&e>[<&color[#CF0BF4]>D<&color[#AB0BEF]>r<&color[#870BEA]>e<&color[#630BE5]>a<&color[#5413D8]>m <&color[#630BE5]>B<&color[#870BEA]>o<&color[#AB0BEF]>a<&color[#CF0BF4]>t<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_4a "<&e>[<&color[#C60101]>S<&color[#C5080E]>w<&color[#C5101B]>e<&color[#C51828]>e<&color[#C41F35]>t<&color[#C42743]>h<&color[#C42F50]>e<&color[#C3365D]>a<&color[#C33E6A]>r<&color[#C34678]>t<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_4b "<&e>[<&color[#C60101]>S<&color[#C5080E]>w<&color[#C5101B]>e<&color[#C51828]>e<&color[#C41F35]>t<&color[#C42743]>h<&color[#C42F50]>e<&color[#C3365D]>a<&color[#C33E6A]>r<&color[#C34678]>t<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_5a "<&e>[<&color[#E51C00]>S<&color[#E52C01]>m<&color[#E53D03]>o<&color[#E54E05]>o<&color[#E65E07]>t<&color[#E66F09]>h <&color[#E66F09]>T<&color[#E65E07]>a<&color[#E54E05]>l<&color[#E53D03]>k<&color[#E52C01]>e<&color[#E51C00]>r<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_5b "<&e>[<&color[#E51C00]>S<&color[#E52C01]>m<&color[#E53D03]>o<&color[#E54E05]>o<&color[#E65E07]>t<&color[#E66F09]>h <&color[#E66F09]>T<&color[#E65E07]>a<&color[#E54E05]>l<&color[#E53D03]>k<&color[#E52C01]>e<&color[#E51C00]>r<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_6a "<&e>[<&color[#E53200]>T<&color[#E32B16]>r<&color[#E1252C]>u<&color[#E01F43]>e <&color[#DE1959]>L<&color[#DD1370]>o<&color[#DB0D86]>v<&color[#DA079D]>e<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_6b "<&e>[<&color[#E53200]>T<&color[#E32B16]>r<&color[#E1252C]>u<&color[#E01F43]>e <&color[#DE1959]>L<&color[#DD1370]>o<&color[#DB0D86]>v<&color[#DA079D]>e<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_7a "<&e>[<&color[#8E00AD]>S<&color[#9603A6]>e<&color[#9E079F]>c<&color[#A60A98]>r<&color[#AE0E91]>e<&color[#B6128A]>t<&color[#BE1583]>l<&color[#C6197C]>y <&color[#CE1D75]>A<&color[#D6206E]>d<&color[#DE2467]>m<&color[#E62860]>i<&color[#EE2B59]>r<&color[#F62F52]>e<&color[#FF334B]>d<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_7b "<&e>[<&color[#8E00AD]>S<&color[#9603A6]>e<&color[#9E079F]>c<&color[#A60A98]>r<&color[#AE0E91]>e<&color[#B6128A]>t<&color[#BE1583]>l<&color[#C6197C]>y <&color[#CE1D75]>A<&color[#D6206E]>d<&color[#DE2467]>m<&color[#E62860]>i<&color[#EE2B59]>r<&color[#F62F52]>e<&color[#FF334B]>d<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_8a "<&e>[<&color[#DB76BE]>P<&color[#D56DAC]>o<&color[#D0659B]>p<&color[#CB5D8A]>u<&color[#C55478]>l<&color[#C04C67]>a<&color[#BB4456]>r <&color[#B53B44]>D<&color[#B03333]>a<&color[#AB2B22]>t<&color[#A62311]>e<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_8b "<&e>[<&color[#DB76BE]>P<&color[#D56DAC]>o<&color[#D0659B]>p<&color[#CB5D8A]>u<&color[#C55478]>l<&color[#C04C67]>a<&color[#BB4456]>r <&color[#B53B44]>D<&color[#B03333]>a<&color[#AB2B22]>t<&color[#A62311]>e<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_9a "<&e>[<&color[#DA079D]>M<&color[#DB0B8B]>a<&color[#DC107A]>d<&color[#DD1568]>l<&color[#DE1A57]>y <&color[#E01E45]>L<&color[#E12334]>o<&color[#E22822]>v<&color[#E32D11]>e<&color[#E53200]>d<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_9b "<&e>[<&color[#DA079D]>M<&color[#DB0B8B]>a<&color[#DC107A]>d<&color[#DD1568]>l<&color[#DE1A57]>y <&color[#E01E45]>L<&color[#E12334]>o<&color[#E22822]>v<&color[#E32D11]>e<&color[#E53200]>d<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_10a "<&e>[<&color[#e66efa]>L<&color[#d167e8]>o<&color[#bd60d6]>v<&color[#a958c3]>e<&color[#9751b1]>l<&color[#85499f]>y <&color[#73418d]>P<&color[#73418d]>o<&color[#73418d]>e<&color[#73418d]>t<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_10b "<&e>[<&color[#e66efa]>L<&color[#d167e8]>o<&color[#bd60d6]>v<&color[#a958c3]>e<&color[#9751b1]>l<&color[#85499f]>y <&color[#73418d]>P<&color[#73418d]>o<&color[#73418d]>e<&color[#73418d]>t<&e>] <player.name> <&d>Swooned<&e> out of the server"
    - define vday2021_11a "<&e>[<&color[#db3057]>H<&color[#d32760]>e<&color[#c92069]>r<&color[#be1c71]>o <&color[#b11d79]>o<&color[#a2207f]>f <&color[#cd34e3]>R<&color[#ba33d0]>h<&color[#a730bd]>y<&color[#952eaa]>m<&color[#832b97]>e<&e>] <player.name> <&d>Swooned<&e> into the server"
    - define vday2021_11b "<&e>[<&color[#db3057]>H<&color[#d32760]>e<&color[#c92069]>r<&color[#be1c71]>o <&color[#b11d79]>o<&color[#a2207f]>f <&color[#cd34e3]>R<&color[#ba33d0]>h<&color[#a730bd]>y<&color[#952eaa]>m<&color[#832b97]>e<&e>] <player.name> <&d>Swooned<&e> out of the server"
    #Easter 2021 prefixes
    - define easter2021_1a "<&e>[<&color[#f4978e]>Egg <&color[#e0aaff]>Hunter<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_1b "<&e>[<&color[#f4978e]>Egg <&color[#e0aaff]>Hunter<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_2a "<&e>[<&color[#8ac926]>Burrowing <&color[#aaf683]>Bunny<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_2b "<&e>[<&color[#8ac926]>Burrowing <&color[#aaf683]>Bunny<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_3a "<&e>[<&color[#ffee32]>Hard<&color[#c1ff9b]>-Boi<&color[#b4e1ff]>led <&color[#ab87ff]>Hatc<&color[#fface4]>hling<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_3b "<&e>[<&color[#ffee32]>Hard<&color[#c1ff9b]>-Boi<&color[#b4e1ff]>led <&color[#ab87ff]>Hatc<&color[#fface4]>hling<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_4a "<&e>[<&color[#deff0a]>Egg<&color[#a1ff0a]>cel<&color[#06d6a0]>lent <&color[#6fffe9]>See<&color[#7bdff2]>ker<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_4b "<&e>[<&color[#deff0a]>Egg<&color[#a1ff0a]>cel<&color[#06d6a0]>lent <&color[#6fffe9]>See<&color[#7bdff2]>ker<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_5a "<&e>[<&color[#AB87FF]>Eg<&color[#56B0FF]>gs<&color[#00D9FF]>tr<&color[#51E4BD]>em<&color[#A1EF7A]>e <&color[#A1EF7A]>E<&color[#D0F73D]>gg<&color[#FFFF00]>spl<&color[#FFCF00]>or<&color[#FF686B]>er<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_5b "<&e>[<&color[#AB87FF]>Eg<&color[#56B0FF]>gs<&color[#00D9FF]>tr<&color[#51E4BD]>em<&color[#A1EF7A]>e <&color[#A1EF7A]>E<&color[#D0F73D]>gg<&color[#FFFF00]>spl<&color[#FFCF00]>or<&color[#FF686B]>er<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_6a "<&e>[<&color[#8B8202]>Rotten <&color[#DECF01]>Egg<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_6b "<&e>[<&color[#8B8202]>Rotten <&color[#DECF01]>Egg<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_7a "<&e>[<&color[#C98601]>C<&color[#BA7D01]>h<&color[#AC7301]>o<&color[#956400]>c<&color[#895C02]>o<&color[#7F5501]>l<&color[#704C02]>a<&color[#5F4001]>t<&color[#513601]>e <&color[#6C5019]>B<&color[#7F6531]>u<&color[#9B8457]>n<&color[#B3A07A]>n<&color[#DCD4C3]>y<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_7b "<&e>[<&color[#C98601]>C<&color[#BA7D01]>h<&color[#AC7301]>o<&color[#956400]>c<&color[#895C02]>o<&color[#7F5501]>l<&color[#704C02]>a<&color[#5F4001]>t<&color[#513601]>e <&color[#6C5019]>B<&color[#7F6531]>u<&color[#9B8457]>n<&color[#B3A07A]>n<&color[#DCD4C3]>y<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_8a "<&e>[<&color[#dee2ff]>Ea<&color[#feeafa]>st<&color[#FFC2C3]>er <&color[#ddb892]>Bun<&color[#b08968]>ny<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_8b "<&e>[<&color[#dee2ff]>Ea<&color[#feeafa]>st<&color[#FFC2C3]>er <&color[#ddb892]>Bun<&color[#b08968]>ny<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    - define easter2021_9a "<&e>[<&color[#FFFCC6]>E <&color[#FFF561]>G <&color[#FFF00E]>G<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> into the server"
    - define easter2021_9b "<&e>[<&color[#FFFCC6]>E <&color[#FFF561]>G <&color[#FFF00E]>G<&e>] <player.name> <&color[#ffca3a]>Hopped<&e> out of the server"
    #Summer 2021 prefixes
    - define summer2021_1a "<&e>[<&color[#143af1]>W<&color[#005aff]>a<&color[#0072ff]>v<&color[#0087ff]>e<&sp><&color[#009aff]>C<&color[#00abff]>a<&color[#00bcff]>t<&color[#00ccff]>c<&color[#00daff]>h<&color[#00e9ff]>e<&color[#4ff6ff]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_1b "<&e>[<&color[#143af1]>W<&color[#005aff]>a<&color[#0072ff]>v<&color[#0087ff]>e<&sp><&color[#009aff]>C<&color[#00abff]>a<&color[#00bcff]>t<&color[#00ccff]>c<&color[#00daff]>h<&color[#00e9ff]>e<&color[#4ff6ff]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_2a "<&e>[<&color[#acfc00]>M<&color[#dafc00]>a<&color[#fceb00]>n<&color[#fcb900]>g<&color[#fc7e00]>o<&sp><&color[#ff0606]>M<&color[#acfc00]>u<&color[#dafc00]>n<&color[#fceb00]>c<&color[#fcb900]>h<&color[#fc7e00]>e<&color[#ff0606]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_2b "<&e>[<&color[#acfc00]>M<&color[#dafc00]>a<&color[#fceb00]>n<&color[#fcb900]>g<&color[#fc7e00]>o<&sp><&color[#ff0606]>M<&color[#acfc00]>u<&color[#dafc00]>n<&color[#fceb00]>c<&color[#fcb900]>h<&color[#fc7e00]>e<&color[#ff0606]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_3a "<&e>[<&color[#ff8360]>T<&color[#e8e288]>r<&color[#7dce82]>o<&color[#3cdbd3]>p<&color[#00fff5]>i<&color[#ff8360]>c<&color[#e8e288]>a<&color[#7dce82]>l<&sp><&color[#ffd700]>T<&color[#f4cf10]>r<&color[#e8c819]>e<&color[#dec020]>a<&color[#d3b925]>s<&color[#c8b129]>u<&color[#beaa2c]>r<&color[#b4a22f]>e<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_3b "<&e>[<&color[#ff8360]>T<&color[#e8e288]>r<&color[#7dce82]>o<&color[#3cdbd3]>p<&color[#00fff5]>i<&color[#ff8360]>c<&color[#e8e288]>a<&color[#7dce82]>l<&sp><&color[#ffd700]>T<&color[#f4cf10]>r<&color[#e8c819]>e<&color[#dec020]>a<&color[#d3b925]>s<&color[#c8b129]>u<&color[#beaa2c]>r<&color[#b4a22f]>e<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_4a "<&e>[<&color[#ed47e4]>S<&color[#ee38d0]>e<&color[#ec29bc]>a<&color[#e917a9]>s<&color[#e50096]>h<&color[#df0084]>e<&color[#d70073]>l<&color[#cf0063]>l<&sp><&color[#c60054]>S<&color[#bc0046]>k<&color[#b10038]>i<&color[#a6002c]>m<&color[#9b0020]>m<&color[#8f0015]>e<&color[#830009]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_4b "<&e>[<&color[#ed47e4]>S<&color[#ee38d0]>e<&color[#ec29bc]>a<&color[#e917a9]>s<&color[#e50096]>h<&color[#df0084]>e<&color[#d70073]>l<&color[#cf0063]>l<&sp><&color[#c60054]>S<&color[#bc0046]>k<&color[#b10038]>i<&color[#a6002c]>m<&color[#9b0020]>m<&color[#8f0015]>e<&color[#830009]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_5a "<&e>[<&color[#ec2323]>P<&color[#df2525]>i<&color[#d22627]>l<&color[#c62728]>l<&color[#b92829]>a<&color[#ac292a]>g<&color[#9f2a2a]>i<&color[#932a2a]>n<&color[#862a2a]>g<&sp><&color[#424040]>P<&color[#424040]>i<&color[#ded7d7]>r<&color[#ded7d7]>a<&color[#424040]>t<&color[#424040]>e<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_5b "<&e>[<&color[#ec2323]>P<&color[#df2525]>i<&color[#d22627]>l<&color[#c62728]>l<&color[#b92829]>a<&color[#ac292a]>g<&color[#9f2a2a]>i<&color[#932a2a]>n<&color[#862a2a]>g<&sp><&color[#424040]>P<&color[#424040]>i<&color[#ded7d7]>r<&color[#ded7d7]>a<&color[#424040]>t<&color[#424040]>e<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_6a "<&e>[<&color[#1f68eb]>D<&color[#2261e0]>e<&color[#2359d5]>e<&color[#2452ca]>p<&sp><&color[#2344b5]>S<&color[#223dab]>e<&color[#2136a0]>a<&sp><&color[#1f2f96]>D<&color[#1d288c]>i<&color[#1a2282]>v<&color[#171b78]>e<&color[#171b78]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_6b "<&e>[<&color[#1f68eb]>D<&color[#2261e0]>e<&color[#2359d5]>e<&color[#2452ca]>p<&sp><&color[#2344b5]>S<&color[#223dab]>e<&color[#2136a0]>a<&sp><&color[#1f2f96]>D<&color[#1d288c]>i<&color[#1a2282]>v<&color[#171b78]>e<&color[#171b78]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_7a "<&e>[<&color[#388ead]>S<&color[#309eb0]>m<&color[#3eadac]>a<&color[#5bbba4]>l<&color[#7ec79a]>l<&sp><&color[#FFCF5D]>F<&color[#FFCF5D]>r<&color[#FFCF5D]>y<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_7b "<&e>[<&color[#388ead]>S<&color[#309eb0]>m<&color[#3eadac]>a<&color[#5bbba4]>l<&color[#7ec79a]>l<&sp><&color[#FFCF5D]>F<&color[#FFCF5D]>r<&color[#FFCF5D]>y<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_8a "<&e>[<&color[#bbd2e2]>H<&color[#9aa2bf]>e<&color[#5e7990]>r<&color[#5d4e6e]>m<&color[#7eb1b4]>i<&color[#c7ebea]>t<&sp><&color[#f4bab2]>C<&color[#f4bab2]>r<&color[#f4bab2]>a<&color[#f4bab2]>b<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_8b "<&e>[<&color[#bbd2e2]>H<&color[#9aa2bf]>e<&color[#5e7990]>r<&color[#5d4e6e]>m<&color[#7eb1b4]>i<&color[#c7ebea]>t<&sp><&color[#f4bab2]>C<&color[#f4bab2]>r<&color[#f4bab2]>a<&color[#f4bab2]>b<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    - define summer2021_9a "<&e>[<&color[#f4d629]>S<&color[#f4d12a]>a<&color[#f3cd2c]>n<&color[#f2c82d]>d<&sp><&color[#f1c42f]>C<&color[#f0c030]>a<&color[#efbb32]>s<&color[#eeb733]>t<&color[#ecb335]>l<&color[#ebaf36]>e<&sp><&color[#e9aa38]>S<&color[#e7a639]>m<&color[#e5a23b]>a<&color[#e39e3c]>s<&color[#e09b3e]>h<&color[#de973f]>e<&color[#db9340]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed into the server"
    - define summer2021_9b "<&e>[<&color[#f4d629]>S<&color[#f4d12a]>a<&color[#f3cd2c]>n<&color[#f2c82d]>d<&sp><&color[#f1c42f]>C<&color[#f0c030]>a<&color[#efbb32]>s<&color[#eeb733]>t<&color[#ecb335]>l<&color[#ebaf36]>e<&sp><&color[#e9aa38]>S<&color[#e7a639]>m<&color[#e5a23b]>a<&color[#e39e3c]>s<&color[#e09b3e]>h<&color[#de973f]>e<&color[#db9340]>r<&e>] <player.name> <&color[#4ff6ff]>Splashed out of the server"
    # hallow2021_prefixes
    - define hallow2021_1a a
    - define hallow2021_1b a

# fix_easter:
#   type: task
#   debug: false
#   script:
#     - foreach <server.players_flagged[easterpref_1]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Egg<&sp>Hunter]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_1a "<&e>[<&color[#f4978e]>Egg <&color[#e0aaff]>Hunter<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_1b "<&e>[<&color[#f4978e]>Egg <&color[#e0aaff]>Hunter<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_1a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_1b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_2]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Burrowing<&sp>Bunny]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_2a "<&e>[<&color[#8ac926]>Burrowing <&color[#aaf683]>Bunny<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_2b "<&e>[<&color[#8ac926]>Burrowing <&color[#aaf683]>Bunny<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_2a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_2b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_3]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Hard-Boiled<&sp>Hatchling]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_3a "<&e>[<&color[#ffee32]>Hard<&color[#c1ff9b]>-Boi<&color[#b4e1ff]>led <&color[#ab87ff]>Hatc<&color[#fface4]>hling<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_3b "<&e>[<&color[#ffee32]>Hard<&color[#c1ff9b]>-Boi<&color[#b4e1ff]>led <&color[#ab87ff]>Hatc<&color[#fface4]>hling<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_3a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_3b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_4]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Eggcellent<&sp>Seeker]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_4a "<&e>[<&color[#deff0a]>Egg<&color[#a1ff0a]>cel<&color[#06d6a0]>lent <&color[#6fffe9]>See<&color[#7bdff2]>ker<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_4b "<&e>[<&color[#deff0a]>Egg<&color[#a1ff0a]>cel<&color[#06d6a0]>lent <&color[#6fffe9]>See<&color[#7bdff2]>ker<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_4a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_4b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_5]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Eggstreme<&sp>Eggsplorer]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_5a "<&e>[<&color[#AB87FF]>Eg<&color[#56B0FF]>gs<&color[#00D9FF]>tr<&color[#51E4BD]>em<&color[#A1EF7A]>e <&color[#A1EF7A]>E<&color[#D0F73D]>gg<&color[#FFFF00]>spl<&color[#FFCF00]>or<&color[#FF686B]>er<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_5b "<&e>[<&color[#AB87FF]>Eg<&color[#56B0FF]>gs<&color[#00D9FF]>tr<&color[#51E4BD]>em<&color[#A1EF7A]>e <&color[#A1EF7A]>E<&color[#D0F73D]>gg<&color[#FFFF00]>spl<&color[#FFCF00]>or<&color[#FF686B]>er<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_5a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_5b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_6]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Rotten<&sp>Egg]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_6a "<&e>[<&color[#8B8202]>Rotten <&color[#DECF01]>Egg<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_6b "<&e>[<&color[#8B8202]>Rotten <&color[#DECF01]>Egg<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_6a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_6b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_7]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Chocolate<&sp>Bunny]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_7a "<&e>[<&color[#C98601]>C<&color[#BA7D01]>h<&color[#AC7301]>o<&color[#956400]>c<&color[#895C02]>o<&color[#7F5501]>l<&color[#704C02]>a<&color[#5F4001]>t<&color[#513601]>e <&color[#6C5019]>B<&color[#7F6531]>u<&color[#9B8457]>n<&color[#B3A07A]>n<&color[#DCD4C3]>y<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_7b "<&e>[<&color[#C98601]>C<&color[#BA7D01]>h<&color[#AC7301]>o<&color[#956400]>c<&color[#895C02]>o<&color[#7F5501]>l<&color[#704C02]>a<&color[#5F4001]>t<&color[#513601]>e <&color[#6C5019]>B<&color[#7F6531]>u<&color[#9B8457]>n<&color[#B3A07A]>n<&color[#DCD4C3]>y<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_7a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_7b]>
#       - wait 1t
#     - foreach <server.players_flagged[easterpref_8]>:
#       - foreach <[value].flag[e_prefixes].filter[strip_color.contains_any_text[Easter<&sp>Bunny]]> as:pref:
#         - flag <[value]> e_prefixes:<-:<[pref]>
#       - define easter2021_8a "<&e>[<&color[#dee2ff]>Ea<&color[#feeafa]>st<&color[#FFC2C3]>er <&color[#ddb892]>Bun<&color[#b08968]>ny<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> into the server"
#       - define easter2021_8b "<&e>[<&color[#dee2ff]>Ea<&color[#feeafa]>st<&color[#FFC2C3]>er <&color[#ddb892]>Bun<&color[#b08968]>ny<&e>] <[value].name> <&color[#ffca3a]>Hopped<&e> out of the server"
#       - flag <[value]> e_prefixes:->:<[easter2021_8a]>
#       - flag <[value]> e_prefixes:->:<[easter2021_8b]>
#       - wait 1t

ea_items_world:
  type: world
  debug: false
  events:
    on player clicks block:
    - if <context.item.script.name.contains_any_text[ea_pref_i_]||false>:
      - ratelimit <player> 5t
      - define num <context.item.script.name.after[ea_pref_i_]>
      - if <player.has_flag[easterpref_<[num]>]>:
        - narrate "You already have this prefix." format:zc_text
        - narrate "Not showing up on /prefix set? try and do /prefix update" format:zc_text
        - stop
      - flag player easterpref_<[num]>
      - narrate "You got the prefix <context.item.lore.first>" format:zc_text
      - narrate "Do /prefix update so it shows up in /prefix set!" format:zc_text
      - take item:<context.item.script.name>

su_items_world:
  type: world
  debug: false
  events:
    on player clicks block:
    - if <context.item.script.name.contains_any_text[su_pref_i_]||false>:
      - ratelimit <player> 5t
      - define num <context.item.script.name.after[su_pref_i_]>
      - if <player.has_flag[summerpref_<[num]>]>:
        - narrate "You already have this prefix." format:zc_text
        - narrate "Not showing up on /prefix set? try and do /prefix update" format:zc_text
        - stop
      - flag player summerpref_<[num]>
      - narrate "You got the prefix <context.item.lore.first>" format:zc_text
      - narrate "Do /prefix update so it shows up in /prefix set!" format:zc_text
      - take item:<context.item.script.name>
