# build_pasting_points:
#   type: task
#   debug: true
#   definitions: points|side|name
#   script:
#     - define num 1
#     - if <[side]> == l:
#       - foreach <[points]>:
#         - if <[value].material.name> == gold_block || if <[value].material.name> == diamond_block:
#           - note <[value]> as:<[name]>_paste_point_l_<[num]>
#           - define num:+:1
#           - wait 2t
#         - else:
#           - foreach next
#     - else:
#       - foreach <[points]>:
#         - if <[value].material.name> == gold_block || <[value].material.name> == diamond_block:
#           - note <[value]> as:<[name]>_paste_point_r_<[num]>
#           - define num:+:1
#           - wait 2t
#         - else:
#           - foreach next

build_huge_copy:
  type: task
  debug: false
  definitions: selection|name|origin
  script:
      - define num 1
      - ~filecopy o:schematics/DO_NOT_REMOVE d:schematics/<[name]> save:copy
      - foreach <[selection].partial_chunks>:
      # need to partially load chunks??
        - chunkload <[value]> duration:5s
        - if <[value].cuboid.blocks[!air].size> >= 1:
          - ~schematic create name:<[name]>_section_<[num]> cuboid:<[value].cuboid> position:<[origin]> entities flags
          - ~schematic save name:<[name]>_section_<[num]> filename:<[name]>/<[name]>_section_<[num]>
          - ~schematic unload name:<[name]>_section_<[num]>
          - define num:++
          - wait 1t
        - else:
          - foreach next
      - narrate "<yellow>copy completed"

# build_copying_sections:
#   type: task
#   debug: true
#   definitions: num|name|origin
#   script:
#     - repeat <[num]>:
#       #- announce <cuboid[<location[<[name]>_paste_point_l_<[value]>]>|<location[<[name]>_paste_point_l_<[value]>]>]>
#       # - ~schematic create name:<[name]>_section_<[value]> <location[<[name]>_paste_point_l_<[value]>].to_cuboid[<location[<[name]>_paste_point_l_<[value]>]>]> <[origin]> entities
#       # - ~schematic save name:<[name]>_section_<[value]>
#       - worldedit create_schematic file:<[name]>_section_<[value]> cuboid:<location[<[name]>_paste_point_l_<[value]>].to_cuboid[<location[<[name]>_paste_point_l_<[value]>]>]> position:<[origin]>
#       - wait 1s

build_pasting_sections:
  type: task
  debug: false
  definitions: name
  script:
    - define num <server.list_files[schematics/<[name]>/].size||0>
    - define origin <player.location>
    - narrate "beginning paste of <[num]> sections at <player.location>"
    - repeat <[num]>:
      #- announce <cuboid[<location[<[name]>_paste_point_l_<[value]>]>|<location[<[name]>_paste_point_l_<[value]>]>]>
      - ~schematic load name:<[name]>/<[name]>_section_<[value]>
      - schematic paste name:<[name]>/<[name]>_section_<[value]> <[origin]> entities flags delayed
      - ~schematic unload name:<[name]>/<[name]>_section_<[value]>
      # - worldedit paste file:<[name]>_section_<[value]> position:<[origin]> undoable noair
      # -2153 -3107
      - wait 1s
    - narrate "<yellow>paste completed"

build_huge_delete:
  type: task
  debug: false
  definitions: name
  script:
    - if <server.has_file[schematics/<[name]>]>:
      - adjust server delete_file:schematics/<[name]>
      - narrate "schematic deleted"
    - else:
      - narrate "No schematics of that name exits"
we_huge_delete:
  type: task
  debug: false
  definitions: selection
  script:
    - define cuboids <list>
    - define w <[selection].world.name>
    - define s <[selection].size>
    - define v <[selection].volume>
    - define min <[selection].min>
    - define max <[selection].max>
    - narrate "<yellow>Selection of <[v]> total blocks being removed"
    - repeat <[s].y.div[25].round_up> as:num:
      - if <[num]> <= 1:
        - define y1 <[min].y>
      - else:
        - define y1 <[min].y.add[<element[25].mul[<[num].sub[1]>]>].add[1]>
      - if <[min].y.add[<element[25].mul[<[num]>]>]> > <[max].y>:
        - define y2 <[max].y>
      - else:
        - define y2 <[min].y.add[<element[25].mul[<[num]>]>]>
      - repeat <[s].x.div[25].round_up> as:num2:
        - if <[num2]> <= 1:
          - define x1 <[min].x>
        - else:
          - define x1 <[min].x.add[<element[25].mul[<[num2].sub[1]>]>].add[1]>
        - if <[min].x.add[<element[25].mul[<[num2]>]>]> > <[max].x>:
          - define x2 <[max].x>
        - else:
          - define x2 <[min].x.add[<element[25].mul[<[num2]>]>]>
        - repeat <[s].z.div[25].round_up> as:num3:
          - if <[num3]> <= 1:
            - define z1 <[min].z>
          - else:
            - define z1 <[min].z.add[<element[25].mul[<[num3].sub[1]>]>].add[1]>
          - if <[min].z.add[<element[25].mul[<[num3]>]>]> > <[max].z>:
            - define z2 <[max].z>
          - else:
            - define z2 <[min].z.add[<element[25].mul[<[num3]>]>]>
          - if <[w]||null> == null || <[y1]||null> == null || <[y2]||null> == null || <[x1]||null> == null || <[x2]||null> == null || <[z1]||null> == null || <[z2]||null> == null:
            - narrate "something went wrong. script not running!"
            - narrate "Cuboid it went wrong on: <[w]>,<[x1]>,<[y1]>,<[z1]>,<[x2]>,<[y2]>,<[z2]>"
          - define cub <cuboid[<[w]>,<[x1]>,<[y1]>,<[z1]>,<[x2]>,<[y2]>,<[z2]>]>
          - define cuboids <[cuboids].include[<[cub]>]>
    - narrate "<yellow>all smaller cuboids created. deletion beginning!"
    - foreach <[cuboids]> as:cu:
      - chunkload <[cu].partial_chunks> duration:5s
      - if <[cu].blocks[!air].size> >= 1:
        - modifyblock <[cu].blocks[!air]> air
        - wait 1s
      - else:
        - foreach next
    - narrate "<yellow>Deletion complete!"



