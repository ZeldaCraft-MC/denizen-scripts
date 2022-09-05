#------------------------------------------------------#
# The different commands so it overwrites any exsisting ones.
# also the /moderate command which will probably not serve any purpose
#------------------------------------------------------#
zc_moderate_cmd:
  type: command
  debug: false
  name: moderate
  usage: /moderate (player name)
  description: opens the moderate gui
  permission: zc.mod
  script:
    - define player <server.match_offline_player[<context.args.first||fkhdksahfkdsahf>]||noone>
    - if <[player]> == noone:
      - narrate "Cannot find <context.args.first||<empty>> Did you write the name correctly?"
      - stop
    - if <[player].has_permission[op]>:
      - narrate "You cannot moderate an OP"
      - stop
    - if <[player].name> == blueleeuw || <[player].name> == yellowleeuw || <[player].name> == pinkleeuw || <[player].name> == Zeldacraft:
      - narrate "I said TRY ME" format:zc_temp_text
      - stop
    - inventory open d:wban_gui

zc_tempban_cmd:
  type: command
  debug: false
  name: tempban
  usage: /tempban (player name)
  description: opens the tempban gui
  aliases:
  - tempbanip
  permission: zc.mod
  script:
    - define player <server.match_offline_player[<context.args.first||fdhkjfslhakjfhdsa>]||noone>
    - define method Tempban
    - if <[player]> == noone:
      - if <context.alias> == tempbanip:
        - define ip <context.args.first.replace[.].with[-]>
        - if !<server.flag[ip_addresses].keys.contains[<[ip]>]>:
          - narrate "Cannot find <context.args.first||empty> Make sure it is a valid name or ip address"
          - stop
        - define player <server.flag[ip_addresses].get[<[ip]>].first>
      - else:
        - narrate "Cannot find <context.args.first||empty> Did you write the name correctly?" format:zc_temp_text
        - stop
    - if <[player].has_permission[op]>:
      - narrate "You cannot tempban an OP" format:zc_temp_text
      - stop
    - if <[player].name> == blueleeuw || <[player].name> == yellowleeuw || <[player].name> == pinkleeuw || <[player].name> == Zeldacraft:
      - narrate "I said TRY ME" format:zc_temp_text
      - stop
    - define other_players <list[]>
    - foreach <[player].flag[ip_addresses].keys> as:ip:
      - if <server.has_flag[ip_addresses.<[ip]>]>:
        - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
          - flag <[player]> ip_addresses.<[ip]>:!
          - foreach next
        - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
    - define other_players <[other_players].deduplicate.replace[<[player]>].parse_tag[<&3><[parse_value].name>].alphanumeric||list[]>
    - define is_perm false
    - inventory open d:tempban_gui
    - if <context.alias> == tempbanip:
      - wait 4t
      - inventory adjust slot:27 enchantments:lure,1 d:<player.open_inventory>
      - inventory adjust slot:27 hides:enchants d:<player.open_inventory>
      - inventory flag slot:27 ip_selected d:<player.open_inventory>

zc_ban_cmd:
  type: command
  debug: false
  name: ban
  usage: /ban (player name)
  description: opens the ban gui
  permission: zc.mod
  aliases:
  - ban_zc
  - banip
  - ban-ip
  script:
    - define player <server.match_offline_player[<context.args.first||fhsdkhalkfhsdakljhfklsdajhfkl>]||noone>
    - define method Ban
    - if <[player]> == noone:
      - if <context.alias> == banip || <context.alias> == ban-ip:
        - define ip <context.args.first.replace[.].with[-]||<empty>>
        - if !<server.flag[ip_addresses].keys.contains[<[ip]>]>:
          - narrate "Cannot find <context.args.first||<empty>> Make sure it is a valid name or ip address"
          - stop
        - define player <server.flag[ip_addresses].get[<[ip]>].first>
      - else:
        - narrate "Cannot find <context.args.first||<empty>> Did you write the name correctly?" format:zc_temp_text
        - stop
    - if <[player].has_permission[op]>:
      - narrate "You cannot permban an OP" format:zc_perm_text
      - stop
    - if <[player].name> == blueleeuw || <[player].name> == yellowleeuw || <[player].name> == pinkleeuw || <[player].name> == Zeldacraft:
      - narrate "I said TRY ME" format:zc_temp_text
      - stop
    - define other_players <list[]>
    - foreach <[player].flag[ip_addresses].keys> as:ip:
      - if <server.has_flag[ip_addresses.<[ip]>]>:
        - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
          - flag <[player]> ip_addresses.<[ip]>:!
          - foreach next
        - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
    - define other_players <[other_players].deduplicate.replace[<[player]>].parse_tag[<&c><[parse_value].name>].alphanumeric||list[]>
    - define is_perm true
    - inventory open d:ban_gui
    - if <context.alias> == banip || <context.alias> == ban-ip:
      - wait 4t
      - inventory adjust slot:18 enchantments:lure,1 d:<player.open_inventory>
      - inventory adjust slot:18 hides:enchants d:<player.open_inventory>
      - inventory flag slot:18 ip_selected d:<player.open_inventory>

zc_warn_cmd:
  type: command
  debug: false
  name: warn
  usage: /warn (player name)
  description: opens the warn gui
  permission: zc.mod
  script:
    - define player <server.match_offline_player[<context.args.first||fdjl;fjsdlkfjds>]||noone>
    - define method Warn
    - if <[player]> == noone:
      - narrate "Cannot find <context.args.first||empty> Did you write the name correctly?" format:zc_warn_text
      - stop
    - if <[player].has_permission[op]>:
      - narrate "You cannot warn an OP" format:zc_warn_text
      - stop
    - if <player.name> != greenleeuw:
      - if <[player].name> == blueleeuw || <[player].name> == yellowleeuw || <[player].name> == pinkleeuw || <[player].name> == Zeldacraft:
        - narrate "I said TRY ME" format:zc_temp_text
        - stop
    - inventory open d:warn_gui

#------------------------------------------------------#
# Here are all the events we need to check while we use
# this new ban system
#------------------------------------------------------#
warn_world:
  type: world
  debug: false
  events:
    on player signs book:
    - if !<context.book.script.name.exists>:
      - stop

    #----------------------------------------------------#
    # when the player signs a warn book
    #----------------------------------------------------#
    - if <context.book.script.name> == warn_book:
      - if !<player.has_permission[zc.mod]>:
        - narrate "You do not have permission to submit a warning"
        - determine passively not_signing
        - take scriptname:warn_book
        - stop
      - determine passively not_signing
      - wait 1t
      - if <context.book.book_pages.is_empty||false>:
        - stop
      - define player <player.flag[writing.warn]>
      - flag player writing.warn:!
      - define message <context.book.book_pages.separated_by[<&nl>].strip_color>
      - define method Warn
      - take scriptname:warn_book
      - inventory open d:warn_gui
      - inventory adjust slot:9 enchantments:lure,1 d:<player.open_inventory>
      - inventory adjust slot:9 hides:enchants d:<player.open_inventory>
      - inventory adjust slot:9 "lore:<&f>Give <[player].name> a warning for<&nl><&6><[message]>" d:<player.open_inventory>
      - inventory flag slot:9 selected d:<player.open_inventory>
      - inventory flag slot:9 message:<[message]> d:<player.open_inventory>

    #-----------------------------------------------------#
    # when the player signs the ban book
    #-----------------------------------------------------#
    - if <context.book.script.name> == ban_book:
      - if !<player.has_permission[zc.mod]>:
        - narrate "You do not have permission to submit a ban"
        - determine passively not_signing
        - take scriptname:warn_book
        - stop
      - determine passively not_signing
      - wait 1t
      - if <context.book.book_pages.is_empty||false>:
        - stop
      - define player <player.flag[writing.ban]>
      - flag player writing.ban:!
      - define message <context.book.book_pages.separated_by[<&nl>].strip_color>
      - define method ban
      - define other_players <list[]>
      - foreach <[player].flag[ip_addresses].keys> as:ip:
        - if <server.has_flag[ip_addresses.<[ip]>]>:
          - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
            - flag <[player]> ip_addresses.<[ip]>:!
            - foreach next
          - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
      - define other_players <[other_players].deduplicate.replace[<[player]>].parse_tag[<&c><[parse_value].name>].alphanumeric||list[]>
      - define is_perm true
      - take scriptname:ban_book
      - inventory open d:ban_gui
      - define item_slot <player.open_inventory.find_item[ban_i_9]>
      - inventory adjust slot:<[item_slot]> enchantments:lure,1 d:<player.open_inventory>
      - inventory adjust slot:<[item_slot]> hides:enchants d:<player.open_inventory>
      - inventory adjust slot:<[item_slot]> "lore:<&f>Permban <[player].name> for<&nl><&4><[message]>" d:<player.open_inventory>
      - inventory flag slot:<[item_slot]> selected d:<player.open_inventory>
      - inventory flag slot:<[item_slot]> message:<[message]> d:<player.open_inventory>

    #-----------------------------------------------------#
    # when the player signs the tempban book
    #-----------------------------------------------------#
    - if <context.book.script.name> == tempban_book:
      - if !<player.has_permission[zc.mod]>:
        - narrate "You do not have permission to submit a tempban"
        - determine passively not_signing
        - take scriptname:warn_book
        - stop
      - determine passively not_signing
      - wait 1t
      - if <context.book.book_pages.is_empty||false>:
        - stop
      - define player <player.flag[writing.tempban.player]>
      - define method Tempban
      - define message <context.book.book_pages.separated_by[<&nl>].strip_color>
      - define other_players <list[]>
      - foreach <[player].flag[ip_addresses].keys> as:ip:
        - if <server.has_flag[ip_addresses.<[ip]>]>:
          - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
            - flag <[player]> ip_addresses.<[ip]>:!
            - foreach next
          - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
      - define other_players <[other_players].deduplicate.replace[<[player]>].parse_tag[<&3><[parse_value].name>].alphanumeric||list[]>
      - define is_perm false
      - inventory open d:tempban_gui
      - wait 1t
      - define item_slot <player.open_inventory.find_item[tempban_i_9]>
      - inventory adjust slot:<[item_slot]> enchantments:lure,1 d:<player.open_inventory>
      - inventory adjust slot:<[item_slot]> hides:enchants d:<player.open_inventory>
      - inventory adjust slot:<[item_slot]> "lore:<&f>Tempban <[player].name> for<&nl><&1><[message]>" d:<player.open_inventory>
      - inventory flag slot:<[item_slot]> selected d:<player.open_inventory>
      - inventory flag slot:<[item_slot]> message:<[message]> d:<player.open_inventory>

      #------------------------------------------------------#
      # check if there was already a time selected
      #------------------------------------------------------#
      - if <player.has_flag[writing.tempban.time]>:
        - define item_slot <player.open_inventory.find_item[<player.flag[writing.tempban.time]>]>
        - inventory adjust slot:<[item_slot]> enchantments:lure,1 d:<player.open_inventory>
        - inventory adjust slot:<[item_slot]> hides:enchants d:<player.open_inventory>
        - inventory flag slot:<[item_slot]> time_selected d:<player.open_inventory>
        - if <player.flag[writing.tempban.time]> == time_i_9:
          - inventory adjust slot:<[item_slot]> "lore:<&f>Tempban <[player].name> for<&nl><&3><player.flag[writing.tempban.time_date]><&nl><&3>Until: <util.time_now.add[<player.flag[writing.tempban.time_amount]>].format>" d:<player.open_inventory>
          - inventory flag slot:<[item_slot]> time:<player.flag[writing.tempban.time_amount]> d:<player.open_inventory>
      - flag player writing.tempban:!
      - take scriptname:tempban_book

    #----------------------------------------#
    # ban gui interactions
    #----------------------------------------#
    on player clicks in ban_gui:
    - determine passively cancelled
    - define player <context.item.flag[player]||null>
    - define message <context.item.flag[message]||no_message>
    - define time_now <util.time_now>
    - choose <context.item.script.name||none>:
      - case none:
        - stop
      - case cancel_i:
        - inventory close
      - case confirm_i:
        - if !<player.has_permission[zc.mod]>:
          - narrate "You do not have permission to submit a ban"
          - inventory close
          - stop
        - if !<player.open_inventory.contains_item[item_flagged:selected]>:
          - narrate "You need to select a reason to ban this person" format:zc_perm_text
          - stop
        - define message <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first.flag[message]>
        - define num <[player].flag[moderate.permban].size.add[1]||1>
        - if <player.open_inventory.contains_item[item_flagged:ip_selected]>:
          - define other_players <list[]>
          - foreach <[player].flag[ip_addresses].keys> as:ip:
            - if <server.has_flag[ip_addresses.<[ip]>]>:
              - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
                - flag <[player]> ip_addresses.<[ip]>:!
                - foreach next
              - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
          - define other_players <[other_players].deduplicate||list[]>
          - foreach <[other_players]> as:players:
            - define num <[players].flag[moderate.permban].size.add[1]||1>
            - flag <[players]> moderate.permban.<[num]>.by_player:<player>
            - flag <[players]> moderate.permban.<[num]>.reason:<[message]>
            - flag <[players]> moderate.permban.<[num]>.time_now:<[time_now]>
            - flag <[players]> moderate.permban.<[num]>.was_ip:true
            - flag <[players]> moderate.permban.<[num]>.ip_person:<[player]>
          - ban addresses:<[player].flag[ip_addresses].keys.replace_text[-].with[.]> reason:<[message]> source:<player.name>
          - ban <[other_players]> reason:<[message]> source:<player.name>
          - if <player.is_online>:
            - inventory close
            - define has_perm <[player].has_flag[moderate.permban]>
            - define has_temp <[player].has_flag[moderate.tempban]>
            - define has_warn <[player].has_flag[moderate.warnings]>
            - narrate "<&4>Permban From <&c><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>
            - narrate "<&4>Permban <&c>recorded:<&nl>"
            - narrate "<&c>Players: <&f><[player].flag[ip_addresses].keys.separated_by[<&sp>].replace[-].with[.].on_hover[<[players].parse[name].separated_by[<&nl>]>]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&c>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&c>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&c><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name> has permbanned <[player].name>].add_field[Permban Reason:].value[<[message]>].add_field[Time of permban:].value[<[time_now].format>].add_inline_field[Ip permban].value[true].add_field[Other known players on that ip:].value[- <[other_players].replace[<[player]>].parse[name].separated_by[<&nl>- ]>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[<player.name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[timestamp].as[<util.time_now>]>"
        - else:
          - flag <[player]> moderate.permban.<[num]>.by_player:<player>
          - flag <[player]> moderate.permban.<[num]>.reason:<[message]>
          - flag <[player]> moderate.permban.<[num]>.time_now:<[time_now]>
          - flag <[player]> moderate.permban.<[num]>.was_ip:false
          - ban <[player]> reason:<[message]> source:<player.name>
          - inventory close
          - define has_perm <[player].has_flag[moderate.permban]>
          - define has_temp <[player].has_flag[moderate.tempban]>
          - define has_warn <[player].has_flag[moderate.warnings]>
          - narrate "<&4>Permban From <&c><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>
          - narrate "<&4>Permban <&c>recorded:<&nl>"
          - narrate "<&c>Player: <&f><[player].name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&c>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&c>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&c><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name> has permbanned <[player].name>].add_field[Permban Reason:].value[<[message]>].add_inline_field[Time of permpban:].value[<[time_now].format>].add_field[Ip tempban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[<player.name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[timestamp].as[<util.time_now>]>"
      - case ip_ban_i:
        - if <context.item.has_flag[ip_selected]>:
          - inventory flag slot:<context.slot> ip_selected:! d:<player.open_inventory>
          - inventory adjust slot:<context.slot> remove_enchantments d:<player.open_inventory>
        - else:
          - inventory adjust slot:<context.slot> enchantments:lure,1 d:<player.open_inventory>
          - inventory adjust slot:<context.slot> hides:enchants d:<player.open_inventory>
          - inventory flag slot:<context.slot> ip_selected d:<player.open_inventory>
      - default:
        - if <context.item.script.name.contains_all_text[ban_i_]||false>:
          - if <context.item.script.name> == ban_i_9:
            - if <[message]> == no_message:
              - inventory close
              - narrate "Here is a book write your message in here then sign it"
              - flag player writing.ban:<[player]>
              - give ban_book
              - stop
            - if !<context.item.has_flag[selected]>:
              - if <player.open_inventory.contains_item[item_flagged:selected]>:
                - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first>
                - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
                - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
                - inventory flag slot:<[old_slot]> selected:! d:<player.open_inventory>
              - inject highlight_reason_task
              - stop
          - else:
            - if <player.open_inventory.contains_item[item_flagged:selected]>:
              - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first>
              - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
              - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
              - inventory flag slot:<[old_slot]> selected:! d:<player.open_inventory>
            - inject highlight_reason_task

    #----------------------------------------#
    # tempban gui interactions
    #----------------------------------------#
    on player clicks in tempban_gui:
    - determine passively cancelled
    - define player <context.item.flag[player]||null>
    - define message <context.item.flag[message]||no_message>
    - define time <context.item.flag[time]||no_time>
    - define time_now <util.time_now>
    - choose <context.item.script.name||none>:
      - case none:
        - stop
      - case cancel_i:
        - inventory close
      - case confirm_i:
        - if !<player.has_permission[zc.mod]>:
          - narrate "You do not have permission to submit a tempban"
          - inventory close
          - stop
        - if !<player.open_inventory.contains_item[item_flagged:selected]> || !<player.open_inventory.contains_item[item_flagged:time_selected]>:
          - narrate "You need to select both a time and a reason to tempban <[player].name>" format:zc_temp_text
          - stop
        - define message <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first.flag[message]>
        - define time <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[time_selected]>].first.flag[time]>
        - define num <[player].flag[moderate.tempban].size.add[1]||1>

        #------------------------------------------------------#
        # Check if it was an ip ban or not
        # if it was do the same punishment to all known accounts
        #------------------------------------------------------#
        - if <player.open_inventory.contains_item[item_flagged:ip_selected]>:
          - define other_players <list[]>
          - foreach <[player].flag[ip_addresses].keys> as:ip:
            - if <server.has_flag[ip_addresses.<[ip]>]>:
              - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
                - flag <[player]> ip_addresses.<[ip]>:!
                - foreach next
              - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
          - define other_players <[other_players].deduplicate||list[]>
          - foreach <[other_players]> as:players:
            - define num <[players].flag[moderate.tempban].size.add[1]||1>
            - flag <[players]> moderate.tempban.<[num]>.by_player:<player>
            - flag <[players]> moderate.tempban.<[num]>.reason:<[message]>
            - flag <[players]> moderate.tempban.<[num]>.time_till:<[time]>
            - flag <[players]> moderate.tempban.<[num]>.time_now:<[time_now]>
            - flag <[players]> moderate.tempban.<[num]>.was_ip:true
            - flag <[players]> moderate.tempban.<[num]>.ip_person:<[player]>

          #------------------------------------------------------#
          # banning just their address doesn't kick them.
          # and it also doesn't show the custom ban message when they log in
          # so i just went with the good ol multiple bans
          #------------------------------------------------------#
          - ban addresses:<[player].flag[ip_addresses]> reason:<[message]> duration:<[time]> source:<player.name>
          - ban <[other_players]> reason:<[message]> duration:<[time]> source:<player.name>
          - if <player.is_online>:
            - inventory close
            - define has_perm <[player].has_flag[moderate.permban]>
            - define has_temp <[player].has_flag[moderate.tempban]>
            - define has_warn <[player].has_flag[moderate.warnings]>
            - narrate "<&4>Tempban From <&3><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>
            - narrate "<&1>Tempban <&3>recorded:<&nl>"
            - narrate "<&3>Players: <&f><[player].flag[ip_addresses].keys.separated_by[<&sp>].replace[-].with[.].on_hover[<[players].parse[name].separated_by[<&nl>]>]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&3>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&3>Until: <&f><[time_now].add[<[time]>].format> (<[time].as[duration].formatted>)" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&3>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<&3><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
            - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name> has tempbanned <[player].name>].add_field[Tempban Reason:].value[<[message]>].add_inline_field[Time of tempban:].value[<util.time_now.format>].add_inline_field[Tempban until:].value[<util.time_now.add[<[time]>].format> (<duration[<[time]>].formatted>)].add_field[Ip tempban].value[true].add_field[Other known players on that ip:].value[- <[other_players].replace[<[player]>].parse[name].separated_by[<&nl>- ]>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[<player.name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[timestamp].as[<util.time_now>]>"

        #------------------------------------------------------#
        # if it isn't an ip ban it just does this
        #------------------------------------------------------#
        - else:
          - flag <[player]> moderate.tempban.<[num]>.by_player:<player>
          - flag <[player]> moderate.tempban.<[num]>.reason:<[message]>
          - flag <[player]> moderate.tempban.<[num]>.time_till:<[time]>
          - flag <[player]> moderate.tempban.<[num]>.time_now:<[time_now]>
          - flag <[player]> moderate.tempban.<[num]>.was_ip:false
          - ban <[player]> reason:<[message]> duration:<[time]> source:<player.name>
          - inventory close
          - define has_perm <[player].has_flag[moderate.permban]>
          - define has_temp <[player].has_flag[moderate.tempban]>
          - define has_warn <[player].has_flag[moderate.warnings]>
          - narrate "<&1>Tempban From <&3><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>
          - narrate "<&1>Tempban <&3>recorded:<&nl>"
          - narrate "<&3>Player: <&f><[player].name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&3>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&3>Until: <&f><[time_now].add[<[time]>].format> (<[time].as[duration].formatted>)" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&3>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<&3><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name> has tempbanned <[player].name>].add_field[Tempban Reason:].value[<[message]>].add_inline_field[Time of tempban:].value[<util.time_now.format>].add_inline_field[Tempban until:].value[<util.time_now.add[<[time]>].format> (<duration[<[time]>].formatted>)].add_field[Ip tempban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[red].with[footer].as[<player.name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[timestamp].as[<util.time_now>]>"

      #------------------------------------------------------#
      # checking if the item clicked is the ip ban one
      #------------------------------------------------------#
      - case ip_ban_i:
        - if <context.item.has_flag[ip_selected]>:
          - inventory flag slot:<context.slot> ip_selected:! d:<player.open_inventory>
          - inventory adjust slot:<context.slot> remove_enchantments d:<player.open_inventory>
        - else:
          - inventory adjust slot:<context.slot> enchantments:lure,1 d:<player.open_inventory>
          - inventory adjust slot:<context.slot> hides:enchants d:<player.open_inventory>
          - inventory flag slot:<context.slot> ip_selected d:<player.open_inventory>
      - default:
        #------------------------------------------------------#
        # check if it is a tempban or a time item that was clicked
        #------------------------------------------------------#
        - if <context.item.script.name.contains_all_text[tempban_i_]>:
          - if <context.item.script.name> == tempban_i_9:
            - if <[message]> == no_message:
              - narrate "Here is a book write your message in here then sign it" format:zc_temp_text
              - flag player writing.tempban.player:<[player]>
              - if <player.open_inventory.contains_item[item_flagged:time_selected]>:
                - flag player writing.tempban.time:<player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[time_selected]>].first.script.name>
                - if <player.flag[writing.tempban.time]> == time_i_9:
                  - flag player writing.tempban.time_amount:<player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[time_selected]>].first.flag[time]>
                  - flag player writing.tempban.time_date:<player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[time_selected]>].first.lore.get[2].strip_color>
              - inventory close
              - give tempban_book
              - stop
            - if !<context.item.has_flag[selected]>:
              - if <player.open_inventory.contains_item[item_flagged:selected]>:
                - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first>
                - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
                - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
                - inventory flag slot:<[old_slot]> selected:! d:<player.open_inventory>
              - inject highlight_reason_task
              - stop

          #------------------------------------------------------#
          # if it isn't the custom message option it is alot simpler
          #------------------------------------------------------#
          - else:
            - if <player.open_inventory.contains_item[item_flagged:selected]>:
              - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first>
              - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
              - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
              - inventory flag slot:<[old_slot]> selected:! d:<player.open_inventory>
            - inject highlight_reason_task

        #------------------------------------------------------#
        # all of the above but then for the time items
        #------------------------------------------------------#
        - if <context.item.script.name.contains_all_text[time_i_]>:
          - if <context.item.script.name> == time_i_9:
            - if <[time]> == no_time:
              - if <player.open_inventory.contains_item[item_flagged:selected]>:
                - flag player time.tempban.selected:<player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first.script.name>
                - if <player.flag[time.tempban.selected]> == tempban_i_9:
                  - define message <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first.flag[message]>
                  - flag player time.tempban.reason:<[message]>
              - flag player time.tempban.player:<[player]>
              - inventory close
              - run give_time_book
          - else:
            - if <player.open_inventory.contains_item[item_flagged:time_selected]>:
              - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[time_selected]>].first>
              - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
              - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
              - inventory flag slot:<[old_slot]> time_selected:! d:<player.open_inventory>
            - inject highlight_time_task
    #-----------------------------------#
    # Warn gui interactions
    #-----------------------------------#
    on player clicks in warn_gui:
    - determine passively cancelled
    - if !<context.item.script.name.exists>:
      - stop
    - define player <context.item.flag[player]||null>
    - define message <context.item.flag[message]||no_message>
    - define time_now <util.time_now>
    - if <context.item.script.name> == cancel_i:
      - inventory close
      - stop
    - if <context.item.script.name> == confirm_i:
      - if !<player.has_permission[zc.mod]>:
        - narrate "You do not have permission to submit a warning"
        - inventory close
        - stop
      - if !<player.open_inventory.contains_item[item_flagged:selected]>:
        - narrate "You need to select a reason to warn <[player].name>" format:zc_warn_text
        - stop
      - define message <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first.flag[message]>
      - if <[player].is_online>:
        - clickable confirm_warn def:<[player]> save:conf_click
        - narrate "<&e>You have been <&6>warned:<&nl>" targets:<[player]>
        - narrate "<&e>Reason: <&f><[message]>" targets:<[player]>
        - narrate "<&e>Time: <&f><[time_now].format><&nl>" targets:<[player]>
        - narrate "<&e>Click <&click[<entry[conf_click].command>]><&hover[Confirm to stop the warning message from reappearing]><&a>[Confirm]<&end_hover><&end_click><&e> to confirm that you received this" targets:<[player]>
      - flag <[player]> new_warnings:->:<map.with[<[message]>].as[<[time_now]>]>
      - define num <[player].flag[moderate.warnings].size.add[1]||1>
      - flag <[player]> moderate.warnings.<[num]>.by_player:<player>
      - flag <[player]> moderate.warnings.<[num]>.reason:<[message]>
      - flag <[player]> moderate.warnings.<[num]>.time:<[time_now]>
      - inventory close
      - define has_perm <[player].has_flag[moderate.permban]>
      - define has_temp <[player].has_flag[moderate.tempban]>
      - define has_warn <[player].has_flag[moderate.warnings]>
      - narrate "<&6>Warning From <&e><player.name> recorded:<&nl>" targets:<server.online_players.filter[has_permission[zc.mod]].exclude[<player>]>
      - narrate "<&6>Warning <&e>recorded:<&nl>"
      - narrate "<&e>Player: <&f><[player].name>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e>Reason: <&f><[message]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e>Time: <&f><[time_now].format><&nl>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<&e><[player].name> their warnings, tempbans and perms" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - narrate "<tern[<[has_warn]>].pass[<&click[/listwarns <[player].name>]><&hover[Click to show their warning(s)]><&e>[<[player].flag[moderate.warnings].size> Warning(s)]<&end_hover><&end_click>].fail[<&e>[0 Warnings]]> <tern[<[has_temp]>].pass[<&click[/listtemps <[player].name>]><&hover[Click to show their Tempban(s)]><&3>[<[player].flag[moderate.tempban].size> Tempban(s)]<&end_hover><&end_click>].fail[<&3>[0 Tempbans]]> <tern[<[has_perm]>].pass[<&click[/listperms <[player].name>]><&hover[Click to show their permban(s)]><&c>[<[player].flag[moderate.permban].size> Permbans(s)]<&end_hover><&end_click>].fail[<&c>[0 Permbans]]>" targets:<server.online_players.filter[has_permission[zc.mod]]>
      - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name> has warned <[player].name>].add_field[Warning Reason:].value[<[message]>].add_field[Time of warning:].value[<util.time_now.format>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[yellow].with[footer].as[<player.name>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name>/190.png].with[timestamp].as[<util.time_now>]>"
      - stop
    - if <context.item.script.name.contains_all_text[warn_i_]>:
      - if <context.item.script.name> == warn_i_9:
        - if <[message]> == no_message:
          - inventory close
          - narrate "Here is a book write your message in here then sign it"
          - flag player writing.warn:<[player]>
          - give warn_book
          - stop
        - if !<context.item.has_flag[selected]>:
          - if <player.open_inventory.contains_item[item_flagged:selected]>:
            - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first>
            - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
            - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
            - inventory flag slot:<[old_slot]> selected:! d:<player.open_inventory>
          - inject highlight_reason_task
          - stop
    - if <player.open_inventory.contains_item[item_flagged:selected]>:
      - define old_item <player.open_inventory.list_contents.filter_tag[<[filter_value].has_flag[selected]>].first>
      - define old_slot <player.open_inventory.find_item[<[old_item].script.name>]>
      - inventory adjust slot:<[old_slot]> remove_enchantments d:<player.open_inventory>
      - inventory flag slot:<[old_slot]> selected:! d:<player.open_inventory>
    - inject highlight_reason_task
    #------------------------------------------------------#
    # this is the gui that comes up when you do /moderate (so not alot of peeps will see it)
    #------------------------------------------------------#
    on player clicks in wban_gui:
    - determine passively cancelled
    - define player <context.item.flag[player]||null>
    - choose <context.item.script.name||default>:
      - case warn_i:
        - execute as_player "warn <[player].name>"
      - case tempban_i:
        - execute as_player "tempban <[player].name>"
      - case ban_i:
        - execute as_player "ban_zc <[player].name>"
      - default:
        - stop
    #------------------------------------------------------#
    # and all the determine cancelled on the different inventories
    #------------------------------------------------------#
    on player drags in wban_gui:
    - determine passively cancelled
    on player drags in warn_gui:
    - determine passively cancelled
    on player drags in tempban_gui:
    - determine passively cancelled
    on player drags in ban_gui:
    - determine passively cancelled
    #------------------------------------------------------#
    # checks for any warned players that haven't clicked confirm on their warning
    #------------------------------------------------------#
    on system time minutely every:10:
    - if !<server.online_players.filter[has_flag[new_warnings]].is_empty>:
      - foreach <server.online_players.filter[has_flag[new_warnings]]> as:player:
        - define warnings <list[]>
        - foreach <[player].flag[new_warnings]> as:warning:
          - define warnings "<[warnings].include[<&e><[loop_index]>. <&f><[warning].keys.first.on_hover[<[warning].values.first.format>]>]>"
        - clickable confirm_warn def:<[player]> save:conf_click
        - narrate "<&e>You have been <&6>Warned<&nl>" targets:<[player]>
        - narrate "<&e>Warnings: " targets:<[player]>
        - narrate <[warnings].separated_by[<&nl>]><&nl> targets:<[player]>
        - narrate "<&e>Click <&click[<entry[conf_click].command>]><&hover[Confirm to stop the warning message from reappearing]><&a>[Confirm]<&end_hover><&end_click><&e> to confirm that you received this" targets:<[player]>
    after player join:
    - if !<server.online_players.filter[has_flag[new_warnings]].is_empty>:
      - foreach <server.online_players.filter[has_flag[new_warnings]]> as:player:
        - define warnings <list[]>
        - foreach <[player].flag[new_warnings]> as:warning:
          - define warnings "<[warnings].include[<&e><[loop_index]>. <&f><[warning].keys.first.on_hover[<[warning].values.first.format>]>]>"
        - clickable confirm_warn def:<[player]> save:conf_click
        - narrate "<&e>You have been <&6>Warned<&nl>" targets:<[player]>
        - narrate "<&e>Warnings: " targets:<[player]>
        - narrate <[warnings].separated_by[<&nl>]><&nl> targets:<[player]>
        - narrate "<&e>Click <&click[<entry[conf_click].command>]><&hover[Confirm to stop the warning message from reappearing]><&a>[Confirm]<&end_hover><&end_click><&e> to confirm that you received this" targets:<[player]>

confirm_warn:
  type: task
  debug: false
  definitions: player
  script:
    - narrate "<&e>You've confirmed receiving the warning"
    - narrate "<&e>Getting too many warnings may result in a temp or perm ban"
    - narrate "<&e>So we simply ask you to not do it again"
    - flag player new_warnings:!

highlight_reason_task:
  type: task
  debug: false
  script:
    - inventory adjust slot:<context.slot> enchantments:lure,1 d:<player.open_inventory>
    - inventory adjust slot:<context.slot> hides:enchants d:<player.open_inventory>
    - inventory flag slot:<context.slot> selected d:<player.open_inventory>
    - stop

highlight_time_task:
  type: task
  debug: false
  script:
    - inventory adjust slot:<context.slot> enchantments:lure,1 d:<player.open_inventory>
    - inventory adjust slot:<context.slot> hides:enchants d:<player.open_inventory>
    - inventory flag slot:<context.slot> time_selected d:<player.open_inventory>
    - stop

#------------------------------------------------------#
# creating clickables for the book gui
#------------------------------------------------------#
give_time_book:
  type: task
  debug: false
  script:
    - clickable time_col1_up save:1up
    - clickable time_col1_down save:1down
    - clickable time_col2_up save:2up
    - clickable time_col2_down save:2down
    - clickable date_col1_up save:3up
    - clickable date_col1_down save:3down
    - clickable time_book_done save:done
    - give time_book

time_book_done:
  type: task
  debug: false
  script:
    - define time <player.item_in_hand.book_pages.first.before[:].after_last[<n>].split[].replace[<&sp>].unseparated>
    - define date <player.item_in_hand.book_pages.first.after[:].before[<n>].split[].replace[<&sp>].unseparated>
    - if <[time]> < 1:
      - narrate "You cannot ban for 0 <[date]>"
    #------------------------------------------------------#
    # transfers the book text into denizen readable durations
    #------------------------------------------------------#
    - choose <[date]>:
      - case seconds:
        - define d_time <[time]>s
      - case minutes:
        - define d_time <[time]>m
      - case hours:
        - define d_time <[time]>h
      - case days:
        - define d_time <[time]>d
      - case weeks:
        - define d_time <[time]>w
      - case months:
        - define d_time <[time].mul[31]>d
      - case years:
        - define d_time <[time].mul[52]>w
    - define player <player.flag[time.tempban.player]>
    - define method Tempban
    - define other_players <list[]>
    - foreach <[player].flag[ip_addresses].keys> as:ip:
      - if <server.has_flag[ip_addresses.<[ip]>]>:
        - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
          - flag <[player]> ip_addresses.<[ip]>:!
          - foreach next
        - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
    - define other_players <[other_players].deduplicate.replace[<[player]>].parse_tag[<&3><[parse_value].name>].alphanumeric||list[]>
    - define is_perm false
    - inventory open d:tempban_gui
    - wait 1t
    - define item_slot <player.open_inventory.find_item[time_i_9]>
    - inventory adjust slot:<[item_slot]> enchantments:lure,1 d:<player.open_inventory>
    - inventory adjust slot:<[item_slot]> hides:enchants d:<player.open_inventory>
    - inventory adjust slot:<[item_slot]> "lore:<&f>Tempban <[player].name> for<&nl><&3><[time]> <[date]><&nl><&3>Until: <util.time_now.add[<[d_time]>].format>" d:<player.open_inventory>
    - inventory flag slot:<[item_slot]> time_selected d:<player.open_inventory>
    - inventory flag slot:<[item_slot]> time:<[d_time]> d:<player.open_inventory>
    #------------------------------------------------------#
    # checks if the player already had a reason selected
    #------------------------------------------------------#
    - if <player.has_flag[time.tempban.selected]>:
      - define item_slot <player.open_inventory.find_item[<player.flag[time.tempban.selected]>]>
      - inventory adjust slot:<[item_slot]> enchantments:lure,1 d:<player.open_inventory>
      - inventory adjust slot:<[item_slot]> hides:enchants d:<player.open_inventory>
      - inventory flag slot:<[item_slot]> selected d:<player.open_inventory>
      - if <player.flag[time.tempban.selected]> == tempban_i_9:
        - inventory adjust slot:<[item_slot]> "lore:<&f>Tempban <[player].name> for<&nl><&1><player.flag[time.tempban.reason]>" d:<player.open_inventory>
        - inventory flag slot:<[item_slot]> message:<player.flag[time.tempban.reason]> d:<player.open_inventory>
    - flag player time.tempban:!
    - take iteminhand

#------------------------------------------------------#
# these tasks handle the switching numbers/dates in the book
# they first define the current displayed time
# use some math (0+1=1&9+1=0) and refresh the book
#------------------------------------------------------#
time_col1_up:
  type: task
  debug: false
  script:
    - inject time_book_defs
    - if <[time1]> >= 9:
      - define time1 0
    - else:
      - define time1 <[time1].add[1]>
    - inventory adjust slot:<player.held_item_slot> "book_pages:<p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     <[time1]> <[time2]>    :   <[date]><n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>" d:<player.inventory>
    - adjust <player> open_book

time_col1_down:
  type: task
  debug: false
  script:
    - inject time_book_defs
    - if <[time1]> <= 0:
      - define time1 9
    - else:
      - define time1 <[time1].sub[1]>
    - inventory adjust slot:<player.held_item_slot> "book_pages:<p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     <[time1]> <[time2]>    :   <[date]><n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>" d:<player.inventory>
    - adjust <player> open_book

time_col2_up:
  type: task
  debug: false
  script:
    - inject time_book_defs
    - if <[time2]> >= 9:
      - define time2 0
    - else:
      - define time2 <[time2].add[1]>
    - inventory adjust slot:<player.held_item_slot> "book_pages:<p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     <[time1]> <[time2]>    :   <[date]><n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>" d:<player.inventory>
    - adjust <player> open_book

time_col2_down:
  type: task
  debug: false
  script:
    - inject time_book_defs
    - if <[time2]> <= 0:
      - define time2 9
    - else:
      - define time2 <[time2].sub[1]>
    - inventory adjust slot:<player.held_item_slot> "book_pages:<p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     <[time1]> <[time2]>    :   <[date]><n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>" d:<player.inventory>
    - adjust <player> open_book

#------------------------------------------------------#
# handles the transfer of the dates.
# no math used just simple if it was this then it will become this
#------------------------------------------------------#
date_col1_up:
  type: task
  debug: false
  script:
    - inject time_book_defs
    - choose <[date]>:
      - case seconds:
        - define date " minutes"
      - case minutes:
        - define date "  hours"
      - case hours:
        - define date "  days"
      - case days:
        - define date "  weeks"
      - case weeks:
        - define date " months"
      - case months:
        - define date "  years"
      - case years:
        - define date seconds
    - inventory adjust slot:<player.held_item_slot> "book_pages:<p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     <[time1]> <[time2]>    :   <[date]><n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>" d:<player.inventory>
    - adjust <player> open_book

date_col1_down:
  type: task
  debug: false
  script:
    - inject time_book_defs
    - choose <[date]>:
      - case seconds:
        - define date "  years"
      - case minutes:
        - define date seconds
      - case hours:
        - define date " minutes"
      - case days:
        - define date "  hours"
      - case weeks:
        - define date " days"
      - case months:
        - define date "  weeks"
      - case years:
        - define date " months"
    - inventory adjust slot:<player.held_item_slot> "book_pages:<p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     <[time1]> <[time2]>    :   <[date]><n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>" d:<player.inventory>
    - adjust <player> open_book

#------------------------------------------------------#
# injecting this into the tasks above to greatly reduce the size
# for each edit to the book i will have to make new clickables
#------------------------------------------------------#
time_book_defs:
  type: task
  debug: false
  script:
    - clickable time_col1_up save:1up
    - clickable time_col1_down save:1down
    - clickable time_col2_up save:2up
    - clickable time_col2_down save:2down
    - clickable date_col1_up save:3up
    - clickable date_col1_down save:3down
    - clickable time_book_done save:done
    - define time1 <player.item_in_hand.book_pages.first.before[:].after_last[<n>].split[].replace[<&sp>].first>
    - define time2 <player.item_in_hand.book_pages.first.before[:].after_last[<n>].split[].replace[<&sp>].get[2]>
    - define date <player.item_in_hand.book_pages.first.after[:].before[<n>].split[].replace[<&sp>].unseparated>

#------------------------------------------------------#
# All the custom items used withing the different guis
#------------------------------------------------------#
warn_i:
  type: item
  debug: false
  material: filled_map
  lore:
  - <&f>Click here to warn <[player].name||error>
  flags:
    player: <[player]||error>
  mechanisms:
    display: <&e>Warn <[player].name||error>
    enchantments:
      lure: 1
    hides: enchants

tempban_i:
  type: item
  debug: false
  material: structure_void
  lore:
  - <&f>Click here to warn <[player].name||error>
  flags:
    player: <[player]||error>
  mechanisms:
    display: <&3>Tempban <[player].name||error>
    enchantments:
      lure: 1
    hides: enchants

ban_i:
  type: item
  debug: false
  material: barrier
  lore:
  - <&f>Click here to warn <[player].name||error>
  flags:
    player: <[player]||error>
  mechanisms:
    display: <&c>Ban <[player].name||error>
    enchantments:
      lure: 1
    hides: enchants

confirm_i:
  type: item
  debug: false
  material: lime_concrete
  flags:
    player: <[player]||error>
    method: <[method]||error>
  mechanisms:
    display: <&a>Confirm <[method]||error>
  lore:
  - <&f>Click here to confirm the <[method]||error> on <[player].name||error>

cancel_i:
  type: item
  debug: false
  material: red_concrete
  mechanisms:
    display: <&c>Cancel <[method]||error>
  lore:
  - <&f>Click here to cancel the <[method]||error> on <[player].name||error>

warn_i_1:
  type: item
  debug: false
  material: paper
  display name: <&e>Griefing
  flags:
    player: <[player]||error>
    message: Some minor griefing
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>minor griefs

warn_i_2:
  type: item
  debug: false
  material: paper
  display name: <&e>Spam
  flags:
    message: Spamming in chat
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>spamming

warn_i_3:
  type: item
  debug: false
  material: paper
  display name: <&e>Advertising
  flags:
    message: Advertising
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>advertising

warn_i_4:
  type: item
  debug: false
  material: paper
  display name: <&e>Abusing exploits
  flags:
    message: Abusing exploits
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>abusing exploits

warn_i_5:
  type: item
  debug: false
  material: paper
  display name: <&e>Throwing slurs
  flags:
    message: Throwing mean/harmfull slurs around (or at another player)
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>using slurs against other players/in general

warn_i_6:
  type: item
  debug: false
  material: paper
  display name: <&e>Not listening
  flags:
    message: Not listening to a staff member
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>not listening to a staff member

warn_i_7:
  type: item
  debug: false
  material: paper
  display name: <&e>Pretending
  flags:
    message: Impersonating another person (without their consent)
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>pretending to be someone else

warn_i_8:
  type: item
  debug: false
  material: paper
  display name: <&e>not leaving
  flags:
    message: Entering/not leaving someones home
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&e>not leaving someone elses home

warn_i_9:
  type: item
  debug: false
  material: paper
  display name: <&6>Fill in your own
  flags:
    player: <[player]||error>
  lore:
  - <&f>Give <[player].name||error> a warning for
  - <&6>your own written message

tempban_i_1:
  type: item
  debug: false
  material: paper
  display name: <&3>Griefing
  flags:
    message: Griefing/stealing multiple items/blocks.
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>Griefing multiple (non valuable) items

tempban_i_2:
  type: item
  debug: false
  material: paper
  display name: <&3>Griefing valuables
  flags:
    message: Griefing/stealing some/multiple valuable items/blocks
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>Griefing multiple valuable items

tempban_i_3:
  type: item
  debug: false
  material: paper
  display name: <&3>Spamming/spamvertising
  flags:
    message: Continued spamming/spam advertising in chat
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>Continued spamming/spam advertising

tempban_i_4:
  type: item
  debug: false
  material: paper
  display name: <&3>Abusing exploits
  flags:
    message: Continued abusing of exploits
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>Continued exploit abusing

tempban_i_5:
  type: item
  debug: false
  material: paper
  display name: <&3>Harrasment
  flags:
    message: Continued harassment after already receiving a warning for it
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>Continued harassment after warning

tempban_i_6:
  type: item
  debug: false
  material: paper
  display name: <&3>Misbehaviour
  flags:
    message: Misbehaving while already having warns.
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>General misbehaviour

tempban_i_7:
  type: item
  debug: false
  material: paper
  display name: <&3>
  flags:
    message: <empty>
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>

tempban_i_8:
  type: item
  debug: false
  material: paper
  display name: <&3>
  flags:
    message: <empty>
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>

tempban_i_9:
  type: item
  debug: false
  material: paper
  display name: <&1>Fill in your own
  flags:
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&1>your own written message

time_i_1:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 1d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>1 day
  - <&3>Until: <util.time_now.add[1d].format>

time_i_2:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 2d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>2 days
  - <&3>Until: <util.time_now.add[2d].format>

time_i_3:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 3d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>3 days
  - <&3>Until: <util.time_now.add[3d].format>

time_i_4:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 5d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>5 days
  - <&3>Until: <util.time_now.add[5d].format>

time_i_5:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 7d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>7 days
  - <&3>Until: <util.time_now.add[7d].format>

time_i_6:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 10d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>10 days
  - <&3>Until: <util.time_now.add[10d].format>

time_i_7:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 15d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>15 days
  - <&3>Until: <util.time_now.add[15d].format>

time_i_8:
  type: item
  debug: false
  material: clock
  display name: <&3>Time
  flags:
    time: 31d
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>31 days
  - <&3>Until: <util.time_now.add[31d].format>

time_i_9:
  type: item
  debug: false
  material: clock
  display name: <&3>Fill in your own
  flags:
    player: <[player]||error>
  lore:
  - <&f>Tempban <[player].name||error> for
  - <&3>your own time

ban_i_1:
  type: item
  debug: false
  material: paper
  display name: <&c>Hacking
  flags:
    player: <[player]||error>
    message: You were caught hacking or using a x-ray texture pack.
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>using hacks or x-ray texture pack

ban_i_2:
  type: item
  debug: false
  material: paper
  display name: <&c>Racial slurs/racism
  flags:
    player: <[player]||error>
    message: Using any kind of racial slurs, therefore being racist.
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>using any kind of racial slurs

ban_i_3:
  type: item
  debug: false
  material: paper
  display name: <&c>0 tolerence
  flags:
    player: <[player]||error>
    message: Breaking any rule while being on a 0 tolerence rule.
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>breaking any rule while on 0 tolerence

ban_i_4:
  type: item
  debug: false
  material: paper
  display name: <&c>Griefing
  flags:
    player: <[player]||error>
    message: Griefing too many valuable items, or griefing after already being punished.
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>Griefing alot of valuables/after punishment

ban_i_5:
  type: item
  debug: false
  material: paper
  display name: <&c>Exploits
  flags:
    player: <[player]||error>
    message: Continued using of exploits after already being temp banned for it.
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>more exploit abuse after a tempban.

ban_i_6:
  type: item
  debug: false
  material: paper
  display name: <&c>Crashing
  flags:
    player: <[player]||error>
    message: Intentially crashing the server over and over again
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>Intentially crashing the server

ban_i_7:
  type: item
  debug: false
  material: paper
  display name: <&c>
  flags:
    player: <[player]||error>
    message: <empty>
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>

ban_i_8:
  type: item
  debug: false
  material: paper
  display name: <&c>
  flags:
    player: <[player]||error>
    message: <empty>
  lore:
  - <&f>Permban <[player].name||error> for
  - <&c>

ban_i_9:
  type: item
  debug: false
  material: paper
  display name: <&4>Fill in your own
  flags:
    player: <[player]||error>
  lore:
  - <&f>Permban <[player].name||error> for
  - <&4>your own written message

ip_ban_i:
  type: item
  debug: false
  material: book
  mechanisms:
    display: <tern[<[is_perm]||false>].pass[<&c>].fail[<&3>]>Ip ban <[player].name||noone>
  flags:
    player: <[player]||noone>

#------------------------------------------------------#
# Different books the player uses to make custom reasons/times
#------------------------------------------------------#
warn_book:
  type: item
  debug: false
  material: writable_book
  mechanisms:
    display: <&e>Warn book <[player].name||error>
  flags:
    player: <[player]||error>
  lore:
  - <&f>Write your warning to <[player].name||error> in here

tempban_book:
  type: item
  debug: false
  material: writable_book
  flags:
    player: <[player]||error>
  mechanisms:
    display: <&3>Tempban book <[player].name||error>
  lore:
  - <&f>Write your tempban reason to <[player].name||error> in here

ban_book:
  type: item
  debug: false
  material: writable_book
  mechanisms:
    display: <&c>Permban book <[player].name||error>
  flags:
    player: <[player]||error>
  lore:
  - <&f>Write you permban reason to <[player].name||error> in here

time_book:
  type: book
  debug: false
  title: tempban time
  author: greenleeuw
  signed: true
  text:
  - <p>Choose your time<p>     <&click[<entry[1up].command>]><&chr[25B2]><&end_click> <&click[<entry[2up].command>]><&chr[25B2]><&end_click>            <&click[<entry[3up].command>]><&chr[25B2]><&end_click><n>     0 0    :   seconds<n>     <&click[<entry[1down].command>]><&chr[25BC]><&end_click> <&click[<entry[2down].command>]><&chr[25BC]><&end_click>            <&click[<entry[3down].command>]><&chr[25BC]><&end_click><p>Click finish to choose the current displayed time<p>         <&a><&click[<entry[done].command>]>[Finish]<&end_click>

#------------------------------------------------------#
# And the different guis the player opens when using the commands
#------------------------------------------------------#
wban_gui:
  type: inventory
  inventory: hopper
  debug: false
  title: <&2>Moderate
  slots:
    - [warn_i] [] [tempban_i] [] [ban_i]

warn_gui:
  type: inventory
  inventory: chest
  debug: false
  size: 18
  title: <&e>Warning
  slots:
  - [warn_i_1] [warn_i_2] [warn_i_3] [warn_i_4] [warn_i_5] [warn_i_6] [warn_i_7] [warn_i_8] [warn_i_9]
  - [] [] [] [confirm_i] [] [cancel_i] [] [] []

tempban_gui:
  type: inventory
  inventory: chest
  debug: false
  size: 27
  title: <&3>Tempbanning
  slots:
  - [] [tempban_i_1] [tempban_i_2] [tempban_i_3] [tempban_i_4] [tempban_i_5] [tempban_i_6] [tempban_i_9] []
  - [time_i_1] [time_i_2] [time_i_3] [time_i_4] [time_i_5] [time_i_6] [time_i_7] [time_i_8] [time_i_9]
  - [] [] [] [confirm_i] [] [cancel_i] [] [] [ip_ban_i[lore=<list[<&f>Select this to also tempban their ip(s)|<&f>IP(s): <&3><[player].flag[ip_addresses].keys.parse[replace_text[-].with[.]].separated_by[ ]>|<&f>other known players on that address].include[<[other_players]>]>]]

ban_gui:
  type: inventory
  inventory: chest
  debug: false
  size: 18
  title: <&c>Banning
  slots:
  - [] [ban_i_1] [ban_i_2] [ban_i_3] [ban_i_4] [ban_i_5] [ban_i_6] [ban_i_9] []
  - [] [] [] [confirm_i] [] [cancel_i] [] [] [ip_ban_i[lore=<list[<&f>Select this to also permban their ip(s)|<&f>IP(s): <&c><[player].flag[ip_addresses].keys.parse[replace_text[-].with[.]].separated_by[ ]>|<&f>other known players on that address].include[<[other_players]>]>]]

#------------------------------------------------------#
# anddd all the way at the bottom the useless tasks
# the format tasks wuw becuase i wanted them no other reason
#------------------------------------------------------#
zc_warn_text:
    type: format
    debug: false
    format: <&color[#009900]>Z<&color[#00CC00]>c <&color[#00FF00]>W<&color[#33FF33]>a<&color[#66FF66]>r<&color[#99FF99]>n<&color[#CCFFCC]>s <&7><&gt><&gt><&f> <[text]>

zc_temp_text:
    type: format
    debug: false
    format: <&color[#009900]>Z<&color[#00CC00]>c <&color[#00FF00]>T<&color[#33FF33]>e<&color[#66FF66]>m<&color[#99FF99]>p<&color[#CCFFCC]>s <&7><&gt><&gt><&f> <[text]>

zc_perm_text:
    type: format
    debug: false
    format: <&color[#009900]>Z<&color[#00CC00]>c <&color[#00FF00]>P<&color[#33FF33]>e<&color[#66FF66]>r<&color[#99FF99]>m<&color[#CCFFCC]>s <&7><&gt><&gt><&f> <[text]>

zc_list_text:
  type: format
  debug: false
  format: <&color[#009900]>Z<&color[#00CC00]>c <&color[#00FF00]>L<&color[#33FF33]>i<&color[#66FF66]>s<&color[#99FF99]>t<&color[#CCFFCC]>s <&7><&gt><&gt><&f> <[text]>

zc_unban_text:
  type: format
  debug: false
  format: <&color[#009900]>Z<&color[#00CC00]>c <&color[#00FF00]>U<&color[#33FF33]>n<&color[#66FF66]>b<&color[#99FF99]>a<&color[#CCFFCC]>n <&7><&gt><&gt><&f> <[text]>

#-------------------------------------------------------#
# None gui needed commands
#-------------------------------------------------------#
unban_co:
  type: command
  name: unban
  debug: false
  description: Unbans a certain user or their ip
  usage: /unban (player name) with_ip
  permission: zc.mod
  aliases:
  - unbanip
  - pardon
  - pardon-ip
  - pardonip
  tab completions:
    1: <server.banned_players.parse[name]>
    2: with_ip
  script:
    #--------------------------------------------------#
    # Checking if the player is real and if he's banned
    #--------------------------------------------------#
    - define player <server.match_offline_player[<context.args.first||fdsafkjlsdjfds>]||noone>
    - if <[player]> == noone:
      - narrate "this does not seem to be a player" format:zc_unban_text
      - stop
    - if !<[player].is_banned>:
      - narrate "<[player].name> does not seem to be banned" format:zc_unban_text
      - stop
    #--------------------------------------------------#
    # Checks wether it is an ip unban or not
    #--------------------------------------------------#
    - if <context.args.get[2]||false> == with_ip:
      - define other_players <list[]>
      - foreach <[player].flag[ip_addresses].keys> as:ip:
        - if <server.has_flag[ip_addresses.<[ip]>]>:
          - if <server.flag[ip_addresses.<[ip]>].object_type> != player:
            - flag <[player]> ip_addresses.<[ip]>:!
            - foreach next
          - define other_players <[other_players].include[<server.flag[ip_addresses.<[ip]>]>]>
      - define other_players <[other_players].deduplicate||list[]>
      - foreach <[other_players]> as:players:
        - define num <[players].flag[moderate.unban].size.add[1]||1>
        #----------------------------------------------------#
        # Since it is an ip ban it need to check if
        # Other players on that ip are also banned
        #---------------------------------------------------#
        - if <[players].is_banned>:
          - define reason <[players].ban_reason>
          - define source <[players].ban_source>
          - if <[players].ban_expiration_time||never> != never:
            - define expiration <[players].ban_expiration_time>
          - define created <[players].ban_created_time>
        - flag <[players]> moderate.unban.<[num]>.by_player:<player||server>
        - flag <[players]> moderate.unban.<[num]>.time:<util.time_now>
        - if <[players].is_banned>:
        #---------------------------------------------#
        # Logs info about the ban the player had
        #---------------------------------------------#
          - flag <[players]> moderate.unban.<[num]>.reason:<[reason]>
          - flag <[players]> moderate.unban.<[num]>.source:<[source]>
          - if <[players].ban_expiration_time||never> != never:
            - flag <[players]> moderate.unban.<[num]>.expiration:<[expiration]>
          - flag <[players]> moderate.unban.<[num]>.created:<[created]>
        - flag <[players]> moderate.unban.<[num]>.was_ip:true
        - flag <[players]> moderate.unban.<[num]>.ip_person:<[player]>
        #--------------------------------------------------#
        # I know it says ban but thats the way to unban them.
        # by removing the ban
        #--------------------------------------------------#
      - define num <[player].flag[moderate.unban].size>
      - define discord no_ban
      - if <[player].is_banned>:
        - define discord ban
        - define reason <[player].ban_reason>
        - define source <[player].ban_source>
        - if <[player].ban_expiration_time||never> != never:
          - define discord ban_expiration
          - define expiration <[player].ban_expiration_time>
        - define created <[player].ban_created_time>
      - ban addresses:<[player].flag[ip_addresses].keys.replace_text[-].with[.]> remove source:<player.name||server>
      - ban <[other_players]> remove source:<player.name||server>
      - if <player.is_online>:
        - narrate "<&8>Unban <&7>recorded<&nl>"
        - narrate "<&7>Player: <&f><[player].name>"
        - narrate "<&7>Time: <&f><util.time_now.format><&nl>"
        - narrate "<&7><[player].name> their unbans"
        - narrate "<&click[/listunbans <[player].name>]><&hover[Click here to show their unban(s)]><&8>[<&7><[num]> Unban(s)<&8>]<&end_hover><&end_click>"
      - choose <[discord]>:
        - case no_ban:
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name||server> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ip unban].value[true].add_field[Other known players on that ip:].value[- <[other_players].replace[<[player]>].parse[name].separated_by[<&nl>- ]>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<player.name||server>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name||Loopsplz>/190.png].with[timestamp].as[<util.time_now>]>"
        - case ban:
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name||server> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[reason]>].add_field[Ban source:].value[<[source]>].add_inline_field[Ban creation time:].value[<[created].format>].add_field[Ip unban].value[true].add_field[Other known players on that ip:].value[- <[other_players].replace[<[player]>].parse[name].separated_by[<&nl>- ]>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<player.name||server>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name||Loopsplz>/190.png].with[timestamp].as[<util.time_now>]>"
        - case ban_expiration:
          - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name||server> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[reason]>].add_field[Ban source:].value[<[source]>].add_inline_field[Ban creation time:].value[<[created].format>].add_inline_field[Ban expiration time:].value[<[expiration].format> (<[expiration].duration_since[<[created]>].formatted>)].add_field[Ip unban].value[true].add_field[Other known players on that ip:].value[- <[other_players].replace[<[player]>].parse[name].separated_by[<&nl>- ]>].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<player.name||server>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name||Loopsplz>/190.png].with[timestamp].as[<util.time_now>]>"
      - stop
    #-------------------------------------------#
    # This happens if it is not a ip unban
    #-------------------------------------------#
    - define num <[player].flag[moderate.unban].size.add[1]||1>
    - define discord no_ban
    - if <[player].is_banned>:
      - define discord ban
      - define reason <[player].ban_reason>
      - define source <[player].ban_source>
      - if <[player].ban_expiration_time||never> != never:
        - define discord ban_expiration
        - define expiration <[player].ban_expiration_time>
      - define created <[player].ban_created_time>
    - flag <[player]> moderate.unban.<[num]>.by_player:<player||server>
    - flag <[player]> moderate.unban.<[num]>.time:<util.time_now>
    - if <[player].is_banned>:
      - flag <[player]> moderate.unban.<[num]>.reason:<[reason]>
      - flag <[player]> moderate.unban.<[num]>.source:<[source]>
      - if <[player].ban_expiration_time||never> != never:
        - flag <[player]> moderate.unban.<[num]>.expiration:<[expiration]>
      - flag <[player]> moderate.unban.<[num]>.created:<[created]>
    - flag <[player]> moderate.unban.<[num]>.was_ip:false
    - ban <[player]> remove source:<player.name||server>
    - if <player.is_online||false>:
      - narrate "<&8>Unban <&7>recorded<&nl>"
      - narrate "<&7>Player: <&f><[player].name>"
      - narrate "<&7>Time: <&f><util.time_now.format><&nl>"
      - narrate "<&7><[player].name> their unbans"
      - narrate "<&click[/listunbans <[player].name>]><&hover[Click here to show their unban(s)]><&8>[<&7><[num]> Unban(s)<&8>]<&end_hover><&end_click>"
    - choose <[discord]>:
      - case no_ban:
        - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name||server> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<player.name||server>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name||Loopsplz>/190.png].with[timestamp].as[<util.time_now>]>"
      - case ban:
        - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name||server> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[reason]>].add_field[Ban source:].value[<[source]>].add_inline_field[Ban creation time:].value[<[created].format>].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<player.name||server>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name||Loopsplz>/190.png].with[timestamp].as[<util.time_now>]>"
      - case ban_expiration:
        - ~discordmessage id:zc-info channel:763308613795315732 "<discord_embed.with[author_name].as[<[player].name>].with[author_url].as[https://minecraft-statistic.net/en/player/<[player].name>.html].with[author_icon_url].as[https://cravatar.eu/helmavatar/<[player].name>/190.png].with[description].as[<player.name||server> has unbanned <[player].name>].add_field[Time of unban:].value[<util.time_now.format>].add_field[Ban reason:].value[<[reason]>].add_field[Ban source:].value[<[source]>].add_inline_field[Ban creation time:].value[<[created].format>].add_inline_field[Ban expiration time].value[<[expiration].format> (<[expiration].duration_since[<[created]>].formatted>)].add_field[Ip unban].value[false].add_inline_field[Warnings].value[<[player].flag[moderate.warnings].size||0> Warnings].add_inline_field[Tempbans].value[<[player].flag[moderate.tempban].size||0> Tempbans].add_inline_field[Permbans].value[<[player].flag[moderate.permban].size||0> Permbans].with[color].as[gray].with[footer].as[<player.name||server>].with[footer_icon].as[https://cravatar.eu/helmavatar/<player.name||Loopsplz>/190.png].with[timestamp].as[<util.time_now>]>"

list_warns_co:
  type: command
  name: listwarns
  debug: false
  description: List the warns of a player
  usage: /listwarns (player name)
  permission: zc.mod
  aliases:
  - listperms
  - listtemps
  - listunbans
  script:
    #----------------------------------------------------#
    # Checking if the player has the moderation or not
    # also checking if it is even a valid player
    #----------------------------------------------------#
    - define player <server.match_offline_player[<context.args.first||fdklsfjhsldjfdld>]||noone>
    - if <[player]> == noone:
      - narrate "<context.args.first||empty> Does not seem to be a player" format:zc_list_text
      - stop
    - if !<[player].has_flag[moderate]>:
      - narrate "<[player].name> does not have any warnings/bans"
      - stop
    #------------------------------------#
    # Deciding what logs to show
    #------------------------------------#
    - choose <context.alias>:
      - case listwarns:
        - define cur_mod warnings
      - case listperms:
        - define cur_mod permban
      - case listtemps:
        - define cur_mod tempban
      - case listunbans:
        - define cur_mod unban
    - if !<[player].has_flag[moderate.<[cur_mod]>]>:
      - narrate "<[player].name> does not have any <[cur_mod]>"
      - stop
    #----------------------------------------------#
    # Getting page information max_page page number
    #----------------------------------------------#
    - define page <context.args.get[2]||1>
    - define max_page <[player].flag[moderate.<[cur_mod]>].size.div[10].round_up>
    - if <[page]> > <[max_page]> || <[page]> < 1:
      - narrate "That is not a valid page" format:zc_list_text
      - stop
    - define nums <[player].flag[moderate.<[cur_mod]>].keys.get[<[page].mul[10].sub[9]>].to[<[page].mul[10]>]>
    - define is_perm false
    - define is_temp false
    - define is_warn false
    - define is_unban false
    - define reasons <list[]>
    #---------------------------------------------#
    # Creating the hovers and reasons that show in the log
    #---------------------------------------------#
    - if <[cur_mod]> == warnings:
      - define is_warn true
      - define col <&e>
      - define bcol <&6>
      - foreach <[nums]> as:num:
        - define "hover:!|:<&e>warning from - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.by_player].name>"
        - define "hover:->:<&e>warning time - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.time].format>"
        - if "<[player].flag[moderate.<[cur_mod]>.<[num]>.reason].contains_all_text[You have been warned for]>":
          - define reasons "<[reasons].include[<&e><[num]>.<&f> <[player].flag[moderate.<[cur_mod]>.<[num]>.reason].after[You have been warned for].on_hover[<[hover].separated_by[<&nl>]>]>]>"
        - else:
          - define reasons "<[reasons].include[<&e><[num]>.<&f> <[player].flag[moderate.<[cur_mod]>.<[num]>.reason].on_hover[<[hover].separated_by[<&nl>]>]>]>"
    - if <[cur_mod]> == tempban:
      - define is_temp true
      - define col <&3>
      - define bcol <&1>
      - foreach <[nums]> as:num:
        - define "hover:!|:<&3>Tempban from - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.by_player].name>"
        - define "hover:->:<&3>Tempban time - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.time_now].format>"
        - define "hover:->:<&3>Tempban duration - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.time_now].add[<[player].flag[moderate.<[cur_mod]>.<[num]>.time_till]>].format> (<duration[<[player].flag[moderate.<[cur_mod]>.<[num]>.time_till]>].formatted>)"
        - define "hover:->:<&3>Was an IP ban - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.was_ip]>"
        - if <[player].flag[moderate.<[cur_mod]>.<[num]>.was_ip]>:
          - define "hover:->:<&3>IP User - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.ip_person].name>"
        - define reasons "<[reasons].include[<&3><[num]>.<&f> <[player].flag[moderate.<[cur_mod]>.<[num]>.reason].on_hover[<[hover].separated_by[<&nl>]>]>]>"
    - if <[cur_mod]> == permban:
      - define is_perm true
      - define col <&c>
      - define bcol <&4>
      - foreach <[nums]> as:num:
        - define "hover:!|:<&c>Permban from - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.by_player].name>"
        - define "hover:->:<&c>Permban time - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.time_now].format>"
        - define "hover:->:<&c>Was an IP ban - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.was_ip]>"
        - if <[player].flag[moderate.<[cur_mod]>.<[num]>.was_ip]>:
          - define "hover:->:<&c>IP User - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.ip_person].name>"
        - define reasons "<[reasons].include[<&c><[num]>.<&f> <[player].flag[moderate.<[cur_mod]>.<[num]>.reason].on_hover[<[hover].separated_by[<&nl>]>]>]>"
    - if <[cur_mod]> == unban:
      - define is_unban true
      - define col <&7>
      - define bcol <&8>
      - foreach <[nums]> as:num:
        - define "hover:!|:<&7>Unban from - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.by_player].name||server>"
        #---------------------------------------------#
        # Checking if the player had a ban reason
        # Bc if the player wasn't banned but an alt got IP unbanned this would break
        #----------------------------------------------#
        - if <[player].has_flag[moderate.<[cur_mod]>.<[num]>.reason]>:
          - define "hover:->:<&7>Ban reason - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.reason]>"
          - define "hover:->:<&7>Ban source - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.source]>"
          - define "hover:->:<&7>Ban created - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.created].format>"
          - if <[player].has_flag[moderate.<[cur_mod]>.<[num]>.expiration]>:
            - define "hover:->:<&7>Ban expiration - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.expiration].format> (<[player].flag[moderate.<[cur_mod]>.<[num]>.expiration].duration_since[<[player].flag[moderate.<[cur_mod]>.<[num]>.created]>].formatted>)"
        - define "hover:->:<&7>Was an IP unban - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.was_ip]>"
        - if <[player].flag[moderate.<[cur_mod]>.<[num]>.was_ip]>:
          - define "hover:->:<&7>IP User - <&f><[player].flag[moderate.<[cur_mod]>.<[num]>.ip_person].name||server>"
        - define reasons "<[reasons].include[<&7><[num]>.<&f> <[player].flag[moderate.<[cur_mod]>.<[num]>.time].format.on_hover[<[hover].separated_by[<&nl>]>]>]>"
    #---------------------------------------#
    # Looking for what tabs it should show
    #---------------------------------------#
    - define tabs <list[]>
    - if <[player].has_flag[moderate.warnings]>:
      - define tabs "<[tabs].include[<&6>[<tern[<[is_warn]>].pass[<&6>Warnings].fail[<&e><&click[/listwarns <[player].name>]><&hover[Click here to view their warnings]>Warnings<&end_hover><&end_click>]><&6>]]>"
    - if <[player].has_flag[moderate.tempban]>:
      - define tabs "<[tabs].include[<&1>[<tern[<[is_temp]>].pass[<&1>Tempbans].fail[<&3><&click[/listtemps <[player].name>]><&hover[Click here to view their tempbans]>Tempbans<&end_hover><&end_click>]><&1>]]>"
    - if <[player].has_flag[moderate.permban]>:
      - define tabs "<[tabs].include[<&4>[<tern[<[is_perm]>].pass[<&4>Permbans].fail[<&c><&click[/listperms <[player].name>]><&hover[Click here to view their permbans]>Permbans<&end_hover><&end_click>]><&4>]]>"
    - if <[player].has_flag[moderate.unban]>:
      - define tabs "<[tabs].include[<&8>[<tern[<[is_unban]>].pass[<&8>Unbans].fail[<&7><&click[/listunbans <[player].name>]><&hover[Click here to view their unbans]>Unbans<&end_hover><&end_click>]><&8>]]>"
    #-----------------#
    # The actual text
    #-----------------#
    - narrate "<&2><[player].name> <&a>lists<&nl>"
    - narrate <[tabs].separated_by[<&sp>]><&nl>
    - narrate <[reasons].separated_by[<&nl>]>
    #------------------------------------------------#
    # And some page magic stolen from my home rewrite
    #------------------------------------------------#
    - if <[max_page]> <= 1:
      - narrate " "
      - stop
    - define left_ar "<&hover[Click here to go a page backwards]><&click[/<context.alias> <[player].name> <[page].sub[1]>]><[bcol]><&chr[25C0]><&end_click><&end_hover>"
    - define right_ar "<&hover[Click here to go a page forward]><&click[/<context.alias> <[player].name> <[page].add[1]>]><[bcol]><&chr[25B6]><&end_click><&end_hover>"
    - if <[page]> == 1:
      - narrate "<&nl><[bcol]><&chr[25C1]> <&r><[col]>Page <[page]>/<[max_page]> <[right_ar]><&nl>"
      - stop
    - if <[page]> == <[max_page]>:
      - narrate "<&nl><[left_ar]> <&r><[col]>Page <[page]>/<[max_page]> <[bcol]><&chr[25B7]><&nl>"
      - stop
    - narrate "<&nl><[left_ar]> <&r><[col]>Page <[page]>/<[max_page]> <[right_ar]><&nl>"

books_data:
  type: data
  debug: false
  books:
    - warn_book
    - tempban_book
    - ban_book
    - time_book

prevent_non_mod_ban_books:
  type: world
  debug: false
  events:
    on player picks up item:
    - if <script[books_data].data_key[books].contains[<context.item.script.name||nothing>]>:
      - if <player.has_permission[zc.mod]>:
        - stop
      - determine passively cancelled
      - remove <context.entity>
    on player clicks in inventory:
    - if <script[books_data].data_key[books].contains[<context.item.script.name||nothing>]>:
      - if <player.has_permission[zc.mod]>:
        - stop
      - determine passively cancelled
      - wait 1t
      - take slot:<context.slot> from:<context.inventory>
