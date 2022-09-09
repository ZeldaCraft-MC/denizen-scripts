poseidon_world:
  type: world
  debug: false
  events:
    on player shoots bow:
    - if <player.location.cuboids.parse[note_name].contains[poseidon_dungeon]>:
      - flag player poseidon_arrows:->:<context.projectile>
    on player enters poseidon_area2:
    - if <player.flag[poseidon_arrows].filter[is_spawned].is_empty||true>:
      - stop
    - remove <player.flag[poseidon_arrows].filter[is_spawned]||null>
    - flag player poseidon_arrows:!
    on player enters poseidon_area3:
    - if <player.flag[poseidon_arrows].filter[is_spawned].is_empty||true>:
      - stop
    - remove <player.flag[poseidon_arrows].filter[is_spawned]||null>
    - remove <location[remove_item_loc].find_entities[dropped_item].within[2]>
    - flag player poseidon_arrows:!
