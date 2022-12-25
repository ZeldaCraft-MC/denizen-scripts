

vpn_blocker_events:
  type: world
  debug: false
  events:
    on player prelogin:
      - if <player.name.exists>:
        - stop
      - define name <context.name>
      - determine passively <queue>
      - ~webget http://v2.api.iphub.info/ip/<context.hostname.after[/]> headers:<map[X-Key=<secret[iphub_key]>]> save:iphub
      - if <entry[iphub].failed>:
        - define staff <server.online_players.filter[groups.contains_any[admin|moderator|owner]]>
        - narrate "<&e>IP LOOKUP FAILED FOR <[name]> (<context.hostname.after[/]>)" targets:<[staff]>
        - narrate "<&7><&o>This does not mean <[name]> is using a vpn. Please contact an admin about this immediately." targets:<[staff]>
        - stop

      - if <entry[iphub].result.after[<&dq>block<&dq><&co>].before[,].is[!=].to[1]||true>:
        - stop

      - define staff <server.online_players.filter[groups.contains_any[admin|moderator|owner]]>
      - narrate "<&c>PLAYER <[name]> (<context.hostname.after[/]>) IS USING A VPN. BLOCKED." targets:<[staff]>
      - determine "KICKED Login auto-blocked by VPN detector."

#VPN_Command:
#  type: command
#  debug: false
#  name: vpn
#  permission: vpn
#  script:
#    - choose <context.args.get[1]||null>:
#      - case "bypass":
#        - define username <context.args.get[2]||null>
#        - if <def[username].is[==].to[null]> {
#          - narrate "<&7>Usage<&co> <&a>/vpn bypass <&lt>username<&gt>"
#          - stop
#          }
#        - define player <server.match_offline_player[%username%]||null>
#        - if <def[player].is[==].to[null]> {
#          - narrate "<&c>Could not find player."
#          - stop
#          }
#        - narrate "<&7>Found player <&a><def[player].name><&7>. Are you sure you want to allow this player to bypass the VPN blocker?"
#        - narrate "<&7>Type <&e>/vpn confirm <&7>to accept."
#        - flag <player> vpn_confirmation:<def[player]> duration:1m
#      - case "confirm":
#        - if !<player.has_flag[vpn_confirmation]> {
#          - narrate "<&c>You don't have anything to confirm!"
#          }
#        - flag <player.flag[vpn_confirmation]> vpn_bypass
#        - narrate "<&7>VPN bypass enabled for <player.flag[vpn_confirmation].name>."
#      - default:
#        - narrate "<&7>Use /vpn bypass to allow a player to bypass the VPN blocker."
