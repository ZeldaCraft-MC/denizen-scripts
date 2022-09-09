test_rp_command:
  type: command
  debug: false
  name: testrp
  usage: /testrp (url)
  description: Swaps your resource pack to the given url.
  permission: zc.command.testrp
  script:
    - if <context.args.size> == 0:
      - narrate "<&c>You must provide a valid url to a resource pack."
      - stop
    - define url http://packs.zeldacraft.net:4000
    - ~webget <[url]>/metadata.yml save:res
    - define metadata <util.parse_yaml[<entry[res].result>]>
    - resourcepack url:<[url]>/<context.args.get[1]> hash:<[metadata.hashes.<context.args.get[1].before[.]>]> forced "prompt:Please accept this" targets:<player>

rp_prompt:
  type: data
  debug: false
  data:
    - <empty>
    - <&8><&m>---------------
    - <&color[#3dffc8]>It's dangerous to go alone! Take this.
    - <empty>
    - <&color[#c0c0c0]>🗡
    - <empty>
    - <&7>To begin your journey on ZeldaCraft,
    - <&7>you must first accept our resource pack!
    - <empty>
    - <&color[#4287f5]>Are you ready?
    - <&8><&m>---------------
    - <&f>

rp_handler:
  type: world
  debug: false
  events:
    after player joins:
    - if <player.has_flag[from_server_swap]>:
      - flag <player> from_server_swap:!
      - stop
    - define url http://packs.zeldacraft.net:4000
    - ~webget <[url]>/metadata.yml save:res
    - define metadata <util.parse_yaml[<entry[res].result>]>
    - define live_pack <[metadata.live]>
    - if <player.has_permission[zc.rp_bypass]>:
      - resourcepack url:<[url]>/<[live_pack]>.zip hash:<[metadata.hashes.<[live_pack]>]> targets:<player>
    - else:
      - resourcepack url:<[url]>/<[live_pack]>.zip hash:<[metadata.hashes.<[live_pack]>]> forced prompt:<script[rp_prompt].parsed_key[data].separated_by[<n>]> targets:<player>
