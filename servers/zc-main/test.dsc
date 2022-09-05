fill_map_test:
  type: task
  debug: false
  script:
  - define loc <player.location.center.with_y[250]>
  - define x_loc <player.location.center.add[2016,0,0].with_y[250]>
  - define z_loc <player.location.center.add[0,0,2016].with_y[250]>
  - foreach <[loc].points_between[<[x_loc]>].distance[112]> as:x:
    - foreach <[x].points_between[<[z_loc].with_x[<[x].x>]>].distance[64]> as:z:
      - teleport <player> <location[<[z]>]>
      - wait 0.5s

skin_restore:
  type: task
  debug: false
  script:
    - foreach <server.online_players>:
      - adjust <[value]> skin:<[value].name>

no_portal_world:
  type: world
  debug: false
  events:
    on portal created:
    - if <context.entity.location.world> == <world[s3]> || <context.entity.location.world> == <world[s3_nether]>:
      - stop
    - if <context.entity.name> == greenleeuw || <context.entity.name> == nasfi || <context.entity.name> == mergu || <context.entity.name> == Mayor_Disney:
      - stop
    - determine cancelled

inf_slime:
  type: entity
  debug: false
  entity_type: slime
  mechanisms:
    size: 2
    custom_name: <&6><&l>Infinity
    custom_name_visible: true
    persistent: true

inf_slime_world:
  type: world
  debug: false
  events:
    on inf_slime dies:
    - spawn inf_slime <context.entity.location>

hallow2021_tot_ass:
  type: assignment
  debug: false
  actions:
    on click:
    - stop

hallow2021_cs_ass:
  type: assignment
  debug: false
  actions:
    on click:
    - stop

hallow2021_rab_ass:
  type: assignment
  debug: false
  actions:
    on click:
    - stop

hallow2021_ass:
  type: assignment
  debug: false
  actions:
    on click:
    - stop
