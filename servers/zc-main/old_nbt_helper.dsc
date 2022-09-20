get_old_nbt_map:
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
