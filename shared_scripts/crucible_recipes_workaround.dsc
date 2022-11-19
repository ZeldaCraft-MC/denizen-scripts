crucible_workaround_events:
  type: world
  debug: false
  events:
    on player crafts item bukkit_priority:lowest:
      - flag <player> crucible_crafting_workaround:<context.item> expire:1t
    on player crafts item bukkit_priority:highest:
      - if <player.has_flag[crucible_crafting_workaround]>:
        - determine <player.flag[crucible_crafting_workaround]>
    after player closes inventory:
      - adjust <player.inventory> reformat:scripts
    after player opens inventory:
      - adjust <player.inventory> reformat:scripts
