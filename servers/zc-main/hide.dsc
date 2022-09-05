hide_command:
  type: command
  description: Toggles hiding the nameplate for hide and seek
  usage: /hide
  name: hide
  debug: false
  script:
    - if <player.has_flag[hiding]>:
      - sneak <player> stop fake
      - flag <player> hiding:!
      - narrate "<&7>You are no longer hiding!"
    - else:
      - flag <player> hiding
      - sneak <player> fake
      - narrate "<&7>Your name is now hidden behind blocks as if you were sneaking!"

hide_events:
  type: world
  debug: false
  events:
    on delta time secondly:
      - if <server.online_players_flagged[hiding].is_empty>:
        - stop
      - define text "<element[Your nameplate is hidden! Use /hide again to show it.].color_gradient[from=#54ff82;to=#54f6ff]>"
      - actionbar <[text]> targets:<server.online_players_flagged[hiding]>
    on player quits:
      - if <player.has_flag[hiding]>:
        - sneak <player> stop fake
        - flag <player> hiding:!
