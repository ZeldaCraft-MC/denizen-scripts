ping_command:
  type: command
  debug: false
  description: Check your ping
  usage: /ping
  name: ping
  script:
    - narrate "<&7>Your ping is: <&3><player.ping>ms"
