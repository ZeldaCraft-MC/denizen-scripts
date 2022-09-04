builds_command:
  type: command
  debug: false
  name: builds
  description: Go to our builds world.
  usage: /builds
  permission: zc.builds
  script:
    - adjust <player> send_to:builds

rpg_command:
  type: command
  debug: false
  name: rpg
  description: Go to our rpg server.
  usage: /rpg
  permission: zc.rpg
  script:
    - adjust <player> send_to:rpg
