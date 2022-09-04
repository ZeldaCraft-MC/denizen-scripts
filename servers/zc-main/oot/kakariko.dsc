kakariko_region_protection:
  type: world
  debug: false
  events:
    after player clicks barrier in:oot ignorecancelled:true:
      - adjust <player> velocity:0,-1,0
      #- teleport <player> <player.eye_location.with_pose[90,0].precise_cursor_on.with_pose[<player>]>
    after player steps on block in:oot:
      - ratelimit <player> 5s
      - if !<player.is_online>:
        - stop
      - if <player.location.polygons.is_empty>:
        - teleport <player> <server.flag[warps.kakariko]>
        - narrate "<&c>You should not be out here. This incident has been logged for admin review."
        - ~log "Player <player.name> (<player.uuid>) caught outside of kakariko_build! Pos: <context.location.simple>" file:boundary_breaks.log
    after player exits kakariko_build:
      - if <player.is_online> && <player.world.name> == oot && <player.is_spawned>:
        - narrate "<player.location>"
        - teleport <player> <server.flag[warps.kakariko]>
        - narrate "<&c>You should not be out here. This incident has been logged for admin review."
        - ~log "Player <player.name> (<player.uuid>) caught outside of kakariko_build! From: <context.from.simple||null> To: <context.to.simple||null>" file:boundary_breaks.log
    on player starts gliding in:oot:
      - determine passively cancelled
      - wait 1t
      - fakeequip <player> duration:3s chest:air
      - adjust <player> velocity:0,-1,0
      - actionbar "<&c>Elytra flight is not allowed in this world!"
