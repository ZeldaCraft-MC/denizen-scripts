edit_sign_cmd:
  type: command
  description: Use to edit a sign.
  usage: /es
  debug: false
  name: es
  script:
    - if <player.has_permission[zcshop.admin].or[<player.is_op>].not>:
      - narrate "<&c>You don't have permission to create Admin Shops."
      - determine <context.old>
    - adjust <player> edit_sign:<player.cursor_on>
