#------------------------------------#
# RUN THIS ONLY ONES WHILE CONVERTING
#------------------------------------#
#warps_conv:
#  type: task
#  debug: false
#  script:
#    - foreach <essentials.list_warps> as:warp:
#      - define name <[warp]>
#      - define loc <essentials.warp[<[warp]>]>
#      - flag server warps.<[name]>:<[loc]>
#      - announce "<[name]> warp done" to_console

#-------------#
# warp command
#-------------#
warp_cmd:
  type: command
  name: warp
  debug: false
  description: used to warp to certain areas
  usage: /warp (name)
  tab completions:
    1: <server.flag[warps].keys.alphabetical.parse[to_lowercase]>
    2: <server.online_players.parse[name]>
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "PLease enter a warp name"
      - stop
    - if !<server.flag[warps].keys.contains[<context.args.first||empty>]>:
      - narrate "This does not seem to be a valid warp"
      - stop
    - define name <context.args.first>
    - define loc <server.flag[warps].get[<[name]>]>
    - if <player.is_op>:
      - if <context.args.get[2]||null> == null:
        - narrate "<&6>Warping to <&c><[name]><&6>."
        - teleport <player> <[loc]>
        - stop
      - define player <server.match_player[<context.args.get[2]>]||noone>
      - if <[player]> == noone:
        - narrate "<&4>No player was found with <context.args.get[2]>"
        - stop
      - narrate "<&6>Teleporting <&a><[player].name> <&6>to <&c><[name]><&6>."
      - narrate "<&6>Warping to <&c><[name]><&6>." targets:<[player]>
      - teleport <[player]> <[loc]>
      - stop
    - narrate "<&6>Teleportation will commence in <&c>2 seconds<&6>. Don't move"
    - define ol_loc <player.location.block>
    - wait 2s
    - if <player.location.block> != <[ol_loc]>:
      - narrate "<&4>Pending teleportation request cancelled."
      - stop
    - teleport <player> <[loc]>
    - narrate "<&6>Warping to <&c><[name]>"
create_warp_cmd:
  type: command
  name: createwarp
  debug: false
  description: Creates a server warp
  usage: /createwarp (name)
  permission: zc.admin
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "<&4>Did you forget to put a name in?"
      - stop
    # no need for check, flag will just override if name already exists
    # - if <server.flag[warps].keys.contains[<context.args.first>]>:
    #   - narrate "<&4>This warp already exists! Remove the warp before creating a new one."
    #   - stop
    - flag server warps.<context.args.first>:<player.location>
    - if <context.args.get[2]||<empty>> == <empty>:
      - narrate "<&4>No warp menu item defined, warp will be created, but will not appear in the warps menu."
    - else:
      - flag server warp_menu_items.<context.args.first>:<context.args.get[2]>
    - narrate "<&6>Warp <&c><context.args.first><&6> has been <&a>created<&6>!"
del_warp_cmd:
  type: command
  name: delwarp
  debug: false
  description: Deletes a server warp
  usage: /delwarp (name)
  permission: zc.admin
  tab completions:
    1: <server.flag[warps].keys.alphabetical.parse[to_lowercase]>
  script:
    - if <context.args.first||<empty>> == <empty>:
      - narrate "<&4>Did you forget to put a name in?"
      - stop
    - if !<server.flag[warps].keys.contains[<context.args.first>]>:
      - narrate "<&4>This warp doesn't exist!"
      - stop
    - flag server warps.<context.args.first>:!
    - flag server warp_menu_items.<context.args.first>:!
    - narrate "<&6>Warp <&c><context.args.first><&6> has been <&c>removed<&6>!"
warps_command:
  type: command
  debug: false
  name: warps
  description: gives you a list of all the server warps
  usage: /warps (page number)
  script:
  - define page <context.args.first||1>
  - define max_page <server.flag[warps].keys.size.div[20].round_up>
  - if <[page]> > <[max_page]>:
    - narrate "<&4>You cannot go that high"
    - stop
  - if <[page]> < 1:
    - narrate "<&4>You cannot go that low"
    - stop
  - define end <[page].mul[20]>
  - define start <[end].sub[19]>
  - narrate "<&6>There are <&c><server.flag[warps].keys.size><&6> warps."
  - narrate "<server.flag[warps].keys.alphabetical.get[<[start]>].to[<[end]>].parse_tag[<&click[/warp <[parse_value]>]><&hover[Click to warp to <[parse_value]>]><[parse_value].to_lowercase><&end_hover><&end_click>].separated_by[,<&sp>]>"
  - if <[max_page]> <= 1:
    - narrate " "
    - stop
  - define left_ar "<&hover[Click here to go a page backwards]><&click[/warps <[page].sub[1]>]><&6><&chr[25C0]><&end_click><&end_hover>"
  - define right_ar "<&hover[Click here to go a page forward]><&click[/warps <[page].add[1]>]><&6><&chr[25B6]><&end_click><&end_hover>"
  - if <[page]> == 1:
    - narrate "<&6><&chr[25C1]> <&6>Page <&c><[page]>/<[max_page]> <[right_ar]>"
    - stop
  - if <[page]> == <[max_page]>:
    - narrate "<[left_ar]> <&6>Page <&c><[page]>/<[max_page]> <&6><&chr[25B7]>"
    - stop
  - narrate "<[left_ar]> <&6>Page <&c><[page]>/<[max_page]> <[right_ar]>"
#------------#
# warp signs
#-----------#
warp_sign_world:
  type: world
  debug: false
  events:
    on player changes sign:
    - if <context.new.first.to_lowercase.strip_color> != [warp]:
      - stop
    - if !<player.is_op>:
      - modifyblock <context.location> air naturally:diamond_axe
      - narrate "<&c>Error: <&4>You do not have permission to create a warp sign"
      - stop
    - if <context.new.get[2]> == <empty>:
      - narrate "<&c>Error: <&4>No warp name given"
      - determine "<list[<&c>[warp]|<&4>(warp name)]>"
    - if !<server.flag[warps].keys.contains[<context.new.get[2].to_lowercase.strip_color>]>:
      - narrate "<&c>Error: <&4>Invalid warp name given <&c><context.new.get[2]> <&4>is not a warp"
      - determine "<list[<&c>[warp]|<&4>(warp name)]>"
    - adjust <context.location> sign_contents:<list[<&1><&lb>Warp<&rb>]>
    on player right clicks *_sign priority:1:
    - if <context.location.sign_contents.first> != <&1>[Warp]:
      - stop
    - if !<server.flag[warps].contains[<context.location.sign_contents.get[2].to_lowercase.strip_color||null>]>:
      - adjust <context.location> sign_contents:<list[&c[warp]]>
      - narrate "Seems like this warp no longer exsist." format:zc_text
      - narrate "Notify an admin if you think this is incorrect." format:zc_text
      - stop
    - execute as_player "warp <context.location.sign_contents.get[2].to_lowercase.strip_color>"