custom_record_events:
  type: world
  debug: false
  events:
    on player right clicks jukebox:
        - determine passively cancelled
        - ratelimit <player> 5t
        - if !<context.location.jukebox_is_playing> && <context.item.has_flag[custom_record_sound]||false>:
            - if <player.gamemode> != creative:
                - take slot:<player.held_item_slot>
            - adjust <context.location> jukebox_record:<context.item>
            - wait 1.5t
            - if <context.item.script.name> == frozen_hyrule_custom_record && !<context.item.has_flag[xmas_bug_patch]>:
              - adjust <context.location> jukebox_record
              - narrate "This record was obtained due to a bug, please dispose of any duplicate frozen hyrule records. after donating again, use /xmas_claim again to receive a new record"
            - adjust <context.location.find_players_within[65]> stop_sound:music_disc.13
            - playsound sound:<context.item.flag[custom_record_sound]> custom <context.location> volume:4 sound_category:records
            - actionbar "Now Playing: <context.item.lore.get[1]>" targets:<context.location.find_players_within[65]>
            - stop
        - else if <context.location.jukebox_record.has_flag[custom_record_sound]||false>:
            - adjust <context.location.find_players_within[65]> stop_sound:<context.location.jukebox_record.flag[custom_record_sound]>
            - drop <context.location.jukebox_record> <context.location.center.above>
            - adjust <context.location> jukebox_record
            - stop
        - else:
            - determine cancelled:false
