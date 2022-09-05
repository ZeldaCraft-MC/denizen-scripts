biome_selector:
  type: item
  debug: false
  material: golden_axe
  display name: Biome Wand

biome_wand:
  type: command
  debug: false
  name: biomewand
  usage: /biomewand
  description: Retrieve a biome wand
  permission: zc.setbiome
  script:
    - give biome_selector

biome_command:
  type: command
  debug: false
  name: setbiome
  usage: /setbiome
  description: Use to set a biome
  permission: zc.setbiome
  script:
    - if <context.args.get[1]||help> == help:
      - narrate "<&b>Use <&e>/setbiome [biome]<&b> after selecting a biome with the biome wand (<&e>/biomewand<&b>)"
      - narrate "<&b>A list of all valid biomes are here: <&e>https://hub.spigotmc.org/javadocs/spigot/org/bukkit/block/Biome.html"
      - stop
    - if !<player.has_flag[biome_pos1]> || !<player.has_flag[biome_pos2]>:
      - narrate "<&b>Please select a biome region first via <&e>/biomewand"
      - stop
    - define cuboid <location[<player.flag[biome_pos1]>].to_cuboid[<player.flag[biome_pos2]>]>
    - define biome <context.args.get[1].to_lowercase>
    - if !<server.biome_types.parse[name].contains[<[biome]>]>:
      - narrate "<&b>Unknown biome specified! See here for biome list: <&e>https://hub.spigotmc.org/javadocs/spigot/org/bukkit/block/Biome.html"
      - stop
    - if <[cuboid].blocks.size> > 50000:
      - narrate "<&b>Selected region too large. Max area is 1000 blocks."
      - stop
    - adjust <[cuboid].blocks> biome:<biome[<[biome]>]>
    - foreach <player.location.find_players_within[50]> as:player:
      - adjust <[player]> skin_blob:<[player].skin_blob>

biome_events:
  type: world
  debug: false
  events:
    on player left clicks block with:biome_selector:
      - determine passively cancelled
      - if <context.click_type> != LEFT_CLICK_BLOCK:
        - stop
      - if !<player.has_permission[zc.setbiome]>:
        - stop
      - narrate "<&b>Selected biome position 1 at <context.location.simple>"
      - flag player biome_pos1:<context.location.with_y[0].block>
    on player right clicks block with:biome_selector:
      - determine passively cancelled
      - if <context.click_type> != RIGHT_CLICK_BLOCK:
        - stop
      - if !<player.has_permission[zc.setbiome]>:
        - stop
      - narrate "<&b>Selected biome position 2 at <context.location.simple>"
      - flag player biome_pos2:<context.location.with_y[0].block>
