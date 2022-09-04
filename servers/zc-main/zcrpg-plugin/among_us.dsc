#this will be among us in minecraft
reset_skins:
  type: task
  debug: false
  script:
    - foreach <server.online_players>:
      - adjust <[value]> skin:<[value].name>
