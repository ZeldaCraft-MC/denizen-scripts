hylian_shield:
  type: item
  material: shield
  mechanisms:
    custom_model_data: 100
  display name: Hylian Shield

hylian_shield_events:
  type: world
  events:
    on player raises hylian_shield:
      - narrate "a"
    on player lowers hylian_shield:
      - narrate "b"
