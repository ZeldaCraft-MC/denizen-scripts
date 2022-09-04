moving_block_handler:
  type: world
  debug: false
  events:
    on entity spawns because custom ignorecancelled:true bukkit_priority:highest:
    - determine cancelled:false

    on entity spawns because default ignorecancelled:true bukkit_priority:highest:
    - determine cancelled:false

    on armor_stand damaged by block_explosion:
    - determine cancelled

    on armor_stand damaged by entity_explosion:
    - determine cancelled

    on player right clicks pushable_block:
    - if <player.location.distance[<context.entity.location>]> < 1.2 && <player.location.block.y> == <context.entity.location.block.y>:
      - define x <player.location.direction.vector.x>
      - define z <player.location.direction.vector.z>
      - if <[x].abs> > <[z].abs>:
        - if <player.location.block.z> != <context.entity.location.block.z>:
          - stop
        - if <[x]> < 0:
          - define direction -1,0,0
        - else:
          - define direction 1,0,0
      - else:
        - if <player.location.block.x> != <context.entity.location.block.x>:
          - stop
        - if <[z]> < 0:
          - define direction 0,0,-1
        - else:
          - define direction 0,0,1
      - define new_loc <context.entity.location.add[<[direction]>]>
      - if <[new_loc].material.name> != air && <[new_loc].material.name> != water && !<[new_loc].material.name.contains[pressure_plate]>:
        - stop
      #- if !<[new_loc].find.entities.within[0.45].is_empty>:
      #  - stop
      - teleport <context.entity>|<context.entity.flag[link]> <[new_loc]>
      - adjust <context.entity.flag[link]> gravity:true
      - wait 2t
      - if !<context.entity.is_spawned>:
        - stop
      - adjust <context.entity.flag[link]> gravity:false
      - teleport <context.entity.flag[link]> <[new_loc]>
      - playsound <[new_loc]> sound:ENTITY_IRON_GOLEM_ATTACK volume:1 pitch:0
      - if <[new_loc].below.material.name.contains[ice]>:
        - while <[new_loc].below.material.name.contains[ice]>:
          - define temp <[new_loc].add[<[direction]>]>
          - if <[temp].material.name> != air && <[temp].material.name> != water && !<[temp].material.name.contains[pressure_plate]>:
            - while stop
          - if !<[temp].find.entities[pushable_block].within[0.45].is_empty>:
            - while stop
          - define new_loc <[temp]>
        - teleport <context.entity>|<context.entity.flag[link]> <[new_loc]>
        - adjust <context.entity.flag[link]> gravity:true
        - wait 2t
        - adjust <context.entity.flag[link]> gravity:false
        - teleport <context.entity.flag[link]> <[new_loc]>
      - if <[new_loc].below.material.name> != air && <[new_loc].below.material.name> != water && !<[new_loc].below.material.name.contains[pressure_plate]>:
        - stop
      - wait 7t
      - while <[new_loc].below.material.name> == air || <[new_loc].below.material.name> == water || <[new_loc].below.material.name.contains[pressure_plate]>:
        - if !<[new_loc].below.find.entities[pushable_block].within[0.45].is_empty>:
          - while stop
        - define new_loc <[new_loc].below>
      - teleport <context.entity>|<context.entity.flag[link]> <[new_loc]>
      - adjust <context.entity.flag[link]> gravity:true
      - wait 2t
      - adjust <context.entity.flag[link]> gravity:false
      - teleport <context.entity.flag[link]> <[new_loc]>

pushable_block:
  type: entity
  debug: false
  entity_type: shulker
  has_ai: false
  invulnerable: true

spawn_pushable_block:
  type: command
  name: pb
  description: Spawns a pushable block
  usage: /pb
  permission: pblock
  debug: false
  script:
  - choose <context.args.get[1]||null>:
    - case create:
      - spawn pushable_block[color=<context.args.get[2].to_uppercase||BLACK>] <player.location> save:block
      - spawn armor_stand[visible=false;is_small=true] <entry[block].spawned_entities.get[1].location> save:stand
      - flag <entry[block].spawned_entities.get[1]> link:<entry[stand].spawned_entities.get[1]>
      - flag <entry[stand].spawned_entities.get[1]> link:<entry[block].spawned_entities.get[1]>
      - wait 1t
      - adjust <entry[stand].spawned_entities.get[1]> gravity:false
    - case remove:
      - if <player.target.has_flag[link]>:
        - remove <player.target.flag[link]>|<player.target>
    - default:
      - narrate "Usage:<n>/pb create (color)<n>/pb remove"
