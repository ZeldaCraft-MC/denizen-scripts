# A comphrehensive list of zcrpg commands

fill_magic:
  type: command
  name: fillmagic
  description: fills your magic
  usage: /fillmagic
  permission: op
  debug: false
  script:
    - narrate "Your magic has been filled" format:zc_text
    - yaml set magicmeter:<yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]> id:<player.uuid>

zeldacraft_command:
  type: command
  name: zeldacraft
  description: The main ZeldaCraft command.
  permission: zc.default
  usage: /zeldacraft
  debug: false
  aliases:
    - zc
  tab complete:
    - define base_cmds:|:bind|changerace|checkpoint|finished|help|race|races|secrets|spell|spells|stats|toppvp|unbind
    - if <player.is_op>:
      - define base_cmds:|:reload

    - define args <context.args>
    - if <context.raw_args.length> == 0 || <context.raw_args.char_at[<context.raw_args.length>]> == " " || <context.args.is_empty>:
      - define args:->:<empty>

    - if <[args].size> == 1:
      - determine <[base_cmds].filter[starts_with[<[args].get[1]>]]>

    - if <[args].size> == 2:
      - choose <[args].get[1]>:
        - case bind spell:
          - determine <yaml[zcrpg_config].read[spell_list].filter[starts_with[<[args].get[2]>]]>
        - case race changerace:
          - determine <yaml[zcrpg_config].list_keys[races].filter[starts_with[<[args].get[2]>]]>
        - case secrets:
          - determine <yaml[zcrpg_config].list_keys[dungeons].filter[starts_with[<[args].get[2]>]]>
        - case stats:
          - determine <server.online_players.parse[name].filter[starts_with[<[args].get[2]>]]>
        - case help:
          - determine <list[1|2|3].filter[starts_with[<[args].get[2]>]]>

  script:
    - if !<yaml.list.contains[<player.uuid>]>:
      - narrate "<&c>We weren't able to load your player data for some reason. Please contact an admin!"
      - stop

    - choose <context.args.get[1]||null>:
      - case bind:
        - run zc_bind def:<context.args.get[2].to_lowercase||null>
      - case changerace:
        - run zc_changerace def:<context.args.get[2].to_lowercase||null>
      - case checkpoint:
        - run zc_checkpoint
      - case finished:
        - run zc_finished
      - case help:
        - run zc_help def:<context.args.get[2].round_down||1>
      - case race:
        - run zc_race def:<context.args.get[2].to_lowercase||null>
      - case races:
        - run zc_races
      - case reload:
        - run zc_reload
      - case secrets:
        - run zc_secrets def:<context.args.get[2].to_lowercase||null>
      - case spell:
        - run zc_spell def:<context.args.get[2].to_lowercase||null>
      - case spells:
        - run zc_spells def:<context.args.get[2].round_down||1>
      - case stats:
        - run zc_stats def:<context.args.get[2]||null>
      - case toppvp:
        - run zc_toppvp
      - case unbind:
        - run zc_unbind
      - default:
        - define fail true
        - narrate "<&e>Please type /zc help to get started with the ZeldaCraft RPG"

    #- if !<[fail]||false>:
    #  - yaml set 'statsd.player~commands~zc_<context.args.get[1].to_lowercase>:++' id:stats_log

zc_bind:
  type: task
  definitions: spell
  debug: false
  script:
    - if <[spell]> == null:
      - narrate "<&c>Please specify a spell to bind. E.g. /zc bind goron_tunic"
      - narrate "<&c>You can view available spells with /zc spells"
      - stop

    - if !<yaml[zcrpg_config].contains[spells.<[spell]>]>:
      - narrate "<&c>Spell with that code not found. Please type /zc spells to see a list of spells."
      - narrate "<&c>You can then bind the spell to an item using /zc bind, e.g. /zc bind goron_tunic"
      - stop

    - if <player.item_in_hand.material.name> == air:
      - narrate "<&c>Cannot bind a spell to air! Please hold an item in your hand."
      - stop

    - if !<player.item_in_hand.has_nbt[spell]>:
      - if <player.item_in_hand.script.exists> || !<player.item_in_hand.nbt_keys.exclude[spell].is_empty> || <player.item_in_hand.has_lore>:
        - narrate "<&c>Can't bind a spell to a custom item!"
        - stop

    - define dungeon_points <yaml[zcrpg_config].read[spells.<[spell]>.dp]||0>
    - if <yaml[<player.uuid>].read[completed_dungeons].size> < <[dungeon_points]>:
      - narrate "<&c>Your dungeon points are too low to use this spell! Requires <[dungeon_points]> dungeon points."
      - stop

    - define secret_points <yaml[zcrpg_config].read[spells.<[spell]>.sp]||0>
    - if <yaml[<player.uuid>].read[completed_secrets].size> < <[secret_points]>:
      - narrate "<&c>Your secret points are too low to use this spell! Requires <[secret_points]> secret points."
      - stop

    - define pvp_points <yaml[zcrpg_config].read[spells.<[spell]>.pvp]||0>
    - if <yaml[<player.uuid>].read[pvppoints]> < <[pvp_points]>:
      - narrate "<&c>Your pvp points are too low to use this spell! Requires <[pvp_points]> pvp points."
      - stop

    - define item <player.item_in_hand>
    - define lore:|:<empty>|<&a>[<yaml[zcrpg_config].read[spells.<[spell]>.name]>]
    - foreach <yaml[zcrpg_config].read[spells.<[spell]>.description].split_lines_by_width[150].split[<&nl>]>:
      - define lore:|:<&7><[value]>
    - take iteminhand quantity:1
    - give <[item].with[nbt=spell/<[spell]>|uniquifier/<util.random_uuid>;lore=<[lore]>]> quantity:1

    - narrate "<&e>The spell has been bound successfully."
    - narrate "<&e>It will now be cast whenever you use the item you placed it on."
    - narrate "<&e>You can unbind the spell with /zc unbind."

zc_changerace:
  type: task
  definitions: race
  debug: false
  script:
    - if <[race]> == null:
      - narrate "<&c>Please specify a race, e.g. /zc changerace kokiri"
      - narrate "<&c>For a list of available races, type /zc races"
      - stop

    - if !<yaml[zcrpg_config].contains[races.<[race]>]>:
      - narrate "<&c>The race you specified could not be found."
      - narrate "<&c>For a list of available races, type /zc races"
      - stop

    - yaml set race:<[race]> id:<player.uuid>
    - narrate "<&e>You are now a member of the <&a><[race]><&e> race."

zc_checkpoint:
  type: task
  debug: false
  script:
    - define uuid <player.uuid>
    - define loc <location[<yaml[<[uuid]>].read[checkpoint_x]>,<yaml[<[uuid]>].read[checkpoint_y]>,<yaml[<[uuid]>].read[checkpoint_z]>,dungeons]>
    - if <[loc].simple> == 0,0,0,dungeons:
      - narrate "<&c>You don't have a checkpoint set."
      - stop
    - teleport <player> <[loc]>

zc_finished:
  type: task
  debug: false
  script:
    - define dungeons <yaml[<player.uuid>].read[completed_dungeons]>
    - narrate "<&3><player.name>'s finished dungeons: <&r><[dungeons].size>"
    - narrate "<&3>List: <&r><[dungeons].pad_right[1].with[none].separated_by[ ]>"

zc_help:
  type: task
  definitions: page
  debug: false
  script:
    - narrate "<&3>ZeldaCraft RPG Help - Page <[page]>"
    - if <[page]> == 3:
      - narrate "<&e>- Gain <&b>dungeon points<&e> by completing parkour/dungeons in the dungeons world (type /warp dungeons)"
      - narrate "<&e>- Gain <&b>secret points<&e> by finding hidden areas inside dungeons."
      - narrate "<&e>- Gain <&b>PVP points<&e> by killing other players."
      - narrate "<&e>- The higher your stats are, the more spells you will be able to use!"
    - else if <[page]> == 2:
      - narrate "<&b>/zc spells <&e>- View a list of spells."
      - narrate "<&b>/zc spell [spell code] <&e>- View information about a certain spell."
      - narrate "<&b>/zc bind [spell code] <&e>- Bind a spell to the item you are holding."
      - narrate "<&b>/zc unbind <&e>- Unbind a spell from the item you are holding."
      - narrate "<&b>/zc finished <&e>- Lists all dungeons you have finished."
      - narrate "<&b>/zc secrets <&e>- Check which secrets you have discovered."
      - narrate "<&a>Use /zc help 3 to view information about the RPG."
    - else:
      - narrate "<&b>/zc races <&e>- View a list of races."
      - narrate "<&b>/zc changerace [race] <&e>- Change your race."
      - narrate "<&b>/zc stats <&e>- View your own stats."
      - narrate "<&b>/zc stats [name] <&e>- View another player's stats."
      - narrate "<&a>Use /zc help 2 to view more commands."

zc_race:
  type: task
  definitions: race
  debug: false
  script:
    - if <[race]> == null:
      - narrate "<&c>Please specify a race, e.g. /zc race kokiri"
      - narrate "<&c>For a list of available races, type /zc races"
      - stop

    - if !<yaml[zcrpg_config].contains[races.<[race]>]>:
      - narrate "<&c>The race you specified could not be found."
      - narrate "<&c>For a list of available races, type /zc races"
      - stop

    - narrate "<&3><[race].to_titlecase>: <&7><yaml[zcrpg_config].read[races.<[race]>.description]>"
    - narrate "<&b>Perk: <&e><yaml[zcrpg_config].read[races.<[race]>.perk]>"
    - narrate "<&a>To become a member of this race type /racemenu"

zc_races:
  type: task
  debug: false
  script:
    - narrate "<&b>Available races: <&e><yaml[zcrpg_config].list_keys[races].separated_by[, ]>"
    - narrate "<&a>To view info for a race type /zc race <&lt>name<&gt>, e.g. /zc race hylian"

zc_reload:
  type: task
  debug: false
  script:
    - ~yaml load:zcrpg_config.yml id:zcrpg_config
    - narrate "<&a>Configuration file reloaded."

zc_secrets:
  type: task
  definitions: dungeon
  debug: false
  script:
    - if <[dungeon]> == null:
      - narrate "<&c>Please specify a dungeon to check secrets for. E.g. /zc secrets dungeon1"
      - stop

    - if !<yaml[zcrpg_config].contains[dungeons.<[dungeon]>]>:
      - narrate "<&c>The dungeon you specified could not be found."
      - stop

    - define secrets <yaml[zcrpg_config].read[dungeons.<[dungeon]>.secrets].as[list].exclude[none]>
    - if <[secrets].size> == 1:
      - narrate "<&3>There is <&e>1<&3> secret in <[dungeon].to_titlecase>"
    - else:
      - narrate "<&3>There are <&e><[secrets].size><&3> secrets in <[dungeon].to_titlecase>"

    - define completed <[secrets].exclude[<[secrets].exclude[<yaml[<player.uuid>].read[completed_secrets]>]>]>
    - if <[completed].size> > 0:
      - narrate "<&b>You have found <[completed].size> of them: <&e><[completed].separated_by[, ]>"

zc_spell:
  type: task
  definitions: spell
  debug: false
  script:
    - if <[spell]> == null:
      - narrate "<&c>Please specify a spell to view. E.g. /zc spell goron_tunic"
      - narrate "<&c>You can view available spells with /zc spells"
      - stop

    - if !<yaml[zcrpg_config].contains[spells.<[spell]>]>:
      - narrate "<&c>Spell with that code not found. Please type /zc spells to see a list of spells."
      - narrate "<&c>You can then bind the spell to an item using /zc bind, e.g. /zc bind goron_tunic"
      - stop

    - narrate "<&3>[ <yaml[zcrpg_config].read[spells.<[spell]>.name]> ]"
    - if <yaml[zcrpg_config].contains[spells.<[spell]>.cooldown]>:
      - narrate "<&a>Cooldown: <&e><duration[<yaml[zcrpg_config].read[spells.<[spell]>.cooldown]>].formatted>"
    - narrate "<&a>Magic Cost: <&e><yaml[zcrpg_config].read[spells.<[spell]>.cost]>"
    - if <yaml[zcrpg_config].contains[spells.<[spell]>.dp]>:
      - narrate "<&b>Requires <&e><yaml[zcrpg_config].read[spells.<[spell]>.dp]><&b> Dungeon Points"
    - if <yaml[zcrpg_config].contains[spells.<[spell]>.sp]>:
      - narrate "<&b>Requires <&e><yaml[zcrpg_config].read[spells.<[spell]>.sp]><&b> Secret Points"
    - if <yaml[zcrpg_config].contains[spells.<[spell]>.pvp]>:
      - narrate "<&b>Requires <&e><yaml[zcrpg_config].read[spells.<[spell]>.pvp]><&b> PVP Score"
    - narrate <&a><yaml[zcrpg_config].read[spells.<[spell]>.description]>

zc_spells:
  type: task
  definitions: page
  debug: false
  script:
    - define page_size 5
    - define spells <yaml[zcrpg_config].read[spell_list]>
    - define last_page <[spells].size.div[<[page_size]>].round_up>
    - if <[page]> > <[last_page]> || <[page]> < 1:
      - define page 1

    - define start <[page].sub[1].mul[<[page_size]>].add[1]>
    - define end <[start].add[<[page_size]>].sub[1]>
    - narrate "<&3>Spells List - Page <[page]> of <[last_page]>"
    - foreach <[spells].get[<[start]>].to[<[end]>]> as:spell:
      - narrate "<&e><yaml[zcrpg_config].read[spells.<[spell]>.name]> (<[spell]>)"
    - if <[page]> != <[last_page]>:
      - narrate "<&b>Next page: /zc spells <[page].add[1]>"

zc_stats:
  type: task
  definitions: name
  debug: false
  script:
    - if <[name]> == null:
      - run show_profile def:<player>
      - stop

    - define player <server.match_player[<[name]>]||null>
    - if <[player]> == null || <[player].name> != <[name]>:
      - define player <server.match_offline_player[<[name]>]||null>
      - if <[player]> == null || <[player].name> != <[name]>:
        - narrate "<&c>The specified player could not be found."
        - stop

    - run show_profile def:<[player]>

zc_toppvp:
  type: task
  debug: false
  script:
    - ~webget http://localhost:8080/toppvp save:request
    - yaml loadtext:<entry[request].result> id:<player.uuid>-toppvp

    - narrate "<&d>Top 5 PVP Scores"
    - narrate <yaml[<player.uuid>-toppvp].read[result].separated_by[<n>].parse_color>

    - yaml unload id:<player.uuid>-toppvp

zc_unbind:
  type: task
  debug: false
  script:
    - if !<player.item_in_hand.has_nbt[spell]>:
      - narrate "<&c>This item doesn't have a spell bound to it!"
      - stop

    - define item <player.item_in_hand>
    - take iteminhand quantity:1
    - give <[item].with[remove_nbt=;lore=]> quantity:1

    - narrate "<&a>Spell binding was removed from the item in your hand!"

show_profile:
  type: task
  definitions: player
  debug: false
  data:
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
  script:
    - define uuid <[player].uuid>
    - if !<yaml.list.contains[<[uuid]>]>:
      - ~webget http://localhost:8080/players/<[uuid]> save:request
      - if <entry[request].failed>:
        - narrate "<&c>This player isn't registered to ZC."
        - stop
      - yaml loadtext:<entry[request].result> id:<[uuid]>
      - define unload true

    - define pvp_points <yaml[<[uuid]>].read[pvppoints]>
    - define max_magic <yaml[<[uuid]>].read[completed_dungeons].size.mul[3].add[<yaml[<[uuid]>].read[completed_secrets].size>].add[100]>
    - foreach <script.list_keys[data.pvp_ranks].sort_by_number[].reverse> as:score:
      - if <[pvp_points]> >= <[score]>:
        - define rank <script.data_key[data.pvp_ranks.<[score]>]>
        - foreach stop

    - narrate "<&3><[player].name> (<yaml[<[uuid]>].read[race]>)"
    - narrate <&3>~~~~~~~~~~~~~~~~~~~
    - narrate "<&e>Dungeon Points: <&a><yaml[<[uuid]>].read[completed_dungeons].size>"
    - narrate "<&e>Secret Points: <&a><yaml[<[uuid]>].read[completed_secrets].size>"
    - if <player.uuid> == <[uuid]>:
      - narrate "<&e>Magic Meter: <&a><yaml[<[uuid]>].read[magicmeter]>/<[max_magic]>"
    - narrate <&3>~~~~~~~~~~~~~~~~~~~
    - narrate "<&e>PVP Points: <&a><[pvp_points]> <&e>| Rank: <&a><[rank]>"

    - if <[unload]||false>:
      - yaml unload id:<[uuid]>
