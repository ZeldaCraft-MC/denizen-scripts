spawner_events:
  type: world
  debug: false
  events:
    on delta time secondly every:5:
      - if <server.recent_tps.get[1]> < 18:
        - flag server spawners_disabled duration:5m
        - remove <world[s1].living_entities.filter[from_spawner].include[<world[s2].living_entities.filter[from_spawner]>]>

    on entity prespawns because spawner in:s* server_flagged:spawners_disabled:
      - determine cancelled

    on player places spawner:
      - if !<context.location.center.find_blocks[spawner].within[2.1].remove[1].is_empty>:
        - narrate "<&c>Spawners can't be placed near each other!"
        - determine cancelled
