creeper_explosion_events:
  type: world
  debug: false
  events:
    on creeper explodes:
      - if !<list[s3|s3_nether].contains[<context.location.world.name>]>:
        - determine cancelled
    on dropped_item damaged by entity_explosion:
      - determine cancelled
    on dropped_item damaged by block_explosion:
      - determine cancelled
