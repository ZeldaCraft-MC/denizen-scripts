ancient_spear:
  type: item
  debug: false
  material: netherite_sword
  display name: <aqua>Ancient Spear
  lore:
      - <gold>This spear is the result of countless hours
      - <gold>of research into the ancient technology
      - <gold>used by Guardians. The glowing spearhead
      - <gold>has high piercing potential.
  mechanisms:
      custom_model_data: 400

ring_of_grace:
  type: item
  debug: false
  material: paper
  display name: <&color[#80a4ba]>Ring of Grace
  lore:
      - <gold>A Zora Heirloom
      - <gold>Wearing this in your
      - <gold>offhand grants 2 extra hearts!
  mechanisms:
      custom_model_data: 700
      attribute_modifiers: <map.with[GENERIC_max_health].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[4].with[slot].as[OFF_HAND]>]>]>
