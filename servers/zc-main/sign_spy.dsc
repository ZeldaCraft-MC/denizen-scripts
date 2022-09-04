sign_spy_events:
  type: world
  debug: false
  events:
    on player changes sign:
      - define signtext "<context.new.parse[trim].filter[length.is_more_than[0]].separated_by[ ]>"
      - if <[signtext].length> == 0:
        - stop
      - define mods <server.online_players.filter[socialspy]>
      - define text "<&7>[SS] <player.name> wrote on a sign: <[signtext]>"
      - if !<[mods].is_empty>:
        - narrate <[text]> targets:<[mods]>
      - announce <[text]> to_console
