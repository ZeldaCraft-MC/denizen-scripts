custom_data_command:
  type: command
  description: Applies custom model data to items
  usage: /custom_data
  name: custom_data
  permission: zc.custom_data
  script:
    - if <player.gamemode> != creative:
      - narrate "must be in creative mode"
      - stop
    - if <context.args.get[1]||null> == null:
      - narrate "gotta give this command a number"
      - stop
    - inventory adjust custom_model_data:<context.args.get[1]> slot:<player.held_item_slot>
