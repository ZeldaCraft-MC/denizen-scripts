nick_helper_events:
  type: world
  debug: false
  events:
    after nick|nickname command:
      - if !<player.has_permission[essentials.nick]>:
        - stop
      - if <context.args.size> > 0:
        - stop
      - if <player.display_name> == <player.name>:
        - stop
      - if <player.display_name.ends_with[<&ss>r]>:
        - define nick <player.display_name.before_last[<&ss>r]>
      - else:
        - define nick <player.display_name>
      - while <[nick].length> > 0:
        - define lc <[nick].last_color>
        - define part <[nick].after_last[<[lc]>]>
        - if <[part].length> == 0:
          - define nick_list:|:<[nick]>|<[lc]>
          - define nick <empty>
          - while stop
        - define nick_list:|:<[part]>|<[lc]>
        - define nick <[nick].before_last[<[lc]>]>
      - define nick_list <[nick_list].reverse>
      - foreach <[nick_list]>:
        - if <[value].starts_with[<&ss>]>:
          - define i 1
          - define converted <empty>
          - while <[i]> <= <[value].length>:
            - if <[value].substring[<[i]>,<[i].add[1]>]> != <&ss>x:
              - define converted <[converted]>&<[value].char_at[<[i].add[1]>]>
              - define i:+:2
            - else:
              - define converted <[converted]>&#<[value].substring[<[i].add[2]>,<[i].add[14]>].replace_text[<&ss>]>
              - define i:+:14
          - define out:->:<[converted].replace_text[<&ss>].with[&]>
        - else:
          - define out:->:<[value]>
      - define curr_color <empty>
      - define clickable <empty>
      - foreach <[out]>:
        - if <[value].parse_color.strip_color.length> == 0:
          - define curr_color <[curr_color]><[value].parse_color>
          - define clickable <[clickable]><&7><[value]>
        - else:
          - define clickable <[clickable]><[curr_color]><[value]>
      - narrate "<n><&6>Your current nickname (click to edit):<&r><n><[clickable].on_click[/nick <[out].separated_by[]>].type[suggest_command].on_hover[<&e>Click to edit!]>"
