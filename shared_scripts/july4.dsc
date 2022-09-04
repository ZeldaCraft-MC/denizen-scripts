freedom_firework:
  type: item
  debug: false
  material: firework_rocket
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Firework].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    firework: 1|true,true,BALL,240,240,240,240,240,240|true,true,BALL,240,0,0,240,0,0|true,true,STAR,0,0,240,0,0,240
    hides: all

freedom_flag:
  type: item
  debug: false
  material: paper
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Flag].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 14012
  lore:
    - <&7><&o>Place in an item frame to use as furniture.
  no_id: true

freedom_blade:
  type: item
  debug: false
  material: netherite_sword
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Blade].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 2600

freedom_pickaxe:
  type: item
  debug: false
  material: netherite_pickaxe
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Pickaxe].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 700

freedom_axe:
  type: item
  debug: false
  material: netherite_axe
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Axe].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 700

freedom_shovel:
  type: item
  debug: false
  material: netherite_shovel
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Shovel].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 900

freedom_hoe:
  type: item
  debug: false
  material: netherite_hoe
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Hoe].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 200

freedom_bow:
  type: item
  debug: false
  material: bow
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Bow].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 500

freedom_rod:
  type: item
  debug: false
  material: fishing_rod
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Rod].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 100

freedom_shield:
  type: item
  debug: false
  material: shield
  display name: "<element[Freedom].color_gradient[from=<&c>;to=<&f>]> <element[Shield].color_gradient[from=<&f>;to=<&9>]>"
  mechanisms:
    custom_model_data: 300

july4_events:
  debug: false
  type: world
  data:
    red_items:
      - red_wool[quantity=64]
      - red_mushroom_block[quantity=16]
      - red_terracotta[quantity=64]
      - red_stained_glass[quantity=64]
      - red_shulker_box
      - red_concrete[quantity=64]
      - red_concrete_powder[quantity=64]
      - redstone[quantity=64]
      - red_dye[quantity=64]
      - red_bed
      - red_banner[quantity=5]
      - red_candle[quantity=16]
      - tipped_arrow[quantity=16;potion_effects=[type=INSTANT_HEAL;upgraded=true;extended=false]]
      - tipped_arrow[quantity=16;potion_effects=[type=STRENGTH;upgraded=true;extended=false]]
    white_items:
      - white_wool[quantity=64]
      - white_terracotta[quantity=64]
      - white_stained_glass[quantity=64]
      - white_shulker_box
      - white_concrete[quantity=64]
      - white_concrete_powder[quantity=64]
      - white_dye[quantity=64]
      - white_bed
      - white_banner[quantity=5]
      - white_candle[quantity=16]
      - tipped_arrow[quantity=16;potion_effects=[type=SLOW_FALLING;upgraded=false;extended=true]]
    blue_items:
      - blue_wool[quantity=64]
      - light_blue_wool[quantity=64]
      - blue_terracotta[quantity=64]
      - light_blue_terracotta[quantity=64]
      - blue_stained_glass[quantity=64]
      - light_blue_stained_glass[quantity=64]
      - blue_shulker_box
      - light_blue_shulker_box
      - blue_concrete[quantity=64]
      - light_blue_concrete[quantity=64]
      - blue_concrete_powder[quantity=64]
      - light_blue_concrete_powder[quantity=64]
      - blue_ice[quantity=64]
      - blue_dye[quantity=64]
      - light_blue_dye[quantity=64]
      - blue_bed
      - light_blue_bed
      - blue_banner[quantity=5]
      - light_blue_banner[quantity=5]
      - blue_candle[quantity=16]
      - light_blue_candle[quantity=16]
      - tipped_arrow[quantity=16;potion_effects=[type=WATER_BREATHING;upgraded=false;extended=true]]
      - tipped_arrow[quantity=16;potion_effects=[type=SPEED;upgraded=true;extended=false]]
      - tipped_arrow[quantity=16;potion_effects=[type=NIGHT_VISION;upgraded=false;extended=true]]
  events:
    on player right clicks wandering_trader:
    - stop
    - if <player.gamemode> == adventure:
      - stop
    - determine passively cancelled
    - ratelimit <player> 1t
    - define title "<&c><&l>Wandering <&9><&l>Patriot <&f> <&f> <&f> <&f> <&f> <&f> <&f> <&f> <&f> "
    - flag <player> july4_trader:<context.entity> expire:15d
    - if <context.entity.has_flag[july4_trades]>:
      - opentrades <context.entity.flag[july4_trades]> title:<[title]>
      - stop
    - define trades:->:trade[result=freedom_firework[quantity=<util.random.int[1].to[10]>];inputs=emerald[quantity=<util.random.int[15].to[30]>];max_uses=<util.random.int[1].to[5]>]
    - foreach <script.data_key[data.red_items].random[3]>:
      - define trades:->:trade[result=<[value]>;inputs=freedom_firework[quantity=<util.random.int[3].to[12]>];max_uses=<util.random.int[1].to[3]>]
    - foreach <script.data_key[data.white_items].random[3]>:
      - define trades:->:trade[result=<[value]>;inputs=freedom_firework[quantity=<util.random.int[3].to[12]>];max_uses=<util.random.int[1].to[3]>]
    - foreach <script.data_key[data.blue_items].random[3]>:
      - define trades:->:trade[result=<[value]>;inputs=freedom_firework[quantity=<util.random.int[3].to[12]>];max_uses=<util.random.int[1].to[3]>]
    - if <util.random_chance[80]>:
      - define trades:->:trade[result=freedom_flag;inputs=freedom_firework[quantity=20];max_uses=1]
    - else:
      - random:
        - define trades:->:trade[result=freedom_blade;inputs=netherite_sword|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_bow;inputs=bow|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_rod;inputs=fishing_rod|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_pickaxe;inputs=netherite_pickaxe|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_axe;inputs=netherite_axe|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_shovel;inputs=netherite_shovel|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_hoe;inputs=netherite_hoe|freedom_firework[quantity=64];max_uses=1]
        - define trades:->:trade[result=freedom_shield;inputs=shield|freedom_firework[quantity=64];max_uses=1]
    - flag <context.entity> july4_trades:<[trades]>
    - opentrades <[trades]> title:<[title]>
    - adjust <context.entity> persistent:true

    after player trades with merchant:
    - stop
    - if !<player.has_flag[july4_trader]> || !<player.flag[july4_trader].has_flag[july4_trades]>:
      - stop
    - define trades <player.open_inventory.trades||null>
    - if <[trades]> == null:
      # Trying to break my event? No trades for u.
      - flag <player.flag[july4_trader]> july4_trades:<list>
      - stop
    - flag <player.flag[july4_trader]> july4_trades:<[trades]>
