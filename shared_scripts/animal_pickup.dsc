held_animal:
  type: item
  material: pig_spawn_egg
  flags:
    uniq: <util.random.uuid>

pickup_animals_events:
  type: world
  debug: false
  events:
    on player right clicks entity with:air:
    - if <player.name> != Mergu:
      - stop
    - if <context.hand> != mainhand or !<player.is_sneaking>:
      - stop
    - ratelimit <player> 10t
    - foreach pig|cow|sheep|chicken:
      - if <context.entity.entity_type> == <[value]>:
        - define cmd <[loop_index]>
        - foreach stop
    - if <context.entity.entity_type> == cat:
      - foreach all_black|black|british_shorthair|calico|persian|jellie|ragdoll|siamese|tabby|white|red:
        - if <context.entity.color.before[|]> == <[value]>:
          - define cmd <[loop_index].add[4]>
          - foreach stop
    - if !<[cmd].exists>:
      - stop
    - if <player.target.custom_name||null> == null:
      - narrate "<&8>This <context.entity.entity_type.to_lowercase> resisted your attempt to carry it, perhaps you need a stronger bond."
      - stop
    - give held_animal[custom_model_data=<[cmd]>;display=<context.entity.custom_name>] slot:<player.held_item_slot>
