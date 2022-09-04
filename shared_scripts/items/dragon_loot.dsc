ender_dragon_events:
  type: world
  debug: false
  events:
    on ender_dragon death:
      - define drops <list>
      - define rand <util.random.decimal>
      - if <context.entity.location.world.name> == resources_nullscape_end_island:
        - define drops <[drops].include[zc_dragon_scale|zc_dragon_scale]>
        - if <[rand]> < 0.40:
          - define drops <[drops].include[dragon_head]>
        - if <[rand]> < 0.25:
          - define drops <[drops].include[dragon_egg]>
        - if <[rand]> < 0.15:
          - define drops <[drops].include[ender_dragon_wings]>
        - if <[rand]> < 0.02:
          - define drops <[drops].include[bedrock]>
        - determine <[drops]>
      - else:
        - define drops <[drops].include[zc_dragon_scale]>
        - if <[rand]> < 0.20:
          - define drops <[drops].include[dragon_head]>
        - if <[rand]> < 0.15:
          - define drops <[drops].include[dragon_egg]>
        - if <[rand]> < 0.10:
          - define drops <[drops].include[ender_dragon_wings]>
        - if <[rand]> < 0.005:
          - define drops <[drops].include[bedrock]>
        - determine <[drops]>

ender_dragon_wings:
  type: item
  debug: false
  material: elytra
  durability: 431
  display name: Dragon Wings
  lore:
    - "The tattered wings of a great beast."
