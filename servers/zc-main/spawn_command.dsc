spawn_command:
  type: command
  debug: false
  description: Teleports you to spawn.
  usage: /spawn
  name: spawn
  script:
    - run warp_task def:spawn
