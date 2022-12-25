conv_ess_data:
  type: data
  debug: false
  back:
    description: Teleports you to your location prior to tp/spawn/warp.
    usage: /<[command]> [player]
    aliases: [eback,return,ereturn]
  balance:
    description: States the current balance of a player.
    usage: /<[command]> [player]
    aliases: [bal,ebal,ebalance,money,emoney]
  clearinventory:
    description: Clear all items in your inventory.
    usage: /<[command]> [player|*] [item[:<&lt>data<&gt>]|*|**] [amount]
    aliases: [ci,eci,clean,eclean,clear,eclear,clearinvent,eclearinvent,eclearinventory]
  disposal:
    description: Opens a portable disposal menu.
    usage: /<[command]>
    aliases: [edisposal,trash,etrash]
  eco:
    description: Manages the server economy.
    usage: /<[command]> <&lt>give|take|set|reset<&gt> <&lt>player<&gt> <&lt>amount<&gt>
    aliases: [eeco,economy,eeconomy]
  enchant:
    description: Enchants the item the user is holding.
    usage: /<[command]> <&lt>enchantmentname<&gt> [level]
    aliases: [eenchant,enchantment,eenchantment]
  enderchest:
    description: Lets you see inside an enderchest.
    usage: /<[command]> [player]
    aliases: [echest,eechest,eenderchest,endersee,eendersee,ec,eec]
  exp:
    description: Give, set, reset, or look at a players experience.
    usage: /<[command]> [reset|show|set|give] [playername [amount]]
    aliases: [eexp,xp]
  feed:
    description: Satisfy the hunger.
    usage: /<[command]> [player]
    aliases: [eat,eeat,efeed]
  gamemode:
    description: Change player gamemode.
    usage: /<[command]> <&lt>survival|creative|adventure|spectator<&gt> [player]
    aliases: [adventure,eadventure,adventuremode,eadventuremode,creative,ecreative,eecreative,creativemode,ecreativemode,egamemode,gm,egm,gma,egma,gmc,egmc,gms,egms,gmt,egmt,survival,esurvival,survivalmode,esurvivalmode,gmsp,sp,egmsp,spec,spectator]
  getpos:
    description: Get your current coordinates or those of a player.
    usage: /<[command]> [player]
    aliases: [coords,egetpos,position,eposition,whereami,ewhereami,getlocation,egetlocation,getloc,egetloc]
  god:
    description: Enables your godly powers.
    usage: /<[command]> [player] [on|off]
    aliases: [egod,godmode,egodmode,tgm,etgm]
  hat:
    description: Get some cool new headgear.
    usage: /<[command]> [remove]
    aliases: [ehat,head,ehead]
  heal:
    description: Heals you or the given player.
    usage: /<[command]> [player]
    aliases: [eheal]
  ignore:
    description: Ignore or unignore other players.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [eignore,unignore,eunignore,delignore,edelignore,remignore,eremignore,rmignore,ermignore]
  invsee:
    description: See the inventory of other players.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [einvsee]
  jump:
    description: Jumps to the nearest block in the line of sight.
    usage: /<[command]>
    aliases: [j,ej,ejump,jumpto,ejumpto]
  kick:
    description: Kicks a specified player with a reason.
    usage: /<[command]> <&lt>player<&gt> [reason]
    aliases: [ekick]
  kickall:
    description: Kicks all players off the server except the issuer.
    usage: /<[command]> [reason]
    aliases: [ekickall]
  kill:
    description: Kills specified player.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [ekill]
  kit:
    description: Obtains the specified kit or views all available kits.
    usage: /<[command]> [kit] [player]
    aliases: [ekit,kits,ekits]
  kittycannon:
    description: Throw an exploding kitten at your opponent.
    usage: /<[command]>
    aliases: [ekittycannon]
  lightning:
    description: The power of Thor. Strike at cursor or player.
    usage: /<[command]> [player] [power]
    aliases: [elightning,shock,eshock,smite,esmite,strike,estrike,thor,ethor]
  list:
    description: List all online players.
    usage: /<[command]> [group]
    aliases: [elist,online,eonline,playerlist,eplayerlist,plist,eplist,who,ewho]
  mail:
    description: Manages inter-player, intra-server mail.
    usage: /<[command]> [read|clear|clear [number]|send [to] [message]|sendtemp [to] [expire time] [message]|sendall [message]]
    aliases: [email,eemail,memo,ememo]
  me:
    description: Describes an action in the context of the player.
    usage: /<[command]> <&lt>description<&gt>
    aliases: [action,eaction,describe,edescribe,eme]
  msg:
    description: Sends a private message to the specified player.
    usage: /<[command]> <&lt>to<&gt> <&lt>message<&gt>
    aliases: [w,m,t,pm,emsg,epm,tell,etell,whisper,ewhisper]
  mute:
    description: Mutes or unmutes a player.
    usage: /<[command]> <&lt>player<&gt> [datediff] [reason]
    aliases: [emute,silence,esilence]
  pay:
    description: Pays another player from your balance.
    usage: /<[command]> <&lt>player<&gt> <&lt>amount<&gt>
    aliases: [epay]
  powertool:
    description: Assigns a command to the item in hand.
    usage: /<[command]> [l:|a:|r:|c:|d:][command] [arguments] - {player} can be replaced by name of a clicked player.
    aliases: [epowertool,pt,ept]
  ptime:
    description: Adjust player's client time. Add @ prefix to fix.
    usage: /<[command]> [list|reset|day|night|dawn|17:30|4pm|4000ticks] [player|*]
    aliases: [playertime,eplayertime,eptime]
  pweather:
    description: Adjust a player's weather
    usage: /<[command]> [list|reset|storm|sun|clear] [player|*]
    aliases: [playerweather,eplayerweather,epweather]
  r:
    description: Quickly reply to the last player to message you.
    usage: /<[command]> <&lt>message<&gt>
    aliases: [er,reply,ereply]
  realname:
    description: Displays the username of a user based on nick.
    usage: /<[command]> <&lt>nickname<&gt>
    aliases: [erealname]
  repair:
    description: Repairs the durability of one or all items.
    usage: /<[command]> [hand|all]
    aliases: [fix,efix,erepair]
  sell:
    description: Sells the item currently in your hand.
    usage: /<[command]> <&lt><&lt>itemname<&gt>|<&lt>id<&gt>|hand|inventory|blocks<&gt> [amount]
    aliases: [esell]
  setworth:
    description: Set the sell value of an item.
    usage: /<[command]> [itemname|id] <&lt>price<&gt>
    aliases: [esetworth]
  socialspy:
    description: Toggles if you can see msg/mail commands in chat.
    usage: /<[command]> [player] [on|off]
    aliases: [esocialspy]
  speed:
    description: Change your speed limits.
    usage: /<[command]> [type] <&lt>speed<&gt> [player]
    aliases: [flyspeed,eflyspeed,fspeed,efspeed,espeed,walkspeed,ewalkspeed,wspeed,ewspeed]
  sudo:
    description: Make another user perform a command.
    usage: /<[command]> <&lt>player<&gt> <&lt>command [args]<&gt>
    aliases: [esudo]
  suicide:
    description: Causes you to perish.
    usage: /<[command]>
    aliases: [esuicide]
  thunder:
    description: Enable/disable thunder.
    usage: /<[command]> <&lt>true/false<&gt> [duration]
    aliases: [ethunder]
  time:
    description: Display/Change the world time. Defaults to current world.
    usage: /<[command]> [set|add] [day|night|dawn|17:30|4pm|4000ticks] [worldname|all]
    aliases: [day,eday,night,enight,etime]
  top:
    description: Teleport to the highest block at your current position.
    usage: /<[command]>
    aliases: [etop]
  tp:
    description: Teleport to a player.
    usage: /<[command]> <&lt>player<&gt> [otherplayer]
    aliases: [tele,etele,teleport,eteleport,etp,tp2p,etp2p]
  tpa:
    description: Request to teleport to the specified player.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [call,ecall,etpa,tpask,etpask]
  tpaall:
    description: Requests all players online to teleport to you.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [etpaall]
  tpaccept:
    description: Accepts a teleport request.
    usage: /<[command]> [otherplayer]
    aliases: [etpaccept,tpyes,etpyes]
  tpahere:
    description: Request that the specified player teleport to you.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [etpahere]
  tpall:
    description: Teleport all online players to another player.
    usage: /<[command]> [player]
    aliases: [etpall]
  tpacancel:
    description: Cancel all outstanding teleport requests. Specify [player] to cancel requests with them.
    usage: /<[command]> [player]
    aliases: [etpacancel]
  tpdeny:
    description: Reject a teleport request.
    usage: /<[command]>
    aliases: [etpdeny,tpno,etpno]
  tphere:
    description: Teleport a player to you.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [s,etphere]
  tpo:
    description: Teleport override for tptoggle.
    usage: /<[command]> <&lt>player<&gt> [otherplayer]
    aliases: [etpo]
  tpohere:
    description: Teleport here override for tptoggle.
    usage: /<[command]> <&lt>player<&gt>
    aliases: [etpohere]
  tppos:
    description: Teleport to coordinates.
    usage: /<[command]> <&lt>x<&gt> <&lt>y<&gt> <&lt>z<&gt> [yaw] [pitch] [world]
    aliases: [etppos]
  tptoggle:
    description: Blocks all forms of teleportation.
    usage: /<[command]> [player] [on|off]
    aliases: [etptoggle]
  vanish:
    description: Hide yourself from other players.
    usage: /<[command]> [player] [on|off]
    aliases: [v,ev,evanish]
  weather:
    description: Sets the weather.
    usage: /<[command]> <&lt>storm/sun<&gt> [duration]
    aliases: [rain,erain,sky,esky,storm,estorm,sun,esun,eweather]
  whois:
    description: Determine the username behind a nickname.
    usage: /<[command]> <&lt>nickname<&gt>
    aliases: [ewhois]
  workbench:
    description: Opens up a workbench.
    usage: /<[command]>
    aliases: [craft,ecraft,wb,ewb,wbench,ewbench,eworkbench]
  worth:
    description: Calculates the worth of items in hand or as specified.
    usage: /<[command]> <&lt><&lt>itemname<&gt>|<&lt>id<&gt>|hand|inventory|blocks<&gt> [-][amount]
    aliases: [eprice,price,eworth]

ess_info_cmd:
  type: command
  debug: false
  name: cmd_info
  description: shows you info of the specified essentials command
  usage: /cmd_info
  permission: op
  tab completions:
    1: <script[conv_ess_data].list_keys[].exclude[type|debug].alphabetical>
  script:
    - if !<script[conv_ess_data].list_keys[].exclude[type|debug].contains[<context.args.first||null>]>:
      - narrate "this command does not seem to be in the list"
      - stop
    - define command <context.args.first>
    - narrate "<&a><&l><[command]><&2><&l> commands info<&nl>"
    - narrate "<&2>Description: <&f><script[conv_ess_data].parsed_key[<[command]>].get[description]>"
    - narrate "<&2>Usage: <&f><script[conv_ess_data].parsed_key[<[command]>].get[usage]>"
    - narrate "<&2>Aliases: <&f><script[conv_ess_data].parsed_key[<[command]>].get[aliases].separated_by[ <&2>- <&f>]><&nl>"

list_cmds:
  type: command
  name: list_cmds
  usage: /list_cmds (page number)
  debug: false
  description: gives you a list with all the commands
  permission: zc.dev
  script:
    - if <context.args.get[1].is_decimal||false>:
      - define page <context.args.get[1]||1>
    - else:
      - define page 1
    - define max <script[conv_ess_data].list_keys[].exclude[type|debug].size.div[10].round_up>
    - if <[page]> <= 0:
      - narrate "the page number cannot go lower then 1" format:zc_text
      - stop
    - if <[page]> > <[max]>:
      - narrate "the page number cannot be higher then <[max]>" format:zc_text
      - stop
    - define start <[page].sub[1].mul[10].add[1]>
    - if <[start]> == 0:
      - define start 1
    - define end <[page].mul[10]>
    - define commands <list>
    - foreach <script[conv_ess_data].list_keys[].exclude[type|debug].alphabetical> as:command:
      - if <[loop_index]> < <[start]>:
        - foreach next
      - if <[loop_index]> > <[end]>:
        - foreach stop
      - define hover <list>
      - define hover "<[hover].include[<&2>Description: <&f><script[conv_ess_data].parsed_key[<[command]>].get[description]>]>"
      - define hover "<[hover].include[<&2>Usage: <&f><script[conv_ess_data].parsed_key[<[command]>].get[usage]>]>"
      - define hover "<[hover].include[<&2>Aliases: <&f><script[conv_ess_data].parsed_key[<[command]>].get[aliases].separated_by[, ]>]>"
      - define commands "<[commands].include[<&hover[<[hover].separated_by[<&nl>]>]><&2>#<[loop_index]>:<&f> <[command]><&end_hover>]>"
    - if <[commands].is_empty>:
      - define voters "<list[No commands where found!]>"
    - define left_ar "<&hover[Click here to go a page backwards]><&click[/list_cmds <[page].sub[1]>]><&color[#04BA04]><&chr[25C0]><&end_click><&end_hover>"
    - define right_ar "<&hover[Click here to go a page forward]><&click[/list_cmds <[page].add[1]>]><&color[#04BA04]><&chr[25B6]><&end_click><&end_hover>"
    - narrate "<&a><&l>Essentials <&2><&l>Commands list<&nl>"
    - narrate <[commands].separated_by[<&nl>]>
    - if <[page]> == 1:
      - narrate "<&nl><&color[#04BA04]><&chr[25C1]> <&r>Page <[page]>/<[max]> <[right_ar]><&nl>"
      - stop
    - if <[page]> == <[max]>:
      - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max]> <&color[#04BA04]><&chr[25B7]><&nl>"
      - stop
    - narrate "<&nl><[left_ar]> <&r>Page <[page]>/<[max]> <[right_ar]><&nl>"
