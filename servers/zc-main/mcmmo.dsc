mcgui_command:
  type: command
  debug: false
  name: mcgui
  script:
    - inventory open d:mcmmo_gui
    #- narrate <queue.time_ran.in_milliseconds>

mcmmo_gui:
  type: inventory
  debug: false
  inventory: chest
  size: 54
  gui: true
  title: <element[<&chr[BB]> mcMMO Skills].color_gradient[from=<&b>;to=<&9>]>
  definitions:
    _: black_stained_glass_pane[display=<&f>]
    f: mcmmo_gui_fishing
    al: mcmmo_gui_alchemy
    ar: mcmmo_gui_archery
    ac: mcmmo_gui_acrobatics
    ax: mcmmo_gui_axes
    t: mcmmo_gui_taming
    sm: mcmmo_gui_smelting
    sa: mcmmo_gui_salvage
    m: mcmmo_gui_mining
    h: mcmmo_gui_herbalism
    s: mcmmo_gui_swords
    u: mcmmo_gui_unarmed
    w: mcmmo_gui_woodcutting
    e: mcmmo_gui_excavation
    r: mcmmo_gui_repair
  slots:
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]
    - [_] [s] [ar] [ax]  [t] [m] [w] [e] [_]
    - [_] [] [u] [ac] [al] [f] [h] [] [_]
    - [_] [] [] [sm] [r] [sa] [] [] [_]
    - [_] [] [] [] [] [] [] [] [_]
    - [_] [_] [_] [_] [_] [_] [_] [_] [_]

mcmmo_refresh_skills:
  type: task
  debug: false
  script:
    - ~yaml load:../mcMMO/child.yml id:mcmmo_child
    - flag server mcmmo_child_skills:<yaml[mcmmo_child].read[]>
    - yaml unload id:mcmmo_child
    - ~yaml load:../mcMMO/skillranks.yml id:mcmmo_skills
    - flag server mcmmo_skills:<yaml[mcmmo_skills].read[]>
    - foreach <server.flag[mcmmo_skills]>:
      - foreach <[value].keys> as:skill:
        - define split_skill:<list>
        - foreach <[skill].to_list> as:c:
          - if <[c].is_uppercase> && <[loop_index]> > 1:
            - define "split_skill:->: "
          - define split_skill:->:<[c]>
        - flag server mcmmo_splitskills.<[skill]>:<[split_skill].unseparated>
    - yaml unload id:mcmmo_skills

mcmmmo_auto_refresh_skills:
  type: world
  debug: false
  events:
    after server start:
    - run mcmmo_refresh_skills

mcmmo_check:
  type: procedure
  debug: false
  definitions: skill
  script:
    - define "out:->:<&7><[skill].to_titlecase> Level: <&e><player.mcmmo.level[<[skill]>]>"
    - if <server.flag[mcmmo_child_skills].contains[<[skill]>]>:
      - define "out:->:<&7>Child skill of <&e><server.flag[mcmmo_child_skills.<[skill]>].separated_by[ <&7>and<&e> ]>"
      - define "out:->:<&8>(Level is avg of parent levels)"
    - else:
      - define "out:->:<&7>Progress: <&e><player.mcmmo.xp[<[skill]>]><&7>/<&e><player.mcmmo.xp[<[skill]>].to_next_level>"
    - define out:->:<empty>
    - define "out:->:<&f><[skill].to_titlecase> Skills"
    - define skillmap <map>
    - define rankmap <map>
    - foreach <server.flag[mcmmo_skills.<[skill]>]> key:skillname as:mode:
      - define skillmap <[skillmap].with[<[skillname]>].as[<[mode.retromode.rank_1]>]>
      - define rankmap <[rankmap].with[<[skillname]>].as[<[mode.retromode]>]>
    - define skillmap <[skillmap].sort_by_value>
    - foreach <[skillmap]> key:skillname as:level:
      - define name <server.flag[mcmmo_splitskills.<[skillname]>]>
      - if <player.mcmmo.level[<[skill]>]> >= <[level]>:
        - define rank 1
        - define maxrank 1
        - foreach <[rankmap.<[skillname]>]>:
          - if <player.mcmmo.level[<[skill]>]> >= <[value]> && <[key].after[_]> > <[rank]>:
            - define rank <[key].after[_]>
          - if <[key].after[_]> > <[maxrank]>:
            - define maxrank <[key].after[_]>
        - define level <[rankmap.<[skillname]>.rank_<[rank].add[1].min[<[maxrank]>]>]>
        - if <[rank]> == 1 and <[maxrank]> == 1:
          - define "out:->:<&6> <&chr[2605]> <&7><[name]> <&e><element[(<[level]>)].proc[superscript]>"
        - else if <[rank]> == <[maxrank]>:
          - define "out:->:<&6> <&chr[2605]><element[<[rank]>].proc[superscript]> <&7><[name]> <&e><element[(<[level]>)].proc[superscript]>"
        - else:
          - define "out:->:<&a> <&chr[2605]><element[<[rank]>/<[maxrank]>].proc[superscript]> <&7><[name]> <&e><element[(<[level]>)].proc[superscript]>"
      - else:
        - define "out:->:<&c> <&chr[2606]> <&7><[name]> <&e><element[(<[level]>)].proc[superscript]>"
    - determine <[out].separated_by[<n>]>

superscript:
  type: procedure
  debug: false
  definitions: text
  script:
    - determine <[text].replace_text[(].with[<&chr[207D]>].replace_text[)].with[<&chr[207E]>].replace_text[0].with[<&chr[2070]>].replace_text[1].with[<&chr[00B9]>].replace_text[2].with[<&chr[00B2]>].replace_text[3].with[<&chr[00B3]>].replace_text[4].with[<&chr[2074]>].replace_text[5].with[<&chr[2075]>].replace_text[6].with[<&chr[2076]>].replace_text[7].with[<&chr[2077]>].replace_text[8].with[<&chr[2078]>].replace_text[9].with[<&chr[2079]>].replace_text[/].with[<&chr[141F]>]>

mcmmo_gui_fishing:
  type: item
  debug: false
  material: fishing_rod
  display name: <element[Fishing].color_gradient[from=<&9>;to=<&1>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The fishing skill allows you to
    - <&7>fish faster and catch unique
    - <&7>treasure while fishing.
    - <empty>
    - <proc[mcmmo_check].context[fishing]>

mcmmo_gui_alchemy:
  type: item
  debug: false
  material: splash_potion
  mechanisms:
    hides: all
  display name: <element[Alchemy].color_gradient[from=<&d>;to=<&5>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The alchemy skill allows you to
    - <&7>brew potions faster and concoct
    - <&7>special potions.
    - <empty>
    - <proc[mcmmo_check].context[alchemy]>

mcmmo_gui_archery:
  type: item
  debug: false
  material: bow
  mechanisms:
    hides: all
  display name: <element[Archery].color_gradient[from=<&f>;to=<&color[#964B00]>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The archery skill allows you to
    - <&7>deal bonus damage with arrows,
    - <&7>apply dazed debuffs, and reuse arrows.
    - <empty>
    - <proc[mcmmo_check].context[archery]>

mcmmo_gui_acrobatics:
  type: item
  debug: false
  material: leather_boots
  mechanisms:
    hides: all
  display name: <element[Acrobatics].color_gradient[from=<&color[#964B00]>;to=<&c>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The acrobatics skill allows you to
    - <&7>roll and dodge attacks as you level up.
    - <empty>
    - <proc[mcmmo_check].context[acrobatics]>

mcmmo_gui_axes:
  type: item
  debug: false
  material: iron_axe
  mechanisms:
    hides: all
  display name: <element[Axes].color_gradient[from=<&f>;to=<&7>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The axes skill allows you to
    - <&7>deal powerful critical strikes
    - <&7>and do heavy damage to armor.
    - <empty>
    - <proc[mcmmo_check].context[axes]>

mcmmo_gui_taming:
  type: item
  debug: false
  material: bone
  mechanisms:
    hides: all
  display name: <element[Taming].color_gradient[from=<&e>;to=<&d>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The taming skill allows you to
    - <&7>summon powerful allies to your side.
    - <empty>
    - <proc[mcmmo_check].context[taming]>

mcmmo_gui_smelting:
  type: item
  debug: false
  material: coal
  mechanisms:
    hides: all
  display name: <element[Smelting].color_gradient[from=<&c>;to=<&7>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The smelting skill give you a chance to
    - <&7>double-smelt and increases the burn
    - <&7>time of fuel as you level up.
    - <empty>
    - <proc[mcmmo_check].context[smelting]>

mcmmo_gui_salvage:
  type: item
  debug: false
  material: golden_helmet
  mechanisms:
    hides: all
  display name: <element[Salvage].color_gradient[from=<&e>;to=<&7>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The salvage skill allows you to right
    - <&7>click a gold block with a salvageable
    - <&7>item to reclaim its raw materials.
    - <empty>
    - <proc[mcmmo_check].context[salvage]>

mcmmo_gui_mining:
  type: item
  debug: false
  material: stone_pickaxe
  mechanisms:
    hides: all
  display name: <element[Mining].color_gradient[from=<&b>;to=<&7>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The mining skill allows you to
    - <&7>mine faster and collect more
    - <&7>drops from mining.
    - <empty>
    - <proc[mcmmo_check].context[mining]>

mcmmo_gui_herbalism:
  type: item
  debug: false
  material: stone_hoe
  mechanisms:
    hides: all
  display name: <element[Herbalism].color_gradient[from=<&a>;to=<&2>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The herbalism skill allows you to
    - <&7>collect more drops from crops and
    - <&7>replant seeds automatically.
    - <empty>
    - <proc[mcmmo_check].context[herbalism]>

mcmmo_gui_swords:
  type: item
  debug: false
  material: iron_sword
  mechanisms:
    hides: all
  display name: <element[Swordsman].color_gradient[from=<&7>;to=<&f>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The swordsman skill allows you to
    - <&7>unlock special combat abilities
    - <&7>as you level up.
    - <empty>
    - <proc[mcmmo_check].context[swords]>

mcmmo_gui_unarmed:
  type: item
  debug: false
  material: player_head
  mechanisms:
    hides: all
  display name: <element[Unarmed].color_gradient[from=<&color[#0eaeae]>;to=<&color[#a97d64]>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The unarmed skill allows you to
    - <&7>use your fist as a powerful weapon
    - <&7>and disarm enemies at later levels.
    - <empty>
    - <proc[mcmmo_check].context[unarmed]>

mcmmo_gui_woodcutting:
  type: item
  debug: false
  material: stone_axe
  mechanisms:
    hides: all
  display name: <element[Woodcutting].color_gradient[from=<&color[#964B00]>;to=<&color[#a97d64]>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The woodcutting skill allows you to
    - <&7>gain extra wood from chopping trees
    - <&7>and chop entire trees down at once.
    - <empty>
    - <proc[mcmmo_check].context[woodcutting]>

mcmmo_gui_excavation:
  type: item
  debug: false
  material: stone_shovel
  mechanisms:
    hides: all
  display name: <element[Excavation].color_gradient[from=<&a>;to=<&color[#964B00]>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The excavation skill allows you to
    - <&7>dig faster and collect treasure from dirt.
    - <empty>
    - <proc[mcmmo_check].context[excavation]>

mcmmo_gui_repair:
  type: item
  debug: false
  material: iron_ingot
  mechanisms:
    hides: all
  display name: <element[Repair].color_gradient[from=<&color[#7803ff]>;to=<&color[#d903ff]>]>
  lore:
    - <empty>
    - <&f>General Information
    - <&7>The repair skill allows you to
    - <&7>right click a block of iron to
    - <&7>restore an item's durability.
    - <empty>
    - <proc[mcmmo_check].context[repair]>
