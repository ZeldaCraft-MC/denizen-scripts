colored_item_events:
  type: world
  debug: false
  events:
    on player prepares anvil craft item:
    - if !<player.has_permission[zc.item.color]> || <context.item.material.name> == air:
      - stop
    - define new_name <context.new_name>
    - while <def[new_name].contains[&k]>:
      - define new_name <def[new_name].replace[&k]>
    - adjust <context.item> "display_name:<def[new_name].parse_color>" "save:item"
    - determine passively <entry[item].result>
    - inventory update
