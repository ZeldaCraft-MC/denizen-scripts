baltop_events:
  type: world
  debug: false
  events:
    on delta time secondly:
    - foreach <server.online_players> as:__player:
      - if <yaml.list.contains[<player.uuid>]>:
        - yaml set money:<player.money> id:<player.uuid>
      - else:
        - webget "http://localhost:8080/players/<player.uuid>" 'post:{"money":<player.money>}' "headers:Content-type/application/json"

baltop_command:
  type: command
  debug: false
  description: "get the players baltop"
  usage: /baltop
  name: baltop
  permission: zc.baltop
  aliases:
    - balancetop
    - essentials:baltop
    - essentials:balancetop
  script:
    - define page_size <context.args.get[2]||10>
    - define page <context.args.get[1].max[1].min[<element[100].div[<[page_size]>].round_up>]||1>
    - define start <[page].sub[1].mul[<[page_size]>].add[1].max[1].min[91]>
    - define end <[start].add[<[page_size]>].sub[1].max[1].min[100]>
    - define output <list[]>

    - ~webget "http://localhost:8080/baltop?offset=<[start].sub[1]>&size=<[page_size].min[<element[100].sub[<[start].sub[1]>]>]>" save:request
    - yaml loadtext:<entry[request].result> id:<player.uuid>-baltop

    # Reads into a list of uuids
    - foreach <yaml[<player.uuid>-baltop].read[result]> as:data:
      - define num <[loop_index].add[<[start].sub[1]>]>
      - if <[num]> == 1:
        - define cc <&c>
      - else if <[num]> == 2:
        - define cc <&5>
      - else if <[num]> == 3:
        - define cc <&d>
      - else:
        - define cc <&7>
      - if <[data].get[uuid]> == <player.uuid>:
        - define f <&l>
      - else:
        - define f:!

      - define pre "<[f]||<empty>><&b.no_reset>#<[num]>: <[cc].no_reset><[data].get[name]>"
      - define "output:|:<[pre]> <element[].pad_right[<element[270].sub[<[pre].text_width>].div_int[2]>].with[.]> <server.economy.format[<[data].get[money]>]><&r>"

    - yaml unload id:<player.uuid>-baltop

    - narrate "<n><&b><&m>---<&b> Top Server Balances | Your Bal: <&d><player.formatted_money> <&b><&m>---"
    - narrate <[output].separated_by[<n>]>
    - narrate "<&b><&m>---------------<&b> Page: <element[[<&chr[AB]>]].on_click[/baltop <[page].sub[1]> <[page_size]>].on_hover[Previous page]> <element[[<&chr[BB]>]].on_click[/baltop <[page].add[1]> <[page_size]>].on_hover[Next page]> <&b><&m>---------------"

# Should only be run one time manually to populate the new baltop
#baltop_prepop:
#  type: command
#  name: baltop_prepop
#  permission: do.not.run.me
#  script:
#    - define all_players <server.list_players>
#    - define size <[all_players].size>
#    - foreach <[all_players]> as:pl:
#      - webget "http://localhost:8080/players/<[pl].uuid>" "post:{<&dq>money<&dq>:<[pl].money>}" "headers:Content-type/application/json"
#      - if <[loop_index].mod[200]> == 0:
#        - narrate "At player <[loop_index]>/<[size]>. <[loop_index].div[<[size]>].mul[100].round>% done."
#        - wait 1s
#    - narrate "Finishing up last iteration..."
#    - narrate "Done! Took <queue.time_ran.formatted> to complete."
