beedle_events:
  type: world
  debug: false
  events:
    on player shoots bell in:beedle_airshop:
      - if <context.location.in_region[airshipscript]>:
        # - playsound <context.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:0
        # - wait 1t
        # - playsound <context.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:1
        # - wait 1t
        # - playsound <context.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:2
        # - wait 1s
        - playsound <location[beedle_ladder_end]> sound:zc_sfx.ss.zss_beedlebell custom pitch:1 volume:6
        - define locs <location[beedle_ladder_start].points_between[beedle_ladder_end]>
        - foreach <[locs]> as:loc:
          - showfake ladder[direction=west] <[loc]> d:<[locs].size.mul[1.5].sub[<[loop_index]>]>s players:<world[spawn].players>
          - wait 0.1s
    on player right clicks *button in:beedle_airshop:
      - if <context.location.in_region[airshipscript]>:
        # - playsound <context.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:0
        # - wait 1t
        # - playsound <context.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:1
        # - wait 1t
        # - playsound <context.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:2
        # - wait 1s
        - playsound <location[beedle_ladder_end]> sound:zc_sfx.ss.zss_beedlebell custom pitch:1 volume:6
        - define locs <location[beedle_ladder_start].points_between[beedle_ladder_end]>
        - foreach <[locs]> as:loc:
          - showfake ladder[direction=west] <[loc]> d:<[locs].size.mul[1.5].sub[<[loop_index]>]>s players:<world[spawn].players>
          - wait 0.1s
    on player kicked for flying:
      - if <player.location.cuboids.contains[<cuboid[beedleladder]>]>:
        - determine passively fly_cooldown:5s
        - determine cancelled

