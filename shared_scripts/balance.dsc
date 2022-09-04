balance_command:
  type: command
  name: balance
  aliases:
    - bal
  script:
    - narrate "<n><&7>Balances for <&f><player.display_name><&7>:<n><&a>$ <&f><player.formatted_money.after[$]>"
    - if <player.name> != Mergu:
      - stop
    - narrate "<&chr[2008].font[icons]> <&color[#bda2cc]><yaml[<player.uuid>_inventories].read[mon_tokens]||0>x Mon<n>"
