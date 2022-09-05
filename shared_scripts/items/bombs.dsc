bomb_item:
  type: item
  debug: false
  material: slime_ball[nbt=Fuse_time/8s]
  display name: Bomb
  lore:
    - Fuse: 8s
  mechanisms:
    custom_model_data: 100

water_bomb_item:
  type: item
  debug: false
  material: slime_ball[nbt=Fuse_time/10s]
  display name: Water Bomb
  lore:
    - Fuse: 10s
  mechanisms:
    custom_model_data: 100

bomb_item_model:
  type: item
  debug: false
  material: clay_ball
  display name: Bomb
  lore:
    - Fuse: 8s
  mechanisms:
    custom_model_data: 100

defused_bomb_item:
  type: item
  debug: false
  material: slime_ball
  display name: Defused Bomb
  lore:
    - NoFuse
  mechanisms:
    disabled_slots: HEAD|CHEST|LEGS|FEET|HAND/ALL|HAND/REMOVE
    custom_model_data: 100

fire_arrow:
  type: item
  debug: false
  material: arrow
  display name: <red>Fire arrow
