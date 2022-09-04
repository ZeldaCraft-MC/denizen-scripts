pl_command:
  type: world
  debug: false
  events:
    on pl|plugins command:
      - if <player||null> != null && !<player.has_permission[zc.plugins]>:
        - determine passively fulfilled
        - narrate "Plugins (?): <&a>Custom features are created by our developers!"
