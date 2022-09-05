# All zcrpg events

zcrpg_playerdata_events:
  type: world
  debug: false
  events:
    on server start:
      - ~yaml load:zcrpg_config.yml id:zcrpg_config

    on player joins:
      - ~webget http://localhost:8080/players/<player.uuid>?name=<player.name> save:request
      - yaml loadtext:<entry[request].result> id:<player.uuid>
      - if <player.name> != <yaml[<player.uuid>].read[name]>:
        - yaml set name:<player.name> id:<player.uuid>
    after player changes world to dungeons:
      - wait 2s
      - if !<player.inventory.contains_item[heros_bow]> && <player.world.name> == dungeons:
        - give heros_bow
        - give arrow quantity:64

    on player death:
      - define killer <player.killer||null>
      - if <[killer]> == null || !<[killer].is_player||false> || <player.uuid> == <[killer].uuid> || <[killer].gamemode||creative> == creative || <[killer].can_fly||true>:
        - stop

      - if !<yaml.list.contains[<player.uuid>]> || !<yaml.list.contains[<[killer].uuid>]>:
        - stop

      - define killed_pts <yaml[<player.uuid>].read[pvppoints]>
      - define pvp_change <[killed_pts].sub[<yaml[<[killer].uuid>].read[pvppoints]>].div[100].add[7].round_down.max[1].min[15]>

      - yaml set pvppoints:<[killed_pts].sub[<[pvp_change]>].max[0]> id:<player.uuid>
      - yaml set pvppoints:+:<[pvp_change]> id:<[killer].uuid>

      - narrate "<&c>You lost <[pvp_change].min[<[killed_pts]>]> PVP score."
      - narrate "<&b>You gained <[pvp_change]> PVP score!" player:<[killer]>

    on player right clicks armor_stand in:dungeons:
      - determine cancelled

    on entity death by:player:
      - adjust <queue> linked_player:<context.damager>
      - if !<context.entity.is_living> || <context.entity.entity_type> == armor_stand || <context.entity.uuid> == <player.uuid> || <context.projectile.entity_type||null> == fireball:
        - stop

      - define uuid <player.uuid>
      - if !<yaml.list.contains[<[uuid]>]>:
        - stop

      - define r <util.random_decimal>
      - if <[r]> < 0.2:
        - define curr_magic <yaml[<[uuid]>].read[magicmeter]>
        - define max_magic <yaml[<[uuid]>].read[completed_dungeons].size.mul[3].add[<yaml[<[uuid]>].read[completed_secrets].size>].add[100]>
        - if <[curr_magic]> < <[max_magic]>:
          - drop magic_jar <context.entity.location> save:e
          - adjust <entry[e].dropped_entity> "custom_name:<&a>Magic Jar"
          - adjust <entry[e].dropped_entity> custom_name_visible:true

    on inventory picks up magic_jar:
      - determine passively cancelled

    on player picks up magic_jar:
      - determine passively cancelled
      - ratelimit <player> 1s
      - remove <context.entity>
      - define uuid <player.uuid>
      - define curr_magic <yaml[<[uuid]>].read[magicmeter]>
      - define max_magic <yaml[<[uuid]>].read[completed_dungeons].size.mul[3].add[<yaml[<[uuid]>].read[completed_secrets].size>].add[100]>
      - define new_magic <[curr_magic].add[10].min[<[max_magic]>]>
      - yaml set magicmeter:<[new_magic]> id:<[uuid]>

      - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <&a><element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> <&2>[<[curr_magic]>/<[max_magic]>]"
      - playsound <player> sound:BLOCK_CONDUIT_ACTIVATE pitch:2
      - while <[curr_magic]> < <[new_magic]> && <player.is_online>:
        - wait 3t
        - define curr_magic <[curr_magic].add[2].min[<[max_magic]>]>
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&a>[Magic] <&a><element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> <&2>[<[curr_magic]>/<[max_magic]>]"

    on delta time minutely:
      - foreach <server.online_players> as:player:
        - if !<yaml.list.contains[<[player].uuid>]>:
          - stop

        - webget http://localhost:8080/players/<[player].uuid> post:<yaml[<[player].uuid>].to_json> headers:<map[Content-type=application/json]>

    on player quits:
      - if !<yaml.list.contains[<player.uuid>]>:
        - stop

      - webget http://localhost:8080/players/<player.uuid> post:<yaml[<player.uuid>].to_json> headers:<map[Content-type=application/json]>
      - yaml unload id:<player.uuid>

    on player right clicks block:
      - if !<yaml.list.contains[<player.uuid>]>:
        - stop

      - define spell <context.item.nbt[spell]||null>
      - if <[spell]> == null || !<yaml[zcrpg_config].contains[spells.<[spell]>]>:
        - stop

      - determine passively cancelled
      - ratelimit <player> 5t

      - define curr_magic <yaml[<player.uuid>].read[magicmeter]>
      - define max_magic <yaml[<player.uuid>].read[completed_dungeons].size.mul[3].add[<yaml[<player.uuid>].read[completed_secrets].size>].add[100]>
      - define cost <yaml[zcrpg_config].read[spells.<[spell]>.cost]||0>
      - if <[curr_magic]> < <[cost]>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&c>[Magic] <element[].pad_right[<[percent]>].with[|]><&4><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - stop

      - define dungeon_points <yaml[zcrpg_config].read[spells.<[spell]>.dp]||0>
      - if <yaml[<player.uuid>].read[completed_dungeons].size> < <[dungeon_points]>:
        - narrate "<&c>Your dungeon points are too low to use this spell! Requires <[dungeon_points]> dungeon points."
        - stop

      - define secret_points <yaml[zcrpg_config].read[spells.<[spell]>.sp]||0>
      - if <yaml[<player.uuid>].read[completed_secrets].size> < <[secret_points]>:
        - narrate "<&c>Your secret points are too low to use this spell! Requires <[secret_points]> secret points."
        - stop

      #- define pvp_points <yaml[zcrpg_config].read[spells.<[spell]>.pvp]||0>
      #- if <yaml[<player.uuid>].read[pvppoints]> < <[pvp_points]>:
      #  - narrate "<&c>Your pvp points are too low to use this spell! Requires <[pvp_points]> pvp points."
      #  - stop

      - define pvp_points <yaml[zcrpg_config].read[spells.<[spell]>.pvp]||0>
      - if <yaml[<player.uuid>].read[pvppoints]> < <[pvp_points]>:
        - narrate "<&c>Your pvp points are too low to use this spell! Requires <[pvp_points]> pvp points."
        - stop

      - if <player.has_flag[spell_cooldown_<[spell]>]>:
        - narrate "<&c>This spell is still on cooldown! You can use it again in <player.flag_expiration[spell_cooldown_<[spell]>].duration_since[<util.time_now>].formatted>"
        - stop

      - ~run <[spell]>_spell save:spell_cast

      - if <entry[spell_cast].created_queue.determination.contains[failed]||false>:
        - stop

      - define new_magic <[curr_magic].sub[<[cost]>]>

      #- yaml set 'statsd.player~event~zcrpg~spells~<[spell].to_lowercase>:++' id:stats_log
      - yaml set magicmeter:<[new_magic]> id:<player.uuid>

      - while <[curr_magic]> > <[new_magic]> && <player.is_online>:
        - define percent <[curr_magic].div[<[max_magic]>].mul[100].round_down>
        - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"
        - define curr_magic <[curr_magic].sub[<[cost].div[5].round_up>].max[0]>
        - wait 1t
      - define percent <[new_magic].div[<[max_magic]>].mul[100].round_down>
      - actionbar "<&a>[Magic] <element[].pad_right[<[percent]>].with[|]><&2><element[].pad_right[<element[100].sub[<[percent]>]>].with[|]> [<[curr_magic]>/<[max_magic]>]"

      - if <yaml[zcrpg_config].contains[spells.<[spell]>.cooldown]>:
        - flag player spell_cooldown_<[spell]> duration:<yaml[zcrpg_config].read[spells.<[spell]>.cooldown]>

    #on player animates bukkit_priority:highest ignorecancelled:true:
    #  - narrate <context.animation>

    on player clicks *_sign in:dungeons:
      - if !<yaml.list.contains[<player.uuid>]>:
        - stop

      - define contents <context.location.sign_contents>

      - if <[contents].get[1].contains[passage]>:
        - define points <[contents].get[3].split[:]||null>
        - define xyz <[contents].get[4].split||null>
        - if <[points]> == null || <[xyz]> == null || <[points].size> != 2 || <[xyz].size> != 3:
          - narrate "<&c>Misconfigured passage sign! Please notify an admin."
          - stop
        - if <yaml[<player.uuid>].read[completed_dungeons].size> < <[points].get[1]>:
          - narrate "<&c>You don't have enough dungeon points to use this passage! Requires <[points].get[1]> points."
          - stop
        - if <yaml[<player.uuid>].read[completed_secrets].size> < <[points].get[2]>:
          - narrate "<&c>You don't have enough secret points to use this passage! Requires <[points].get[2]> points."
          - stop
        - teleport <player> <context.location.center.add[<[xyz].get[1].after[:]>,<[xyz].get[2].after[:]>,<[xyz].get[3].after[:]>].with_pose[<player>]>
        - stop

      # Potential finished sign
      - define pos <[contents].find_partial[finish]>
      - if <[pos]> >= 0:
        - define dungeon <[contents].get[<[pos].add[1]>].strip_color.trim.to_lowercase||null>
        - if <[dungeon]> == null || <[dungeon]> == <empty> || <[dungeon].split.size> > 1 || <[contents].get[<[pos]>].split.size> > 1:
          - stop

        - if !<yaml[zcrpg_config].contains[dungeons.<[dungeon]>]>:
          - narrate "<&c>This dungeon does not exist! Please get in touch with an admin."
          - stop

        - teleport <player> <essentials.warp[dungeons]>
        #- yaml set 'statsd.player~event~zcrpg~dungeons~<[dungeon].to_lowercase>~completed:++' id:stats_log
        - if !<yaml[<player.uuid>].read[completed_dungeons].contains[<[dungeon]>]>:
          - title "title:<green>Dungeon Complete!" "subtitle:<yellow>You earned 1 Dungeon Point" stay:1s fade_out:2s
          - yaml set completed_dungeons:->:<[dungeon]> id:<player.uuid>
        - else:
          - title "title:<green>Dungeon Complete!" stay:1s fade_out:2s
        - playeffect at:<player.location> effect:end_rod quantity:50 offset:0.5,1,0.5 data:0.25
        - playeffect at:<player.location> effect:fireworks_spark quantity:20 offset:0.5,1,0.5 data:0.25
        - playsound <player> sound:ENTITY_PLAYER_LEVELUP pitch:1.5 volume:1
        - playsound <player> sound:ENTITY_PLAYER_LEVELUP pitch:1.1 volume:0.6
        - playsound <player> sound:ENTITY_PLAYER_LEVELUP pitch:0.3 volume:0.8
        - stop

      # Potential secret sign
      - define pos <[contents].find_partial[secret]>
      - if <[pos]> >= 0:
        - define secret <[contents].get[<[pos].add[1]>].strip_color.trim.to_lowercase||null>
        - if <[secret]> == null || <[secret]> == <empty> || <[secret].split.size> > 1 || <[contents].get[<[pos]>].split.size> > 1:
          - stop

        - define secrets <list[]>
        - foreach <yaml[zcrpg_config].list_keys[dungeons]>:
          - define secrets <[secrets].include[<yaml[zcrpg_config].read[dungeons.<[value]>.secrets].as[list].exclude[none]>]>

        - if !<[secrets].contains[<[secret]>]>:
          - narrate "<&c>This secret does not exist! Please get in touch with an admin."
          - stop

        - if !<yaml[<player.uuid>].read[completed_secrets].contains[<[secret]>]>:
          #- yaml set 'statsd.player~event~zcrpg~secrets~<[secret].to_lowercase>~completed:++' id:stats_log
          - yaml set completed_secrets:->:<[secret]> id:<player.uuid>
          - narrate "<&e>You discovered the secret <&c><[secret]><&e>! You gained a secret point."
          - toast "Discovered <[secret]>!" icon:player_head[skull_skin=<player.skull_skin>] frame:challenge
        - else:
          - narrate "<&e>You re-discovered the secret <&c><[secret]><&e>!"

        - stop

      # Potential checkpoint sign
      - define pos <[contents].find_partial[checkpoint]>
      - if <[pos]> >= 0 && <[contents].get[<[pos]>].split.size> == 1 && <[contents].remove[<[pos]>].filter[length.is[more].than[0]].is_empty>:
        - yaml set checkpoint_x:<context.location.center.x> id:<player.uuid>
        - yaml set checkpoint_y:<context.location.center.y.sub[0.5]> id:<player.uuid>
        - yaml set checkpoint_z:<context.location.center.z> id:<player.uuid>
        - yaml set checkpoint_world:<context.location.world.name> id:<player.uuid>
        - narrate "<&e>Checkpoint set. You can warp there at any time by typing the command <&b>/zc checkpoint"
        - stop

#zcrpg_stats_events:
#  type: world
#  debug: false
#  events:
    #on system time minutely every:5:
    #  # send shit here
    #  - yaml set 'statsd.server~version~paper~<server.version.before[ ]>:1' id:stats_log
    #  - yaml set 'statsd.server~version~minecraft~<server.version.after[(].before[)].after[ ].replace[.].with[-]>:1' id:stats_log
    #  - yaml set 'statsd.server~ram~used:<server.ram_usage>' id:stats_log
    #  - yaml set 'statsd.server~ram~total:<server.ram_max>' id:stats_log
    #  - yaml set 'statsd.server~uptime:<server.delta_time_since_start.in_seconds.round>' id:stats_log
    #  - yaml set 'statsd.server~banned~users:<server.list_banned_players.size>' id:stats_log
    #  - yaml set 'statsd.server~banned~ips:<server.list_banned_addresses.size>' id:stats_log
    #  - yaml set 'statsd.server~tps:<server.recent_tps.get[1]>' id:stats_log
    #  - yaml set 'statsd.server~players:<server.list_players.size>' id:stats_log
    #  - webget "http://localhost:8080/stats" "post:<yaml[stats_log].to_json>" "headers:Content-type/application/json"
    #  - yaml set elk:! id:stats_log
    #  - yaml set statsd:! id:stats_log

    #on player dies:
    #  - yaml set 'statsd.player~event~death~<context.cause.to_lowercase||unknown>:++' id:stats_log

    #on spawner spawns entity:
    #  - yaml set 'statsd.mob~event~spawner~<context.entity.entity_type.to_lowercase>:++' id:stats_log

    #on item enchanted:
    #  - yaml set 'statsd.player~event~enchant:++' id:stats_log

    #on player levels up:
    #  - yaml set 'statsd.player~event~level:++' id:stats_log

    #on player jailed:
    #  - yaml set 'statsd.player~event~jailed:++' id:stats_log

    #on player muted:
    #  - yaml set 'statsd.player~event~muted:++' id:stats_log

    #on player first login:
    #  - yaml set 'statsd.player~event~first_join:++' id:stats_log

    #on player crafts item:
    #  - if <context.item.has_script>:
    #    - yaml set 'statsd.player~event~craft~<context.item.script.name.to_lowercase>:+:<context.item.quantity>' id:stats_log
    #  - else:
    #    - yaml set 'statsd.player~event~craft~<context.item.material.name.to_lowercase>:+:<context.item.quantity>' id:stats_log

    #on entity death:
    #  - if !<context.entity.is_living> || <context.entity.is_player>:
    #    - stop
    #  - yaml set 'statsd.mob~event~death~<context.entity.entity_type.to_lowercase>:++' id:stats_log

    #on command:
    #  - if <context.source_type> != 'PLAYER':
    #    - stop
    #  - define command <context.command.to_lowercase>
    #  - if !<server.list_commands.contains[<[command]>]>:
    #    - stop

    #  - if <[command]> == 'warp':
    #    - if <essentials.list_warps.contains[<context.args.get[1]||null>]>:
    #      - define command warp_<context.args.get[1].to_lowercase>

    #  - yaml set 'statsd.player~commands~<[command]>:++' id:stats_log

    #on server start:
    #  - yaml create id:stats_log
