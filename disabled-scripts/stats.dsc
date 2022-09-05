stat_events:
  type: world
  debug: false
  events:
    on system time secondly every:10:
      - ~log "servers.zc-main.online-players <server.online_players.size>" type:none file:stats.txt
    on system time secondly every:5:
      - ~log "<paper.tick_times.parse_tag[servers.zc-main.tick-times <[parse_value].in_milliseconds>].separated_by[<n>]>" type:none file:stats.txt
      - ~log "<server.online_players.filter[flag[login_time].from_now.is_more_than[1m]].parse_tag[servers.zc-main.player-ping <[parse_value].ping>].separated_by[<n>]>" type:none file:stats.txt
    on system time secondly:
      - ~log "servers.zc-main.tps <server.recent_tps.get[1]>" type:none file:stats.txt
    after player joins:
      - if <player.statistic[play_one_minute]> < 100:
        - ~log "servers.zc-main.new-joins 1" type:none file:stats.txt
