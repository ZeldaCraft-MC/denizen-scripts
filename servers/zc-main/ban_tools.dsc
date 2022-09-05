#########################
# Ban Tools, by Mergu
#
# Description:
# Provides some handy ban tools, with all messaging controlled via the ban_tools_messaging config.
# Notifies any players with the denizen.ban_notifier permission when a banned player tries to join.
# Also overrides messaging seen by the banned player. Should get around any pesky messaging set by
# plugins like Essentials.
#
# Permissions:
# denizen.ban_notifier - View when a banned player tries to log in.
#
# Config:
# messages.notify.permban/tempban.chat has an <[ip]> definition available for the player's IP.
# Otherwise, all of these messages support any denizen tags and essentials format codes.
# All messages have an attached player so you can do things like <player.name>.
#
# Instructions:
# Plop this file into plugins/Denizen/scripts and do an /ex reload
#########################

ban_tools_messaging:
  type: data
  debug: false
  messages:
    notify:
      permban:
        chat: &c[Ban Notifier]&7 Banned player &c<player.name>&7 tried to join from &c<[ip]>
        hover:
          - &cReason: &7<player.ban_reason.if_null[None]>
          - &cBanned by: &7<player.ban_source.if_null[None]>
          - &cBanned on: &7<player.ban_created_time.format.if_null[Unknown]>
          - &cBan expires: &7<player.ban_expiration_time.format.if_null[Never]>
      tempban:
        chat: &c[Ban Notifier]&7 Banned player &c<player.name>&7 tried to join from &c<[ip]>
        hover:
          - &cReason: &7<player.ban_reason.if_null[None]>
          - &cBanned by: &7<player.ban_source.if_null[None]>
          - &cBanned on: &7<player.ban_created_time.format.if_null[Unknown]>
          - &cBan expires: &7<player.ban_expiration_time.format.if_null[Never]>
          - &cTotal time: &7<player.ban_expiration_time.duration_since[<player.ban_created_time>].formatted>
          - &cRemaining time: &7<player.ban_expiration_time.from_now.formatted>
    kick:
      permban:
        - <empty>
        - <empty>
        - &2&lZelda&a&lCraft Permban
        - <empty>
        - &f<player.ban_reason>
        - <empty>
        - &c&lThis ban will not expire.
        - <empty>
        - &7If you believe this was a mistake,
        - &7you may appeal on our forums<&co>
        - &b&nhttps://www.zeldacraft.com/forums/
        - <empty>
      tempban:
        - <empty>
        - <empty>
        - &2&lZelda&a&lCraft Tempban
        - <empty>
        - &f<player.ban_reason>
        - <empty>
        - &c&lThis ban expires on <player.ban_expiration_time.format> (<player.ban_expiration_time.from_now.formatted>)
        - <empty>
        - &7If you believe this was a mistake,
        - &7you may appeal on our forums<&co>
        - &b&nhttps://www.zeldacraft.com/forums/
        - <empty>

ban_tools_events:
  type: world
  debug: false
  events:
    on player login:
      - if !<player.name.exists>:
        - stop
      - if !<player.is_banned||false>:
        - stop
      - define ip <context.hostname.after[/]>
      - define ban_type permban
      - if <player.ban_created_time.exists> && <player.ban_expiration_time.exists>:
        - define ban_type tempban
      - define targets <server.online_players.filter[has_permission[denizen.ban_notifier]]>
      - define message <script[ban_tools_messaging].parsed_key[messages.notify.<[ban_type]>.chat].parse_color>
      - define hover <script[ban_tools_messaging].parsed_key[messages.notify.<[ban_type]>.hover].separated_by[<n><&r>].parse_color>
      - determine passively kicked:<script[ban_tools_messaging].parsed_key[messages.kick.<[ban_type]>].separated_by[<n><&f>].parse_color>
      - ratelimit <player> 2m
      - narrate <[message].on_hover[<[hover]>]> targets:<[targets]>
    on player kicked bukkit_priority:highest:
      - if !<player.is_banned||false>:
        - stop
      - define ban_type permban
      - if <player.ban_created_time.exists> && <player.ban_expiration_time.exists>:
        - define ban_type tempban
      - determine reason:<script[ban_tools_messaging].parsed_key[messages.kick.<[ban_type]>].separated_by[<n><&f>].parse_color>
