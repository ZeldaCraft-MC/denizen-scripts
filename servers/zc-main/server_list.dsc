server_list_hover_text:
  type: data
  debug: false
  data:
    quotes:
      - IT'S DANGEROUS TO GO ALONE! TAKE THIS.
      - It's a secret to everybody
      - Grumble, grumble
      - I AM ERROR
      - Well excuse me, princess
      - Hey! Listen!
    text:
      - <&a><&l>Zelda<&2><&l>Craft
      - <&7>[1.17.x - 1.19.x]
      - <&f>
      - <&9><&l>Discord: <&7>discord.gg/zeldacraft
      - <&3><&l>Website: <&7>zeldacraft.com
      - <&f>
      - <&7><&o><&dq><script[server_list_hover_text].data_key[data.quotes].random><&dq>
      - <&f>

server_list_events:
  type: world
  debug: false
  events:
    on server list ping:
      - define l1 "----------[ ZeldaCraft ]----------"
      - define start_color <color[#00ff00]>
      - define end_color <color[#4000ff]>
      - define hue_inc <[end_color].hue.sub[<[start_color].hue>].div_int[<[l1].length>]>
      - define out <empty>
      - foreach <[l1].split[]>:
        - define out <[out]><&color[<[start_color].with_hue[<[start_color].hue.add[<[hue_inc].mul[<[loop_index]>]>]>]>]><&l><[value]>
      #- define l1 "<&color[<[start_color]>]><&l>« <&color[<[start_color]>]>🗡 <&l>»<[out].hex_rainbow><&l>« <&color[<[start_color]>]>🏹 <&l>»"
      - define l1 "<element[ ].repeat[23]><element[ZeldaCraft].proc[gradient].context[#00ff00|#0000ff|<&l>]>"
      #- define l2 "<element[ ].repeat[7]><&c><&l>! <element[ACTIVE BUILD COMPETITION].proc[gradient].context[#ffea96|#f58742|<&l>]> <&c><&l>!"
      #- define l2 " <&color[#00dbfc]>🔱 <&color[#9ee7ff]><&n>Dungeons<&color[#00dbfc]> ☄ <&color[#9ee7ff]><&n>Spells<&color[#00dbfc]> ⛏ <&color[#9ee7ff]><&n>Survival<&color[#00dbfc]> 🪓 <&color[#9ee7ff]><&n>New Recipes<&color[#00dbfc]> ⚗"
      - define l2 "       <element[1.17.x - 1.19.x].proc[gradient].context[#9000ff|#4096ff|<&l>]> <&color[#c0c0c0]>🗡 <element[Java & Bedrock].proc[gradient].context[#4096ff|#9000ff|<&l>]>"
      #- define l2 "             <element[Easter Ev].proc[gradient].context[#9ef8df|#fdcede|<&l>]><element[ent LIVE!].proc[gradient].context[#fdcede|#9ef8df|<&l>]>"
      - determine passively <[l1]><n><[l2]>
      - determine passively icon:zc_icon_sword_pride.png
      - determine passively num_players:<server.flag[global_player_data].size.if_null[0]>
      - determine passively alternate_player_text:<script[server_list_hover_text].parsed_key[data.text]>
