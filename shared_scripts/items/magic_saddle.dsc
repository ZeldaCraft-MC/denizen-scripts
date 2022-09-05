magic_saddle:
  debug: false
  type: item
  material: saddle
  display name: Magic Saddle
  enchantments:
  - LUCK:1
  lore:
  - "If it fits, I sits"
  mechanisms:
    hides:
      - ENCHANTS

magic_saddle_command:
  debug: false
  type: command
  name: magicsaddle
  permission: zcrpg.magicsaddle
  description: "Gives you a magic saddle that lets you ride any passive mobs and players!"
  usage: /magicsaddle
  script:
  - if <player.world.name> == dungeons:
    - narrate "<&c>I'm sorry, you can't use that command here."
    - stop
  - give magic_saddle

#magic_saddle_events:
#  debug: false
#  type: world
#  events:
#    on player right clicks entity with magic_saddle:
#    - determine passively cancelled
#    - if <player.world.name> == dungeons:
#      - narrate "<&c>I'm sorry, you can't use that command here."
#      - stop
#    - if !<player.has_permission[zcrpg.magicsaddle]> || !<context.entity.is_living> || <context.entity.is_monster>:
#      - stop
#    - mount <player>|<context.entity>
#
#    on player clicks magic_saddle in inventory:
#    - if <context.slot_type> == RESULT:
#      - determine cancelled
