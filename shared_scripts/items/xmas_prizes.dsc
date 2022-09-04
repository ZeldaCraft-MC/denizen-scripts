Present_shooter:
  debug: false
  type: item
  material: player_head[skull_skin=Present|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYWIzMzliMWNkNDAwNTNkZWZkN2QzNTI4ZTAxZmVhODc2ZDQxYjQyZjlkOTI2ODQ2MWRhNzlmNWY2Njc3MTIzNiJ9fX0=]
  display name: "<yellow><bold>Present Shooter"
  lore:
  - "<&f><red>Right-Click<gold> to fire Presents!"
  - "<italic><light_purple>Said to contain <yellow><player.flag[contributed_presents]||infinite><light_purple> presents"
  - ""
  - "<&f><blue>Earned as part of the <aqua><bold>2021 Xmas event"

infinite_snowball:
  debug: false
  type: item
  material: snowball
  display name: "<bold>Infinite <aqua>Snowball"
  lore:
  - "<yellow>SNOWBALL FIIIIIGHT!"
  - ""
  - "<&1>Earned as part of the <aqua>2021 Xmas event"

xmas_present_bag_prize:
  debug: false
  type: item
  material: player_head[skull_skin=Present|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYWIzMzliMWNkNDAwNTNkZWZkN2QzNTI4ZTAxZmVhODc2ZDQxYjQyZjlkOTI2ODQ2MWRhNzlmNWY2Njc3MTIzNiJ9fX0=]
  display name: "<red><bold>Present Bag Decoration"
  lore:
  - "<red>Right-Click <yellow>to play a present geyser effect!"
  - "<red>Right-Click <light_purple>While sneaking <yellow>to change the snow particle range"
  - ""

xmas_present_prize:
  debug: false
  type: item
  material: player_head[skull_skin=Present|<script[xmas_data].parsed_key[textures].random>]
  display name: "<gold><bold>Present Decoration"
  lore:
  - "<red>Right-Click <yellow>to play a present sound effect!"
  - "<red>Right-Click <light_purple>While sneaking <yellow>to change the snow particle range"
  - ""

xmas_snow_block_prize:
  debug: false
  type: item
  material: player_head[skull_skin=Snow|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNWRkNmZlMjY3YTQxOGRjYzdmMzdhOGY3Njg1NWI1MzI4YjEzMDM4OTdiMzQyYTEwN2NmMTYyZjE0ZmUzZCJ9fX0=]
  display name: "<bold>Snow block Decoration"
  lore:
  - "<red>Right-Click <yellow>to play a snowy effect!"
  - "<red>Right-Click <light_purple>While sneaking <yellow>to change the snow particle range"
  - ""
jolly_cap:
  debug: false
  type: item
  material: leather_helmet[color=255,48,48;enchantments=aqua_affinity,1|protection,4|respiration,3|thorns,3|]
  #;nbt_attributes=li@el@generic:max_health/head/0/4.0|el@generic&ampampdotmovement_speed/head/1/0.30000001192092896|;repair_cost=15;unbreakable=true]
  display name: "<red><bold>Jolly Red Cap"
  lore:
  - "<light_purple>So that's how Santa stays so nimble..."
  - ""
  mechanisms:
    hides: DYE
    unbreakable: true
    repair_cost: 15
    nbt_attributes: generic.max_health/head/0/4.0|generic.movement_speed/head/1/0.30000001192092896

Present_bag:
  debug: false
  type: item
  material: player_head[skull_skin=Present|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYWIzMzliMWNkNDAwNTNkZWZkN2QzNTI4ZTAxZmVhODc2ZDQxYjQyZjlkOTI2ODQ2MWRhNzlmNWY2Njc3MTIzNiJ9fX0=]
  display name: "Present Bag"
  lore:
  - "<&f><gold><player.flag[player_presents]||0> <red>Presents"
  - "<&f>Any presents you find will be added here"

Present:
  debug: false
  type: item
  material: player_head[skull_skin=Present|<script[xmas_data].parsed_key[textures].random>]
  display name: "Present"

Stack_Present:
  debug: false
  type: item
  material: player_head[skull_skin=Present|<script[xmas_data].parsed_key[textures].random>]
  display name: "Present"

Fake_Present:
  debug: false
  type: item
  material: player_head[skull_skin=Present|<script[xmas_data].parsed_key[textures].random>]
  display name: "Fake Present"
  # mechanisms:
  #   pickup_delay: 5m
    # time_lived: 5m

Hyrule_bass:
  type: item
  debug: false
  material: cod
  display name: "<&color[#6e6226]>Hyrule <&color[#9e9255]>bass"
  lore:
  - <gray>An ordinary fish that
  - <gray>can be found all over hyrule
  - ""
Reekfish:
  type: item
  debug: false
  material: salmon
  display name: "<&color[#bd3e49]>Reek<&color[#a6212d]>fish"
  lore:
  - <gray>Despite it's very powerful odor,
  - <gray>it is apparently sacred among Zora
  - ""

Bokoblin_head:
  debug: false
  type: item
  material: player_head[display=Bokoblin;skull_skin=bfd178b2-cc16-4225-83e2-2bcd04289ad8|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNDExYTY1ZGNkODNkMGNlOWFhZTdjNDhlZTg1YzJkZjYwZWY5NDgxNjMzNDYyMTRlOTVjMWFhZTczODIzZTAyZiJ9fX0=]
  display name: "<&2><&l>Bokoblin head"
  lore:
  - <light_purple>Your prize for besting the swift Bokoblin
  - <&2>It's still staring at my presents..
  - ""

Chilfos_head:
  debug: false
  type: item
  material: skeleton_skull
  display name: "<&b><&l>Chilfos head"
  lore:
  - <light_purple>Your prize for besting the mighty Chilfos
  - <&b>It's still cold to the touch..
  - ""

Moblin_head:
  debug: false
  type: item
  material: player_head[display=Moblin;skull_skin=67cffa16-cf5d-4a75-ab9c-5dec2a02cdfa|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjI5YmE5ZjM2ZTY5NmI1MWJjZTE4NjYwZmIwOTEyNzQwODZiNGYyNmY2NjlkYjY4ZDhiMGMxOGViYmMwMDdiYyJ9fX0=]
  display name: "<&2><&l>Moblin head"
  lore:
  - <light_purple>Your prize for besting the brutish Moblin
  - <&6>It still has a grumpy expression..
  - ""
