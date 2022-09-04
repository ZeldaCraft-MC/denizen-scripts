zc_demon_carver:
  type: item
  debug: false
  material: netherite_sword
  data:
    discover: true
  display name: Demon Carver
  enchantments:
    - sharpness: 4
  mechanisms:
    custom_model_data: 900
  lore:
    - "A lethal weapon forged by the Yiga."
  recipes:
    1:
       type: shaped
       input:
         - zc_soft_iron|zc_dragon_scale|zc_soft_iron
         - zc_dragon_scale|air|zc_dragon_scale
         - stick|zc_dragon_scale|zc_soft_iron

bananna_effect:
  type: world
  debug: false
  events:
    on player kills entity:
    - if <context.cause> == entity_attack:
      - if <context.damager.item_in_hand.script.name.if_null[null]> == zc_demon_carver:
        - define players <context.damager.location.find_players_within[20]>
        - repeat 5:
          - define r1 <util.random.decimal[-0.2].to[0.2]>
          - define r2 <util.random.decimal[-0.2].to[0.2]>
          - fakespawn dropped_item[velocity=<[r1]>,0.3,<[r2]>;item=apple[custom_model_data=100]] <context.entity.location> duration:1s players:<[players]>
