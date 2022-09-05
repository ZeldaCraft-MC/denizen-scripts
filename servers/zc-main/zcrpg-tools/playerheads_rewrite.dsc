ph_command:
  type: command
  name: ph
  description: Player heads rewrite, by Mergu
  debug: false
  usage: /ph
  permission: zc.command.ph.REMOVEME
  script:
  - choose <context.args.get[1].to_lowercase||null>:
    - case spawn:
      - inject <script> path:spawn
    - case rename:
      - inject <script> path:rename
    - case heads:
      - narrate "<&c>Opens custom head repo."
      - narrate "<&c>This feature is in development."
    - case null:
      - narrate <&9>[PlayerHeads]
      - narrate "<&7>Subcommands<&co> <&e>/ph spawn, rename, heads"
    - default:
      - narrate "<&c>This command doesn't seem to exist. Use <&e>/ph<&c> to view available commands."

  spawn:
  - choose <context.args.get[2]||null>:
    - case null:
      - narrate "<&9>Usage: <&e>/ph spawn <&lt>username<&gt> (quantity)"
      - narrate "<&7>Gives you a player head."
    - default:
      - define qty <context.args.get[3]||1>
      - if <[qty].round_down||true> || <[qty]> > 64 || <[qty]> < 1>:
        - narrate "<&c>Quantity must be between <&e>1<&c> and <&e>64<&c>."
        - stop
      - define name <context.args.get[2].to_lowercase.to_titlecase>
      - define head player_head[display_name=<[name]><&sq>s<&sp>Head;skull_skin=<[name]>]
      - if <player.inventory.can_fit[<[head]>].quantity[<[qty]>].not>:
        - narrate "<&c>Inventory is too full!"
        - stop
      - give <[head]> quantity:<[qty]>

  rename:
  - choose <context.args.get[2]||null>:
    - case null:
      - narrate "<&9>Usage: <&e>/ph rename <&lt>username<&gt>"
      - narrate "<&7>Renames the head in your hand."
    - default:
      - if <player.item_in_hand.material.name> != player_head:
        - narrate "<&c>You must be holding a player head!"
        - stop
      - define name <context.args.get[2].to_lowercase.to_titlecase>
      - define qty <player.item_in_hand.quantity>
      - define slot <player.held_item_slot>
      - take iteminhand quantity:<[qty]>
      - give player_head[display=<[name]><&sq>s<&sp>Head;skull_skin=<[name]>] quantity:<[qty]> slot:<[slot]>

ph_menu_p1:
    type: inventory
    inventory: chest
    debug: false
    title: Custom Heads
    size: 54
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
