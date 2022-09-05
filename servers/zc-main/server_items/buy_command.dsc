buy_gui_cmd:
  type: command
  name: buy
  description: Opens the server store gui.
  usage: /buy
  script:
  - inventory open d:buy_gui_inv

buy_gui_inv:
  type: inventory
  inventory: hopper
  debug: false
  title: <&2>Zelda<&a>Craft Store
  gui: true
  procedural items:
    - define list <list[]>
    - if <player.has_permission[zc.svip]>:
      - define list <[list].include[no_item|tebex_thank_you_i|no_item|tebex_gift_i|no_item]>
      - goto smartskip
    - if <player.has_permission[zc.vipplus]>:
      - define list <[list].include[no_item|tebex_vipplustosvip|no_item|tebex_gift_i|no_item]>
      - goto smartskip
    - if <player.has_permission[zc.vip]>:
      - define list <[list].include[no_item|tebex_viptovipplus|tebex_viptosvip|tebex_gift_i|no_item]>
      - goto smartskip
    - define list <[list].include[no_item]>
    - define list <[list].include[tebex_vip|tebex_vipplus|tebex_svip]>
    - define list <[list].include[no_item]>
    - mark smartskip
    - determine <[list]>
  slots:
  - [] [] [] [] []

buy_gui_world:
  type: world
  debug: false
  events:
    on player clicks in buy_gui_inv:
    - if <context.clicked_inventory||none> != <player.open_inventory||none>:
      - stop
    - announce <context.item.script.name> to_console
    - choose <context.item.script.name||default>:
      - case tebex_gift_i:
        - define link https://store.zeldacraft.net/
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&chr[BB]> Visit <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover><&f> to gift a rank!<n>"
        - inventory close
      - case tebex_viptovipplus:
        - definemap package package_id:3928507 username:<player.name>
        - ~webget https://plugin.tebex.io/checkout data:<[package].to_json> headers:<map.with[Content-Type].as[application/json].with[X-Tebex-Secret].as[<secret[tebex_token]>]> save:tebex_req
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&7>To upgrade to <&color[#64dfdf]>VIP+<&7> please click this link:<&sp>"
        - define webget_result <entry[tebex_req].result>
        - define link <entry[tebex_req].result.proc[tebex_proc].first.get[url]>
        - narrate "<&chr[BB]> <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover>"
        - inventory close
      - case tebex_viptosvip:
        - definemap package package_id:4431077 username:<player.name>
        - ~webget https://plugin.tebex.io/checkout data:<[package].to_json> headers:<map.with[Content-Type].as[application/json].with[X-Tebex-Secret].as[<secret[tebex_token]>]> save:tebex_req
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&7>To upgrade to <&color[#80ffdb]>SVIP<&7> please click this link:<&sp>"
        - define webget_result <entry[tebex_req].result>
        - define link <entry[tebex_req].result.proc[tebex_proc].first.get[url]>
        - narrate "<&chr[BB]> <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover>"
        - inventory close
      - case tebex_vipplustosvip:
        - announce test3 to_console
        - definemap package package_id:3928510 username:<player.name>
        - ~webget https://plugin.tebex.io/checkout data:<[package].to_json> headers:<map.with[Content-Type].as[application/json].with[X-Tebex-Secret].as[<secret[tebex_token]>]> save:tebex_req
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&7>To upgrade to <&color[#80ffdb]>SVIP<&7> please click this link:<&sp>"
        - define webget_result <entry[tebex_req].result>
        - define link <entry[tebex_req].result.proc[tebex_proc].first.get[url]>
        - narrate "<&chr[BB]> <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover>"
        - inventory close
      - case tebex_svip:
        - definemap package package_id:3928503 username:<player.name>
        - ~webget https://plugin.tebex.io/checkout data:<[package].to_json> headers:<map.with[Content-Type].as[application/json].with[X-Tebex-Secret].as[<secret[tebex_token]>]> save:tebex_req
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&7>To buy <&color[#80ffdb]>SVIP<&7> please click this link:<&sp>"
        - define webget_result <entry[tebex_req].result>
        - define link <entry[tebex_req].result.proc[tebex_proc].first.get[url]>
        - narrate "<&chr[BB]> <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover>"
        - inventory close
      - case tebex_vipplus:
        - definemap package package_id:3928498 username:<player.name>
        - ~webget https://plugin.tebex.io/checkout data:<[package].to_json> headers:<map.with[Content-Type].as[application/json].with[X-Tebex-Secret].as[<secret[tebex_token]>]> save:tebex_req
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&7>To buy <&color[#64dfdf]>VIP+<&7> please click this link:<&sp>"
        - define webget_result <entry[tebex_req].result>
        - define link <entry[tebex_req].result.proc[tebex_proc].first.get[url]>
        - narrate "<&chr[BB]> <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover>"
        - inventory close
      - case tebex_vip:
        - definemap package package_id:3928494 username:<player.name>
        - ~webget https://plugin.tebex.io/checkout data:<[package].to_json> headers:<map.with[Content-Type].as[application/json].with[X-Tebex-Secret].as[<secret[tebex_token]>]> save:tebex_req
        - narrate "<&nl><&2>Zelda<&a>Craft Store"
        - narrate "<&7>To buy <&color[#48bfe3]>VIP<&7> please click this link:<&sp>"
        - define webget_result <entry[tebex_req].result>
        - define link <entry[tebex_req].result.proc[tebex_proc].first.get[url]>
        - narrate "<&chr[BB]> <&b><&n><&hover[Click here!]><&click[<[link]>].type[open_url]><[link]><&end_click><&end_hover>"
        - inventory close
    on system time minutely:
    - ~webget https://plugin.tebex.io/payments?limit=10 headers:<map.with[X-Tebex-Secret].as[<secret[tebex_token]>]> timeout:10s save:teb_web
    - if <entry[teb_web].failed>:
      - stop
    - define webget_result <entry[teb_web].result>
    - define weblist <entry[teb_web].result.proc[tebex_proc]>
    - define num 0
    - foreach <[weblist]> as:webmap:
      - if <[webmap].get[id]> == <server.flag[tebex_latest_payment]>:
        - if <[loop_index]> == 1:
          - foreach stop
        - announce "<[num]> total new payments" to_console
        - foreach stop
      - if <[webmap].get[id]> == <server.flag[tebex_second_payment]>:
        - foreach stop
      - define player <[webmap].get[player].get[uuid].proc[no_dash_uuid_proc]>
      - define rank <script[tebex_packages].data_key[packages].get[<[webmap].get[packages].first.get[id]>]>
      - execute as_server "lp user <[player].name> parent add <[rank]>"
      - announce "<[player].name> received <[webmap].get[packages].first.get[name]>" to_console
      - define pack_name <script[tebex_packages].data_key[dis_packages].get[<[webmap].get[packages].first.get[id]>]>
      - ~discordmessage id:zc-info channel:152498419569524736 <discord_embed.with_map[<script[teb_messages].parsed_key[donation_message]>]>
      - announce "Thank you <[player].name> for donating for the <[pack_name].to_uppercase> rank!" format:zc_text
      - define num:++
    - flag server tebex_latest_payment:<[weblist].first.get[id]>
    - flag server tebex_second_payment:<[weblist].get[2].get[id]>

tebex_packages:
  type: data
  debug: false
  packages:
    3928510: svip
    4431077: svip
    3928507: vipplus
    3928503: svip
    3928498: vipplus
    3928494: vip
  dis_packages:
    3928510: svip
    4431077: svip
    3928507: vip+
    3928503: svip
    3928498: vip+
    3928494: vip

teb_perks:
  type: data
  debug: false
  vip_perks:
    title: You now have access to<&co>
    value:
      - A freebuild creative world, /warp VIP
      - Changing your ingame name, /nick
      - Chat colors, formatting, and the ability to post URLs
      - A custom [VIP] prefix
    inline: false
  vip+_perks:
    title: You now have access to<&co>
    value:
      - Changing the color on your nick
      - Using color and format codes in signs
      - All rewards from the VIP Rank
      - A custom [VIP+] prefix
    inline: false
  svip_perks:
    title: You now have access to<&co>
    value:
      - Posing armor stands with a piece of flint
      - Dozens of custom player particles, /aura
      - Recoloring items in an anvil
      - Full RGB nickname and chat colors
      - Custom chat flairs, /flair
      - All rewards from the VIP and VIP+ Ranks
      - SVIP role on discord
      - A custom [SVIP] prefix that also appears in tab
    inline: false

teb_messages:
  type: data
  debug: false
  donation_message:
    author_name: ZeldaCraft Donation
    author_icon_url: <discord[zc-info].self_user.avatar_url>
    author_url: https://store.zeldacraft.net/
    description: Thank you <[player].name> for donating for the <[pack_name].to_uppercase> rank!
    fields:
      - <script[teb_perks].parsed_key[<[pack_name]>_perks].with[value].as[<&chr[BB]> <script[teb_perks].parsed_key[<[pack_name]>_perks].get[value].separated_by[<&nl><&chr[BB]> ]>]>
    thumbnail: https://cravatar.eu/helmavata/<[player].name>/32.png
    color: lime
    timestamp: <util.time_now>

tebex_thank_you_i:
  type: item
  debug: false
  material: emerald
  display name: <&a><&l>Thank you!
  lore:
  - <&f>You already have our highest rank <&e><&chr[263B]>
  - <&f>Thank you for donating to our server

tebex_gift_i:
  type: item
  debug: false
  material: player_head[skull_skin=<util.random_uuid>|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNmNlZjlhYTE0ZTg4NDc3M2VhYzEzNGE0ZWU4OTcyMDYzZjQ2NmRlNjc4MzYzY2Y3YjFhMjFhODViNyJ9fX0=]
  display name: <&e><&l>Gift a rank!
  lore:
  - <&f>Feeling generous? Click to gift
  - <&f>a rank to another player!

tebex_viptovipplus:
  type: item
  debug: false
  material: gold_ingot
  display name: <&color[#64dfdf]>VIP <&chr[BB]> VIP+ <&a>Upgrade
  lore:
  - <&7>Price<&co> <&2>$5

tebex_viptosvip:
  type: item
  debug: false
  material: diamond
  display name: <&color[#80ffdb]>VIP <&chr[BB]> SVIP <&a>Upgrade
  lore:
  - <&7>Price<&co> <&2>$15

tebex_vipplustosvip:
  type: item
  debug: false
  material: diamond
  display name: <&color[#80ffdb]>VIP+ <&chr[BB]> SVIP <&a>Upgrade
  lore:
  - <&7>Price<&co> <&2>$10

tebex_vip:
  type: item
  debug: false
  material: iron_ingot
  display name: <&color[#48bfe3]>VIP <&a>Rank
  lore:
  - <&7>Price<&co> <&2>$5

tebex_vipplus:
  type: item
  debug: false
  material: gold_ingot
  display name: <&color[#64dfdf]>VIP+ <&a>Rank
  lore:
  - <&7>Price<&co> <&2>$10

tebex_svip:
  type: item
  debug: false
  material: diamond
  display name: <&color[#80ffdb]>SVIP <&a>Rank
  lore:
  - <&7>Price<&co> <&2>$20

no_dash_uuid_proc:
  type: procedure
  definitions: uuid
  debug: false
  script:
    - determine <[uuid].split[].insert[-].at[9].insert[-].at[14].insert[-].at[19].insert[-].at[24].unseparated.as[player]>

tebex_proc:
  type: procedure
  definitions: webget_result
  debug: false
  script:
    - determine <util.parse_yaml[{"result":<[webget_result]>}].get[result].as[list]>
