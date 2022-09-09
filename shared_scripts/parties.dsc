conv_party_check:
    type: task
    debug: false
    script:
        - ~yaml load:party_conv_test.yml id:party_conv
        - foreach <yaml[party_conv].read[map-parties-by-name].keys> as:n:
            - if <[loop_index].mod[5]> == 0:
                - announce "<[loop_index]>/<yaml[party_conv].read[map-parties-by-name].keys.size> Converted" to_console
                - wait 1s
            - if <yaml[party_conv].read[parties].get[<yaml[party_conv].read[map-parties-by-name].get[<[n]>]>]||error> != error:
                - define party <yaml[party_conv].read[parties].get[<yaml[party_conv].read[map-parties-by-name].get[<[n]>]>]||error>
                - define leader <[party].get[leader]>
                - define members <[party].get[members]||<list>>
                - define desc <[party].get[description]||<empty>>
                - define motd <[party].get[motd]||<empty>>
                - flag server parties.<[n]>.leader.<[leader]>:<player[<[leader]>].name||error>
                - if <[desc]> != <empty>:
                    - flag server parties.<[n]>.desc:<[desc]>
                - if <[motd]> != <empty>:
                    - flag server parties.<[n]>.motd:<[motd]>
                - flag server parties.<[n]>.members:Nobody
                - foreach <[members]> as:id:
                    - if <[loop_index].mod[10]> == 0:
                        - wait 1s
                    - if <player[<[id]>].name||error> == error:
                        - foreach next
                    - flag server parties.<[n]>.members.<[id]>.name:<player[<[id]>].name>
                    - define rank <yaml[party_conv].read[players].get[<[id]>].get[rank]>
                    - choose <[rank]>:
                        - case 20:
                            - flag server parties.<[n]>.members.<[id]>.rank:Leader
                        - case 15:
                            - flag server parties.<[n]>.members.<[id]>.rank:Admin
                        - case 10:
                            - flag server parties.<[n]>.members.<[id]>.rank:Mod
                        - case 5:
                            - flag server parties.<[n]>.members.<[id]>.rank:Member
                        - default:
                            - flag server parties.<[n]>.members.<[id]>.rank:Member
            - else:
                - announce "<[n]> not found Skipping..." to_console

# /ex narrate <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
# /ex narrate <server.flag[parties].get[partyhard].get[members].filter_tag[<[filter_value].get[name].is[==].to[greenleeuw]>].keys>
# /ex narrate <server.flag[global_player_data].filter[get[name].is[==].to[greenleeuw]].first.get[uuid]>
# /ex narrate <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains_any[<server.flag[global_player_data].parse[get[uuid]]>]>]>
# /ex narrate <server.flag[parties].get[partyhard].get[members].keys.filter_tag[<server.flag[global_player_data].parse[get[uuid]].contains[<[filter_value]>]>].size>
party_cmd:
    type: command
    name: testparty
    description: new party command
    usage: /testparty
    permission: op
    debug: false
    script:
        - choose <context.args.first>:
            - case help:
                - narrate help menu
            ## NEEDS CROSS SERVER LEAVE MESSAGES##
            - case leave:
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define p <[party].first>
                - if <server.flag[parties].get[<[p]>].get[leader].keys.first> == <player.uuid>:
                    - narrate "You are the leader of this party, please promote someone else before leaving!"
                    - stop
                - flag server parties.<[p]>.members.<player.uuid>:!
                - narrate "You succesfully left <[p]>"
            ## DONE ##
            - case list:
                - define online_players <server.flag[global_player_data].parse[get[uuid]]>
                - define parties <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains_any[<[online_players]>]>]>
                - define txt "<list[<&b><&l>========== Online Parties List ==========]>"
                - foreach <[parties]> as:p:
                    - define num <server.flag[parties].get[<[p]>].get[members].keys.filter_tag[<server.flag[global_player_data].parse[get[uuid]].contains[<[filter_value]>]>].size||0>
                    - if <server.flag[parties].get[<[p]>].get[desc]||<empty>> == <empty>:
                        - define txt "<[txt].include[<&b><[p]> <&7><&lb><&6>Online <[num]><&7><&rb>]>"
                    - else:
                        - define txt "<[txt].include[<&b><[p]> <&7><&lb><&6>Online <[num]><&7><&rb> <server.flag[parties].get[<[p]>].get[desc]>]>"
                - narrate <[txt].separated_by[<&nl>]>
            ## NEEDS CROSS SERVER INVITES ##
            - case invite:
                - define online_players <server.flag[global_player_data].parse[get[name]]>
                - define args <context.args.get[2].to[last]||<list>>
                - if <[args].is_empty>:
                    - narrate "You did not include a player!"
                    - stop
                - define p <[args].first>
                - if <[p]> !in <[online_players]>:
                    - narrate "<[p]> Does not seem to be online!"
                    - stop
                - define uuid <server.flag[global_player_data].filter[get[name].is[==].to[<[p]>]].first.get[uuid]>
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define rank <server.flag[parties].get[<[party].first>].get[members].get[<player.uuid>].get[rank]>
                - if <[rank]> !in <list[Mod|Admin|Leader]>:
                    - narrate "You lack the required permissions!"
                    - stop
                - narrate "<[p]> Has succesfully been invited(not really)"
            ## DONE ##
            - case info:
                - define online_players <server.flag[global_player_data].parse[get[uuid]]>
                - define args <context.args.get[2].to[last]||<list>>
                - if <[args].is_empty>:
                    - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                    - if <[party].is_empty>:
                        - narrate "You did not specify a party!"
                        - stop
                    - else:
                        - define party <[party].first>
                        - if <[party]> !in <server.flag[parties].keys>:
                            - narrate "the party you specified does not seem to be valid!"
                            - stop
                - else:
                    - define party <[args].first>
                - define map <server.flag[parties].get[<[party]>]>
                - define txt <list>
                - define txt "<[txt].include[<&b><&l>==========<[party]>'s Info==========]>"
                - if <[map].get[desc]||<empty>> != <empty>:
                    - define txt "<[txt].include[<&b>Description<&7>: <server.flag[parties].get[<[party]>].get[desc]>]>"
                - if <[map].get[motd]||<empty>> != <empty>:
                    - define txt "<[txt].include[<&b>Motd<&7>: <server.flag[parties].get[<[party]>].get[motd]>]>"
                - define leader <[map].get[leader].values.first>
                - if <[map].get[leader].keys.first> in <[online_players]>:
                    - define txt "<[txt].include[<&b>Leader<&7>: <&b><[leader]>]>"
                - else:
                    - define txt "<[txt].include[<&b>Leader<&7>: <[leader]>]>"
                - define Admins <list>
                - define Mods <list>
                - define Members <list>
                - define Leaders <list>
                - define online_m 0
                - foreach <[map].get[members].keys> as:p:
                    - if <[p]> in <[online_players]>:
                        - define <[map].get[members].get[<[p]>].get[rank]>s <[<[map].get[members].get[<[p]>].get[rank]>s].include[<&b><[map].get[members].get[<[p]>].get[name]><&7>]>
                        - define online_m:++
                    - else:
                        - define <[map].get[members].get[<[p]>].get[rank]>s <[<[map].get[members].get[<[p]>].get[rank]>s].include[<[map].get[members].get[<[p]>].get[name]>]>
                - if <[Admins].is_empty>:
                    - define txt "<[txt].include[<&b>Admins<&7>: Nobody]>"
                - else:
                    - define txt "<[txt].include[<&b>Admins<&7>: <[Admins].separated_by[,<&sp>]>]>"
                - if <[Mods].is_empty>:
                    - define txt "<[txt].include[<&b>Mods<&7>: Nobody]>"
                - else:
                    - define txt "<[txt].include[<&b>Mods<&7>: <[Mods].separated_by[,<&sp>]>]>"
                - if <[Members].is_empty>:
                    - define txt "<[txt].include[<&b>Members<&7>: Nobody]>"
                - else:
                    - define txt "<[txt].include[<&b>Members<&7>: <[Members].separated_by[,<&sp>]>]>"
                - define txt "<[txt].include[<&b>Online players<&7>: <[online_m]>]>"
                - narrate <[txt].separated_by[<&nl>]>
            # UPDATE CROSS SERVER #
            # NEEDS CROSS SERVER MESSAGES #
            - case desc:
                - define args <context.args.get[2].to[last]||<list>>
                - if <[args].is_empty>:
                    - narrate "You did not include a Description!"
                    - stop
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define rank <server.flag[parties].get[<[party].first>].get[members].get[<player.uuid>].get[rank]>
                - if <[rank]> !in <list[Admin|Leader]>:
                    - narrate "You lack the required permissions!"
                    - stop
                - flag server parties.<[party.first]>.desc:<[args].get[2].to[last]>
                - narrate "The description has been changed!"
            # UPDATE CROSS SERVER #
            # NEEDS CROSS SERVER MESSAGES #
            - case motd:
                - define args <context.args.get[2].to[last]||<list>>
                - if <[args].is_empty>:
                    - narrate "You did not include a Motd!"
                    - stop
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define rank <server.flag[parties].get[<[party].first>].get[members].get[<player.uuid>].get[rank]>
                - if <[rank]> !in <list[Admin|Leader]>:
                    - narrate "You lack the required permissions!"
                    - stop
                - flag server parties.<[party.first]>.motd:<[args].get[2].to[last]>
                - narrate "The motd has been changed!"
            - case rank:
                - narrate rank
            # UPDATE CROSS SERVER #
            # NEEDS CROSS SERVER MESSAGES #
            - case rename:
                - define args <context.args.get[2].to[last]||<list>>
                - if <[args].is_empty>:
                    - narrate "You did not include a new name!"
                    - stop
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define rank <server.flag[parties].get[<[party].first>].get[members].get[<player.uuid>].get[rank]>
                - if <[rank]> !in <list[Admin|Leader]>:
                    - narrate "You lack the required permissions!"
                    - stop
                - if <[party].first> == <[args].first>:
                    - narrate "Party renamed from <[party].first> to <[args].first>"
                    - stop
                - define pa <server.flag[parties].get[<[party].first>]>
                - define n_name <[args].first>
                - if <[n_name].split[].contains_any[<list[<&lb>|<&rb>|<&gt>|<&lt>|.|<&co>]>]>:
                    - narrate "Some characters cannot be used in the name!"
                    - stop
                - define o_name <[party].first>
                - foreach <[pa].keys> as:a:
                    - choose <[a]>:
                        - case desc:
                            - flag server parties.<[n_name]>.desc:<server.flag[parties].get[<[o_name]>].get[desc]>
                        - case motd:
                            - flag server parties.<[n_name]>.motd:<server.flag[parties].get[<[o_name]>].get[motd]>
                        - case leader:
                            - flag server parties.<[n_name]>.leader.<server.flag[parties].get[<[o_name]>].get[leader].keys.first>:<server.flag[parties].get[<[o_name]>].get[leader].values.first>
                        - case members:
                            - foreach <server.flag[parties].get[<[o_name]>].get[members].keys> as:b:
                                - flag server parties.<[n_name]>.members.<[b]>.rank:<server.flag[parties].get[<[o_name]>].get[members].get[<[b]>].get[rank]>
                                - flag server parties.<[n_name]>.members.<[b]>.name:<server.flag[parties].get[<[o_name]>].get[members].get[<[b]>].get[name]>
                - flag server parties.<[o_name]>:!
                - narrate "The name has been changed from <[o_name]> to <[n_name]>"
            - case kick:
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define rank <server.flag[parties].get[<[party].first>].get[members].get[<player.uuid>].get[rank]>
                - if <[rank]> != Leader && <[rank]> != Admin:
                    - narrate "You lack the required permissions!"
                    - stop
                - if <context.args.get[2]||ERROR> == ERROR:
                    - narrate "you did not include a player"
                    - stop
                - define uuid <server.match_offline_player[<context.args.get[2]>]>
            # UPDATE CROSS SERVER #
            # NEEDS CROSS SERVER MESSAGES #
            - case delete:
                - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
                - if <[party].is_empty>:
                    - narrate "You do not seem to be in a party!"
                    - stop
                - define rank <server.flag[parties].get[<[party].first>].get[members].get[<player.uuid>].get[rank]>
                - if <[rank]> != Leader:
                    - narrate "You lack the required permissions!"
                    - stop
                - flag server parties.<[party].first>:!
                - narrate "<[party].first> has been deleted!"
            - case promote:
                - narrate promote
            - case demote:
                - narrate demote
            - default:
                - narrate "Something went wrong!"

chat_cmd:
    type: command
    debug: false
    name: chat
    usage: /chat (default/party)
    description: changes your chat type
    tab complete:
        - foreach gm|admin|moderator as:rank:
            - if <player.in_group[<[rank]>]>:
                - determine default|party|staff
        - determine default|party
    script:
    - choose <context.args.first>:
        - case staff:
            - if !<player.in_group[gm]> && !<player.in_group[admin]> && !<player.in_group[moderator]>:
                - narrate "You do not have permission to use this command!"
                - stop
            - narrate "Your chat has been changed to <&a>Staff" format:zc_text
            - redis id:publisher publish:global_change_chat_<player.uuid> message:staff
        - case party:
            - define party <server.flag[parties].keys.filter_tag[<server.flag[parties].get[<[filter_value]>].get[members].keys.contains[<player.uuid>]>]>
            - if <[party].is_empty>:
                - narrate "You do not seem to be in a party!"
                - stop
            - narrate "Your chat has been changed to <&a>Party" format:zc_text
            - redis id:publisher publish:global_change_chat_<player.uuid> message:party
        - case default:
            - narrate "Your chat has been changed to <&a>Default" format:zc_text
            - redis id:publisher publish:global_change_chat_<player.uuid> message:default
        - default:
            - narrate "Seems like you forgot to put in a chat option."
