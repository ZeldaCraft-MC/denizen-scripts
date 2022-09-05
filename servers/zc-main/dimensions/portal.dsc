portal_activate_button:
  type: item
  debug: false
  material: ender_eye
  lore:
    - What wonders await you
    - past the dimensional rift?
    - <empty>
    - Click to activate
    - Consumes <&d>1 Amethyst Shard
  display name: <&d><&l>Activate

empty_portal_slot:
  type: item
  debug: false
  material: gray_stained_glass_pane
  display name: <&f>

portal_gui:
  type: inventory
  debug: false
  inventory: chest
  title: <&d><&l>Dimensional Stone
  size: 27
  gui: true
  definitions:
    _: empty_portal_slot
    a: portal_activate_button
  slots:
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]
    - [_] [_] [_] [air] [_] [a] [_] [_] [_]
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]

dimension_portal_events:
  type: world
  debug: false
  events:
    on player breaks lodestone bukkit_priority:highest:
      - if <context.location.has_flag[playing_portal_animation]> || <context.location.has_flag[opened]>:
        - determine cancelled
      - if <context.location.has_flag[portal_item]>:
        - define item <context.location.flag[portal_item]>
        - flag <context.location> portal_item:!
        - wait 1t
        - drop <[item]> <context.location>
      - flag <context.location> opened:!
    on player right clicks lodestone:
      - if <player.is_sneaking> || <context.location.world.name> not in s1|s2:
        - stop
      - determine passively cancelled
      - stop if:<context.location.has_flag[playing_portal_animation]>
      - stop if:<context.location.has_flag[opened]>
      - flag <context.location> opened
      - define inv <inventory[portal_gui]>
      - inventory set o:<context.location.flag[portal_item].if_null[air]> d:<[inv]> slot:13
      - inventory open d:<[inv]>
      - flag <player> portal_block_loc:<context.location>
      - wait 1t
      - waituntil <player.open_inventory.script.name||null> != portal_gui || !<player.is_online>
      - if <player.has_flag[portal_block_loc]>:
        - flag <player.flag[portal_block_loc]> opened:!
      - flag <player> portal_block_loc:!
    after player steps on lodestone:
      - ratelimit <player> 2s
      - if <context.location.has_flag[move_to_resources]>:
        - run swap_server def:resources|<context.location.center.xyz>,resources
    after player clicks portal_activate_button in portal_gui:
      - if !<player.has_flag[portal_block_loc]>:
        - stop
      - define loc <player.flag[portal_block_loc]>
      - define valid false
      - if <context.inventory.slot[13].material.name> == amethyst_shard:
        - take slot:13 quantity:1 from:<context.inventory>
        - define valid true
      - inventory close
      - flag <[loc]> playing_portal_animation duration:1m
      - if <[valid]>:
        - chunkload <[loc].chunk> duration:1m
        - wait 5t
        - playsound <[loc]> sound:block_amethyst_cluster_step
        - define portal <[loc].above.to_cuboid[<[loc].above[2]>]>
        - define min1 <[portal].min>
        - define min2 <[portal].min.add[1,0,0]>
        - define min3 <[portal].min.add[0,0,1]>
        - define min4 <[portal].min.add[1,0,1]>
        - define bottom_layer:|:<[min1].points_between[<[min2]>].distance[0.1]>
        - define bottom_layer:|:<[min1].points_between[<[min3]>].distance[0.1]>
        - define bottom_layer:|:<[min2].points_between[<[min4]>].distance[0.1]>
        - define bottom_layer:|:<[min3].points_between[<[min4]>].distance[0.1]>
        - define top_layer <[bottom_layer].parse[above[2]]>
        - define outline <[bottom_layer]>
        - repeat 20:
          - playeffect effect:redstone at:<[outline]> offset:0,0,0 special_data:0.5|#d096ff
          - wait 2t
        - playsound <[loc]> sound:block_amethyst_cluster_step
        - repeat 20:
          - define outline:|:<[min1].above[<[value].div[10]>]>|<[min2].above[<[value].div[10]>]>|<[min3].above[<[value].div[10]>]>|<[min4].above[<[value].div[10]>]>
          - playeffect effect:redstone at:<[outline].include[<[bottom_layer].parse[above[<[value].div[10]>]]>]> offset:0,0,0 special_data:0.5|#d096ff
          - wait 2t
        - playsound <[loc]> sound:block_amethyst_cluster_step
        - define outline:|:<[top_layer]>
        - flag <[loc]> move_to_resources
        - foreach <[loc].above.center.find_players_within[0.5]>:
          - run swap_server def:resources|<[loc].center.xyz>,resources player:<[value]>
        - repeat 200:
          - playeffect effect:redstone at:<[outline]> offset:0,0,0 special_data:0.5|#d096ff
          - wait 2t
        - flag <[loc]> move_to_resources:!
      - else:
        - wait 5t
        - playsound <[loc]> sound:block_lava_extinguish
        - playeffect effect:campfire_cosy_smoke at:<[loc].center.above[0.5]> offset:0.5,0.5,0.5 quantity:5 velocity:0,0.05,0
        - wait 3s
      - flag <[loc]> playing_portal_animation:!
    on player clicks in portal_gui ignorecancelled:true bukkit_priority:monitor:
      - if <context.raw_slot> == 13 || <context.raw_slot> > 27:
        - determine passively cancelled:false
      - wait 1t
      - if <player.has_flag[portal_block_loc]>:
        - flag <player.flag[portal_block_loc]> portal_item:<context.inventory.slot[13]>
      - inventory update
    after player joins:
      # Handle crashes while person has inv open, however rare those will be...
      - flag <player> portal_block_loc:!
