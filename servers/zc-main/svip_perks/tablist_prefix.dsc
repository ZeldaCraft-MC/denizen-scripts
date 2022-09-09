login_tablist:
  type: world
  debug: false
  events:
    on player joins:
      - define rank_order <map[owner=1;admin=2;moderator=3;retired=4;builder=5;twitch=6;svip=8]>
      - define rank <player.groups.last||default>
      #- team name:#<[rank_order].get[<[rank]>]||z>-<[rank]> add:<player>
      #- if <[rank_order].get[<[rank]>]||0> != 0:
      #  - define prefix <server.group_prefix[<[rank]>]>
      #  - adjust <player> "player_list_name: <[prefix].parse_color><player.name> "
      #  - stop
      #- adjust <player> "player_list_name: <player.name> "
