head_command:
  type: command
  name: head
  permission: sajkdsad
  script:
    - give "player_head[skull_skin=<util.random.uuid>|<element[{'textures': {'SKIN': {'url': 'https://education.minecraft.net/wp-content/uploads/<context.args.get[1]>.png'}}}].base64_encode>|<context.args.get[1]>]"

head2_command:
  type: command
  name: head2
  permission: sajkdsad
  script:
    - give "player_head[skull_skin=<util.random.uuid>|<element[{'textures': {'SKIN': {'url': 'https://feedback.minecraft.net/hc/user_images/<context.args.get[1]>.png'}}}].base64_encode>|<context.args.get[1]>]"
