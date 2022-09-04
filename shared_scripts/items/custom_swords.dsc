zc_goddes_sword:
  type: item
  debug: false
  material: golden_sword
  display name: <&e>Goddess Sword
  enchantments:
    - damage_all: 6
  mechanisms:
    custom_model_data: 100
    nbt_attributes: generic.attack_damage/mainhand/0/10
    hides: attributes
  lore:
  - "<&f>Right click for special attack"
  - "<&f>Uses <&d>30 <&f>Magic"
  - ""
  - "<&d>Forged together with the most powerful magic"
  - "<&f>Only a few can wield this power."
  recipes:
    1:
      type: shaped
      input:
        - shroomlight|music_disc_pigstep|shroomlight
        - zc_mythril|netherite_sword|zc_mythril
        - nether_star|zc_triforce_blade|nether_star

zc_twilight_scimitar:
  type: item
  debug: false
  material: netherite_sword
  display name: <&7>Scimitar of Twilight
  mechanisms:
    hides: attributes
    custom_model_data: 200
  enchantments:
    - damage_all: 8
  lore:
  - "<&f>Right click for special attack"
  - "<&f>Uses <&d>70 <&f>Magic"
  - ""
  - "<&c>Forged together with the strongest of metals"
  - "<&f>Only a few can wield this power."
  recipes:
    1:
      type: shaped
      input:
        - crying_obsidian|music_disc_pigstep|crying_obsidian
        - zc_mythril|netherite_sword|zc_mythril
        - netherite_block|zc_triforce_blade|netherite_block
