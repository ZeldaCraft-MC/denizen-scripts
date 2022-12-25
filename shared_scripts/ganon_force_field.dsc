spawn_ganon_forcefield:
  type: task
  debug: false
  script:
    - remove <cuboid[ganon_forcefield].entities[creeper]>
    - define wall <cuboid[ganon_forcefield].center.flood_fill[ganon_forcefield].types[barrier|air]>
    - modifyblock <[wall]> air
    - foreach <[wall]> as:loc:
      - spawn creeper[has_ai=false;powered=true;invulnerable=true;persistent=true] <[loc].center.below[0.5]>
