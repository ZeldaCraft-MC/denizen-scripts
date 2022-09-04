autosell_all_task:
  type: task
  definitions: inventory
  debug: false
  script:
    - define total 0

    # SELL CURRENT INVENTORY
#    - define valuable <[inventory].list_contents.filter[material.name.is[!=].to[air]].filter[has_script.not].filter[worth.is[!=].to[null]]||<list[]>>
#    - foreach <[valuable]> as:item:
#      - money give quantity:<[item].worth.mul[<[item].quantity>]>
#      - define total:+:<[item].worth.mul[<[item].quantity>]>
#      - take <[item]> quantity:<[item].quantity> from:<[inventory]>
#    - if <[total]> > 0 && <player.is_online>:
#      - narrate '<&a>You made $<[total]> from your autoseller!'


    - foreach <[inventory].list_contents||<list[]>> as:item:
      - if !<[item].has_script> && <[item].worth||null> != null:
        - money give quantity:<[item].worth.mul[<[item].quantity>]>
        - define total:+:<[item].worth.mul[<[item].quantity>]>
        - take slot:<[loop_index]> quantity:<[item].quantity> from:<[inventory]>
    - if <[total]> > 0 && <player.is_online>:
      - narrate '<&a>You made $<[total]> from your autoseller!'


autoseller_events:
  type: world
  debug: false
  events:
    on player closes chest:
      - if !<context.inventory.contains.scriptname[AUTOSELLER]>:
        - stop
      - foreach <context.inventory.list_contents.filter[scriptname.is[==].to[AUTOSELLER]]||null> as:item:
        - if <[item].nbt[active]>:
          - run autosell_all_task def:<context.inventory> player:<player[<[item].nbt[player]>]>
          - foreach stop

    on player breaks chest:
      - if !<context.location.inventory.contains.scriptname[AUTOSELLER]>:
        - stop

      - foreach <context.location.inventory.list_contents.filter[scriptname.is[==].to[AUTOSELLER]]||null> as:item:
        - if <[item].nbt[active]>:
          - narrate "<&c>Chests with active autosellers cannot be broken."
          - determine cancelled

    on item moves from inventory:
      # Prevent active autoseller from leaving chest via hopper
      - if <context.item.scriptname||null> == 'AUTOSELLER' && <context.item.nbt[active]>:
        - determine cancelled

      # Ignore all non-chest inventories since autoseller should only work in chest.
      - if <context.destination.inventory_type.to_lowercase> != 'chest':
        - stop

      # If chest does not have an autoseller. Stop early
      - if !<context.destination.contains.scriptname[AUTOSELLER]>:
        - stop

      - define zeworldo <context.destination.location.world.name.to_lowercase||null>
      - if <[zeworldo]> == 's3' || <[zeworldo]> == 'newvip' || <[zeworldo]> == 'dungeonvip':
        - stop

      # Find all autosellers
      - define list <context.destination.list_contents.filter[scriptname.is[==].to[AUTOSELLER]]||null>
      - foreach <[list]> as:item:
        - if <[item].nbt[active]>:
          - define active <[item]>
          - foreach stop

      # There are no active autosellers. Stop early
      - if <[active]||null> == null:
        - stop

      # Save item for after delay
      - define item <item[<context.item>]>

      # Stop early if item is worthless
      - if <[item].worth||null> == null:
        - stop

      # Delay for event safety
      - wait 1t

      # Sell item
      - if <[active].has_nbt[player]>:
        - money give to:<player[<[active].nbt[player]>]> quantity:<[item].worth.mul[<[item].quantity>]>
        - take <[item]> quantity:<[item].quantity> from:<context.destination>


    # Negate all interaction with active autoseller
    on player clicks autoseller in chest:
      - if <context.click> == 'SHIFT_RIGHT' || !<context.item.nbt[active]>:
        - stop
      - determine passively cancelled

      - wait 1t
      - inventory update

    # Toggle autoseller state
    on player shift_right clicks autoseller in chest:
      - if <context.clicked_inventory.inventory_type.to_lowercase> != 'chest':
        - stop

      - define zeworldo <player.world.name.to_lowercase||null>

      - if <[zeworldo]> == 's3' || <[zeworldo]> == 'newvip' || <[zeworldo]> == 'dungeonvip':
        - stop

      - determine passively cancelled
      - wait 1t

      - if <context.item.nbt[active]>:
        - if <context.item.nbt[player]> == <player.uuid>:
          - narrate '<&a>You have Deactivated your Autoseller. It is now safe to move.'
          - inventory adjust d:<context.clicked_inventory> slot:<context.slot> "nbt:active/false"
          - inventory adjust d:<context.clicked_inventory> slot:<context.slot> "remove_nbt:player"
          - inventory adjust d:<context.clicked_inventory> slot:<context.slot> "lore:<script[autoseller].yaml_key[lore_inactive].separated_by[|].parse_color>"
        - else:
          - narrate '<&c>You are not the owner of this Autoseller. You cannot disable it.'

      - if !<context.item.nbt[active]>:
        # Stop duplicate autosellers
        - define list <context.clicked_inventory.list_contents.filter[scriptname.is[==].to[AUTOSELLER]]||null>
        - foreach <[list]> as:item:
          - if <[item].nbt[active]>:
            - narrate '<&c>You cannot activate a second Autoseller.'
            - stop

        - if <context.slot> != <context.clicked_inventory.size>:
          - narrate '<&c>Autoseller must be in last slot of chest.'
          - stop

        # Activate the autoseller
        - narrate '<&a>You have now Activated your Autoseller.'
        - narrate '<&a>While it is Active you cannot move this item.'
        - inventory adjust d:<context.clicked_inventory> slot:<context.slot> "nbt:active/true"
        - inventory adjust d:<context.clicked_inventory> slot:<context.slot> "nbt:player/<player.uuid>"
        - inventory adjust d:<context.clicked_inventory> slot:<context.slot> "lore:<script[autoseller].yaml_key[lore_active].separated_by[|].parse_color>"
        - run autosell_all_task def:<context.clicked_inventory>