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
        - define active <[item].flag[autoseller_active].if_null[<[item].proc[get_old_nbt_map].get[active]>]>
        - if <[active]>:
          - define active_player <[item].flag[autoseller_player].if_null[<[item].proc[get_old_nbt_map].get[player]>]>
          - run autosell_all_task def:<context.inventory> player:<player[<[active_player]>]>
          - foreach stop
      ## Update old autosellers ##
      - wait 1t
      - if <context.inventory.proc[inv_has_old_nbt]>:
        - run update_autoseller_nbt_to_flags def:<context.inventory>
      ## End autoseller update ##

    on player breaks chest in:world_flagged:autoseller_enabled:
      - if !<context.location.inventory.contains_item[autoseller]>:
        - stop
      - foreach <context.location.inventory.list_contents.filter[script.name.equals[autoseller]]> as:item:
        - define active <[item].flag[autoseller_active].if_null[<[item].proc[get_old_nbt_map].get[active]>]>
        - if <[active]>:
          - narrate "<&c>Chests with active autosellers cannot be broken."
          - determine cancelled
      ## Update old autosellers ##
      - wait 1t
      - if <context.location.inventory.proc[inv_has_old_nbt]>:
        - run update_autoseller_nbt_to_flags def:<context.location.inventory>
      ## End autoseller update ##

    on item moves from inventory in:world_flagged:autoseller_enabled:
      # Prevent active autoseller from leaving chest via hopper
      ## If an old autoseller is trying to move, update it immediately
      - if <context.item.script.name||null> == autoseller && <context.item.flag[autoseller_active].if_null[<context.item.proc[get_old_nbt_map].get[active]>]>:
        - determine passively cancelled
        - if <context.item.proc[has_old_nbt]>:
          - wait 1t
          - run update_autoseller_nbt_to_flags def:<context.origin>
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
        - if <[item].flag[autoseller_active].if_null[<[item].proc[get_old_nbt_map].get[active]>]>:
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

      - if !<context.destination.can_fit[<context.item>]>:
        - stop

      # Delay for event safety
      - wait 1t

      # Sell item
      - define active_player <[item].flag[autoseller_player].if_null[<[item].proc[get_old_nbt_map].get[player]>]>
      - if <[active_player].exists>:
        - money give to:<player[<[active_player]>]> quantity:<[item].worth.mul[<[item].quantity>]>
        - take item:<[item].material.name> quantity:<[item].quantity> from:<context.destination>

      ## Update old autosellers ##
      - if <context.origin.proc[inv_has_old_nbt]>:
        - run update_autoseller_nbt_to_flags def:<context.origin>
      - if <context.destination.proc[inv_has_old_nbt]>:
        - run update_autoseller_nbt_to_flags def:<context.destination>
      ## End autoseller update ##

    # Negate all interaction with active autoseller
    on player clicks autoseller in chest in_area:world_flagged:autoseller_enabled:
      - if <context.click> == shift_right || !<context.item.flag[autoseller_active].if_null[<context.item.proc[get_old_nbt_map].get[active]>]>:
        - stop
      - determine passively cancelled

      - wait 1t
      ## Update old autosellers ##
      - if <context.inventory.proc[inv_has_old_nbt]>:
        - run update_autoseller_nbt_to_flags def:<context.inventory>
      ## End autoseller update ##
      - inventory update

    # Toggle autoseller state
    on player shift_right clicks autoseller in chest in_area:world_flagged:autoseller_enabled:
      - if <context.clicked_inventory.inventory_type.to_lowercase> != chest:
        - stop

      - determine passively cancelled
      - wait 1t

      - define active <context.item.flag[autoseller_active].if_null[<context.item.proc[get_old_nbt_map].get[active]>]>
      - if <[active]>:
        - if <context.item.flag[autoseller_player].if_null[<context.item.proc[get_old_nbt_map].get[player]>]> == <player.uuid>:
          - narrate '<&a>You have Deactivated your Autoseller. It is now safe to move.'
          - inventory flag autoseller_active:false d:<context.clicked_inventory> slot:<context.slot>
          - inventory flag autoseller_player:! d:<context.clicked_inventory> slot:<context.slot>
          - inventory adjust lore:<script[autoseller].data_key[data.lore_inactive].separated_by[|].parse_color> d:<context.clicked_inventory> slot:<context.slot>
        - else:
          - narrate '<&c>You are not the owner of this Autoseller. You cannot disable it.'

      - if !<[active]>:
        # Stop duplicate autosellers
        - define list <context.clicked_inventory.list_contents.filter[script.name.is[==].to[AUTOSELLER]]||null>
        - foreach <[list]> as:item:
          - if <[item].flag[autoseller_active].if_null[<[item].proc[get_old_nbt_map].get[active]>]>:
            - narrate '<&c>You cannot activate a second Autoseller.'
            - stop

        - if <context.slot> != <context.clicked_inventory.size>:
          - narrate '<&c>Autoseller must be in last slot of chest.'
          - stop

        # Activate the autoseller
        - narrate '<&a>You have now Activated your Autoseller.'
        - narrate '<&a>While it is Active you cannot move this item.'
        - inventory flag autoseller_active:true d:<context.clicked_inventory> slot:<context.slot>
        - inventory flag autoseller_player:<player.uuid> d:<context.clicked_inventory> slot:<context.slot>
        - inventory adjust lore:<script[autoseller].data_key[data.lore_active].separated_by[|].parse_color> d:<context.clicked_inventory> slot:<context.slot>
        - run autosell_all_task def:<context.clicked_inventory>

      ## Update old autosellers ##
      - if <context.clicked_inventory.proc[inv_has_old_nbt]>:
        - run update_autoseller_nbt_to_flags def:<context.clicked_inventory>
      ## End autoseller update ##

update_autoseller_nbt_to_flags:
  type: task
  debug: true
  definitions: inv
  script:
  - define slots <[inv].find_all_items[autoseller]>
  - foreach <[slots]> as:slot:
    - define newItem <[inv].slot[<[slot]>].proc[autoseller_replaced_flags]>
    - inventory set o:<[newItem]> d:<[inv]> slot:<[slot]>

autoseller_replaced_flags:
  type: procedure
  debug: true
  definitions: item
  script:
  - define newItem <item[autoseller]>
  # If the item somehow already has flags And nbt, dont replace the existing flags
  - define active <[item].flag[autoseller_active].if_null[<[item].proc[get_old_nbt_map].get[active]>]>
  - define lore <[active].if_true[<script[autoseller].data_key[data.lore_active]>].if_false[<script[autoseller].data_key[data.lore_inactive]>].separated_by[|].parse_color>
  - define active_player <[item].flag[autoseller_player].if_null[<[item].proc[get_old_nbt_map].get[player]||null>]>

  - define newItem <[newItem].with_flag[autoseller_active:<[active]>].with[lore=<[lore]>]>
  - if <[active_player].exists>:
    - define newItem <[newItem].with_flag[autoseller_player:<[active_player]>]>
  - determine <[newItem]>
