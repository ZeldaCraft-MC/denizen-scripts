flair_command:
  type: command
  debug: false
  name: flair
  description: Sets your flair, a symbol that appears after your nickname.
  usage: /flair
  permission: zc.flair
  data:
    symbols:
      - 2600
      - 2601
      - 26C8
      - 2602
      - 2614
      - 26C4
      - 2603
      - 2604
      - 2605
      - 2606
      - 2608
      - 2615
      - 2618
      - 2620
      - 2623
      - 2624
      - 262C
      - 262E
      - 262F
      - 263B
      - 263A
      - 2639
      - 263D
      - 2660
      - 2663
      - 2764
      - 2666
      - 2664
      - 2667
      - 2661
      - 2662
      - 2669
      - 266A
      - 266B
      - 266C
      - 266D
      - 266E
      - 266F
      - 267F
      - 2690
      - 2691
      - 2692
      - 2694
      - 2693
      - 2695
      - 26A0
      - 26A1
      - 26C3
      - 26CF
      - 03A9
      - 0024
      - 00A2
      - 2765
      - 27B5
      - 03C0
      - 03BB
      - 03B8
      - 03B4
      - 03C8
      - 222B
      - 2234
      - 2235
      - 221E
      - 2726
      - 2122
      - 2702
      - 2116
      - 2714
      - 2715
      - 2716
      - 2717
  script:
    - if <context.args.get[1]||null> != null:
      - define color <context.args.get[1].parse_color>
      - if <[color].strip_color.length> > 0:
        - narrate "<&c>You can only use valid essentials color codes such as &a, &o, &#abc123, ..."
        - stop
      - if <[color].contains_text[<&ss>k]> && !<player.has_permission[allow.crazy.flair]>:
        - narrate "<&c>Your style cannot contain &k."
        - stop
      - narrate "<&7>Successfully set your flair style!"
      - flag <player> flair_style:<[color]>
      - stop
    - narrate "<&7>Available flairs (click to change):"
    - foreach <script.data_key[data.symbols].sub_lists[24]> as:l:
      - foreach <[l]>:
        - clickable set_flair def.char:<[value]> save:click
        - define line "<[line]||> <player.flag[flair_style]||<&f>><&chr[<[value]>].on_click[<entry[click].command>].on_hover[<&7>Set flair to <player.flag[flair_style]||<&f>><&chr[<[value]>]>]><&r>"
      - narrate <[line]>
      - define line <empty>
    - narrate "<&7>Set your flair's color and format with <&hover[<&7>For example, <&e>/flair &a&l <&7>or <&e>/flair &#abc123]><&e>/flair (style)<&end_hover>"
    - clickable clear_flair save:clear_click
    - narrate "<&c><&lb><&click[<entry[clear_click].command>]><&hover[<&c>Click to clear.]>Clear current flair<&rb><&end_hover><&end_click>"

clear_flair:
  type: task
  script:
    - if !<player.has_permission[zc.flair]>:
      - stop
    - adjust <player> chat_suffix:<empty>
    - narrate "<&c>Cleared your flair"

set_flair:
  type: task
  definitions: char
  script:
    - if !<player.has_permission[zc.flair]>:
      - stop
    - adjust <player> chat_suffix:<&chr[<[char]>]>
    - execute as_server "lp user <player.name> meta setsuffix <&dq><&chr[<[char]>]><&dq>"
    - narrate "<&7>Set your flair to <player.flag[flair_style]||<&f>><&chr[<[char]>]>"
