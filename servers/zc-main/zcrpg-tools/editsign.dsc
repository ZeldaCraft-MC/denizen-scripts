edit_sign_cmd:
  type: command
  debug: false
  name: es
  script:
    - if <player.has_permission[zcshop.admin].or[<player.is_op>].not>:
      - narrate "<&c>You don't have permission to create Admin Shops."
      - determine <c.old>
    - adjust <player> edit_sign:<player.location.cursor_on>
