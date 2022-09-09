rename_command:
  type: command
  debug: false
  description: Rename an item in your hand.
  usage: /rename
  name: rename
  permission: askdjsad
  script:
    - inventory adjust display:<context.raw_args.parse_color> slot:hand
