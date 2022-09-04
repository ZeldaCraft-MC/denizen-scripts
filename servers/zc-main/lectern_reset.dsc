lectern_reset_events:
  type: world
  debug: false
  events:
    on player right clicks lectern:
      - adjust <context.location> lectern_page:0
