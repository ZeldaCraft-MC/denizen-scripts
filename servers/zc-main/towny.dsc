towny_gp_events:
  type: world
  debug: false
  events:
    on gp claim created:
      - define towny_plots <towny.list_towns.parse[cuboids].combine.filter[world.name.equals[<context.claim.world.name>]]>
      - define conflicting_plots <[towny_plots].filter[intersects[<context.claim.cuboid>]]>
      - if !<[conflicting_plots].is_empty>:
        - determine passively cancelled
        - if <context.source_type> == player:
          - wait 1t
          - narrate "<&c>Claiming regions inside of towns is not supported!"
    on gp claim changed:
      - define towny_plots <towny.list_towns.parse[cuboids].combine.filter[world.name.equals[<context.new_claim.world.name>]]>
      - define conflicting_plots <[towny_plots].filter[intersects[<context.new_claim.cuboid>]]>
      - if !<[conflicting_plots].is_empty>:
        - determine passively cancelled
        - if <context.source_type> == player:
          - narrate "<&c>Claiming regions inside of towns is not supported!"
    on towny player creates town:
      - define gp_claims <context.cuboid.world.griefprevention_claims>
      - define conflicting_claims <[gp_claims].filter[cuboid.intersects[<context.cuboid>]]>
      - if !<[conflicting_claims].is_empty>:
        - determine passively "cancel_message:This town plot would intersect a player's claim, cancelling."
        - determine cancelled
    on towny player claims plot:
      - define gp_claims <context.cuboid.world.griefprevention_claims>
      - define conflicting_claims <[gp_claims].filter[cuboid.intersects[<context.cuboid>]]>
      - if !<[conflicting_claims].is_empty>:
        - determine passively "cancel_message:This town plot would intersect a player's claim, cancelling."
        - determine cancelled
