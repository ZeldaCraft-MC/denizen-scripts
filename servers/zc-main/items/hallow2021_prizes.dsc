green_was_too_dumb:
  type: task
  debug: false
  script:
    - foreach <server.flag[hallow2021_topall].sort_by_value.keys.reverse.exclude[<server.match_offline_player[pir_te]>]> as:p:
      - flag <[p]> hallow2021_top_spot:<[loop_index]>

hallow2021_receive_command:
  type: command
  debug: false
  name: receive
  usage: /receive
  description: Receive your halloween rewards.
  script:
    - if <player.name> == Pir_te:
      - stop
    - if <player.gamemode> != SURVIVAL:
      - narrate "You can only use this command while in survival!"
      - stop
    - if <player.has_flag[hallow2021_used_cmd]>:
      - narrate "You already used this command!"
      - stop
    - flag player hallow2021_used_cmd
    - if <list[eyelesstenshi|Dcaff95|Darklordsentis|Ghanti|greenleeuw]> contains <player.name>:
      - give candy_shooter
    - if <player.has_flag[hallow2021_top_spot]>:
      - choose <player.flag[hallow2021_top_spot]>:
        - case 1:
          - give hween_item
          - give candy_shooter
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#1<&f> in the halloween 2021 event]>]"
        - case 2:
          - give hween_item
          - give candy_shooter
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#2<&f> in the halloween 2021 event]>]"
        - case 3:
          - give hween_item
          - give candy_shooter
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#3<&f> in the halloween 2021 event]>]"
        - case 4:
          - give candy_shooter
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#4<&f> in the halloween 2021 event]>]"
        - case 5:
          - give candy_shooter
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#5<&f> in the halloween 2021 event]>]"
        - case 6:
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#6<&f> in the halloween 2021 event]>]"
        - case 7:
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#7<&f> in the halloween 2021 event]>]"
        - case 8:
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#8<&f> in the halloween 2021 event]>]"
        - case 9:
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#9<&f> in the halloween 2021 event]>]"
        - case 10:
          - give "final_hours_custom_record[lore=<list[<&f>For becoming <&d>#10<&f> in the halloween 2021 event]>]"
        - default:
          - narrate "You did not get into the top 10."
          - narrate "You will only get participation rewards."
    - if <player.has_flag[candy_donated]>:
      - give hallow2021_bucket_prize
      - repeat 5:
        - give paper[custom_model_data=<list[11400|11500|11600].random>;display=Boarded<&sp>Window]
    - if <player.has_flag[hallow2021_rabbit_return]>:
      - give paper[custom_model_data=11300;display=Bloody<&sp>axe]
    - if <player.has_flag[hallow2021_bat_shots]>:
      - give paper[custom_model_data=12000;display=Pumpkin<&sp>Lights] quantity:10
    - if <player.has_flag[hallow2021_graves_dug]>:
      - give paper[custom_model_data=12100;display=Ghost]
    - if <player.has_flag[hallow2021_treated]>:
      - give paper[custom_model_data=11700;display=Skeleton] quantity:<player.flag[hallow2021_treated]>
    - if <player.has_flag[hallow2021_tricked]>:
      - give paper[custom_model_data=11800;display=Wither<&sp>Skeleton] quantity:<player.flag[hallow2021_tricked]>
    - if <player.has_flag[hallow2021_candy_sorted]>:
      - give paper[custom_model_data=11200;display=Scarecrow]
    - narrate "Your prizes have been put into your inventory!" format:zc_text
    - narrate "If it was full they landed on the ground." format:zc_text
