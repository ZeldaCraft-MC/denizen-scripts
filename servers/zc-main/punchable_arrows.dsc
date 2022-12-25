punchable_arrows_events:
  type: world
  debug: false
  events:
    on player left clicks block:
      - define arr <player.target[arrow].within[4]||false>
      - if <[arr].is_truthy> && <[arr].is_on_ground>:
        - remove <[arr]>
