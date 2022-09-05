custom_data_command:
  type: command
  debug: false
  description: Applies custom model data to items
  usage: /custom_data
  name: custom_data
  permission: zc.custom_data
  script:
    - if <player.gamemode> != creative:
      - narrate "Must be in creative mode"
      - stop
    - if !<context.args.first.exists> or !<context.args.first.is_integer>:
      - narrate "Must give this command a number"
      - stop
    - inventory adjust custom_model_data:<context.args.first> slot:<player.held_item_slot>
