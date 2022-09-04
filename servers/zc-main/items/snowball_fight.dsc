Snowball_fight_world:
  type: world
  debug: false
  events:
    after *snowball hits player in:Xmas2021:
      - ratelimit <player> 5t
      - if <context.shooter.script.name||false> != sir_frosty:
        - adjust <player> freeze_duration:<player.freeze_duration.add[3s]>
    on player breaks block with:*shovel in:snowball_*:
      - determine passively cancelled
      - ratelimit <player> 2t
      - if <context.location.material.level||0> >= 1:
        - define rand <util.random.int[1].to[4]>
        - if <context.location.material.level.sub[<[rand]>]> <= 0:
          - foreach <context.location.above.points_between[<context.location.above[256]>].filter[material.name.is[==].to[snow]].last||null>:
            - if <[value]> == null:
              - modifyblock <context.location> air
              - foreach next
            - if <[value].above.material.name> == air:
              - modifyblock <[value]> air
              - drop <[value].material.level>
            - else:
              - adjustblock <[value]> level:<[value].above.material.level>
          #- modifyblock <context.location> air
          # - define last <context.location.above.points_between[<context.location.above[256]>].filter[material.name.is[==].to[snow]].last||null>
          # - if <[last]> == null:
          #   - give snowball quantity:<[rand]>
          #   - stop
          # - drop snowball quantity:<[last].material.level> <[last]>
          # - modifyblock <[last]> air
          # - if <[last]> != <context.location.above>
          #   - modifyblock <context.location> snow[level=]
        - else:
          - adjustblock <context.location> level:<context.location.material.level.sub[<[rand]>].max[1]>
        - give snowball quantity:<[rand]>
    on player right clicks snow with:snowball in:snowball_*:
      - determine passively cancelled
      - if <context.location.above.material.name> != air && <context.location.material.level||0> == 8:
        - stop
      - define rand <util.random.int[1].to[4]>
      - take item:snowball quantity:<[rand].min[<player.inventory.quantity_item[snowball]>]>
      - if <context.location.material.level||0> == 8:
        - modifyblock <context.location.above> snow[level=<[rand]>]
      - else:
        - adjustblock <context.location> level:<context.location.material.level.add[<[rand]>].min[8]>
      - if <player.item_in_hand.material.name> == air:
        - define sb <player.inventory.find_item[snowball]>
        - if <[sb]> > 0:
          - define quant <player.inventory.slot[<[sb]>].quantity>
          - take item:snowball slot:<[sb]> quantity:<[quant]>
          - wait 1t
          - give snowball quantity:<[quant]> slot:<player.held_item_slot>
    after snowball launched in:snowball_*:
      - ratelimit <player> 2t
      - define __player <context.entity.shooter>
      - if <player.item_in_hand.material.name> == air:
        - define sb <player.inventory.find_item[snowball]>
        - if <[sb]> > 0:
          - define quant <player.inventory.slot[<[sb]>].quantity>
          - take item:snowball slot:<[sb]> quantity:<[quant]>
          - wait 1t
          - give snowball quantity:<[quant]> slot:<player.held_item_slot>
    on snowball hits snow in:snowball_*:
      - ratelimit <player> 5t
      - if <context.location.material.level> > 2:
        - flag <context.location> snow_damage:+:1 duration:1m
        - blockcrack <context.location> players:<server.online_players> progress:<element[3].mul[<context.location.flag[snow_damage]>]||3>
        - if <context.location.flag[snow_damage]> >= 3:
          - flag <context.location> snow_damage:!
          - foreach <context.location.above.points_between[<context.location.above[256]>].filter[material.name.is[==].to[snow]].last||null>:
            - if <[value]> == null:
              - modifyblock <context.location> air
              - foreach next
            - if <[value].above.material.name> == air:
              - modifyblock <[value]> air
              - drop <[value].material.level>
            - else:
              - adjustblock <[value]> level:<[value].above.material.level>
          - blockcrack <context.location> players:<server.online_players> progress:0
