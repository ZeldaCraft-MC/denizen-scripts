mythicmobs_events_main:
  type: world
  debug: false
  events:
    on entity spawns in:ganon_fight_room:
      - if !<context.entity.is_mythicmob> && <context.entity.is_living>:
        - determine cancelled
