custom_block_handler:
  type: world
  debug: false
  events:
    on player places portal_block:
    - determine passively cancelled
    - wait 1t
    - modifyblock <context.location> nether_portal
    on player places end_gateway_block:
    - determine passively cancelled
    - wait 1t
    - execute as_op "setblock <context.location.simple.split[,].get[1].to[3].separated_by[ ]> end_gateway{Age:-9223372036854775808L}"
    #- modifyblock <context.location> end_gateway[age=-9223372036854775808]

portal_block:
  type: item
  debug: false
  material: spawner
  display name: Nether Portal

end_gateway_block:
  type: item
  debug: false
  material: spawner
  display name: End Gateway
