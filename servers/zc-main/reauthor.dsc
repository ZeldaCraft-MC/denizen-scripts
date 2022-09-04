reauthor_command:
  type: command
  name: reauthor
  debug: false
  permission: askdljalskda
  script:
    - give <player.item_in_hand.with[book=<player.item_in_hand.book_map.with[author].as[<context.args.get[1]>]>]>

retitle_command:
  type: command
  name: retitle
  debug: false
  permission: sakdjalkda
  script:
    - give <player.item_in_hand.with[book=<player.item_in_hand.book_map.with[title].as[<context.raw_args>]>]>
