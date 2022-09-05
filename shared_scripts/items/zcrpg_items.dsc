heros_bow:
  type: item
  debug: false
  material: bow
  display name: <&e><&l>Hero's Bow
  lore:
    - <&6>You'll feel like the hero of Hyrule
    - <&6>with this in your hands.
  enchantments:
    - ARROW_INFINITE:1
  mechanisms:
    hides: ALL
    unbreakable: true

magic_jar:
  type: item
  debug: false
  material: experience_bottle
  mechanisms:
    nbt: uniquifier/<util.random_uuid>
