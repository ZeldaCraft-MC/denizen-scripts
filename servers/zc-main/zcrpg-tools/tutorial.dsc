shrine_warp_events:
  type: world
  debug: false
  events:
    on player enters tut_shrine_warp:
      - teleport <player> nuelasotreshrine_warp
    on player enters tut_goddess_bottom:
      - teleport <player> tut_goddess_top_loc
    on player enters tut_goddess_top:
      - teleport <player> tut_goddess_bottom_loc
