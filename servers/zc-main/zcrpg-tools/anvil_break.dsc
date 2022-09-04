anvil_events:
  type: world
  debug: false
  events:
    on player right clicks anvil|chipped_anvil|damaged_anvil in:spawn:
      - modifyblock <context.location> anvil[direction=<context.location.material.direction>]
