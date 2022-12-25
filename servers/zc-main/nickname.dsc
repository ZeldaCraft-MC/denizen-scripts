unparse_color:
  type: procedure
  debug: false
  definitions: text
  script:
    - define out <list[]>
    - define in_color false
    - define test test
    - foreach <[text].split[]> as:c:
      - if <[in_color]>
      - if <[c]> == <&ss>:
        - define in_color true
        - define out:->:&
        - foreach next

nickname_events:
  type: world
  debug: false
  events:
    on player joins:
      - if <player.name> != Mergu:
        - stop
      - if !<player.has_flag[essentials_nick_updated]>:
        #- flag player essentials_nick_updated
        - if !<util.has_file[../Essentials/userdata/<player.uuid>.yml]>:
          - stop
        - ~yaml load:../Essentials/userdata/<player.uuid>.yml id:ess_<player.uuid>
        - if <yaml[ess_<player.uuid>].contains[nickname]>:
          - narrate <yaml[ess_<player.uuid>].read[nickname]>
        - yaml unload id:ess_<player.uuid>
