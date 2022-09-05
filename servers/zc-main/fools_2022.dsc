#acquire_fools_gold:
#    type: world
#    debug: false
#    events:
#        on player breaks stone:
#        - if <player.location.world.name> != s1:
#            - stop
#        - if <player.has_flag[morshu_cooldown]>:
#            - stop
#        - narrate "<&7><&lb><&f>Morshu<&7><&rb><&f> You break a dwayne you get golden rain"
#        - playsound <player> sound:zc_sfx.fools.mmmmmm-converted custom volume:2
#        - flag player morshu_cooldown expire:1h
#        - repeat <util.random.int[1].to[5]>:
#            - define items:->:fools_gold
#        - determine <[items]>

morshu_ass:
    type: assignment
    debug: false
    actions:
        on click:
        - if <player.has_flag[morshu_int]>:
            - stop
        - flag <player> morshu_int
        - playsound <player> sound:zc_sfx.music.morshu_beatbox custom volume:3
        - repeat 10:
            - repeat 20:
                - actionbar <&chr[<[value].pad_left[4].with[0]>].font[morshu]>
                - wait 1t
        - adjust <player> stop_sound
        - flag <player> morshu_int:!
morshu_trades_ass:
    type: assignment
    debug: false
    actions:
        on click:
        - if <player.has_flag[morshu_int]>:
            - stop
        - flag <player> morshu_int
        - opentrades trade[inputs=fools_gold[quantity=10];result=morshu_record;max_uses=10] title:Morshu
        - playsound <player> sound:zc_sfx.fools.fart-with-reverb custom volume:2
        - flag <player> morshu_int:!
