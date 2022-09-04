common_vote_key:
  type: item
  debug: false
  material: iron_nugget
  mechanisms:
    hides: attributes
    custom_model_data: 100
  display name: <&color[#C0C0C0]>Common <&e>Vote Key
  lore:
  - <&f>Right click a <&color[#C0C0C0]>Common <&e>Vote Crate<&f> to open it
  - <&f>Those can be found in <&d>/spawn
rare_vote_key:
  type: item
  debug: false
  material: gold_nugget
  mechanisms:
    hides: attributes
    custom_model_data: 100
  display name: <&color[#D4AF37]>Rare <&e>Vote Key
  lore:
  - <&f>Right click a <&color[#D4AF37]>Rare <&e>Vote Crate<&f> to open it
  - <&f>Those can be found in <&d>/spawn
common_vote_crate:
  type: item
  debug: false
  material: chest
  display name: <&color[#C0C0C0]>Common <&e>Vote Crate
rare_vote_crate:
  type: item
  debug: false
  material: ender_chest
  display name: <&color[#D4AF37]>Rare <&e>Vote Crate

voting_link_i:
  type: item
  debug: false
  material: paper
#  display name: <&e>Vote for <&a><[site].parsed||error>
#  lore:
#    - <&e>Voting Link<&co>
#    - <&2><script[voting_sites].data_key[sites].get[<[site]>].parsed||error>
#  mechanisms:
#    flag: voting_site:<[site].parsed||error>
cant_vote_i:
  type: item
  debug: false
  material: barrier
#  display name: <&c>Cannot vote on <[site].parsed||error>
#  lore:
#    - <&f>Looks like you already voted today
#    - <&f><player.flag_expiration[voted_<[site].parsed||error>].from_now.formatted||error> until you can vote again
royal_halberd:
  type: item
  debug: false
  material: golden_axe
  display name: <&6>Royal Halberd
  mechanisms:
    hides: attributes
    custom_model_data: 100
    enchantments:
      sharpness: 4
      unbreaking: 2
  lore:
  - <&f>This spear was issued to the knights,
  - <&f>who guarded Hyrule Castle's throne room

Stinky_egg:
  type: item
  debug: false
  material: egg
  display name: <dark_green>Stink Egg
  lore:
  - <&f>Oh man.. that reeks!

Caff_Coupon:
  type: item
  debug: false
  material: paper
  display name: <green>Caff <white>Cou<gold>pon
  lore:
  - <aqua>Can be redeemed
  - <aqua>for 1 free kiss :)

Bottled_fart:
  type: item
  debug: false
  material: potion[color=<color[#A0522D]>]
  display name: <&color[#A0522D]>Bottled fart
  lore:
  - <red>Open at your own risk!
