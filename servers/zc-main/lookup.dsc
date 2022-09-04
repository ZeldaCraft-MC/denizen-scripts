# Permissions:
# denizen.command.lookup to run /lookup
# denizen.clickable to click the options in chat

lookup_command_conf:
  type: data
  data:
    messages:
      no_target: <&c>You must be facing a player when using this command!
      waiting: <&7>This player already has a lookup request, please wait.
      sent: <&e>Lookup request sent.
      request: <&e><[player_name]> <&7>wants to search your pockets!<n>Click to <&a><[accept]> <&7>or to <&c><[forbid]>
      deny_target: <&e><[player_name]> <&c>denied your lookup request.
      deny_self: <&7>Denied lookup request.
      accept_self: <&7>Accepted lookup request.

lookup_command:
  type: command
  name: lookup
  permission: denizen.command.lookup
  script:
  - define target <player.target[player].within[5].if_null[null]>
  - if <[target]> == null:
    - narrate <script[lookup_command_conf].parsed_key[data.messages.no_target]>
    - stop
  - if <[target].has_flag[lookup_requested]>:
    - narrate <script[lookup_command_conf].parsed_key[data.messages.waiting]>
    - stop
  - flag <[target]> lookup_requested expire:1m
  - narrate <script[lookup_command_conf].parsed_key[data.messages.sent]>
  - define player_name <player.name>
  - define uniq <util.random_uuid>
  - clickable peek_inventory_task def:accept|<player>|<[uniq]> usages:1 until:1m save:accept_peek
  - clickable peek_inventory_task def:forbid|<player>|<[uniq]> usages:1 until:1m save:forbid_peek
  - define accept <element[Accept].on_click[<entry[accept_peek].command>]>
  - define forbid <element[Forbid].on_click[<entry[forbid_peek].command>]>
  - narrate <script[lookup_command_conf].parsed_key[data.messages.request]> player:<[target]>

peek_inventory:
  type: inventory
  inventory: chest
  title: <player.name>'s inventory
  size: 36
  gui: true

peek_inventory_task:
  type: task
  definitions: action|peeker|uniq
  script:
    - ratelimit <player>,<[uniq]> 1m
    - if !<[peeker].is_online>:
      - stop
    - define player_name <player.name>
    - if <[action]> == forbid:
      - narrate <script[lookup_command_conf].parsed_key[data.messages.deny_target]> player:<[peeker]>
      - narrate <script[lookup_command_conf].parsed_key[data.messages.deny_self]>
      - stop
    - narrate <script[lookup_command_conf].parsed_key[data.messages.accept_self]>
    - define inv <inventory[peek_inventory]>
    - inventory set d:<[inv]> o:<player.inventory.list_contents.get[1].to[36]>
    - inventory open d:<[inv]> player:<[peeker]>
