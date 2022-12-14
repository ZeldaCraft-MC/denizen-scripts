vday_boat:
    type: world
    debug: false
    events:
        on player right clicks *boat in:vday_tunnel:
            - determine cancelled
        on tpa command in:vday_tunnel:
            - determine cancelled
        on player enters vday_end:
          - if <player.is_inside_vehicle>:
            - mount <player> cancel

        on player exits vehicle in:vday_tunnel:
            - if <player.location.cuboids.parse[note_name].contains[vday_tunnel_end]||false>:
                - define entities <context.vehicle.passengers>
                - wait 2t
                - teleport <[entities]> vday_end
                - remove <context.vehicle>
                - stop
            - define entities <context.vehicle.passengers>
            - wait 2t
            - teleport <[entities]> vday_tunnel_entrance
            - remove <context.vehicle>
            - narrate "<dark_red>You Cucco'd out.." targets:<player>
            - narrate "<dark_red><player.name> Cucco'd out.." targets:<[entities].exclude[<player>]>
        on entity changes lily_pad in:vday_tunnel:
            - determine cancelled
        on player enters vday_tunnel_portal:
            - teleport <player> vday_tunnel_entrance
        on player enters vday_tunnel_portal2:
            - teleport <player> vday_submission_start
        on vehicle damaged in:vday_tunnel:
            - determine cancelled

submit_book_inv:
  type: inventory
  inventory: hopper
  title: <&c>Submit your poem!

vday_events:
  type: world
  debug: false
  events:
    on player takes item from lectern in:vday_poem_submission bukkit_priority:lowest:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - give writable_book
        - narrate "<&c>You took a poem submission book! Make sure to answer the prompt, sign it, and place it in the chest :)"
    on player right clicks block location_flagged:poem_book_chest bukkit_priority:lowest:
        - determine passively cancelled
        - wait 1t
        - inventory open d:submit_book_inv
    on player closes submit_book_inv:
        - define books <context.inventory.list_contents.filter[material.name.is[==].to[written_book]]>
        - define items <context.inventory.list_contents.filter[material.name.is[!=].to[written_book]]>
        - wait 1t
        - give <[items]>
        - if !<[books].is_empty>:
          - narrate "<&c>Thank you for your poem submission(s)! These have been recorded and our staff will review them 2 weeks after Valentine's Day!"
          - flag server vday_poems:|:<[books]>
    on player right clicks armor_stand in:vday_poem_submission:
        - determine cancelled
    on player damages armor_stand in:vday_poem_submission:
        - determine cancelled
    on player enters portal in:vday_poem_submission:
        - determine cancelled
    on player enters portal in:vday_tunnel:
        - determine cancelled
    on player right clicks armor_stand in:vday_tunnel:
        - determine cancelled
    on player damages armor_stand in:vday_tunnel:
        - determine cancelled
    on armor_stand damaged in:vday_tunnel:
        - determine cancelled
    on player quits:
      - if <player.location.cuboids.is_in[*vday_tunnel*]>:
        - teleport <player> vday_submission_start
    on player enters vday_gift:
        - ratelimit <player> 10s
        - narrate "<gold>Great Fairy: <aqua>I hope you two enjoyed your time together! Take this, and spread the love!"
        - wait 1s
        - if <player.has_flag[got_cupid_bow]>:
            - give vday_rose[quantity=<util.random.int[2].to[10]>]
        - else:
            - give cupid_bow
            - flag <player> got_cupid_bow duration:14d
        - wait 2s
        - flag <player> finished_vday:++
        - teleport <player> vday_submission_start

vday_boat_command:
    type: command
    name: vday
    debug: false
    description: Invite someone special to a Valentines boat ride
    usage: "/vday invite|accept|deny (player)"
    tab complete:
        - define args <context.args>
        - if <context.raw_args.length> == 0 || <context.raw_args.char_at[<context.raw_args.length>]> == " " || <context.args.is_empty>:
            - define args:->:<empty>
        - if <[args].size> == 1:
            - determine invite|accept|deny
        - if <[args].size> == 2:
            - determine <server.online_players.parse[name]>
    script:
        - if <context.args.size> < 1:
            - narrate "<&c>Usage: /vday accept|decline|invite (player)"
            - stop
        - choose <context.args.get[1]>:
            - case accept:
                - if !<player.has_flag[vday_invites]>:
                    - narrate "<red>You don't have any pending invites to accept"
                    - stop
                - narrate  "<light_purple><player.name> has accepted your invitation! Teleporting..." targets:<player.flag[vday_invites]>
                - narrate "<light_purple>Invitation Accepted! Teleporting..."
                - teleport <player.flag[vday_invites]>|<player> vday_tunnel_entrance
                - wait 2t
                - mount <player.flag[vday_invites]>|boat vday_tun_1
                - wait 2t
                - mount <player>|<player.flag[vday_invites].vehicle> <player.flag[vday_invites].location>
                - flag <player.flag[vday_invites]> vday_invited:!
                - flag <player> vday_invites:!
            - case deny:
                - if !<player.has_flag[vday_invites]>:
                    - narrate "<red>You don't have any pending invites to deny"
                    - stop
                - narrate "<dark_red><player.name> has denied your invitation.." targets:<player.flag[vday_invites]>
                - narrate "<dark_red>Invitation declined..."
                - flag <player.flag[vday_invites]> vday_invited:!
                - flag <player> vday_invites:!
            - case invite:
                - if <player.has_flag[vday_invited]>:
                    - narrate "<red>You have already sent an invite! Please wait before sending another"
                    - stop
                - if <context.args.get[2]||null> == null:
                    - narrate "<red>Please invite an online player!"
                    - stop
                - define p2 <server.match_player[<context.args.get[2]>]||null>
                - if <[p2]> == null:
                    - narrate "<red>Please invite an online player!"
                    - stop
                - if <[p2].uuid> == <player.uuid>:
                    - narrate "<red>You cannot invite yourself!"
                    - stop
                - flag <player> vday_invited:<[p2]> duration:2m
                - flag <[p2]> vday_invites:<player> duration:2m
                - narrate "<light_purple><player.name> has sent you an invitation to take a Valentines boat ride!<n>use to /vday accept to join them" targets:<[p2]>
                - narrate "<light_purple>Invitation sent."
