finish_block_dep:
  type: item
  material: emerald_block
  display name: <&a><&l>Finish Block
  lore:
    - <&7>Place to mark a finish location!

finish_block_holo1_dep:
  type: entity
  entity_type: armor_stand
  visible: false
  custom_name: <&a><&l>You finished <&e><&l>test<&a><&l>!
  custom_name_visible: true

finish_block_holo2_dep:
  type: entity
  entity_type: armor_stand
  visible: false
  custom_name: <&e><&l>Stand here to earn <&c><&l>1<&e><&l> Dungeon Point!
  custom_name_visible: true

#finish_block_events_dep:
#  type: world
#  debug: false
#  events:
#    on player places finish_block:
#      - define map <server.flag[finish_block_locs].as_map||<map[]>>
#      - flag server finish_block_locs:<[map].with[<context.location.simple>].as[test]||>
#    on player breaks block:
#      - define map <server.flag[finish_block_locs].as_map||<map[]>>
#      - if !<[map].contains[<context.location.simple>]>:
#        - stop
#      - flag server finish_block_locs:<[map].exclude[<context.location.simple>]>
#    on delta time secondly:
#      - define locs <server.flag[finish_block_locs].as_map.keys.parse[as_location.center]>
#      - define valid_locs <[locs].filter[find.players.within[8].is_empty.not]>
#      - if <[valid_locs].is_empty>:
#        - stop
#      - foreach <[valid_locs]>:
#        - define players <[value].find.players.within[8]>
#        - fakespawn finish_block_holo1 <[value].above[0.3]> players:<[players]> d:20t
#        - fakespawn finish_block_holo2 <[value]> players:<[players]> d:20t
#        - playeffect effect:villager_happy at:<[value].above[1.8]> quantity:3 offset:0.6,0.6,0.6 targets:<[players]>
#    on player steps on emerald_block:
#      - define map <server.flag[finish_block_locs].as_map||<map[]>>
#      - if !<[map].contains[<context.location.simple>]>:
#        - stop
#      - narrate "aaa"
#    on player changes sign:
#      - if <player.name> != Mergu:
#        - stop
#      - narrate "aaaa"
#
