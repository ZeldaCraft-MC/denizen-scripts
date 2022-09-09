old_nbt_getmap:
  type: procedure
  debug: false
  definitions: obj
  script:
  - if "<[obj].all_raw_nbt.contains[Denizen NBT]>":
    - determine "<[obj].all_raw_nbt.get[Denizen NBT].parse_value_tag[<[parse_value].after[:]>]>"

has_old_nbt:
  type: procedure
  debug: false
  definitions: obj
  script:
  - determine "<[obj].all_raw_nbt.contains[Denizen NBT].if_null[false]>"

inv_has_old_nbt:
  type: procedure
  debug: false
  definitions: inv
  script:
  - determine <[inv].list_contents.filter[proc[has_old_nbt]].is_truthy>

update_item_nbt_to_flags:
  type: task
  debug: false
  defintitions: inv|itemscript
  script:
  - define slots <[inv].find_all_items[<[itemscript]>]>
  - foreach <[slots]> as:slot:
    - if <proc[has_old_nbt].context[<[inv].slot[<[slot]>]>]>:
      - define flags <proc[old_nbt_getmap].context[<[inv].slot[<[slot]>]>]>
      - foreach <[flags]> key:flag as:flag_value:
        - inventory adjust slot:<[slot]> remove_nbt:<[flag]> destination:<[inv]>
        - inventory flag slot:<[slot]> <[flag]>:<[flag_value]> destination:<[inv]>
