loftwing:
  type: entity
  entity_type: parrot
  mechanisms:
    custom_name: Loftwing
    custom_name_visible: true

loftwing_events:
  type: world
  debug: false
  events:
    on player right clicks loftwing:
    - ratelimit <player> 1s
    - if <context.entity.has_passenger>:
      - stop
    - mount <player>|<context.entity>
    on loftwing pathfinds:
    - determine cancelled
    on player steers loftwing:
    - if <context.dismount> && <context.entity.is_on_ground>:
      - stop
    - determine passively cancelled
    - define mov <location[0,0,0]>
    - if <context.forward> > 0:
      - define mov <player.location.with_pitch[0].forward[0.6].sub[<player.location>]>
    - else if <context.forward> < 0:
      - define mov <player.location.with_pitch[0].backward[0.1].sub[<player.location>]>
    - if <context.sideways> != 0:
      - define mov <[mov].add[<player.location.with_pitch[0].left[1].sub[<player.location>].div[3].mul[<context.sideways>]>]>
    - if <context.jump>:
      - define mov <[mov].above[0.5]>
    - else if <context.dismount>:
      - define mov <[mov].below[0.5]>
    - if <[mov].xyz> != 0.0,0.0,0.0:
      - look <context.entity> <player.location.forward[5]>
      - if <context.entity.is_on_ground>:
        - adjust <context.entity> move:<[mov].div[5]>
      - else:
        - playeffect effect:spell offset:0.3,0.3,0.3 at:<context.entity.location>
        - adjust <context.entity> move:<[mov]>
