race_perk_events:
  type: world
  debug: false
  events:
    #on player damaged by fall:
    #  - if <player.has_flag[zcrpg.race]> && <player.flag[zcrpg.race]> == rito:
    #    - determine cancelled
    on entity damaged:
      - define damage <context.damage>
      - if <context.damager.is_player||false>:
        - choose <yaml[<context.damager.uuid>].read[race]>:
          - case "kokiri":
            - if <context.projectile.entity_type||null> == arrow:
              - define damage:*:1.3
          - case "hylian":
            - define damage:*:1.05
          - case "gerudo":
            - if <context.entity.health_percentage||100> <= 25:
              - define damage:*:1.5
          - case "zora":
            - if <util.random.decimal> <= 0.10:
              - narrate "<&b>[Zora Perk] <&e>Health restored!" player:<context.damager>
              - heal 2 <context.damager>
          - case "fairy":
            - if <context.entity.is_living> && <util.random.decimal> <= 0.04:
              - define effects <list[poison|slow|weakness].exclude[<context.entity.list_effects.parse[before[,]]>]||null>
              - if <[effects]> != null && !<[effects].is_empty>:
                - define effect <[effects].random>
                - cast <[effect]> duration:10s power:0 <context.entity>
                - narrate "<&d>[Fairy Perk] <&e>Inflicted effect: <&d><[effect].to_titlecase>" player:<context.damager>

      - if <context.entity.is_player||false>:
        - choose <yaml[<context.entity.uuid>].read[race]>:
          - case "minish":
            - if <util.random.decimal> <= 0.15:
              - narrate "<&a>[Minish Perk] <&e>Damage avoided!" player:<context.entity>
              - determine cancelled
          - case "goron":
            - if <context.projectile.entity_type||null> == arrow:
              - define damage:*:0.6
            - else:
              - define damage:*:0.9
          - case "hylian":
            - if <context.damager.is_living||false> && !<context.damager.is_player||true>:
              - define damage:*:0.8

      - determine <[damage]>
