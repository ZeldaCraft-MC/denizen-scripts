global_playtime_events:
  type: world
  events:
    after player joins:
      - definemap msg:
          uuid: <player.uuid>
          playtime: <player.statistic[play_one_minute]>
      - redis id:publisher publish:global_playtime_request_<bungee.server> message:<[msg]>
    on redis pubsub message channel:global_playtime_request_*:
      - if !<context.channel.ends_with[<bungee.server>]>:
        - define msg <context.message.as_map>
        - define playtime <player[<[msg.uuid]>].statistic[play_one_minute]||null>
        - if <[playtime]> != null and <[playtime]> > <[msg.playtime]>:
          - definemap msg:
              uuid: <[msg.uuid]>
              playtime: <[playtime]>
          - wait <util.random.int[1].to[20]>t
          - redis id:publisher publish:global_playtime_response_<context.channel.after_last[_]> message:<[msg]>
    on redis pubsub message channel:global_playtime_response_*:
      - if <context.channel.ends_with[<bungee.server>]>:
        - define msg <context.message.as_map>
        - if <player[<[msg.uuid]>].statistic[play_one_minute]> < <[msg.playtime]>:
          - statistic play_one_minute set <[msg.playtime]> player:<player[<[msg.uuid]>]>
