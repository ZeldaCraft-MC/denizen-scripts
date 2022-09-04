autoseller:
  type: item
  material: emerald
  display name: Auto Seller
  debug: false
  discover: true
  enchantments:
    - LUCK: 1
  mechanisms:
    hides:
      - ENCHANTS
    nbt: "active/false"
    lore: <script[autoseller].yaml_key[lore_inactive].separated_by[|].parse_color>
  lore_active:
  - "&aACTIVE"
  - "&7Hold shift and right-click me"
  - "&7to Deactivate."
  - ""
  - "&7When active, I sell"
  - "&7all items in this container."
  - ""
  - "&7Deactivate me to move."
  lore_inactive:
  - "&cINACTIVE"
  - "&7Hold shift and right-click me"
  - "&7to Activate."
  - "&7&l(in last slot of chest only)."
  - ""
  - "&7When active, I sell"
  - "&7all items in this container."
  - ""
  - "&7Please be careful!"
  recipes:
    1:
      type: shaped
      input:
        - emerald|emerald|emerald
        - emerald|zc_power_dust|emerald
        - emerald|emerald|emerald
