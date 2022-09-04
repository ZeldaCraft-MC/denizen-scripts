bomb_item:
  type: item
  debug: false
  material: slime_ball[nbt=li@Fuse_time/8s]
  display name: Bomb
  lore:
    - "Fuse: 8s"
  mechanisms:
    custom_model_data: '100'

water_bomb_item:
  type: item
  debug: false
  material: slime_ball[nbt=li@Fuse_time/10s]
  display name: Water Bomb
  lore:
    - "Fuse: 10s"
  mechanisms:
    custom_model_data: '100'

bomb_item_model:
  type: item
  debug: false
  material: i@clay_ball
  display name: Bomb
  lore:
    - "Fuse: 8s"
  mechanisms:
    custom_model_data: '100'

defused_bomb_item:
  type: item
  debug: false
  material: i@slime_ball
  display name: Defused Bomb
  disabled_slots: HEAD|CHEST|LEGS|FEET|HAND/ALL|HAND/REMOVE
  lore:
    - "NoFuse"
  mechanisms:
    custom_model_data: '100'

fire_arrow:
  type: item
  debug: false
  material: i@arrow
  display name: <red>fire arrow
