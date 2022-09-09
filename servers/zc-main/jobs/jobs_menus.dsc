empty_jobs_slot:
  type: item
  debug: false
  material: gray_stained_glass_pane
  display name: <&f>

jobs_stats_item:
  type: item
  debug: false
  material: player_head
  display name: <&a><&l>Your Statistics
  lore:
    - <&7>Click to open this menu
    - <empty>
    - <&a>Description
    - <&7>View your job statistics,
    - <&7>current jobs, job points,
    - <&7>and more
  mechanisms:
    hides: all

jobs_list_item:
  type: item
  debug: false
  material: writable_book
  display name: <&6><&l>Browse Jobs
  lore:
    - <&7>Click to open this menu
    - <empty>
    - <&6>Description
    - <&7>View available jobs and
    - <&7>update your current jobs
  mechanisms:
    hides: all

jobs_shop_item:
  type: item
  debug: false
  material: chest
  display name: <&d><&l>Jobs Shop
  lore:
    - <&7>Click to open this menu
    - <empty>
    - <&d>Description
    - <&7>Spend your acquired job
    - <&7>points on valuable prizes!
  mechanisms:
    hides: all

jobs_back_item:
  type: item
  debug: false
  material: paper
  display name: <&c><&l>Go Back
  lore:
    - <&7>Click to open the previous menu
  mechanisms:
    hides: all

jobs_main_menu:
  type: inventory
  debug: false
  inventory: chest
  title: <&6><&l>Main Jobs Menu
  size: 27
  gui: true
  definitions:
    _: empty_jobs_slot
    j: jobs_list_item
    p: jobs_stats_item[skull_skin=<player.skull_skin>]
    s: jobs_shop_item
  slots:
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]
    - [_] [_] [j] [_] [p] [_] [s] [_] [_]
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]

jobs_off_slot:
  type: item
  debug: false
  material: red_stained_glass_pane
  display name: <&c><&l>Not Working
  lore:
    - <&7>You are not currently working this job
    - <empty>
    - <&c>Actions
    - <&7>Click to start working

jobs_on_slot:
  type: item
  debug: false
  material: lime_stained_glass_pane
  display name: <&a><&l>Working
  lore:
    - <&7>You are working this job
    - <empty>
    - <&a>Actions
    - <&7>Click to stop working

jobs_list_menu:
  type: inventory
  debug: false
  inventory: chest
  title: <&6><&l>Browse Jobs
  size: 27
  gui: true
  definitions:
    _: empty_jobs_slot
    0: jobs_off_slot
    1: jobs_on_slot
    2: jobs_back_item
    s: jobs_slayer_item
    m: jobs_miner_item
    l: jobs_lumberjack_item
    d: jobs_digger_item
    f: jobs_farmer_item
    r: jobs_rancher_item
    e: jobs_engineer_item
  slots:
    - [2] [_] [_] [_] [_] [_] [_] [_] [_]
    - [_] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [_]
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]

jobs_info_item:
  type: item
  debug: false
  material: spruce_sign
  display name: Job Info
  lore:
    - <&7>Job information
    - <empty>
    - <&a>Details
    - <&7><&chr[BB]> Your level<&co> <&a>0/100
    - <&7><&chr[BB]> Players working job<&co> <&a>0
    - <&7><&chr[BB]> Daily earnings limit<&co> <&a>$10,000

jobs_payouts_item:
  type: item
  debug: false
  material: emerald
  display name: Job Payouts
  lore:
    - <&7>Click to view payouts

jobs_rewards_item:
  type: item
  debug: false
  material: book
  display name: Job Rewards
  lore:
    - <&7>Click to redeem and
    - <&7>view rewards!

jobs_details_menu:
  type: inventory
  debug: false
  inventory: chest
  title: <&6><&l>Job Details
  size: 27
  gui: true
  definitions:
    _: empty_jobs_slot
    2: jobs_back_item
    p: jobs_payouts_item
    i: jobs_info_item
    r: jobs_rewards_item
  slots:
    - [2] [_] [_] [_] [ ] [_] [_] [_] [_]
    - [_] [_] [p] [_] [i] [_] [r] [_] [_]
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]

jobs_menu_events:
  type: world
  debug: false
  events:
    after player clicks jobs_list_item in jobs_main_menu:
      - define inv <inventory[jobs_list_menu]>
      - foreach <script[jobs_config].data_key[order]> as:job:
        - define job_map <script[jobs_config].data_key[jobs.<[job]>]>
        - define display <&color[<[job_map].get[color]>]><&l><[job].to_titlecase>
        - define "lore:!|:<&7>Click to open menu"
        - define lore:->:<empty>
        - define lore:->:<&color[<[job_map].get[color]>]>Description
        - define lore:|:<[job_map].get[desc].parse_tag[<&7><[parse_value]>]>
        - define item <item[<[job_map].get[item]>].with_flag[job:<[job]>].with[hides=all;display=<[display]>;lore=<[lore]>]>
        - inventory set d:<[inv]> slot:<[loop_index].add[10]> o:<[item]>
      - inventory open d:<[inv]>
    after player clicks jobs_back_item in jobs_list_menu:
      - inventory open d:jobs_main_menu
    after player clicks item_flagged:job in jobs_list_menu:
      - define job <context.item.flag[job]>
      - define inv <inventory[jobs_details_menu]>
      - inventory set d:<[inv]> o:<context.item.with[lore=]> slot:5
      - define last_color <context.item.display.last_color>
      - foreach 12|14|16:
        - inventory adjust display:<[last_color]><[inv].slot[<[value]>].display> d:<[inv]> slot:<[value]>
      - inventory open d:<[inv]>
    after player clicks jobs_back_item in jobs_details_menu:
      - inventory open d:jobs_list_menu
