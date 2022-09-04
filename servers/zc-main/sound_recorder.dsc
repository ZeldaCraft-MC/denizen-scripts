repeating_cmd_block_replacements:
  type: world
  debug: false
  events:
    on player joins:
    - adjust <player> clear_scoreboard_tags

    on player right clicks block with:ender_pearl using:either_hand in:dungeons:
    - determine cancelled

    on server start:
    - yaml load:skyloft_music.yml id:skyloft_music

    on time 6 in spawn:
      - foreach <yaml[skyloft_music].read[skyloft_music]> as:line:
        - if <[line].is_integer>:
          - wait <[line]>t
        - else:
          - define targets <region[skyloftbuild,spawn].area.players>
          - if !<[targets].is_empty>:
            - define sound <[line].split[,]>
            #- playsound <[targets]> sound:<[sound].get[1]> volume:<[sound].get[2]> pitch:<[sound].get[3]> sound_category:MUSIC


skyloft_music:
  type: command
  name: skyloftmusic
  debug: false
  usage: /skyloftmusic
  description: idk
  permission: zc.skyloftmusic
  script:
    - yaml load:skyloft_music.yml id:skyloft_music
    - foreach <yaml[skyloft_music].read[skyloft_music]> as:line:
      - if <[line].is_integer>:
        - wait <[line].mul[<context.args.get[1]||1>]>t
      - else:
        - define sound <[line].split[,]>
        #- playsound <player> sound:<[sound].get[1]> volume:<[sound].get[2].mul[<context.args.get[2]||1>]> pitch:<[sound].get[3].mul[<context.args.get[3]||1>]> sound_category:MUSIC

#playsound_events:
#  type: world
#  events:
#    on execute command:
#    - if <context.command_block_location.world.name||null> != spawn:
#      - stop
#
#    - if !<context.command_block_location.in_region[skyloftbuild]>:
#      - stop
#
#    - define pos <context.args.find[run]||-1>
#    - if <[pos]> < 0:
#      - stop
#
#    - define cmd <context.args.get[<[pos].add[1]>].to[999]>
#    - if <[cmd].get[1]> != playsound:
#      - stop
#
#    # This is the first time this is run
#    - if !<server.has_flag[skyloft_music]>:
#      - flag server skyloft_music:<server.current_tick> duration:5s
#      - yaml create id:skyloft_music
#    # This is every other time
#    - else:
#      - define wait <server.current_tick.sub[<server.flag[skyloft_music]>]>
#      - if <[wait]> != 0:
#        - flag server skyloft_music:<server.current_tick> duration:5s
#        - yaml set skyloft_music:->:<[wait]> id:skyloft_music
#      - yaml set skyloft_music:->:<[cmd].get[2].replace[.].with[_]>,<[cmd].get[8]>,<[cmd].get[9]> id:skyloft_music
#    - playsound <player[Mergu]> sound:<[cmd].get[2].replace[.].with[_]> volume:<[cmd].get[8]> pitch:<[cmd].get[9]>

