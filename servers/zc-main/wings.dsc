back_item_entity:
  type: entity
  debug: false
  entity_type: armor_stand
  mechanisms:
    has_ai: false
    marker: true
  #visible: false
  flags:
    stay_mounted: true

test_wings:
  type: command
  debug: false
  description: Tests wings
  usage: /testwings
  name: testwings
  permission: aaaaaa
  script:
    - if <player.gamemode> != creative:
      - stop
    - if <context.args.get[1]||null> == null || !<context.args.get[1].is_integer>:
      - narrate "Usage: /testwings (custom_model_data)"
      - stop
    - give wing_item[custom_model_data=<context.args.get[1]>]

equip_command:
  type: command
  debug: false
  description: Equips wings
  usage: /equip
  name: equip
  permission: aaaaa
  script:
    - if <player.gamemode> != creative:
      - stop
    - if <player.item_in_hand.script.name||null> != wing_item:
      - stop
    - if <player.has_passenger>:
      - narrate "unequip your wings first"
      - stop
    - equip <player> chest:<player.item_in_hand>
    - mount back_item_entity[equipment=air|air|air|<player.item_in_hand>]|<player> save:e
    - define e <entry[e].mounted_entities.get[1]>
    - while <[e].is_truthy> && <player.is_online>:
      - wait 1t
      - look <[e]> yaw:<player.body_yaw>

back_item_events:
  type: world
  debug: false
  events:
    on back_item_entity exits player:
      - adjust <queue> linked_player:<context.vehicle>
      - if <context.entity.is_spawned>:
        - determine cancelled
    on player unequips chestplate:
      - if <context.old_item.script.name||null> != wing_item:
        - stop
      - remove <player.passenger>
