autosell_all_task:
  type: task
  definitions: inventory
  debug: false
  script:
    - define total 0
    - foreach <[inventory].map_slots.if_null[<map>]> key:slot as:item:
      - if !<[item].script.exists> && <[item].worth.exists>:
        - money give quantity:<[item].worth.mul[<[item].quantity>]>
        - define total:+:<[item].worth.mul[<[item].quantity>]>
        - take slot:<[slot]> quantity:<[item].quantity> from:<[inventory]>
    - if <[total]> > 0 && <player.is_online>:
      - narrate '<&a>You made $<[total]> from your autoseller!'

autoseller_events:
  type: world
  debug: false
  events:
    on player closes chest in:world_flagged:autoseller_enabled:
      - if !<context.inventory.contains_item[autoseller]>:
        - stop
      - foreach <context.inventory.list_contents.filter[script.name.equals[autoseller]]> as:item:
        - if <[item].flag[active].if_null[false]>:
          - run autosell_all_task def:<context.inventory> player:<player[<[item].flag[player]>]>
          - foreach stop
      ## Updating old autosellers ##
      - define inv <context.inventory>
      - if <[inv].proc[inv_has_old_nbt]>:
        - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
      ## End update autosellers ##

    on player breaks chest in:world_flagged:autoseller_enabled:
      - if !<context.location.inventory.contains_item[autoseller]>:
        - stop
      - foreach <context.location.inventory.list_contents.filter[script.name.equals[autoseller]]> as:item:
        - if <[item].flag[active].if_null[false]>:
          - narrate "<&c>Chests with active autosellers cannot be broken."
          - determine cancelled
      ## Updating old autosellers ##
      - define inv <context.location.inventory>
      - if <[inv].proc[inv_has_old_nbt]>:
        - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
      ## End update autosellers ##

    on item moves from inventory in:world_flagged:autoseller_enabled:
      # Prevent active autoseller from leaving chest via hopper
      ## If an old autoseller is trying to move, update it immediately
      - if <context.item.script.name||null> == autoseller && <context.item.flag[active].if_null[true]>:
        - determine passively cancelled
        - if <context.item.proc[has_old_nbt]>:
          - wait 1t
          - define inv <context.origin>
          - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
          - stop

      # Ignore all non-chest inventories since autoseller should only work in chest.
      - if <context.destination.inventory_type.to_lowercase> != chest:
        - stop

      # If chest does not have an autoseller. Stop early
      - if !<context.destination.contains_item[autoseller]>:
        - stop

      # Find all autosellers
      - define list <context.destination.list_contents.filter[script.name.is[==].to[AUTOSELLER]]||null>
      - foreach <[list]> as:item:
        - if <[item].flag[active].if_null[false]>:
          - define active <[item]>
          - foreach stop

      # There are no active autosellers. Stop early
      - if !<[active].exists>:
        - stop

      # Save item for after delay
      - define item <item[<context.item>]>

      # Stop early if item is worthless
      - if !<[item].worth.exists>:
        - stop

      # Delay for event safety
      - wait 1t

      # Sell item
      - if <[active].flag[player].exists>:
        - money give to:<player[<[active].flag[player]>]> quantity:<[item].worth.mul[<[item].quantity>]>
        - take item:<[item].material.name> quantity:<[item].quantity> from:<context.destination>

      ## Updating old autosellers ##
      - define inv <context.origin>
      - if <[inv].proc[inv_has_old_nbt]>:
        - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
      - define inv <context.destination>
      - if <[inv].proc[inv_has_old_nbt]>:
        - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
      ## End update autosellers ##

    # Negate all interaction with active autoseller
    on player clicks autoseller in chest in_area:world_flagged:autoseller_enabled:
      - if <context.click> == shift_right || !<context.item.flag[active].if_null[false]>:
        - stop
      - determine passively cancelled

      - wait 1t
      ## Updating old autosellers ##
      - define inv <context.inventory>
      - if <[inv].proc[inv_has_old_nbt]>:
        - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
      ## End update autosellers ##
      - inventory update

    # Toggle autoseller state
    on player shift_right clicks autoseller in chest in_area:world_flagged:autoseller_enabled:
      - if <context.clicked_inventory.inventory_type.to_lowercase> != chest:
        - stop

      - determine passively cancelled
      - wait 1t

      - if <context.item.flag[active].if_null[false]>:
        - if <context.item.flag[player]> == <player.uuid>:
          - narrate '<&a>You have Deactivated your Autoseller. It is now safe to move.'
          - inventory flag d:<context.clicked_inventory> slot:<context.slot> active:false
          - inventory flag d:<context.clicked_inventory> slot:<context.slot> player:!
          - inventory adjust d:<context.clicked_inventory> slot:<context.slot> lore:<script[autoseller].data_key[data.lore_inactive].separated_by[|].parse_color>
        - else:
          - narrate '<&c>You are not the owner of this Autoseller. You cannot disable it.'

      - if !<context.item.flag[active].if_null[true]>:
        # Stop duplicate autosellers
        - define list <context.clicked_inventory.list_contents.filter[script.name.is[==].to[AUTOSELLER]]||null>
        - foreach <[list]> as:item:
          - if <[item].flag[active]>:
            - narrate '<&c>You cannot activate a second Autoseller.'
            - stop

        - if <context.slot> != <context.clicked_inventory.size>:
          - narrate '<&c>Autoseller must be in last slot of chest.'
          - stop

        # Activate the autoseller
        - narrate '<&a>You have now Activated your Autoseller.'
        - narrate '<&a>While it is Active you cannot move this item.'
        - inventory flag d:<context.clicked_inventory> slot:<context.slot> active:true
        - inventory adjust d:<context.clicked_inventory> slot:<context.slot> player:<player.uuid>
        - inventory adjust d:<context.clicked_inventory> slot:<context.slot> lore:<script[autoseller].data_key[data.lore_active].separated_by[|].parse_color>
        - run autosell_all_task def:<context.clicked_inventory>
      ## Updating old autosellers ##
      - define inv <context.inventory>
      - if <[inv].proc[inv_has_old_nbt]>:
        - run update_item_nbt_to_flags def.inv:<[inv]> def.itemscript:autoseller
      ## End update autosellers ##
