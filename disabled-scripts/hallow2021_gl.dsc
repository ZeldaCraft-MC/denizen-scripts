hallow2021_black_list:
  type: data
  debug: false
  users:
    - 07a5cd73-93bb-46d7-a241-2db17785a2bd
#    - 70219804-4769-4e5a-be0a-007f91013a0b
    - 4fc923ad-4aca-4646-a669-2355aea7df57
    - 958f4836-6b80-4416-919d-6c1e2b2397cd

#------------------------#
# prefixes and what to do
#------------------------#
# hallow2021_candy_caught #
#candy fishing fish candy 10 times
#candy fisher fish candy 50 times
#dedicated fisher fish candy 150 times
#-------------------------------------#
# hallow2021_graves_dug #
#grave robber rob 10 graves
#grave dismantler rob 100 graves
#-------------------------------#
# hallow2021_tricked #
#got tricket get tricked 50 times
# hallow2021_treated #
#got treated get treated 50 times
#--------------------------------#
# hallow2021_stashes_found #
#candy finder find 12 hidden candy stashes
#robbing robbers find 30 hidden candy stashes
#---------------------------------#
# hallow2021_rabbit_return #
#rabbit catcher return 15 rabbits
#rabbit tamer return 50 rabbits
#killer bunny return 100 rabbits
#------------------------#
# hallow2021_bat_shots #
#bat basher shoot 15 bats
#bane of bats shoot 50 bats
#dead shot shoot 150 bats
#-----------------------------#
# hallow2021_candy_sorted #
#candy sorter sort the inventory 10 times
#sorting manager sort the inventory 50 times
#-------------------------------------------------#
# a data script that is used throughout the script
# can change warp names if we must
#-------------------------------------------------#
fix_colosseum_task:
  type: task
  debug: false
  script:
    - foreach <server.list_flags.filter[starts_with[hallow2021_coloseum]]> as:flag:
      - flag server <[flag].replace[coloseum].with[colosseum]>:<server.flag[<[flag]>]>
      - flag server <[flag]>:!
    - announce done to_console

hallow2021_warps_list:
  type: data
  debug: false
# the 5 big events and what warps they go to
  events:
    #haunted_mansion:
    #  - animal_village
    #big_phantom:
    #  - coloseum
    #ghost_ship:
    #  - zorasriver
    #witch_house:
    #  - ravio
    graveyard:
      - kakariko
# sevents stands for small events
  sevents:
# all the warps candy fishing can happen in
    candy_fish:
      - fishing_hole
      - castletown
      - clocktown
      - ravio
      - zorasriver
# all other events that are not big or fishing
    other_events:
      - candy_rain
      - candy_sor
      - running_rabbits
      - shoot_bats
      - trick_treat
      - candy_hiding
      - candy_mobs
# all the warps we will use in this event
  warps:
    - animal_village
    - colosseum
    - fishing_hole
    - castletown
    - kakariko
    - clocktown
    - lonlon
    - ravio
    - zorasriver
# head skull_skins that are randomized for the warp menu (which has a max of 9 warps)
  heads:
    - efa1e4d2-3c69-4032-88f5-4c675557a3d4|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODEzOWIyYTI5NWI0NWZkNDJjOTZlZjMxMDk0NGM5NjhmZTY1M2Y5OWI5YTRhZTdjYmRjZGMwMzBlZGRiZWQ4NyJ9fX0=
    - 82af1c74-0b63-4e3f-8f53-7fdf99b5261b|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzVhOWNjZTMyMjNiZTFiYjkyN2JkMjYzNWUxOGI2NDQ2MDFkNTIxYjY0Y2EwNjhjNTQxZDNiYzk2MDkwOGMzYSJ9fX0=
    - 6735c14d-9683-4541-b1af-5f14cfb08e09|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGQzMTE3M2U3YjdjNzhlNWU0OGRjZmY2NmQ1Nzk4MGFlY2EzODI0Y2Q4NTg0YWFjNDZkNzdjMjYwYzM4YmI0YyJ9fX0=
    - 59a22816-64df-4437-9085-e61c8746a2be|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODdmNTA0Y2RiZjViMjExMjFiODIxODUyOGRjZTU2NzUwNWQ0NTY3ZDdlNzJjZDQzYTQ2M2NkNTFjODAxM2E2In19fQ==
    - e1a741d3-2f40-441b-be41-733dec9fdb2b|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmM0MmI5NWVlMWE3OGIwOGI4ZjllN2FjZmVkZjMzYWQ2ZTRlY2QwODE5MTI1MThiYTk5ZjA0MWE3ZWYyMWYxYiJ9fX0=
    - 357d5532-3348-49fb-b547-338fb07c420e|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzZiMzViYTRjYTk2YzBjY2E4YzFmZTg2NDFiMWQ1NzBlOGMzZjY2Mjk4ZTBlNWQ3ZjMzYzEzMDQ2ZTU4NjM3MCJ9fX0=
    - 9c425d62-2cea-4747-b5bd-3139b7b72bdc|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjY3MGMzN2EyZjE3N2U4YWZlMjk2MjdhZGZiNjkyYmFiMzBiYTY3OTczNmNjY2NjODI2MTQ4OTg3ZjliY2YyNyJ9fX0=
    - ec53ef33-a115-405f-96e8-50fe1c86d8f6|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTcxOTFhYTkyMjNkNWE3MzM1MzQ0OWI1OWVlZmIyNjBhYWQzMTVjNzkxNTdkMjJlNTEwNDI0NTBlZDJlNzY5NiJ9fX0=
    - 881b3b65-6fdd-40e3-8526-1c9bc7f5fbe4|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNGViNDZiYmNhMzgxMjM2M2I1OTY3NmZmNjI5ZGMzNjk4MjU3ZmQxNzhkMzk0ZmFkZmZkYTcxNDM0MjJlMmYxMCJ9fX0=
  skins:
    - darklordsentis
    - kkyran
    - eyelesstenshi
    - dcaff95
    - Codespaces
    - Pumpkin000
    - jarvine
    - IlPescatoreHaton
    - Fvly
    - Cthulhu_Chan

#--------------------------------------------#
# command to create the npc
# that warps you around to active event areas
#--------------------------------------------#
hallow2021_npc_create:
  type: command
  name: create_hallownpc
  usage: /create_hallownpc
  description: "creates a halloween 2021 npc"
  debug: false
  permission: op
  script:
    - create villager friendly<&sp>ghost <player.location> save:npc
    - adjust <entry[npc].created_npc> set_entity_type:player
    - adjust <entry[npc].created_npc> skin:ALKRKY
    - adjust <entry[npc].created_npc> set_assignment:hallow2021_ass
    - adjust <entry[npc].created_npc> lookclose:true
    - narrate "New halloween npc has been created :)"

# the assignment script that gets given to the npc
hallow2021_ass:
  type: assignment
  debug: false
  actions:
    on click:
      - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
        - narrate "<&c>Seems like you no longer have access to halloween related npcs"
        - stop
      - if <player.is_sneaking>:
        - if <player.item_in_hand.script.name||err> == hallow2021_bucket_i:
          - define c <player.item_in_hand.flag[candy_storage]>
          - flag server hallow2021_topall.<player>:+:<[c]>
          - flag server hallow2021_topweek.<player>:+:<[c]>
          - flag server hallow2021_candies:+:<[c]>
          - inventory flag candy_storage:0 d:<player.inventory> slot:<player.held_item_slot>
          - define item <player.item_in_hand>
          - define slot <player.held_item_slot>
          - inject hallow2021_update_bucket
          - narrate "You deposited <[c]> candies into the server!"
          - stop
        - else:
          - define c <player.flag[stored_candy]||0>
          - flag server hallow2021_topall.<player>:+:<[c]>
          - flag server hallow2021_topweek.<player>:+:<[c]>
          - flag server hallow2021_candies:+:<[c]>
          - flag <player> stored_candy:0
          - narrate "You deposited <[c]> candies into the server!"
          - inject hallow2021_update_pl
          - stop
      - if <player.inventory.find_item[lens_oftruth]> == -1:
        - narrate "Take this for your travels!"
        - give lens_oftruth
      - inventory open d:hallow2021_info_inv

hallow2021_rab_ass:
  type: assignment
  debug: false
  actions:
    on click:
      - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
        - narrate "<&c>Seems like you no longer have access to halloween related npcs"
        - stop
      - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.after[hallow2021_]||null> != <server.flag[hallow2021_running_rabbits_warp]||none>:
        - stop
      - if !<player.has_passenger>:
        - narrate "My fo-. Uhh pet rabbits seem to have escaped." format:hallow2021_fm_format
        - wait 2s
        - narrate "You wouldn't mind catching some for me would you?" format:hallow2021_fm_format
        - wait 2s
        - narrate "I will reward you if you bring them back to me!" format:hallow2021_fm_format
        - actionbar "<&c>!!<&f> Right Click the rabbits to pick them up <&c>!!"
        - wait 1s
        - actionbar "<&c>!!<&f> Right Click the rabbits to pick them up <&c>!!"
        - wait 1s
        - actionbar "<&c>!!<&f> Right Click the rabbits to pick them up <&c>!!"
        - stop
      - if <player.passenger.script.name||null> != hallow2021_rab_e:
        - narrate "That doesn't look like a rabbit?" format:hallow2021_fm_format
        - wait 2s
        - narrate "How did it even get up there?" format:hallow2021_fm_format
        - wait 2s
        - narrate "Come back with one of my rabbits to get your reward!" format:hallow2021_fm_format
        - stop
      - flag <player> hallow2021_rabbit_return:++
      - narrate "Ohh that seems tas-. I uhh mean. There is my lost pet rabbit!" format:hallow2021_fm_format
      - wait 2s
      - remove <player.passenger>
      - wait 1s
      - narrate "Thank you so much for bringing him back to me. i honestly dont know why i would have ea-, uhm.. done if i lost him" format:hallow2021_fm_format
      - wait 3s
      - narrate "If you bring back more i will reward you again" format:hallow2021_fm_format
      - repeat <util.random.int[3].to[9]>:
        - spawn hallow2021_candy_e <player.location>
      - wait 5s
      - playsound sound:ENTITY_PLAYER_BURP pitch:0.7 <player>
      - narrate "ohm nom nom, that tastes good."

hallow2021_cs_ass:
  type: assignment
  debug: false
  actions:
    on click:
      - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
        - narrate "<&c>Seems like you no longer have access to halloween related npcs"
        - stop
      - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.after[hallow2021_]||null> != <server.flag[hallow2021_candy_sor_warp]||none>:
        - stop
      - if <player.has_flag[helped_ol_lady]>:
        - narrate "You have already helped me." format:hallow2021_ol_format
        - wait 2s
        - narrate "If you come back later i may have something else for you to sort" format:hallow2021_ol_format
        - stop
      - narrate "I've seem to make a mess of my chest." format:hallow2021_ol_format
      - wait 2s
      - narrate "Would you be so kind to sort things out for me?" format:hallow2021_ol_format
      - wait 3s
      - inventory open d:HALLOW2021_CS_INV

hallow2021_tot_ass:
  type: assignment
  debug: false
  actions:
    on click:
      - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
        - narrate "<&c>Seems like you no longer have access to halloween related npcs"
        - stop
      - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.after[hallow2021_]||null> != <server.flag[hallow2021_trick_treat_warp]||none>:
        - stop
      - ratelimit <player> 1s
      - if <player.has_flag[now_int_<npc>]>:
        - stop
      - flag <player> now_int_<npc>
      - if <player.has_flag[Interactedwith_<npc>]>:
        - if <player.flag[Interactedwith_<npc>]> > 6:
          - chat "Just because you keep bothering me" targets:<player>
          - wait 2s
          - chat "I have taken some candies from you!" targets:<player>
          - wait 1s
          - flag <player> stored_candy:-:20
          - inject hallow2021_update_pl
          - flag <player> now_int_<npc>:!
          - stop
        - chat "You already trick or treated with me" targets:<player>
        - wait 2s
        - chat "Go bother someone else!" targets:<player>
        - flag <player> Interactedwith_<npc>:++ expire:30m
        - flag <player> now_int_<npc>:!
        - stop
      - choose <list[Trick|Treat].random>:
        - case Trick:
          - chat "I think i will..." targets:<player>
          - wait 2s
          - chat "<&4>Trick you!" targets:<player>
          - repeat <util.random.int[1].to[3]>:
            - random:
              - spawn spectralcreep1 <npc.location> save:ent
              - spawn fire_bubble <npc.location> save:ent
              - spawn poison_bubble <npc.location> save:ent
              - spawn redead_walker <npc.location> save:ent
              - spawn water_bubble <npc.location> save:ent
              - spawn jumper <npc.location> save:ent
              - spawn floating_pumpkin <npc.location> save:ent
            - flag <entry[ent].spawned_entity> hallow2021_mob
          - flag <player> hallow2021_tricked:++
          - flag <player> Interactedwith_<npc>:++ expire:30m
          - flag <player> now_int_<npc>:!
        - case Treat:
          - chat "I think i will..." targets:<player>
          - wait 2s
          - chat "<&a>Treat you!" targets:<player>
          - repeat <util.random.int[3].to[6]>:
            - spawn hallow2021_candy_e <player.location>
          - flag <player> hallow2021_treated:++
          - flag <player> Interactedwith_<npc>:++ expire:30m
          - flag <player> now_int_<npc>:!

# the interaction feature of the inventory that opens
hallow2021_warp_world:
  type: world
  debug: false
  events:
    on player clicks player_head in hallow2021_warp_inv:
    - if <context.item.has_flag[warp]>:
      - execute as_player "warp <context.item.flag[warp]>"
      - inventory close
    on player clicks hallow2021_buy_basket in hallow2021_info_inv:
    - if <player.flag[stored_candy]||0> >= 500:
      - flag player stored_candy:-:500
      - give player hallow2021_bucket_i
      - narrate "<&d>You bought a candy bucket!"
      - narrate "<&d>Remaining candy: <&f><player.flag[stored_candy]||0>"
      - inject hallow2021_update_pl
    - else:
      - narrate "<&c>You do not have enough candies to buy a basket!"
      - narrate "<&c>You need <&f><element[500].sub[<player.flag[stored_candy]||0>]><&c> more!"
    on player clicks hallow2021_warps_i in hallow2021_info_inv:
    - inventory open d:hallow2021_warp_inv
    on player clicks written_book in hallow2021_info_inv:
    - adjust <player> show_book:hallow2021_info_book

# the inventory that opens when a player right clicks the npc
hallow2021_info_inv:
  type: inventory
  inventory: hopper
  title: <&f><&l>Friendly ghost
  debug: false
  gui: true
  slots:
  - [hallow2021_buy_basket] [] [hallow2021_warps_i] [] [hallow2021_info_book]

hallow2021_warp_inv:
  type: inventory
  inventory: chest
  title: <&color[#FF8000]><&l>Halloween <&0><&l>Warps
  size: 9
  gui: true
  procedural items:
    - define items <list>
    - define heads <script[hallow2021_warps_list].data_key[heads].random[9]>
    - foreach <server.flag[hallow2021_active_warps]> as:num:
      - define item <item[player_head[skull_skin=<[heads].get[<[loop_index]>]>]]>
      - define item "<[item].with[lore=<list[<&f>Warp to <&e><[num]>]>;display=<&e><[num].replace[_].with[ ]>]>"
      - define item <[item].with[flag=warp:<[num]>]>
      - define items <[items].include[<[item]>]>
    - determine <[items]>
  slots:
  - [] [] [] [] [] [] [] [] []

hallow2021_buy_basket:
  type: item
  material: paper
  display name: <&5>Buy <&e>Candy Bucket
  debug: false
  mechanisms:
    custom_model_data: 10600
  lore:
    - <&f>To buy this bucket
    - <&f>Click here when you have <&d>500 candy
    - <&f>in your player storage

hallow2021_warps_i:
  type: item
  material: player_head
  display name: <&d>Warps
  debug: false
  mechanisms:
    skull_skin: <script[hallow2021_warps_list].data_key[heads].random>
  lore:
    - <&f>Click here to go to the active warps list

hallow2021_info_book:
  type: book
  title: haunted info
  author: halloween
  debug: false
  signed: true
  text:
  - I am proud to announce this years halloween event.<p><&color[#FF8000]>Pages:<n><&click[2].type[change_page]>+<&gt> <&0><&l>Story<&end_click><n><&click[4].type[change_page]><&color[#FF8000]>+<&gt> <&0><&l>Info<&end_click><n><&click[15].type[change_page]><&color[#FF8000]>+<&gt> <&0><&l>Prizes<&end_click><p><&color[#FF8000]><&l>Happy <&0><&l>Halloween!
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Story<&end_click><p>The same forces that haunted kakariko last year came back! but now they are haunting multiple places at once! However these forces seem more friendly
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Story<&end_click><p>they only release deadly forces every so often. But they are giving out candy. Can you collect more candy then other players?
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>A friendly ghost has appeared through different warps. These ghosts show you what warps have active events in them.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>The more players collect candy together the more events are going to happen the same time. These events are randomized each day.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>So each day there are 5 random warps with 5 random events. Each small event is the same through all the warps.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>Go and explore the different events. Each event gives you candy, use this candy to climb the top 10 candy collecters
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>because the #1, #2 and #3 will recieve a special prize no one else will get.<p>Right click this ghost while sneaking to deposit candy<n>do the same with a candy bucket to deposit its candy
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>In total there currently are 9 different events.<n>In the next few pages i will explain to you what each event does, and what you need to do to get candy from it.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p><&l>Graveyard:<&r> is kakariko specific, Go into the graveyard and open containers<n><&l>Candy fishing:<&r> is limited to only the warps that contain water. Each time you catch something it becomes a(or more) candy instead.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p><&l>Raining candy:<&r> it rains candy within this warp, pick them up<p><&l>Sorting candy:<&r> speak to the very old lady in this warp to sort out her chest. she gives candy as a reward.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p><&l>Running rabbits:<&r> talk to the friendly monster within the warp<n><&l>Shoot the bats:<&r> shoot the bats that are flying around<n><&l>Trick or Treating:<&r> trick or treat by the different npcs standing around.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p><&l>Hiding candy:<&r> There are bundels full of candy hidden around this warp. Finders are keepers.<n><&l>Candy monsters:<&r> there are mobs spawning all over this warp, kill them to collect candy.
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Info<&end_click><p>You got a shard when talking with the ghost. This shard is used to see the ghoul rats<p>You can pick up rabbits if you right click them, and you can deliver them by sneaking next to the friendly monster
  - <&click[1].type[change_page]><&color[#FF8000]><&l>Halloween <&0><&l>Prizes<&end_click><p>There currently are no known prizes. But there sure will be some when it ends<n>This page will be updated when prizes are added!
#-----------------------------------------------#
# a command that makes it wayyy easier to set up
# all the different events in the different areas
#-----------------------------------------------#
hallow2021_setup_c:
  type: command
  name: hallowsetup
  usage: /hallowsetup
  debug: false
  description: sets up halloween areas
  permission: op
  tab completions:
    1: <script[hallow2021_warps_list].data_key[warps].include[graveyard]>
    2: area|candy_rain|candy_fish|candy_sort|running_rabbits|shoot_bats|trick_treat|candy_hiding|candy_mobs
  script:
    - if <context.args.first||err> not in <script[hallow2021_warps_list].data_key[warps]>:
      - choose <context.args.first||default>:
        - case graveyard:
          - define a <context.args.first||err>
          - choose <context.args.get[2]||default>:
            - case left:
              - define b <context.args.get[2]||err>
              - if <player.we_selection||null> == null:
                - narrate "<&c>You need to have the area selected!"
                - stop
              - if !<server.has_flag[hallow2021_<[a]>]>:
                - flag server hallow2021_<[a]>:<player.we_selection>
              - else:
                - flag server hallow2021_<[a]>:<server.flag[hallow2021_<[a]>].add_member[<player.we_selection>]>
              - note <server.flag[hallow2021_<[a]>]> as:hallow2021_<[a]>
              - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
              - stop
            - case middle:
              - define b <context.args.get[2]||err>
              - if <player.we_selection||null> == null:
                - narrate "<&c>You need to have the area selected!"
                - stop
              - if !<server.has_flag[hallow2021_<[a]>]>:
                - flag server hallow2021_<[a]>:<player.we_selection>
              - else:
                - flag server hallow2021_<[a]>:<server.flag[hallow2021_<[a]>].add_member[<player.we_selection>]>
              - note <server.flag[hallow2021_<[a]>]> as:hallow2021_<[a]>
              - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
              - stop
            - case right:
              - define b <context.args.get[2]||err>
              - if <player.we_selection||null> == null:
                - narrate "<&c>You need to have the area selected!"
                - stop
              - if !<server.has_flag[hallow2021_<[a]>]>:
                - flag server hallow2021_<[a]>:<player.we_selection>
              - else:
                - flag server hallow2021_<[a]>:<server.flag[hallow2021_<[a]>].add_member[<player.we_selection>]>
              - note <server.flag[hallow2021_<[a]>]> as:hallow2021_<[a]>
              - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
              - stop
            - case lava_spawn:
              - define b <context.args.get[2]>
              - flag server hallow2021_<[a]>_<[b]>:<player.location>
              - narrate "<[b]> has been setup in <[a]> at <&a><player.location>"
              - stop
            - case lava_cub:
              - define b <context.args.get[2]||err>
              - if <player.we_selection||null> == null:
                - narrate "<&c>You need to have the area selected!"
                - stop
              - note <player.we_selection> as:lava_hallow
              - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
              - stop
            - default:
              - narrate "You need to specify (left/middle/right/lava_spawn/lava_cub) as your second arg"
              - stop
        - default:
          - narrate "<&c>that doesn't seem to be a valid warp"
          - stop
    - define a <context.args.first||err>
    - define b <context.args.get[2]||err>
    - choose <context.args.get[2]>:
      # set up the entire area.
      # allows it to show a sidebar with current event
      - case area:
        - if <player.we_selection||null> == null:
          - narrate "<&c>You need to have the area selected!"
          - stop
        - flag server hallow2021_<[a]>_<[b]>:<player.we_selection>
        - note <player.we_selection> as:hallow2021_<[a]>
        - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
      # select an area up higher where items spawn
      # those rain down on the players
      - case candy_rain:
        - if <player.we_selection||null> == null:
          - narrate "<&c>You need to have the area selected!"
          - stop
        - flag server hallow2021_<[a]>_<[b]>:<player.we_selection>
        - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
      # the water in which the player can fish
      # could be same as area this is just extra
      # protection against any breakage
      - case candy_fish:
        - if <player.we_selection||null> == null:
          - narrate "<&c>You need to have the area selected!"
          - stop
        - flag server hallow2021_<[a]>_<[b]>:<player.we_selection>
        - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
      # set the location the candy sort lady will spawn
      # this can only be interacted with if the event is
      # active in that warp
      - case candy_sort:
        - create villager very<&sp>old<&sp>lady <player.location> save:npc
        - adjust <entry[npc].created_npc> set_entity_type:player
        - adjust <entry[npc].created_npc> skin:Skeleton
        - adjust <entry[npc].created_npc> name_visible:hover
        - adjust <entry[npc].created_npc> set_assignment:hallow2021_cs_ass
        - adjust <entry[npc].created_npc> lookclose:true
        - narrate "<[b]> has been setup in <[a]> at <&a><player.location.center.simple>"
      # running rabbits has a third arg
      - case running_rabbits:
        - choose <context.args.get[3]>:
          # these will be set multiple so the rabbits spawn in seemingly random locations
          # all while they will not get stuck because the location is still player picked
          - case spawns:
            - if <player.we_selection||null> == null:
              - narrate "<&c>You need to have the area selected!"
              - stop
            - flag server hallow2021_<[a]>_<[b]>_spawns:<player.we_selection>
            - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
          # the location where the player has to stand if they return the rabbit
          - case return:
            - create villager friendly<&sp>monster <player.location> save:npc
            - adjust <entry[npc].created_npc> set_entity_type:player
            - adjust <entry[npc].created_npc> skin:dgates3757
            - adjust <entry[npc].created_npc> name_visible:hover
            - adjust <entry[npc].created_npc> set_assignment:hallow2021_rab_ass
            - adjust <entry[npc].created_npc> lookclose:true
            - narrate "<[b]> has been setup in <[a]> at <&a><player.location.center.simple>"
          - default:
            - narrate "<&c>running_rabbits needs a spawns/return arg!"
            - stop
      # somewhere in the sky where bats are able to spawn,
      # yet close enough so players can see and shoot them
      - case shoot_bats:
        - if <player.we_selection||null> == null:
          - narrate "<&c>You need to have the area selected!"
          - stop
        - flag server hallow2021_<[a]>_<[b]>:<player.we_selection>
        - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
      # spawns a random "trick or treat" npc at the players location
      # these only trick or treat if the event is active
      - case trick_treat:
        - create villager tot <player.location> save:npc
        - adjust <entry[npc].created_npc> set_entity_type:player
        - adjust <entry[npc].created_npc> skin:<script[hallow2021_warps_list].data_key[skins].random>
        - adjust <entry[npc].created_npc> name:<yaml[r-names].read[names].random>
        - adjust <entry[npc].created_npc> name_visible:false
        - adjust <entry[npc].created_npc> set_assignment:hallow2021_tot_ass
        - adjust <entry[npc].created_npc> lookclose:true
        - narrate "<[b]> has been setup in <[a]> at <&a><player.location.center.simple>"
      # this should be used is hiding spots but a few in plain sight
      # locations will be chosen randomly during the event
      - case candy_hiding:
        - flag server hallow2021_<[a]>_<[b]>:->:<player.location.center>
        - narrate "<[b]> has been setup in <[a]> at <&a><player.location.center.simple>"
      # select the area you want the mobs to spawn in
      # should not go outside of the map
      - case candy_mobs:
        - if <player.we_selection||null> == null:
          - narrate "<&c>You need to have the area selected!"
          - stop
        - flag server hallow2021_<[a]>_<[b]>:<player.we_selection>
        - narrate "<[b]> has been setup in <[a]> at <&a><player.we_selection.max.simple> / <player.we_selection.min.simple>"
      - default:
        - narrate "<&c>Something went wrong with your second arch. Are you sure it is correct?"

sel_boat_inv:
  type: inventory
  inventory: chest
  debug: false
  size: 9
  title: Choose a Boat
  gui: true
  slots:
    - [] [oak_boat] [spruce_boat] [birch_boat] [] [jungle_boat] [acacia_boat] [dark_oak_boat] []

#---------------------------------#
# events regarding automazation of events
# such as daily changing the events
# and respawning mobs/items
#---------------------------------#
hallow2021_sevents_w:
  type: world
  debug: false
  events:
    # changes the events around daily
    on system time hourly every:24:
    - flag server hallow2021_topweek:!
    - run hallow2021_se_task
    # Hiding candy spots
    on system time minutely every:5:
    - if <server.has_flag[hallow2021_candy_hiding_warp]>:
      - run hallow2021_hc_task
    # mob respawn
    # bat respawn
    # item respawn
    on system time secondly every:10:
    - if <server.has_flag[hallow2021_candy_mobs_warp]>:
      - run hallow2021_mr_task
    - if <server.has_flag[hallow2021_shoot_bats_warp]>:
      - run hallow2021_br_task
    - if <server.has_flag[hallow2021_candy_rain_warp]>:
      - run hallow2021_ir_task
    - if <server.has_flag[hallow2021_running_rabbits_warp]>:
      - run hallow2021_rr_task
    on vehicle damaged:
    - if <context.vehicle.has_flag[despawn_boat]>:
      - determine cancelled
    on vehicle destroyed:
    - if <context.vehicle.has_flag[despawn_boat]>:
      - determine cancelled
    on player exits vehicle:
    - if <context.vehicle.has_flag[despawn_boat]>:
      - wait 10s
      - if !<context.vehicle.passengers.is_empty||false>:
        - stop
      - if !<context.vehicle.is_spawned>:
        - stop
      - remove <context.vehicle>
    on player right clicks barrel location_flagged:boat_barrel:
    - determine passively cancelled
    - if <player.has_flag[got_boat]>:
      - narrate "<&c>Seems like you already got a boat recently"
      - stop
    - inventory open d:sel_boat_inv
    on player clicks in sel_boat_inv:
    - if <context.clicked_inventory||null> != <context.inventory>:
      - stop
    - choose <context.item.material.name>:
      - case oak_boat:
        - define typ generic
      - case spruce_boat:
        - define typ redwood
      - case birch_boat:
        - define typ birch
      - case jungle_boat:
        - define typ jungle
      - case acacia_boat:
        - define typ acacia
      - case dark_oak_wood:
        - define typ dark_oak
      - default:
        - stop
    - spawn boat[boat_type=<[typ]>] <server.flag[hallow2021_boat_spawn]> save:boat
    - flag <player> got_boat:3m
    - inventory close
    - flag <entry[boat].spawned_entity> despawn_boat
    on player damaged:
    - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].is_empty>:
      - stop
    - if <context.damager||null> == null:
      - stop
    - if <player.health.sub[<context.damage>]> <= 0:
      - determine 50
    - determine passively cancelled
    - hurt <context.damage> <player> cause:VOID source:<context.damager>
    on system time secondly:
    - define pl <server.online_players.filter[location.cuboids.parse[note_name].contains[hallow2021_graveyard]].exclude[<server.online_players_flagged[hallow_debug]>]>
    - cast blindness duration:3s <[pl]> no_ambient hide_particles no_icon
    on hanging breaks:
    - if !<player.location.cuboids.filter[note_name.starts_with[hallow2021_]].is_empty>:
      - determine passively cancelled
    on player breaks farmland priority:2:
    - if !<player.location.cuboids.filter[note_name.starts_with[hallow2021_]].is_empty>:
      - determine passively cancelled
    after player breaks farmland with:hallow2021_old_shov in:hallow2021_graveyard priority:1:
    - if <player.has_flag[hallow2021_dug_<context.location>]>:
      - determine cancelled
    - determine cancelled passively
    - flag player hallow2021_dug_<context.location> expire:20m
    - flag player hallow2021_dug_<context.location.add[1,0,0]> expire:20m
    - flag player hallow2021_dug_<context.location.add[0,0,1]> expire:20m
    - flag player hallow2021_dug_<context.location.add[1,0,1]> expire:20m
    - flag player hallow2021_dug_<context.location.add[-1,0,0]> expire:20m
    - flag player hallow2021_dug_<context.location.add[-1,0,1]> expire:20m
    - flag player hallow2021_dug_<context.location.add[0,0,-1]> expire:20m
    - flag player hallow2021_dug_<context.location.add[1,0,-1]> expire:20m
    - flag player hallow2021_dug_<context.location.add[-1,0,-1]> expire:20m
    - if <util.random.int[1].to[2]> == 1:
      - stop
    - flag <player> hallow2021_graves_dug:++
    - run hallow2021_candy_geyser def:<context.location.center>|2|5|3s|0.5s|up|candy
    on player opens inventory in:hallow2021_graveyard:
    - if <context.inventory.inventory_type> != CHEST && <context.inventory.inventory_type> != BARREL:
      - narrate stop
      - stop
    - if !<player.has_flag[gottem_shov]>:
      - inventory set d:<context.inventory> o:hallow2021_old_shov slot:14
      - stop
    - if <player.has_flag[hallow2021_opened_<context.inventory.location>]>:
      - stop
    #- inventory clear d:<context.inventory>
    - flag <player> hallow2021_opened_<context.inventory.location> expire:5m
    - if <util.random.int[1].to[2]> == 1:
      - stop
    - define amt <util.random.int[2].to[4]>
    - define s <context.inventory.size>
    - repeat <[amt]>:
      - define slots:->:<util.random.int[1].to[<[s]>]>
    - foreach <[slots]> as:slot:
      - inventory set d:<context.inventory> o:hallow2021_candy_i[quantity=<util.random.int[1].to[3]>] slot:<[slot]>
    after player closes inventory:
      - if !<player.has_flag[gottem_shov]>:
        - if <player.inventory.contains_item[hallow2021_old_shov]>:
          - flag <player> gottem_shov
    on player fishes while caught_fish:
    - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.after[hallow2021_]||null> != <server.flag[hallow2021_fish_warp]||none>:
      - stop
    - flag <player> hallow2021_candy_caught:++
    - determine caught:hallow2021_candy_i[quantity=<util.random.int[3].to[8]>]
    on system time secondly every:3:
    - define pl <server.online_players.filter[location.cuboids.first.note_name.starts_with[hallow2021_]]>
    - define opl <server.online_players.filter[sidebar_title.is[==].to[<&d><&l>Halloween]]>
    - define npl <[opl].exclude[<[pl]>]>
    - if !<[npl].is_empty>:
      - foreach <[npl]>:
        - sidebar remove players:<[value]>
    - foreach <[pl]> as:player:
      - if <[player].location.cuboids.filter[note_name.starts_with[hallow2021_]].is_empty>:
        - foreach next
      - define area <[player].location.cuboids.filter[note_name.starts_with[hallow2021_]].first.note_name.after[hallow2021_]>
      - define ev <server.flag[hallow2021_<[area]>_event]||nothing>
      - choose <[ev]>:
        - case haunted_mansion:
          - define ev "Haunted Mansion"
        - case big_phantom:
          - define ev "Boss Battle"
        - case ghost_ship:si
          - define ev "Ghost Ship"
        - case witch_house:
          - define ev "Witches house"
        - case graveyard:
          - define ev Graveyard
        - case candy_fish:
          - define ev "Candy Fishing"
        - case candy_rain:
          - define ev "Raining Candy"
        - case candy_sor:
          - define ev "Candy Sorting"
        - case running_rabbits:
          - define ev "Running Rabbits"
        - case shoot_bats:
          - define ev "Shooting Bats"
        - case trick_treat:
          - define ev "Trick or Treating"
        - case candy_hiding:
          - define ev "Candy Hiding"
        - case candy_mobs:
          - define ev "Candy Monsters"
        - default:
          - define ev "No Event Currently"
      - define text:!
      - define values:!
      - define "text:->: <&7>Current warp:"
      - define "text:->: <&e><[area].replace[_].with[ ]>"
      - define "text:->: <&7>Current event:"
      - define "text:->: <&e><[ev]>"
      - define "text:->: <&f>"
      - define "text:->: <&7>Personal candy storage:"
      - define "text:->: <&d><[player].flag[stored_candy]||0>/1000"
      - define "text:->: <&7>Total server candies"
      - define "text:->: <&d><server.flag[hallow2021_candies]||0>"
      - define sep <&7>+<empty.pad_right[<[text].parse[text_width].highest.div[8].round_down>].with[-]>+
      - define values:->:<[sep]>
      - define values:|:<[text]>
      - define values:->:<&f><[sep]>
      - sidebar set title:<&d><&l>Halloween values:<[values]> players:<[player]>
    on player enters cuboid priority:2:
    - if !<context.area.note_name.starts_with[hallow2021_]||false>:
      - stop
    - if <context.area.note_name> == hallow2021_graveyard:
      - stop
    - define area <context.area.note_name.after[hallow2021_]>
    - define ev <server.flag[hallow2021_<[area]>_event]||nothing>
    - choose <[ev]>:
      - case haunted_mansion:
        - define ev "Haunted Mansion"
      - case big_phantom:
        - define ev "Boss Battle"
      - case ghost_ship:
        - define ev "Ghost Ship"
      - case witch_house:
        - define ev "Witches house"
      - case graveyard:
        - define ev Graveyard
      - case candy_fish:
        - define ev "Candy Fishing"
      - case candy_rain:
        - define ev "Raining Candy"
      - case candy_sor:
        - define ev "Candy Sorting"
      - case running_rabbits:
        - define ev "Running Rabbits"
      - case shoot_bats:
        - define ev "Shooting Bats"
      - case trick_treat:
        - define ev "Trick or Treating"
      - case candy_hiding:
        - define ev "Candy Hiding"
      - case candy_mobs:
        - define ev "Candy Monsters"
      - default:
        - define ev "No Event Currently"
    - define "text:->: <&7>Current warp:"
    - define "text:->: <&e><[area].replace[_].with[ ]>"
    - define "text:->: <&7>Current event:"
    - define "text:->: <&e><[ev]>"
    - define "text:->: <&f>"
    - define "text:->: <&7>Personal candy storage:"
    - define "text:->: <&d><player.flag[stored_candy]||0>/1000"
    - define "text:->: <&7>Total server candies"
    - define "text:->: <&d><server.flag[hallow2021_candies]||0>"
    - define sep <&7>+<empty.pad_right[<[text].parse[text_width].highest.div[8].round_down>].with[-]>+
    - define values:->:<[sep]>
    - define values:|:<[text]>
    - define values:->:<&f><[sep]>
    - sidebar set title:<&d><&l>Halloween values:<[values]> players:<player>
    on player exits cuboid priority:1:
    - if !<context.area.note_name.starts_with[hallow2021_]||false>:
      - stop
    - if <context.area.note_name> == hallow2021_graveyard:
      - stop
    - sidebar remove players:<player>

# changing the events daily task
hallow2021_se_task:
  type: task
  debug: false
  script:
    - define ex_warps:!
    - define amt <server.flag[hallow2021_candies].div[200000].round_up||1>
    - define bevent <script[hallow2021_warps_list].data_key[events].keys.get[1].to[<[amt]>].random>
    - define big_warp <script[hallow2021_warps_list].data_key[events].get[<[bevent]>].first>
    - define ex_warps:->:<[big_warp]>
    - define fish_warp <script[hallow2021_warps_list].data_key[sevents].get[candy_fish].exclude[<[ex_warps]>].random>
    - define ex_warps:->:<[fish_warp]>
    - define events <script[hallow2021_warps_list].data_key[sevents].get[other_events].random[<[amt].add[2]>]>
    - foreach <[events]> as:e:
      - define <[e]>_warp <script[hallow2021_warps_list].data_key[warps].exclude[<[ex_warps]>].random>
      - define ex_warps:->:<[<[e]>_warp]>
    - foreach <script[hallow2021_warps_list].data_key[warps]> as:w:
      - flag server hallow2021_<[w]>_event:!
    - flag server hallow2021_active_warps:<[ex_warps]>
    - flag server hallow2021_big_event:<[bevent]>
    - flag server hallow2021_big_warp:<[big_warp]>
    - flag server hallow2021_fish_warp:<[fish_warp]>
    - flag server hallow2021_<[fish_warp]>_event:candy_fish
    - flag server hallow2021_<[big_warp]>_event:<[bevent]>
    - foreach <script[hallow2021_warps_list].data_key[sevents].get[other_events]> as:v:
      - if <[v]> in <[events]>:
        - flag server hallow2021_<[v]>_warp:<[<[v]>_warp]>
        - flag server hallow2021_<[<[v]>_warp]>_event:<[v]>
      - else:
        - flag server hallow2021_<[v]>_warp:!
hallow2021_randome_world:
  type: world
  debug: false
  events:
    on player enters lava_hallow:
    - if <player.has_flag[falling]>:
      - teleport <player> <player.flag[falling]>
      - flag player falling:!
      - cast jump amplifier:30 duration:0.3s no_icon
    on delta time secondly every:30:
    - if <server.online_players.is_empty>:
      - stop
    - define pl <server.online_players.filter[location.cuboids.parse[note_name].contains[hallow2021_graveyard]]>
    - foreach <[pl]> as:player:
      - flag <[player]> hallow_random:++
      - if <[player].flag[hallow_random]> >= <util.random.int[4].to[6]>:
        - flag <[player]> hallow_random:!
        - random:
          - repeat 1:
            - cast <[player]> blindness duration:5s no_icon
            - cast <[player]> speed duration:5s amplifier:-10 no_icon
            - cast <[player]> jump duration:5s amplifier:-10 no_icon
            - spawn zombie[has_ai=false;invulnerable=true] <[player].location.forward_flat[5].with_yaw[<[player].location.yaw.add[180]>]> save:zomb
            - wait 0.8s
            - remove <entry[zomb].spawned_entity>
            - spawn zombie[has_ai=false;invulnerable=true] <[player].location.forward_flat[4].with_yaw[<[player].location.yaw.add[180]>]> save:zomb
            - wait 0.8s
            - remove <entry[zomb].spawned_entity>
            - spawn zombie[has_ai=false;invulnerable=true] <[player].location.forward_flat[3].with_yaw[<[player].location.yaw.add[180]>]> save:zomb
            - wait 0.8s
            - remove <entry[zomb].spawned_entity>
            - spawn zombie[has_ai=false;invulnerable=true] <[player].location.forward_flat[2].with_yaw[<[player].location.yaw.add[180]>]> save:zomb
            - wait 0.6s
            - playsound sound:entity_lightning_bolt_thunder <[player]> volume:10 pitch:1
            - strike no_damage <[player].location.forward_flat[2]>
            - remove <entry[zomb].spawned_entity>
          - repeat 1:
            - flag <[player]> falling:<[player].location>
            - cast <[player]> slow_falling amplifier:10 duration:1s no_icon
            - cast <[player]> blindness remove
            - teleport <[player]> <server.flag[hallow2021_graveyard_lava_spawn]>
          - playsound sound:entity_wolf_howl <[player]> pitch:2 volume:4
          - playsound sound:entity_zombie_horse_death <[player]> pitch:1.4 volume:4
          - repeat 1:
            - spawn ghost_vex <[player].location> target:<[player]> save:vex
            - spawn ghost_armor <[player].location> save:armor
            - flag server ghost:->:<entry[vex].spawned_entity>
            - flag <entry[vex].spawned_entity> link:<entry[armor].spawned_entity>
            - flag <entry[armor].spawned_entity> link:<entry[vex].spawned_entity>
            - attach <entry[armor].spawned_entity> to:<entry[vex].spawned_entity>
            - wait 1m
            - flag server ghost:<-:<entry[vex].spawned_entity>
            - remove <entry[vex].spawned_entity>|<entry[armor].spawned_entity>

hallow2021_i_categories:
  type: data
  debug: false
  weapons:
    - bow
    - trident
    - wooden_sword
    - stone_sword
    - iron_sword
    - golden_sword
    - diamond_sword
    - netherite_sword
    - crossbow
  armor:
    - elytra
    - turtle_helmet
    - leather_helmet
    - leather_chestplate
    - leather_leggings
    - leather_boots
    - chainmail_helmet
    - chainmail_chestplate
    - chainmail_leggings
    - chainmail_boots
    - iron_helmet
    - iron_chestplate
    - iron_leggings
    - iron_boots
    - golden_helmet
    - golden_chestplate
    - golden_leggings
    - golden_boots
    - diamond_helmet
    - diamond_chestplate
    - diamond_leggings
    - diamond_boots
    - netherite_helmet
    - netherite_chestplate
    - netherite_leggings
    - netherite_boots
  tools:
    - compass
    - flint_and_steel
    - shears
    - spyglass
    - wooden_shovel
    - wooden_pickaxe
    - wooden_axe
    - wooden_hoe
    - stone_shovel
    - stone_pickaxe
    - stone_axe
    - stone_hoe
    - golden_shovel
    - golden_pickaxe
    - golden_axe
    - golden_hoe
    - iron_shovel
    - iron_pickaxe
    - iron_axe
    - iron_hoe
    - diamond_shovel
    - diamond_pickaxe
    - diamond_axe
    - diamond_hoe
    - netherite_shovel
    - netherite_pickaxe
    - netherite_axe
    - netherite_hoe
  glass:
    - black_stained_glass
    - white_stained_glass
    - brown_stained_glass
    - light_gray_stained_glass
    - gray_stained_glass
    - red_stained_glass
    - pink_stained_glass
    - orange_stained_glass
    - yellow_stained_glass
    - lime_stained_glass
    - green_stained_glass
    - magenta_stained_glass
    - purple_stained_glass
    - blue_stained_glass
    - light_blue_stained_glass
    - cyan_stained_glass
    - glass
    - black_stained_glass_pane
    - white_stained_glass_pane
    - brown_stained_glass_pane
    - light_gray_stained_glass_pane
    - gray_stained_glass_pane
    - red_stained_glass_pane
    - pink_stained_glass_pane
    - orange_stained_glass_pane
    - yellow_stained_glass_pane
    - lime_stained_glass_pane
    - green_stained_glass_pane
    - magenta_stained_glass_pane
    - purple_stained_glass_pane
    - blue_stained_glass_pane
    - light_blue_stained_glass_pane
    - cyan_stained_glass_pane
    - glass_pane
  wools:
    - white_wool
    - black_wool
    - red_wool
    - orange_wool
    - blue_wool
    - cyan_wool
    - light_blue_wool
    - purple_wool
    - magenta_wool
    - green_wool
    - lime_wool
    - yellow_wool
    - pink_wool
    - gray_wool
    - light_gray_wool
    - brown_wool
    - black_wool
  food:
    - apple
    - mushroom_stew
    - carrot
    - cooked_cod
    - baked_potato
    - cooked_porkchop
    - cooked_chicken
    - cooked_beef
    - cooked_rabbit
    - cooked_mutton
    - cooked_salmon
    - sweet_berries
    - honey_bottle
    - melon
    - pumpkin
    - bread
  buckets:
    - bucket
    - water_bucket
    - lava_bucket
    - powder_snow_bucket
    - milk_bucket
    - pufferfish_bucket
    - salmon_bucket
    - cod_bucket
    - tropical_fish_bucket
    - axolotl_bucket
  redstone:
    - daylight_detector
    - lectern
    - observer
    - redstone
    - piston
    - sticky_piston
    - repeater
    - hopper
    - redstone_lamp
    - tripwire_hook
    - note_block
    - comparator
    - dispenser
    - dropper
  ores:
    - coal
    - charcoal
    - diamond
    - emerald
    - lapis_lazuli
    - quartz
    - amethyst_shard
    - raw_iron
    - raw_copper
    - raw_gold
    - netherite_scrap

hallow2021_cs_inv:
  type: inventory
  inventory: chest
  size: 54
  debug: false
  title: old lady
  procedural items:
    - define items <list>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[weapons].random[5].parse_tag[<item[<[parse_value]>].with[flag=weapons]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[armor].random[5].parse_tag[<item[<[parse_value]>].with[flag=armor]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[tools].random[5].parse_tag[<item[<[parse_value]>].with[flag=tools]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[glass].random[5].parse_tag[<item[<[parse_value]>].with[flag=glass]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[wools].random[5].parse_tag[<item[<[parse_value]>].with[flag=wools]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[food].random[5].parse_tag[<item[<[parse_value]>].with[flag=food]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[buckets].random[5].parse_tag[<item[<[parse_value]>].with[flag=buckets]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[redstone].random[5].parse_tag[<item[<[parse_value]>].with[flag=redstone]>]>]>
    - define items <[items].include[<script[hallow2021_i_categories].data_key[ores].random[4].parse_tag[<item[<[parse_value]>].with[flag=ores]>]>]>
    - define items <[items].random[44]>
    - determine <[items]>
  slots:
  - [hallow2021_Weapon] [hallow2021_Armor] [hallow2021_Tool] [hallow2021_Glass] [hallow2021_Wool] [hallow2021_Food] [hallow2021_Bucket] [hallow2021_Redstone] [hallow2021_Ore]
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] [hallow2021_Confirm]

hallow2021_csinv_e:
  type: world
  debug: false
  events:
    on player drags in hallow2021_cs_inv:
    - if <context.clicked_inventory.script.name> != hallow2021_cs_inv:
      - determine cancelled
    on player clicks in hallow2021_cs_inv:
    - if <context.clicked_inventory.script.name> != hallow2021_cs_inv:
      - determine cancelled
    - if <context.click.contains_any[shift|NUMBER_KEY|double|drop|swap|right]>:
      - determine cancelled
    - if <context.clicked_inventory||nothing> != <player.open_inventory>:
      - determine passively cancelled
      - wait 2t
      - inventory update
    - if <context.item.script.name.starts_with[hallow2021_]||false>:
      - determine passively cancelled
      - wait 2t
      - inventory update
      - if <context.item.script.name> == hallow2021_Confirm:
        - adjust <player> item_on_cursor:air
        - if <context.inventory.slot[10|19|28|37|46].parse[has_flag[weapons]].contains[false]> || <context.inventory.slot[11|20|29|38|47].parse[has_flag[armor]].contains[false]>:
          - narrate "This wasn't sorted properly!" format:hallow2021_ol_format
          - inventory close
          - stop
        - if <context.inventory.slot[12|21|30|39|48].parse[has_flag[tools]].contains[false]> || <context.inventory.slot[13|22|31|40|49].parse[has_flag[glass]].contains[false]>:
          - narrate "This wasn't sorted properly!" format:hallow2021_ol_format
          - inventory close
          - stop
        - if <context.inventory.slot[14|23|32|41|50].parse[has_flag[wools]].contains[false]> || <context.inventory.slot[15|24|33|42|51].parse[has_flag[food]].contains[false]>:
          - narrate "This wasn't sorted properly!" format:hallow2021_ol_format
          - inventory close
          - stop
        - if <context.inventory.slot[16|25|34|43|52].parse[has_flag[buckets]].contains[false]> || <context.inventory.slot[17|26|35|44|53].parse[has_flag[redstone]].contains[false]>:
          - narrate "This wasn't sorted properly!" format:hallow2021_ol_format
          - inventory close
          - stop
        - if <context.inventory.slot[18|27|36|45].parse[has_flag[ores]].contains[false]>:
          - narrate "This wasn't sorted properly!" format:hallow2021_ol_format
          - inventory close
          - stop
        - narrate "everything was sorted properly!" format:hallow2021_ol_format
        - narrate "Here have some candy" format:hallow2021_ol_format
        - flag <player> hallow2021_candy_sorted:++
        - flag <player> helped_ol_lady expire:1h
        - repeat <util.random.int[30].to[45]>:
          - spawn hallow2021_candy_e <player.location>
        - inventory close

hallow2021_ol_format:
  type: format
  format: <&f>Old <&7>Lady <&8><&chr[BB]> <&f><text>

hallow2021_fm_format:
  type: format
  format: <&color[#6F5901]>Friendly <&color[#957802]>Monster <&7><&chr[BB]> <&f><text>

hallow2021_Weapon:
  type: item
  material: iron_sword
  display name: <&e>Weapons
  lore:
  - <&f>Place all weapons below

hallow2021_Armor:
  type: item
  material: leather_helmet
  display name: <&a>Armor
  lore:
  - <&f>Place all armor below

hallow2021_Tool:
  type: item
  material: iron_hoe
  display name: <&b>Tools
  lore:
  - <&f>Place all tools below

hallow2021_Glass:
  type: item
  material: glass
  display name: <&d>Glass
  lore:
  - <&f>Place all glass below

hallow2021_Wool:
  type: item
  material: white_wool
  display name: <&5>Wools
  lore:
  - <&f>Place all wools below

hallow2021_Food:
  type: item
  material: bread
  display name: <&2>Food
  lore:
  - <&f>Place all food below

hallow2021_Bucket:
  type: item
  material: bucket
  display name: <&7>Buckets
  lore:
  - <&f>Place all buckets below

hallow2021_Redstone:
  type: item
  material: redstone
  display name: <&c>Redstone
  lore:
  - <&f>Place all redstone componements below

hallow2021_Ore:
  type: item
  material: raw_copper
  display name: <&8>Ores
  lore:
  - <&f>Place all ores below

hallow2021_confirm:
  type: item
  material: lime_concrete
  display name: <&a>Confirm!
  lore:
  - <&f>Click this once you have sorted
  - <&f>all items

# randomly hiding the candy task
hallow2021_hc_task:
  type: task
  debug: false
  script:
    - define locs <server.flag[hallow2021_<server.flag[hallow2021_candy_hiding_warp]>_candy_hiding].random[3]>
    - foreach <[locs]> as:loc:
      - if !<[loc].chunk.is_loaded>:
        - foreach next
      - spawn hallow2021_hidden_candy_e <[loc]> save:ent
      - flag <entry[ent].spawned_entity> has_candy:<util.random.int[30].to[45]>

# checking how many mobs are left
# spawning new ones if there are less then x amount
hallow2021_mr_task:
  type: task
  debug: false
  script:
    - define cub <server.flag[hallow2021_<server.flag[hallow2021_candy_mobs_warp]>_candy_mobs]>
    - define area <server.flag[hallow2021_<server.flag[hallow2021_candy_mobs_warp]>_area]>
    - define ents <[area].entities.filter[has_flag[hallow2021_mob]]>
    - if <[ents].size> > 30:
      - foreach <[ents]> as:enti:
        - if <[enti].is_spawned>:
          - remove <[enti]>
    - foreach <[area].entities.filter[has_flag[hallow2021_mob]]> as:e:
      - if <[e].time_lived.in_seconds||0> >= 240:
        - remove <[e]>
    - if <[area].players.is_empty>:
      - stop
    - repeat <element[15].sub[<[ents].size>]||0>:
      - define num <[cub].spawnable_blocks.random>
      - if !<[num].chunk.is_loaded>:
        - stop
      - random:
        - spawn spectralcreep1 <[num]> save:ent
        - spawn ghoul_rat <[num]> save:ent
        - spawn fire_bubble <[num]> save:ent
        - spawn poison_bubble <[num]> save:ent
        - spawn redead_walker <[num]> save:ent
        - spawn water_bubble <[num]> save:ent
        - spawn jumper <[num]> save:ent
        - spawn floating_pumpkin <[num]> save:ent
      - flag <entry[ent].spawned_entity> hallow2021_mob

# checking how many bats are left
# spawning new ones if there are less then x amount
hallow2021_br_task:
  type: task
  debug: false
  script:
    - define cub <server.flag[hallow2021_<server.flag[hallow2021_shoot_bats_warp]>_shoot_bats]>
    - define area <server.flag[hallow2021_<server.flag[hallow2021_shoot_bats_warp]>_area]>
    - define ents <[area].entities.filter[has_flag[hallow2021_bat]]>
    - if <[ents].size> > 30:
      - foreach <[ents]> as:enti:
        - if <[enti].is_spawned>:
          - remove <[enti]>
    - foreach <[area].entities.filter[has_flag[hallow2021_bat]]> as:e:
      - if <[e].time_lived.in_seconds||0> >= 120:
        - remove <[e]>
    - if <[area].players.is_empty>:
      - stop
    - repeat <element[15].sub[<[ents].size>]||0>:
      - define num <[cub].spawnable_blocks.random.above>
      - if !<[num].chunk.is_loaded>:
        - stop
      - spawn hallow2021_bat <[num]> save:ent
      - flag <entry[ent].spawned_entity> hallow2021_bat

hallow2021_rr_task:
  type: task
  debug: false
  script:
    - define cub <server.flag[hallow2021_<server.flag[hallow2021_running_rabbits_warp]>_running_rabbits_spawns]>
    - define area <server.flag[hallow2021_<server.flag[hallow2021_running_rabbits_warp]>_area]>
    - define ents <[area].entities.filter[has_flag[hallow2021_rab]]>
    - if <[ents].size> > 30:
      - foreach <[ents]> as:enti:
        - if <[enti].is_spawned>:
          - remove <[enti]>
    - foreach <[area].entities.filter[has_flag[hallow2021_rab]]> as:e:
      - if <[e].time_lived.in_seconds||0> >= 120:
        - remove <[e]>
    - if <[area].players.is_empty>:
      - stop
    - repeat <element[15].sub[<[ents].size>]||0>:
      - define num <[cub].spawnable_blocks.random>
      - if !<[num].chunk.is_loaded>:
        - stop
      - spawn hallow2021_rab_e <[num]> save:ent
      - flag <entry[ent].spawned_entity> hallow2021_rab

# checking how many items there are in total in the area
# spawning new ones if there are less then x amount
# items should despawn after like 2 minutes so they dont all get stuck ontop of things
hallow2021_ir_task:
  type: task
  debug: false
  script:
    - define cub <server.flag[hallow2021_<server.flag[hallow2021_candy_rain_warp]>_candy_rain]>
    - repeat 10:
      - define num <[cub].random>
      - if !<[num].chunk.is_loaded||false>:
        - stop
      - spawn hallow2021_candy_e <[cub].random>

#---------------------------------#
# a
# a
#---------------------------------#
hallow2021_old_shov:
  type: item
  material: stone_shovel
  debug: false
  display name: <&8>Old Shovel
  lore:
    - <&f>What can i dig up with this?

hallow2021_candy_e:
  type: entity
  entity_type: dropped_item
  debug: false
  item: hallow2021_candy_i
  pickup_delay: 2s
  time_lived: <duration[240s]>

hallow2021_candy_i:
  type: item
  material: apple
  debug: false
  display name: <&e>Candy
  lore:
    - <&f>it has a sugary taste
  mechanisms:
    custom_model_data: <list[200|300|400|500|600|700|800|900|1000].random>

hallow2021_hidden_candy_e:
  type: entity
  entity_type: dropped_item
  debug: false
  item: hallow2021_hidden_candy_i
  pickup_delay: 3s

hallow2021_hidden_candy_i:
  type: item
  material: bundle
  debug: false
  display name: <&d>Hidden Bundle
  lore:
    - <&f>How did you get this?

hallow2021_bucket_i:
  type: item
  material: paper
  display name: <&e>Candy Bucket
  mechanisms:
    custom_model_data: 10600
  flags:
    candy_storage: 0
    custom_uuid: <util.random_uuid>
  lore:
    - <&f>This bucket seems to be empty
    - <&f>Collect candy to fill it
    - <&f>0/5000 candy

hallow2021_update_bucket:
  type: task
  debug: false
  script:
    - define can <[item].flag[candy_storage].add[<[i].quantity||0>]>
    - if <[can]> <= 500:
      - define data 10600
      - define msg "This bucket seems to be empty"
      - goto fin
    - if <[can]> <= 1000:
      - define data 10700
      - define msg "This bucket is barely empty"
      - goto fin
    - if <[can]> <= 2000:
      - define data 10800
      - define msg "This bucket is almost half way full"
      - goto fin
    - if <[can]> <= 3000:
      - define data 10900
      - define msg "This bucket seems to be half way full"
      - goto fin
    - if <[can]> <= 4500:
      - define data 11000
      - define msg "This bucket is just over half filled"
      - goto fin
    - if <[can]> <= 5000:
      - define data 11100
      - define msg "This bucket is almost full"
      - define extra_msg "You should probably go and dispose of some"
    - if <[can]> > 5000:
      - define data 11100
      - define msh "this bucket has overfilled"
      - define extra_msg "You should defintly go and dispose of some"
    - mark fin
    - inventory adjust "lore:<list[<&f><[msg]>|<&f><[extra_msg].if_null[Collect candy to fill it]>|<&d><[can]>/5000 <&e>candy]>" slot:<[slot]> d:<player.inventory>
    - inventory adjust custom_model_data:<[data]> slot:<[slot]> d:<player.inventory>

hallow2021_update_pl:
  type: task
  debug: false
  script:
    - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].is_empty>:
      - stop
    - define area <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.note_name.after[hallow2021_]>
    - define ev <server.flag[hallow2021_<[area]>_event]||nothing>
    - choose <[ev]>:
      - case haunted_mansion:
        - define ev "Haunted Mansion"
      - case big_phantom:
        - define ev "Boss Battle"
      - case ghost_ship:
        - define ev "Ghost Ship"
      - case witch_house:
        - define ev "Witches house"
      - case graveyard:
        - define ev Graveyard
      - case candy_fish:
        - define ev "Candy Fishing"
      - case candy_rain:
        - define ev "Raining Candy"
      - case candy_sor:
        - define ev "Candy Sorting"
      - case running_rabbits:
        - define ev "Running Rabbits"
      - case shoot_bats:
        - define ev "Shooting Bats"
      - case trick_treat:
        - define ev "Trick or Treating"
      - case candy_hiding:
        - define ev "Candy Hiding"
      - case candy_mobs:
        - define ev "Candy Monsters"
      - default:
        - define ev "No Event Currently"
    - define "text:->: <&7>Current warp:"
    - define "text:->: <&e><[area].replace[_].with[ ]>"
    - define "text:->: <&7>Current event:"
    - define "text:->: <&e><[ev]>"
    - define "text:->: <&f>"
    - define "text:->: <&7>Personal candy storage:"
    - define "text:->: <&d><player.flag[stored_candy]||0>/1000"
    - define "text:->: <&7>Total server candies"
    - define "text:->: <&d><server.flag[hallow2021_candies]||0>"
    - define sep <&7>+<empty.pad_right[<[text].parse[text_width].highest.div[8].round_down>].with[-]>+
    - define values:->:<[sep]>
    - define values:|:<[text]>
    - define values:->:<&f><[sep]>
    - sidebar set title:<&d><&l>Halloween values:<[values]> players:<player>

candy_int_w:
  type: world
  debug: false
  events:
    on player picks up hallow2021_hidden_candy_i:
    - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
      - determine cancelled
    - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.after[hallow2021_]||null> != <server.flag[hallow2021_candy_hiding_warp]||none>:
      - determine passively cancelled
      - remove <context.entity>
      - stop
    - if !<context.entity.has_flag[has_candy]>:
      - determine passively cancelled
      - remove <context.entity>
      - stop
    - define amt <context.entity.flag[has_candy]>
    - determine passively cancelled
    - remove <context.entity>
    - flag <player> hallow2021_stashes_found:++
    - repeat <[amt]>:
      - spawn hallow2021_candy_e <context.location>
    on player picks up hallow2021_candy_i:
    - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
      - determine cancelled
    - define i <context.item>
    - determine passively cancelled
    - if <player.inventory.contains_item[hallow2021_bucket_i]>:
      - foreach <player.inventory.find_all_items[hallow2021_bucket_i]> as:slot:
        - define item <player.inventory.slot[<[slot]>]>
        - if !<[item].has_flag[candy_storage]>:
          - foreach next
        - if <[item].flag[candy_storage]> >= 5000:
          - foreach next
        - inventory flag candy_storage:+:<[i].quantity> slot:<[slot]> d:<player.inventory>
        - remove <context.entity>
        - flag player candy_pickup:+:<[i].quantity> expire:1s
        - actionbar "<player.flag[candy_pickup]> Candy added to your basket"
        - inject hallow2021_update_bucket
        - stop
    - if <player.flag[stored_candy]||0> >= 1000:
      - ratelimit <player> 2s
      - narrate "seems like your candy storage is full."
      - narrate "deposit them to collect more candies."
      - stop
    - if <player.flag[stored_candy].add[<[i].quantity>]||0> > 1000:
      - ratelimit <player> 2s
      - narrate "Your storage is almost full."
      - narrate "You cannot fit all these candies in there."
      - narrate "deposit them to collect more candies."
      - stop
    - flag player stored_candy:+:<[i].quantity>
    - remove <context.entity>
    - inject hallow2021_update_pl
    - flag player candy_pickup:+:<[i].quantity> expire:1s
    - actionbar "<player.flag[candy_pickup]> candy added to your storage"
    on player clicks in inventory:
    - if <player.inventory.find_all_items[hallow2021_candy_i]> != -1:
      - foreach <player.inventory.find_all_items[hallow2021_candy_i]> as:slot:
        - take slot:<[slot]> from:<player.inventory> quantity:64
    on player drags hallow2021_candy_i in inventory:
      - determine passively cancelled
    on player clicks hallow2021_candy_i in inventory:
    - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
      - determine cancelled
    - define i <context.item>
    - determine passively cancelled
    - if <player.inventory.contains_item[hallow2021_bucket_i]>:
      - foreach <player.inventory.list_contents> as:item:
        - if !<[item].has_flag[candy_storage]>:
          - foreach next
        - if <[item].flag[candy_storage]> >= 5000:
          - foreach next
        - define slot <player.inventory.map_slots.invert.get[<[item]>].first>
        - inventory flag candy_storage:+:<[i].quantity> slot:<[slot]> d:<player.inventory>
        - inventory set d:<context.inventory> o:air slot:<context.slot>
        - flag player candy_pickup:+:<[i].quantity> expire:1s
        - actionbar "<player.flag[candy_pickup]> Candy added to your basket"
        - inject hallow2021_update_bucket
        - stop
    - if <player.flag[stored_candy]||0> >= 1000:
      - ratelimit <player> 2s
      - narrate "seems like your candy storage is full."
      - narrate "deposit them to collect more candies."
      - stop
    - if <player.flag[stored_candy].add[<[i].quantity>]||0> >= 1000:
      - ratelimit <player> 2s
      - narrate "Your storage is almost full."
      - narrate "You cannot fit all these candies in there."
      - narrate "deposit them to collect more candies."
      - stop
    - flag player stored_candy:+:<[i].quantity>
    - take slot:<context.slot> from:<context.clicked_inventory> quantity:64
    - inject hallow2021_update_pl
    - flag player candy_pickup:+:<[i].quantity> expire:1s
    - actionbar "<player.flag[candy_pickup]> candy added to your storage"

hallow2021_mob_e:
  type: world
  debug: false
  events:
    after server start:
    - ~yaml load:r-names.yml id:r-names
    on player right clicks hallow2021_rab_e:
    - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
      - stop
    - ratelimit <player> 2t
    - if <player.has_passenger>:
      - stop
    - if <context.entity.vehicle||null> != null:
      - stop
    - mount <context.entity>|<player>
    - actionbar "You picked up a rabbit, return to the monster"
    on player kills hallow2021_rab_e:
    - repeat 5:
      - spawn rabbit[color=the_killer_bunny;max_health=50;health=50]
    on player toggles sneaking:
    - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
      - stop
    - if <player.passenger.script.name||null> == hallow2021_rab_e:
      - if <player.location.find.entities.within[1].parse[script.name].contains[hallow2021_rab_ass]>:
        - ratelimit <player> 4s
        - if <player.location.cuboids.filter[note_name.starts_with[hallow2021_]].first.after[hallow2021_]||null> != <server.flag[hallow2021_running_rabbits_warp]||none>:
          - mount cancel <player.passenger>|<player>
          - stop
        - flag <player> hallow2021_rabbit_return:++
        - narrate "Ohh that seems tas-. I uhh mean. There is my lost pet rabbit!" format:hallow2021_fm_format
        - wait 2s
        - remove <player.passenger>
        - wait 1s
        - narrate "Thank you so much for bringing him back to me. i honestly dont know why i would have ea-, uhm.. done if i lost him" format:hallow2021_fm_format
        - wait 3s
        - narrate "If you bring back more i will reward you again" format:hallow2021_fm_format
        - repeat <util.random.int[3].to[9]>:
          - spawn hallow2021_candy_e <player.location>
        - wait 5s
        - playsound sound:ENTITY_PLAYER_BURP pitch:0.7 <player>
        - narrate "ohm nom nom, that tastes good." format:hallow2021_fm_format
        - stop
      - mount cancel <player.passenger>|<player>
    on entity dies:
    - if <context.entity.has_flag[hallow2021_bat]>:
      - repeat <util.random.int[1].to[5]>:
        - spawn hallow2021_candy_e <context.entity.location>
    - if !<context.entity.has_flag[hallow2021_mob]>:
      - stop
    - repeat <util.random.int[0].to[4]>:
      - spawn hallow2021_candy_e <context.entity.location>
    on projectile hits hallow2021_bat shooter:player:
    - if <script[hallow2021_black_list].data_key[users].contains[<player.uuid>]>:
      - determine cancelled
    - repeat <util.random.int[1].to[5]>:
      - spawn hallow2021_candy_e <context.hit_entity.location>
    - flag <context.shooter> hallow2021_bat_shots:++
    - remove <context.hit_entity>
    - if <context.projectile.entity_type> != trident:
      - remove <context.projectile>
    on hallow2021_bat exits cuboid:
    - if !<context.area.note_name.starts_with[hallow2021_]||false>:
      - stop
    - define nl <server.flag[hallow2021_<server.flag[hallow2021_shoot_bats_warp]>_shoot_bats].spawnable_blocks[air].random||nothing>
    - if !<[nl].chunk.is_loaded||false>:
      - remove <context.entity>
      - stop
    - teleport <context.entity> <[nl]>
    on hallow2021_rab_e exits cuboid:
    - if !<context.area.note_name.starts_with[hallow2021_]||false>:
      - stop
    - define nl <server.flag[hallow2021_<server.flag[hallow2021_running_rabbits_warp]>_running_rabbits_spawns].spawnable_blocks[air].random||nothing>
    - if !<[nl].chunk.is_loaded||false>:
      - remove <context.entity>
      - stop
    - teleport <context.entity> <[nl]>
    on spectralcreep1 damaged:
    - playsound <context.entity.location> sound:entity_creeper_hurt volume:2 pitch:0.6
    on spectralcreep2 damaged:
    - playsound <context.entity.location> sound:entity_creeper_hurt volume:2 pitch:0.6
    on spectralcreep1 dies:
    - if <util.random.int[0].to[10]> == 1:
      - determine spechead
    - else:
      - determine no_drops
    on spectralcreep2 dies:
    - if <util.random.int[0].to[10]> == 1:
      - determine spechead
    - else:
      - determine no_drops
    on spectralcreep1 explosion primes:
    - shoot spectralcreep2 origin:<context.entity>
    on spectralcreep2 explosion primes:
    - adjust <context.entity> remove_effects
    on silverfish changes block:
    - determine cancelled
    on player right clicks block with:lens_oftruth:
    - if <player.item_cooldown[ender_eye]> > 0:
      - stop
    - determine passively cancelled
    - itemcooldown ender_eye d:<duration[1m]>
    - playeffect effect:spell_witch at:<player.location> quantity:150 offset:5,0.5,5
    - if <player.location.find.entities[ghoul_rat].within[5].is_empty>:
      - stop
    - foreach <player.location.find.entities[ghoul_rat].within[5]>:
      - if <[value].has_flag[shown]>:
        - goto rat_next
      - flag player ghoul_rats:->:<[value]>
      - flag <[value]> shown
      - adjust <[value]> show_to_players
      - mark rat_next
    - wait 45s
    - foreach <player.flag[ghoul_rats]>:
      - if !<[value].is_spawned||false>:
        - goto ghoul_next
      - adjust <[value]> hide_from_players
      - flag <[value]> shown:!
      - mark ghoul_next
    - flag player ghoul_rats:!
    on hallow2021_rab_e damages player:
    - determine passively 1
    on ghoul_rat damages player:
    - determine passively 3
    - cast <context.entity> slow duration:3
    - random:
      - playsound sound:entity_bat_ambient <context.damager.location> volume:0.6 pitch:0.8
      - playeffect effect:ash at:<context.damager.location.add[0,0.2,0]> offset:0.4,0.4,0.4 quantity:10
    on fire_bubble spawns:
    - flag server firebs:->:<context.entity>
    on water_bubble spawns:
    - flag server waterbs:->:<context.entity>
    on poison_bubble spawns:
    - flag server poisonbs:->:<context.entity>
    on fire_bubble dies:
    - flag server firebs:<-:<context.entity>
    - if <util.random.int[0].to[10]> == 1:
      - determine <context.entity.equipment.head.with[display_name=<context.entity.custom_name>]>
    - else:
      - determine no_drops
    on water_bubble dies:
    - flag server waterbs:<-:<context.entity>
    - if <util.random.int[0].to[10]> == 1:
      - determine <context.entity.equipment.head.with[display_name=<context.entity.custom_name>]>
    - else:
      - determine no_drops
    on poison_bubble dies:
    - flag server poisonbs:<-:<context.entity>
    - if <util.random.int[0].to[10]> == 1:
      - determine <context.entity.equipment.head.with[display_name=<context.entity.custom_name>]>
    - else:
      - determine no_drops
    on redead_walker spawns:
    - flag server redead:->:<context.entity>
    on redead_walker dies:
    - flag server redead:<-:<context.entity>
    - if <util.random.int[0].to[8]> == 1:
      - determine <context.entity.equipment.head.with[display_name=<&f>head<&sp>of<&sp><context.entity.custom_name>]>
    - else:
      - determine no_drops
    on redead_walker damaged:
    - playsound <context.entity.location> sound:entity_illusioner_hurt volume:2 pitch:0.7
    on fire_bubble damages player:
    - determine passively cancelled
    - burn <context.entity> duration:6
    - cast weakness duration:4s amplifier:0 <context.entity> no_ambient hide_particles no_icon
    on water_bubble damages player:
    - determine passively 3
    - adjust <context.entity> oxygen:0
    - cast weakness duration:4s amplifier:0 <context.entity> no_ambient hide_particles no_icon
    on poison_bubble damages player:
    - determine passively cancelled
    - cast poison duration:6s amplifier:0 <context.entity> no_ambient hide_particles no_icon
    - cast weakness duration:4s amplifier:0 <context.entity> no_ambient hide_particles no_icon
    on jumper damaged:
    - if <context.entity.has_flag[jumped]>:
      - determine 2
    on jumper damages player:
    - if <context.damager.has_flag[jumped]>:
      - playsound sound:entity_fox_aggro volume:2 pitch:1.6 <context.damager.location>
      - determine 2
    - if <util.random.int[0].to[5]> == 1:
      - attach <context.damager> to:<context.entity> offset:0,1.9,0 sync_server
      - flag <context.damager> jumped

hallow2021_candy_geyser:
  type: task
  definitions: loc|min|max|dur|delay|direction|type
  debug: false
  script:
    - if <[type]||no> != candy:
      - run present_effect def:<[loc]>|<[min]>|<[delay]>|<[dur]>|<[direction]>
    - playsound sound:ENTITY_skeleton_horse_death <[loc]> pitch:0.2 volume:1
    - while <duration[<[dur]||1s>].sub[<duration[<[delay]||1s>]>].in_milliseconds||duration[0s].in_milliseconds> > <duration[0s].in_milliseconds>:
      - choose <[direction]>:
        - case down:
          - define dir <util.random.decimal[-1.0].to[-2.0]>
          - define adj_loc <[loc].sub[0,<util.random.decimal[0.1].to[4]>,0]>
        - case up:
          - define dir <util.random.decimal[1.0].to[2.0]>
          - define adj_loc <[loc].add[0,<util.random.decimal[0.1].to[4]>,0]>
        - default:
          - define dir <util.random.decimal[0.1].to[1]>
          - define adj_loc <[loc]>
      - if <[type]||no> == candy:
        - repeat <util.random.int[<[min]>].to[<[max]>]>:
          - drop hallow2021_candy_i <[adj_loc]> speed:<[dir]>
        - define offset <util.random.decimal[1].to[4]>
        - define velocity <util.random.decimal[0].to[0.08]>
        - playeffect effect:soul at:<[loc]> quantity:10 offset:<[offset]>,<[offset]>,<[offset]> velocity:<[velocity]>,<util.random.decimal[0.2].to[0.2]>,<[velocity]>
        - playeffect effect:soul_fire_flame at:<[loc]> quantity:10 offset:<[offset]>,<[offset]>,<[offset]> velocity:<[velocity]>,<util.random.decimal[0.2].to[0.2]>,<[velocity]>
      - wait <[delay]||1s>
      - define dur:<duration[<[dur]||1s>].sub[<duration[<[delay]||1s>]>]||duration[0s]>

hallow2021_spawn_ghost:
  type: task
  debug: false
  script:
    - spawn ghost_vex save:vex target:<player>
    - spawn ghost_armor save:armor
    - flag server ghost:->:<entry[vex].spawned_entity>
    - flag <entry[vex].spawned_entity> link:<entry[armor].spawned_entity>
    - flag <entry[armor].spawned_entity> link:<entry[vex].spawned_entity>
    - attach <entry[armor].spawned_entity> to:<entry[vex].spawned_entity>
    - wait 1m
    - flag server ghost:<-:<entry[vex].spawned_entity>
    - remove <entry[vex].spawned_entity>|<entry[armor].spawned_entity>

spectralcreep1:
  type: entity
  entity_type: creeper
  debug: false
  custom_name: "<&color[#003366]>S<&color[#004C99]>p<&color[#0066CC]>e<&color[#0080FF]>c<&color[#3399FF]>t<&color[#66B2FF]>r<&color[#99CCFF]>a<&color[#CCE5FF]>l <&color[#CCFFCC]>C<&color[#99FF99]>r<&color[#66FF66]>e<&color[#33FF33]>e<&color[#00FF00]>p<&color[#00CC00]>e<&color[#009900]>r"
  custom_name_visible: true

spectralcreep2:
  type: entity
  entity_type: creeper
  debug: false
  powered: true
  potion_effects: invisibility,0,999999,false,false,false|damage_resistance,50,2,false,false,false|slow_falling,0,100,false,false,false
  custom_name: "<&color[#003366]>S<&color[#004C99]>p<&color[#0066CC]>e<&color[#0080FF]>c<&color[#3399FF]>t<&color[#66B2FF]>r<&color[#99CCFF]>a<&color[#CCE5FF]>l <&color[#CCFFCC]>C<&color[#99FF99]>r<&color[#66FF66]>e<&color[#33FF33]>e<&color[#00FF00]>p<&color[#00CC00]>e<&color[#009900]>r"
  custom_name_visible: true
  speed: 1.2

ghoul_rat:
  type: entity
  entity_type: silverfish
  debug: false
  hide_from_players: true
  custom_name: "<&color[#202020]>G<&color[#404040]>h<&color[#606060]>o<&color[#808080]>u<&color[#A0A0A0]>l <&color[#C0C0C0]>R<&color[#E0E0E0]>a<&color[#FFFFFF]>t"
  custom_name_visible: true

fire_bubble:
  type: entity
  entity_type: zombie
  debug: false
  age: adult
  item_in_hand: air
  potion_effects: invisibility,0,999999,false,false,false
  custom_name: "<&color[#B62203]>F<&color[#D73502]>i<&color[#FC6400]>r<&color[#FaC000]>e <&color[#CC99FF]>B<&color[#B266FF]>u<&color[#9933FF]>b<&color[#7F00FF]>b<&color[#6600CC]>l<&color[#4C0099]>e"
  custom_name_visible: true
  silent: true
  speed: 0.32
  equipment: air|air|air|player_head[skull_skin=24304ecb-4215-49ce-b145-4d9dc5e21b68|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYjYxNzg1NWZmMTI2OGQ5NTliZDlmMjM5Mzg0ZmUwNDMxZWJkNzUxYjI2MjQ2MTljNTU1ZTlkNDcxZTk0NDAifX19]

poison_bubble:
  type: entity
  entity_type: zombie
  debug: false
  age: adult
  item_in_hand: air
  custom_name: "<&color[#336600]>P<&color[#4C9900]>o<&color[#66CC00]>i<&color[#80FF00]>s<&color[#99FF33]>o<&color[#B2FF66]>n <&color[#CC99FF]>B<&color[#B266FF]>u<&color[#9933FF]>b<&color[#7F00FF]>b<&color[#6600CC]>l<&color[#4C0099]>e"
  custom_name_visible: true
  potion_effects: invisibility,0,999999,false,false,false
  silent: true
  speed: 0.32
  equipment: air|air|air|player_head[skull_skin=aa84e219-41f5-4a9f-a4e0-49e003aa29e8|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjYwOTMyYjJjMjI0YjdjMjE2M2NiYWMwNWYyODZhMDZlNjkyMjUyN2IwMzY2N2M0ZTk2ZjcyOGU1YzRmZmI2NiJ9fX0=]

redead_walker:
  type: entity
  entity_type: husk
  debug: false
  age: adult
  silent: true
  custom_name: "<&color[#5a382f]>U<&color[#6d4e46]>n<&color[#7f645d]>d<&color[#917a74]>e<&color[#a4918c]>a<&color[#b6a7a3]>d<&f> <yaml[r-names].read[names].random>"
  custom_name_visible: true
  item_in_hand: air
  equipment: air|air|leather_chestplate[color=<color[85,60,35]>]|player_head[skull_skin=d4576dca-a99e-4875-a319-81b4e61c0579|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZTczM2Q1YTMzMGJiYmQ0MGUzYjZhNWRmYWY4MGFmNTMzZGYxZmFmOTE1ZDg4Y2I4OTEyNDg5YWI3ZDA2YWIwIn19fQ==]

ghost_armor:
  type: entity
  entity_type: armor_stand
  debug: false
  is_small: true
  invulnerable: true
  base_plate: false
  custom_name: <&l>Ghost
  custom_name_visible: true
  disabled_slots: chest/all|feet/all|hand/all|head/all|legs/all|off_hand/all
  equipment: leather_boots[color=white]|leather_leggings[color=white]|leather_chestplate[color=white]|player_head[skull_skin=31152fb2-cb1e-45c3-86dd-b23f7a20a6f8|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjhkMjE4MzY0MDIxOGFiMzMwYWM1NmQyYWFiN2UyOWE5NzkwYTU0NWY2OTE2MTllMzg1NzhlYTRhNjlhZTBiNiJ9fX0=]

ghost_vex:
  type: entity
  entity_type: vex
  debug: false
  potion_effects: weakness,255,1000000,false,false,false
  hide_from_players: true
  invulnerable: true
  silent: true

water_bubble:
  type: entity
  entity_type: zombie
  debug: false
  age: adult
  item_in_hand: air
  custom_name: "<&color[#0D78AA]>W<&color[#02BAD6]>a<&color[#A4F4F8]>t<&color[#C9FaFe]>e<&color[#E3FAFF]>r <&color[#CC99FF]>B<&color[#B266FF]>u<&color[#9933FF]>b<&color[#7F00FF]>b<&color[#6600CC]>l<&color[#4C0099]>e"
  custom_name_visible: true
  potion_effects: invisibility,0,999999,false,false,false
  silent: true
  speed: 0.32
  equipment: air|air|air|player_head[skull_skin=33782a3d-90da-4c6b-a6d6-0748cb84278b|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmE5OWQ5ZWU2NTEzYWE4OGEzYzQ1NmFiYTJiZDFlMTdkMTM0NDQ4ZmQxMTc3NWJkMWQ1NWVmNjlhYTc3ZDIzMCJ9fX0=]

jumper:
  type: entity
  entity_type: cave_spider
  debug: false
  custom_name: <&color[#9999FF]>J<&color[#6666FF]>u<&color[#3333FF]>m<&color[#0000FF]>p<&color[#0000CC]>e<&color[#000099]>r
  custom_name_visible: true
  max_health: 30
  health: 30
  silent: true

lens_oftruth:
  type: item
  material: ender_eye
  debug: false
  enchantments:
  - lure:1
  mechanisms:
    hides: ENCHANTS
  display name: "<&d>Shard <&f>of <&5>Truth"
  lore:
  - "<&f>Shows you hidden enemies"

spechead:
  type: item
  debug: false
  material: player_head[skull_skin=f9318e11-a0c7-4cfd-85c9-2b2852e1a8b0|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjJjZWIzOWRkNGRlMjRhN2FkZmUyOTFhM2EwY2ZjN2NmNGY2NDVkZTU5YjYwM2ZjZmUwNmM2YjVhMDZlMjYifX19]
  display name: "<&color[#003366]>S<&color[#004C99]>p<&color[#0066CC]>e<&color[#0080FF]>c<&color[#3399FF]>t<&color[#66B2FF]>r<&color[#99CCFF]>a<&color[#CCE5FF]>l <&f>Head"

floating_pumpkin:
  type: entity
  entity_type: zombie
  debug: false
  custom_name: Floating Pumpkin
  custom_name_visible: true
  silent: true
  equipment: air|air|air|<list[carved_pumpkin|jack_o_lantern].random>
  age: <list[baby|adult].random>
  potion_effects: invisibility,0,999999,false,false,false
  item_in_hand: air

hallow2021_bat:
  type: entity
  entity_type: bat
  silent: true
  debug: false

hallow2021_rab_e:
  type: entity
  entity_type: rabbit
  silent: true
  debug: false
  color: <list[brown|white|black|black_and_white|gold|salt_and_pepper|the_killer_bunny].random>
  max_health: 50
  health: 50

#------------#
# scoreboards
# aaa
#------------#
hallow2021_topweek_block:
  type: item
  material: crimson_hyphae
  debug: false
  display name: <&3><&l>Halloween top 10 weekly
  lore:
    - <&7>Place to mark a top 10 location!

hallow2021_topall_block:
  type: item
  material: warped_hyphae
  debug: false
  display name: <&3><&l>Halloween top 10 all
  lore:
    - <&7>Place to mark a top 10 location!

hallow2021_top_block_holo:
  type: entity
  entity_type: armor_stand
  debug: false
  visible: false
  custom_name: <&3><&l>1.
  custom_name_visible: true
  marker: true

hallow2021_top_world:
  type: world
  debug: false
  events:
    on player places hallow2021_topweek_block:
    - flag <context.location> hallow2021_topweek_block
    on player places hallow2021_topall_block:
    - flag <context.location> hallow2021_topall_block
    on player breaks crimson_hyphae location_flagged:hallow2021_topweek_block:
    - flag <context.location> hallow2021_topweek_block:!
    on player breaks warped_hyphae location_flagged:hallow2021_topall_block:
    - flag <context.location> hallow2021_topall_block:!
    on delta time secondly:
    - if <server.has_flag[ghost]>:
      - foreach <server.flag[ghost]>:
        - if !<[value].is_spawned||false>:
          - flag server ghost:<-:<[value]>
          - goto fini
        - flag <[value]> counter:++
        - if <[value].flag[counter]> == 10:
          - playsound sound:entity_elder_guardian_ambient volume:2 pitch:0.3 <[value].location>
          - flag <[value]> counter:!
        - mark fini
    - if <server.has_flag[firebs]>:
      - foreach <server.flag[firebs]>:
        - if !<[value].is_spawned||false>:
          - flag server firebs:<-:<[value]>
          - goto fini
        - playeffect effect:flame at:<[value].eye_location> quantity:10 offset:0.2,0.2,0.2
        - mark fini
    - if <server.has_flag[waterbs]>:
      - foreach <server.flag[waterbs]>:
        - if !<[value].is_spawned||false>:
          - flag server waterbs:<-:<[value]>
          - goto fini
        - playeffect effect:soul_fire_flame at:<[value].eye_location> quantity:10 offset:0.2,0.2,0.2
        - mark fini
    - if <server.has_flag[poisonbs]>:
      - foreach <server.flag[poisonbs]>:
        - if !<[value].is_spawned||false>:
          - flag server poisonbs:<-:<[value]>
          - goto fini
        - playeffect effect:sneeze at:<[value].eye_location> quantity:10 offset:0.2,0.2,0.2
        - mark fini
    - if <server.has_flag[redead]>:
      - foreach <server.flag[redead]>:
        - if !<[value].is_spawned||false>:
          - flag server redead:<-:<[value]>
          - goto fini
        - if <[value].location.light> <= 8:
          - if <[value].has_flag[hidden]>:
            - goto fini
          - flag <[value]> hidden
          - flag <[value]> shown:!
          - playeffect effect:smoke at:<[value].location> offset:1,1,1 quantity:20
          - adjust <[value]> invulnerable:true
          - adjust <[value]> hide_from_players
        - if <[value].location.light> > 8:
          - if <[value].has_flag[shown]>:
            - goto fini
          - flag <[value]> shown
          - flag <[value]> hidden:!
          - playeffect effect:smoke at:<[value].location> offset:1,1,1 quantity:20
          - adjust <[value]> invulnerable:false
          - adjust <[value]> show_to_players
        - mark fini
    - define players <server.online_players>
    - if <[players].is_empty>:
      - stop
    - define valid_ta_locs <[players].filter[location.find_blocks_flagged[hallow2021_topall_block].within[8].is_empty.not]>
    - define valid_tw_locs <[players].filter[location.find_blocks_flagged[hallow2021_topweek_block].within[8].is_empty.not]>
    - if <[valid_ta_locs].is_empty> && <[valid_tw_locs].is_empty>:
      - stop
    ##----------------##
    - foreach <[valid_ta_locs]> as:player:
      - define locs <[player].location.find_blocks_flagged[hallow2021_topall_block].within[8]>
      - foreach <[locs]> as:loc:
        - define top_10 <list[]>
        - if <server.flag[hallow2021_topall].keys||error> == error:
          - goto smartskip
        - foreach <server.flag[hallow2021_topall].sort_by_value.keys.reverse> as:f_player:
          - if <script[hallow2021_black_list].data_key[users]> contains <[f_player].uuid>:
            - foreach next
          - if <[f_player]> == <[player]>:
            - define top_10 <[top_10].include[<&a><server.flag[hallow2021_topall].get[<[f_player]>]><&sp><&7>-<&sp><&5><&l><[f_player].name>]>
          - else:
            - define top_10 <[top_10].include[<&a><server.flag[hallow2021_topall].get[<[f_player]>]><&sp><&7>-<&sp><[f_player].name>]>
        - mark smartskip
        - if <[top_10].size> < 10:
          - repeat 10:
            - define top_10 <[top_10].include[<&c>0000<&sp><&7>-<&sp>No<&sp>one]>
        - define loc <[loc].add[0,0.5,0]>
        - foreach <[top_10]> as:top:
          - choose <[loop_index]>:
            - case 1:
              - fakespawn "hallow2021_top_block_holo[custom_name=Top candy donaters all time]" <[loc].above[3.3]> players:<[player]> duration:20t
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[3.0]> players:<[player]> duration:20t
            - case 2:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[2.7]> players:<[player]> duration:20t
            - case 3:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[2.4]> players:<[player]> duration:20t
            - case 4:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[2.1]> players:<[player]> duration:20t
            - case 5:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[1.8]> players:<[player]> duration:20t
            - case 6:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[1.5]> players:<[player]> duration:20t
            - case 7:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[1.2]> players:<[player]> duration:20t
            - case 8:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[0.9]> players:<[player]> duration:20t
            - case 9:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[0.6]> players:<[player]> duration:20t
            - case 10:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[0.3]> players:<[player]> duration:20t
            - default:
              - foreach stop
    ##-----------------##
    - foreach <[valid_tw_locs]> as:player:
      - define locs <[player].location.find_blocks_flagged[hallow2021_topweek_block].within[8]>
      - foreach <[locs]> as:loc:
        - define top_10 <list[]>
        - if <server.flag[hallow2021_topweek].keys||error> == error:
          - goto smartskip
        - foreach <server.flag[hallow2021_topweek].sort_by_value.keys.reverse> as:f_player:
          - if <script[hallow2021_black_list].data_key[users]> contains <[f_player].uuid>:
            - foreach next
          - if <[f_player]> == <[player]>:
            - define top_10 <[top_10].include[<&a><server.flag[hallow2021_topweek].get[<[f_player]>]><&sp><&7>-<&sp><&5><&l><[f_player].name>]>
          - else:
            - define top_10 <[top_10].include[<&a><server.flag[hallow2021_topweek].get[<[f_player]>]><&sp><&7>-<&sp><[f_player].name>]>
        - mark smartskip
        - if <[top_10].size> < 10:
          - repeat 10:
            - define top_10 <[top_10].include[<&c>0<&sp><&7>-<&sp>No<&sp>one]>
        - define loc <[loc].add[0,0.5,0]>
        - foreach <[top_10]> as:top:
          - choose <[loop_index]>:
            - case 1:
              - fakespawn "hallow2021_top_block_holo[custom_name=Top candy donaters today]" <[loc].above[3.3]> players:<[player]> duration:20t
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[3.0]> players:<[player]> duration:20t
            - case 2:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[2.7]> players:<[player]> duration:20t
            - case 3:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[2.4]> players:<[player]> duration:20t
            - case 4:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[2.1]> players:<[player]> duration:20t
            - case 5:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[1.8]> players:<[player]> duration:20t
            - case 6:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[1.5]> players:<[player]> duration:20t
            - case 7:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[1.2]> players:<[player]> duration:20t
            - case 8:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[0.9]> players:<[player]> duration:20t
            - case 9:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[0.6]> players:<[player]> duration:20t
            - case 10:
              - fakespawn hallow2021_top_block_holo[custom_name=<[top]>] <[loc].above[0.3]> players:<[player]> duration:20t
            - default:
              - foreach stop
