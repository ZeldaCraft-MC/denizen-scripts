kiss_animation:
  type: world
  debug: false
  events:
    on player right clicks player:
      - ratelimit <player> 5t
      - if <player.location.distance[<context.entity.location>]> < 3 && <player.is_sneaking>:
        - animate <player> animation:arm_swing
        - playeffect effect:heart at:<player.location.add[<context.entity.location.sub[<player.location>].div[2]>].above[2]> offset:0,0,0
        - playsound <player.location> sound:ENTITY_SILVERFISH_AMBIENT pitch:2
        - wait 3t
        - playsound <player.location> sound:ENTITY_ITEM_PICKUP pitch:10
