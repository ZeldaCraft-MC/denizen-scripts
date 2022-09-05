colored_item_events:
  type: world
  debug: false
  events:
    on player prepares anvil craft item:
      - if !<player.has_permission[zc.item.color]> || <context.item.material.name> == air:
        - stop
      - define new_name <context.new_name>
      - while <[new_name].contains_text[&k]>:
        - define new_name <[new_name].replace_text[&k]>
      - adjust <context.item> display:<[new_name].parse_color> save:item
      - determine passively <entry[item].result>
      - inventory update
