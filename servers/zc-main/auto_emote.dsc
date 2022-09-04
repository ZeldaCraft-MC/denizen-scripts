auto_emote_co:
  type: command
  name: auto_emote
  description: "Enables/disables auto emoticons"
  usage: /auto_emote
  permission: zc.aura
  script:
  - if <player.has_flag[emojis]>:
    - flag player emojis:!
    - narrate "auto emoticons have been turned off" format:zc_text
  - else:
    - flag player emojis
    - narrate "auto emoticons have been turned on" format:zc_text
