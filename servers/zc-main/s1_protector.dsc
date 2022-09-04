s1_protector_events:
  type: world
  debug: false
  newbie_check:
    - if <player.statistic[play_one_minute].div[1200]> > 60:
      - stop
    - if <player.location.distance[<player.world.spawn_location>]> > 500:
      - stop
    - if <player.has_flag[accepted_rules]>:
      - stop
    - narrate "<&nl><&a><&l>Z<&2><&l>C <&8><&chr[BB]> <&7>To build near spawn in the first hour of playing, we require you to accept the following:"
    - narrate " <&a><&chr[2022]> <&7>You will not grief (break into houses, steal items, etc)."
    - narrate " <&a><&chr[2022]> <&7>You will follow the server rules listed in <&e>/rules"
    - narrate "<&a><&l>Z<&2><&l>C <&8><&chr[BB]> <&7>You can accept these rules by typing <&a>/accept<&7><&nl>"
    - determine cancelled
  events:
    on player breaks block in:s1:
      - inject script:s1_protector_events path:newbie_check
    on player places block in:s1:
      - inject script:s1_protector_events path:newbie_check
    on player opens inventory in:s1:
      - inject script:s1_protector_events path:newbie_check
    on player breaks hanging in:s1:
      - inject script:s1_protector_events path:newbie_check
    on player places hanging in:s1:
      - inject script:s1_protector_events path:newbie_check
    on player damages item_frame in:s1:
      - inject script:s1_protector_events path:newbie_check

rules_command:
  type: command
  name: rules
  debug: false
  script:
    - narrate "<&nl><&a><&l>Z<&2><&l>C <&8><&chr[BB]> <&7>Server Rules - Failure to follow these rules may result in a kick or ban."
    - narrate " <&a><&chr[2022]> <&7>No griefing. This includes chest/crop raiding and animal killing."
    - narrate " <&a><&chr[2022]> <&7>Be respectful of chat and players. Do not spam or harass players."
    - narrate " <&a><&chr[2022]> <&7>Do not use mods or hacks that provide an unfair advantage over normal players."
    - narrate " <&a><&chr[2022]> <&7>Do not advertise your server here. We would not do it to you."
    - narrate " <&a><&chr[2022]> <&7>Cursing is allowed, but be mindful and moderate. Racist/homophobic/etc slurs are not allowed."
    - narrate " <&a><&chr[2022]> <&7>Do not abuse exploits! If you find one, please report it to an Admin."
    - narrate " <&a><&chr[2022]> <&7>Use common sense. If it is not listed here, ask a moderator. Most importantly, have fun!<&nl>"
    - flag player read_rules duration:10m

accept_rules_command:
  type: command
  name: accept
  debug: false
  script:
    - if !<player.has_flag[read_rules]>:
      - narrate "<&nl><&a><&l>Z<&2><&l>C <&8><&chr[BB]> <&7>You haven't read the rules yet! Please read the rules with <&e>/rules<&7> before accepting them.<&nl>"
      - stop
    - flag player accepted_rules duration:1w
    - narrate "<&nl><&a><&l>Z<&2><&l>C <&8><&chr[BB]> <&7>Thank you for accepting the rules! You can build a bit closer to the survival spawn now.<&nl>"
