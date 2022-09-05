hotdog:
  type: item
  debug: false
  material: bread
  display name: <&e>Hotdog
  recipes:
    1:
      type: shaped
      input:
      - air|bread|air
      - air|beef|air
      - air|bread|air
  lore:
  - <&f>Tasty

boiled_hotdog:
  type: item
  debug: false
  material: bread
  display name: <&3>Boiled Hotdog
  recipes:
    1:
      type: shapeless
      input: hotdog|boiled_water
  lore:
  - <&f>Even Tastier

boiled_water:
  type: item
  debug: false
  material: water_bucket
  display name: <&1>Boiled Water
  recipes:
    1:
      type: furnace
      cook_time: 1s
      experience: 1
      input: water_bucket
  lore:
  - <&f>Hot
