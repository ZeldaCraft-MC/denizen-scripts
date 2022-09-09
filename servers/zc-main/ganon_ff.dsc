ganon_force_field_events:
  type: world
  debug: false
  events:
    on delta time secondly:
      - foreach <cuboid[ganon_fight_room].players> as:__player:
        - define wall <cuboid[ganon_forcefield].center.flood_fill[ganon_forcefield].types[barrier|air]>
        - showfake barrier <[wall]> d:2s
        - team name:ganon_wall add:<cuboid[ganon_forcefield].entities[creeper]>
        - team name:ganon_wall add:<player>
        - team name:ganon_wall option:collision_rule status:never
        - team name:ganon_wall option:see_invisible status:never
    on delta time secondly every:5:
      - foreach <cuboid[ganon_forcefield].entities[creeper]>:
        - cast invisibility duration:99999s <[value]> hide_particles
    after player exits ganon_forcefield_open:
      - if !<player.is_online>:
        - stop
      - showfake barrier <cuboid[ganon_forcefield].center.flood_fill[ganon_forcefield].types[barrier|air]> d:2s
      - run set_team_nameplates
      - wait 1s
