################
# Zc Race Menu #  (Created with help By Marshall, Finalized by Ichikuro)
################

###############
###Definition##
###############

racemenu_cmd:
    type: command
    debug: false
    description: "Viewing and selecting a ZC race."
    name: racemenu
    usage: /racemenu
    permission: "racemenu"
    aliases:
    - rm
    - changerace
    tab complete:
    - stop
    script:
    - inventory open d:racemenu

##############
##   MENU   ##
##############

racemenu:
    type: inventory
    debug: false
    title: "             <&3><&l>Race Menu"
    size: 9
    slots:
    - "[] [hylian] [zora] [goron] [kokiri] [fairyrace] [gerudo] [minish] []"

##################
###RaceHandler####
#################

hylian:
    type: item
    debug: false
    material: iron_sword[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&e><&l>Hylian
    lore:
    - "<&c>Increases damage dealt by <&c>5 percent"
    - "<&7>and reduces damage taken from"
    - "<&7>creatures by <&c>20 percent."

zora:
    type: item
    debug: false
    material: cod[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&9><&l>Zora
    lore:
    - "<&7>When you <&c>damage <&7>a target,"
    - "<&7>you have a chance to gain"
    - "<&c>2 hearts<&7> of HP."

goron:
    type: item
    debug: false
    material: leather_chestplate[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&4><&l>Goron
    lore:
    - "<&c>Reduces damage <&7>taken from"
    - "<&7>attacks by <&c>10 percent <&7>and from"
    - "<&7>arrows by <&c>30 percent."

kokiri:
    type: item
    debug: false
    material: bow[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&2><&l>Kokiri
    lore:
    - "<&7>Increases <&c>damage <&7>you deal"
    - "<&7>with arrows by <&c>30 percent."


fairyrace:
    type: item
    debug: false
    material: dragon_breath[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&d><&l>Fairy
    lore:
    - "<&7>Your attacks have a <&c>3 percent"
    - "<&7>chance to inflict a"
    - "<&c>random harmful effect"
    - "<&7>on the target."

gerudo:
    type: item
    debug: false
    material: cactus[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&6><&l>Gerudo
    lore:
    - "<&7>Your attacks deal <&c>50 percent"
    - "<&c>more damage <&7>if the target"
    - "<&7>is <&c>at or below 1/4 HP."

minish:
    type: item
    debug: false
    material: rabbit_foot[hides=ENCHANTS|ATTRIBUTES]
    enchantments:
    - durability:3
    display name: <&a><&l>Minish
    lore:
    - "<&7>You have a <&c>15 percent chance <&7>of"
    - "<&c>avoiding all damage <&7>from"
    - "<&7>any attack."


############
##Binding ##
############

race_handler:
    type: world
    debug: false
    events:
        on player right clicks in racemenu priority:2:
        - determine cancelled

        on player clicks in racemenu priority:2:
        - determine cancelled

        on player drags in racemenu priority:2:
        - determine cancelled

        on player clicks hylian in racemenu priority:1:
        - execute as_player "zc changerace hylian"
        - wait 1t
        - inventory close

        on player clicks zora in racemenu priority:1:
        - execute as_player "zc changerace zora"
        - wait 1t
        - inventory close

        on player clicks goron in racemenu priority:1:
        - execute as_player "zc changerace goron"
        - wait 1t
        - inventory close

        on player clicks kokiri in racemenu priority:1:
        - execute as_player "zc changerace kokiri"
        - wait 1t
        - inventory close

        on player clicks fairyrace in racemenu priority:1:
        - execute as_player "zc changerace fairy"
        - wait 1t
        - inventory close

        on player clicks gerudo in racemenu priority:1:
        - execute as_player "zc changerace gerudo"
        - wait 1t
        - inventory close

        on player clicks minish in racemenu priority:1:
        - execute as_player "zc changerace minish"
        - wait 1t
        - inventory close


####EndScript###
