rankups_menu:
  type: inventory
  debug: false
  inventory: chest
  size: 54
  gui: true
  slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

ranks_command:
  type: command
  debug: false
  description: View ranks
  usage: /ranks
  name: ranks
  permission: sadadasd
  script:
    - inventory open d:rankups_menu

rankup_ranks:
  type: data
  debug: false
  data:
    ranks:
      1:
        display: <&2>Deku
      2:
        display: <&3>Tektite
        requirements:
          playtime: 1h
      3:
        display: <&b>ChuChu
        requirements:
          playtime: 5h
      4:
        display: <&5>Octorok
        requirements:
          playtime: 10h
          fish_caught: 10
