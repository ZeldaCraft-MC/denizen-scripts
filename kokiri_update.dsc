deku_nut:
  type: item
  debug: false
  material: snowball
  data:
    discover: true
  display name: <&color[#995F31]>Deku Nut
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 100
    hides:
      - ENCHANTS
  lore:
    - <&color[#C27A40]>The dried bud of
    - <&color[#C27A40]>a Deku Baba.

blue_deku_husk:
  type: item
  debug: false
  material: leather
  data:
    discover: true
  display name: <&color[#4087C2]>Blue Deku Husk
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 600
    hides:
      - ENCHANTS
  lore:
    - <&color[#4F9EE2]>The outer husk of
    - <&color[#4F9EE2]>a Deku Baba. It's tough
    - <&color[#4F9EE2]>and shell like.

orange_deku_husk:
  type: item
  debug: false
  material: leather
  data:
    discover: true
  display name: <&color[#F39C2C]>Tough Deku Husk
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 700
    hides:
      - ENCHANTS
  lore:
    - <&color[#FFB85E]>The outer husk of
    - <&color[#FFB85E]>a Quadro Deku Baba.
    - <&color[#FFB85E]>It's very sturdy.

twilight_deku_husk:
  type: item
  debug: false
  material: leather
  data:
    discover: true
  display name: <&color[#5E1B91]>Carnivourous Deku Husk
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 800
    hides:
      - ENCHANTS
  lore:
    - <&color[#B63FB1]>The outer husk of
    - <&color[#B63FB1]>a Shadow Deku Baba.
    - <&color[#B63FB1]>It feels cursed.

deku_stick:
  type: item
  debug: false
  material: stick
  data:
    discover: true
  display name: <&color[#81623A]>Deku Stick
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 700
    hides:
      - ENCHANTS
  lore:
    - <&color[#A7865B]>The dried stem
    - <&color[#A7865B]>of a Deku Baba.

deku_torch:
  type: item
  debug: false
  material: torch
  data:
    discover: true
  display name: <&color[#AD6E1E]>Deku Torch
  enchantments:
    - LUCK: 1
  mechanisms:
    custom_model_data: 100
    hides:
      - ENCHANTS
  lore:
    - <&color[#D87B30]>A sturdy torch
    - <&color[#D87B30]>made from a Deku Stick.
  recipes:
    1:
      type: shaped
      input:
        - coal
        - deku_stick
      output_quantity: 8

kokiri_sword:
  type: item
  debug: false
  material: stone_sword
  data:
    discover: true
  display name: <&color[#A5ABA6]>Kokiri Sword
  mechanisms:
    custom_model_data: 1700
  enchantments:
    - DAMAGE_ARTHROPODS: 3
  lore:
    - <&color[#DFDFDF]>A short blade, suitable for a child.
    - <&color[#DFDFDF]>This sword is a treasure
    - <&color[#DFDFDF]>of the Kokiri.
  recipes:
    1:
      type: shaped
      input:
        - air|zc_courage_shard|air
        - blue_deku_husk|stone_sword|blue_deku_husk
        - air|deku_stick|air

kokiri_cap:
  type: item
  debug: false
  material: leather_helmet
  data:
    discover: true
  display name: <&color[#39C63F]>Kokiri Cap
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#5BDA76]>A green cap made
    - <&color[#5BDA76]>and worn by the
    - <&color[#5BDA76]>Kokiri. It fits snug!
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shell|zc_courage_shell|zc_courage_shell
        - zc_courage_shell|air|zc_courage_shell

kokiri_tunic:
  type: item
  debug: false
  material: leather_chestplate
  data:
    discover: true
  display name: <&color[#39C63F]>Kokiri Tunic
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#5BDA76]>A green tunic made
    - <&color[#5BDA76]>and worn by the
    - <&color[#5BDA76]>Kokiri. It fits snug!
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shell|zc_courage_shell|zc_courage_shell
        - zc_courage_shell|air|zc_courage_shell

kokiri_leggings:
  type: item
  debug: false
  material: leather_leggings
  data:
    discover: true
  display name: <&color[#FAFAF2]>Kokiri Leggings
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#FFFFFF]>White leggings made
    - <&color[#FFFFFF]>and worn by the
    - <&color[#FFFFFF]>Kokiri. It fits snug!
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shell|zc_courage_shell|zc_courage_shell
        - zc_courage_shell|air|zc_courage_shell
        - zc_courage_shell|air|zc_courage_shell

kokiri_boots:
  type: item
  debug: false
  material: leather_boots
  data:
    discover: true
  display name: <&color[#786049]>Kokiri Boots
  mechanisms:
    custom_model_data: 200
  lore:
    - <&color[#987C62]>Brown boots made
    - <&color[#987C62]>and worn by the
    - <&color[#987C62]>Kokiri. It fits snug!
  recipes:
    1:
      type: shaped
      input:
        - zc_courage_shell|air|zc_courage_shell
        - zc_courage_shell|air|zc_courage_shell

