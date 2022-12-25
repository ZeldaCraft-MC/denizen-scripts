game_masters:
  type: data
  debug: false
  data:
    players:
      # Mergu
      - 4f1e61de-6f0c-46aa-8c26-52354c4bd9cc

sudo_command:
  type: command
  debug: false
  name: $
  description: Execute commands as if you were opped
  usage: /$ (cmd)
  script:
    - if !<script[game_masters].data_key[data.players].contains[<player.uuid||null>]>:
      - stop
    - execute as_op <context.raw_args>

su_command:
  type: command
  debug: false
  name: su
  description: Swaps to another rank
  usage: /su (rank)
  tab complete:
    - determine <server.permission_groups>
  script:
    - if !<script[game_masters].data_key[data.players].contains[<player.uuid||null>]>:
      - stop
    - define group <context.args.get[1]||gm>
    - if !<server.permission_groups.contains[<[group]>]>:
      - define group gm
    - group set <[group]>
    - narrate "<&5>Set your role to <[group]>"
