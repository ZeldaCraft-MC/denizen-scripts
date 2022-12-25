# Protects our server from massive lag when people stack tnt minecarts
tnt_minecart_events:
  type: world
  debug: false
  events:
    on minecart_tnt collides with minecart_tnt:
      - if <context.vehicle.entity_type||null> == minecart_tnt && <context.entity.entity_type||null> == minecart_tnt:
        - remove <context.entity>
