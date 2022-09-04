sidebar_command:
  type: command
  name: sidebar
  description: "Used to toggle the sidebar shown in dungeons"
  usage: /sidebar (on/off/toggle)
  tab completions:
    1: on|off|toggle
  script:
    - choose <context.args.first||default>:
      - case on:
        - flag player no_sidebar:!
        - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar<&nl>"
        - narrate "The <&b>sidebar<&f> has been toggled <&a>on"
      - case off:
        - flag player no_sidebar
        - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar<&nl>"
        - narrate "The <&b>sidebar<&f> has been toggled <&c>off"
      - case toggle:
        - if <player.has_flag[no_sidebar]>:
          - flag player no_sidebar:!
          - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar<&nl>"
          - narrate "The <&b>sidebar<&f> has been toggled <&a>on"
        - else:
          - flag player no_sidebar
          - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar<&nl>"
          - narrate "The <&b>sidebar<&f> has been toggled <&c>off"
      - case help:
        - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar"
        - narrate "The sidebar command toggles a sidebar on/off"
        - narrate "This sidebar only shows up while you are in the dungeons world<&nl>"
        - narrate "<&hover[Run the sidebar command]><&click[/sidebar toggle]><&a>/sidebar<&end_click><&end_hover><&f> - Is the main command"
        - narrate "Use one of these args with the command <&a><&click[/sidebar on]>on<&end_click>/<&click[/sidebar off]>off<&end_click>/<&click[/sidebar toggle]>toggle<&end_click>"
      - default:
        - if <player.has_flag[no_sidebar]>:
          - flag player no_sidebar:!
          - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar<&nl>"
          - narrate "The <&b>sidebar<&f> has been toggled <&a>on"
        - else:
          - flag player no_sidebar
          - narrate "<&a><&l>Zelda<&2><&l>Craft Sidebar<&nl>"
          - narrate "The <&b>sidebar<&f> has been toggled <&c>off"

sidebar_handler:
  type: world
  debug: false
  events:
    on player changes world to dungeons:
      - define player <player>
      - run dungeons_sidebar_task def:<[player]>
    on player changes world from dungeons:
      - sidebar remove
    on delta time secondly:
      - foreach <server.online_players> as:player:
        - if <[player].location.world.name> != dungeons:
          - foreach next
        - run dungeons_sidebar_task def:<[player]>

dungeons_sidebar_task:
  type: task
  debug: false
  definitions: player
  script:
    - if <[player].has_flag[no_sidebar]>:
      - sidebar remove players:<[player]>
      - stop
    - waituntil <yaml.list.contains[<[player].uuid>]>
    - define pvp_points <yaml[<[player].uuid>].read[pvppoints]>
    - foreach <script[show_profile].list_keys[pvp_ranks].sort_by_number[].reverse> as:score:
      - if <[pvp_points]> >= <[score]>:
        - define rank <script[show_profile].yaml_key[pvp_ranks.<[score]>]>
        - foreach stop
    - define max_magic <yaml[<[player].uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<[player].uuid>].read[completed_secrets].size>].add[100]>
    - define "text:->: <&7>Race: <&e><yaml[<[player].uuid>].read[race].to_titlecase>"
    - define "text:->: <&7>Magic: <&e><yaml[<[player].uuid>].read[magicmeter]> / <[max_magic]>"
    - define "text:->: <&7>PVP: <&e><[pvp_points]> [<[rank]>]<&e>"
    - define "text:->: <&f>"
    - define "text:->: <&7>Dungeon Pts: <&e><yaml[<[player].uuid>].read[completed_dungeons].size>"
    - define "text:->: <&7>Secret Pts: <&e><yaml[<[player].uuid>].read[completed_secrets].size>"
    - define "text:->: <&7>Current Dungeon:"
    - define "text:->: <&d><[player].location.cuboids.parse[note_name].filter_tag[<[filter_value].advanced_matches[*_dungeon]>].first.before[_dungeon].to_titlecase||Unknown>"
    - define "text:->: <&f>"
    - define "text:->: <&7>Use <&b>/bindmenu<&7>"
    - define "text:->: <&7>to equip spells"
    - define "text:->: <&f>"
    - define "text:->: <&7>Use <&b>/sidebar"
    - define "text:->: <&7>to toggle this"
    - define sep <&8>+<empty.pad_right[<[text].parse[text_width].highest.div[8].round_down>].with[-]>+
    - define values:->:<[sep]>
    - define values:|:<[text]>
    - define values:->:<&f><[sep]>
    - sidebar set title:<&e><&l>Dungeons values:<[values]> players:<[player]>
