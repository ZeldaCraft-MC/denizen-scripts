old_nbt_getmap:
  type: procedure
  debug: false
  definitions: obj
  script:
  - if "<[obj].all_raw_nbt.keys.contains[Denizen NBT]>":
    - define newMap "<[obj].all_raw_nbt.get[Denizen NBT]>"
    - foreach <[newMap].keys> as:key:
      - define newMap <[newMap].with[<[key]>].as[<[newMap].get[<[key]>].after[:]>]>
    - determine <[newMap]>

has_old_nbt:
  type: procedure
  debug: false
  definitions: obj
  script:
  - determine "<[obj].all_raw_nbt.keys.contains[Denizen NBT]>"

inv_has_old_nbt:
  type: procedure
  debug: true
  definitions: inv
  script:
  - determine !<[inv].list_contents.exclude[<item[air]>].filter_tag[<proc[has_old_nbt].context[<[filter_value]>]>].is_empty>

update_item_nbt_to_flags:
  type: task
  defintitions: inv|itemscript
  script:
  - define slots <[inv].find_all_items[<[itemscript]>]>
  - foreach <[slots]> as:slot:
    - if <proc[has_old_nbt].context[<[inv].slot[<[slot]>]>]>:
      - define flags <proc[old_nbt_getmap].context[<[inv].slot[<[slot]>]>]>
      - foreach <[flags].keys> as:flag:
        - inventory adjust slot:<[slot]> remove_nbt:<[flag]> destination:<[inv]>
        - inventory flag slot:<[slot]> <[flag]>:<[flags].get[<[flag]>]> destination:<[inv]>
