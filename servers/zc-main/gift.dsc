gifts_inv:
  type: inventory
  title: Your Gifts
  inventory: chest
  gui: true
  definitions:
    _: light_blue_stained_glass_pane[display_name=<&f>]
    b: "book[display=<&b>Click a gift to open it!;lore=<empty>|<&7>Use <&b>/gift (name)<&7> to send|<&7>someone else a gift!]"
  slots:
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [_] [_] [_] [_] [b] [_] [_] [_] [_]

rupee:
  type: item
  material: emerald
  mechanisms:
    custom_model_data: 100

gift_inv:
  type: inventory
  inventory: chest
  gui: true
  definitions:
    _: light_blue_stained_glass_pane[display_name=<&f>]
    1: <server.flag[gift_red]>
  slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [barrier] [bundle] [rupee] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

# Gift skins:
# gift_red
# gift_cyan
# gift_blue
# gift_purple
# gift_brown
# gift_green
# gift_pink
# gift_magenta
# gift_black

# Admin gift skins:
# gift_chest
# gift_iron_chest
# gift_gold_chest
# gift_royal_chest
# gift_mystic_chest

open_gifts:
  type: task
  script:
    - define inv <inventory[gifts_inv]>
    - foreach <player.flag[gifts]> as:gift_map:
      - define c <element[.].repeat[100].hex_rainbow.split[.].random>
      - if <[gift_map.type]> == items:
        - define present_item <server.flag[<[gift_map.present]>]>
        - adjust def:present_item "display:<[c]>A gift for you!"
        - adjust def:present_item "lore:<&7>Sent by <[c]><[gift_map.sender]>||<&7>Note:|<&7><[gift_map.note]>||<&7>Contains:|<[c]><[gift_map.value].size>x Item(s)"
        - adjust def:present_item flag:uniq:<util.random.uuid>
        - give <[present_item]> to:<[inv]>
    - inventory open d:<[inv]>

gifts_command:
  type: command
  name: gifts
  usage: /gifts
  description: Send and receive gifts.
  permission: zc.gift
  script:
    - define gifts <list>
    - repeat 27:
      - definemap gift:
          type: items
          present: gift_red
          value: <list[stone|stick]>
          sender: <player.name>
          note: heyo itsa mergu
      - define gifts:->:<[gift]>
    - flag <player> gifts:<[gifts]>
    - run open_gifts

match_player:
  type: procedure
  debug: false
  definitions: name
  script:
    - if <[name].length> < 3 || <[name].length> > 16:
      - determine null
    - define p <server.match_player[<[name]>].if_null[null]>
    - if <[p]> == null:
      - define p <server.match_offline_player[<[name]>].if_null[null]>
    - determine <[p]>

gift_command:
  type: command
  name: gift
  usage: /gift (user)
  description: Send a gift to another player!
  permission: zc.gift
  script:
    - if !<context.args.first.exists>:
      - narrate "<&7>Usage: <&b><script.data_key[usage]>"
      - stop
    - define p <context.args.first.proc[match_player]>
    - if <[p]> == null:
      - narrate "<&7>Unable to find player! Have they logged in before?"
      - stop
    - define inv <inventory[gift_inv]>
    - adjust <[inv]> "title:<&translate[space.-8]><&f><&chr[0001].font[menus]><&translate[space.-248]><&3>Gifting to: <&b><[p].name>"
    - inventory open d:<[inv]>
