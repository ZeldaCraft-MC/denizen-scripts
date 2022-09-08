old_nbt_getmap:
    type: procedure
    definitions: obj
    script:
    - if "<[obj].all_raw_nbt.keys.contains[Denizen NBT]>":
        - define newMap "<[obj].all_raw_nbt.get[Denizen NBT]>"
        - foreach <[newMap].keys> as:key:
            - define newMap <[newMap].with[<[key]>].as[<[newMap].get[<[key]>].after[:]>]>
        - determine <[newMap]>
