#xp store command
xp_command_zc:
  type: command
  name: xp
  description: stores/retrieves your current xp level
  usage: /xp (store/retrieve)
  debug: false
  tab completions:
    1: store|retrieve
  permission: zc.storexp
  script:
    - choose <context.args.first||default>:
      - case store:
        - if <player.has_flag[stored_xp]>:
          - if <context.args.get[2]> == confirm:
            - flag player stored_xp:<player.xp_level>
            - experience set level 0
            - narrate "Your xp has been stored. use /xp retrieve to retrieve your xp." format:zc_text
            - stop
          - narrate "You already have some xp stored. Click <&click[/xp store confirm]><&b>Here<&end_click><&f> to confirm you want to overwrite the xp you have stored" format:zc_text
          - stop
        - flag player stored_xp:<player.xp_level>
        - experience set level 0
        - narrate "Your xp has been stored. use /xp retrieve to retrieve your xp." format:zc_text
        - stop
      - case retrieve:
        - if !<player.has_flag[stored_xp]>:
          - narrate "You do not seem to have xp stored" format:zc_text
          - stop
        - experience set level <player.flag[stored_xp]>
        - flag player stored_xp:!
        - stop
      - default:
        - narrate "You did not seem to specify wether you wanted to store or retrieve your xp" format:zc_text
        - stop
