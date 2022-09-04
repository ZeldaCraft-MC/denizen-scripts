hallow2021_candy_prize:
  type: item
  material: apple
  debug: false
  display name: <&e>Candy
  lore:
    - <&f>it has a sugary taste
  mechanisms:
    custom_model_data: <list[200|300|400|500|600|700|800|900|1000].random>

hallow2021_bucket_prize:
  type: item
  material: paper
  display name: <&e>Candy Bucket
  mechanisms:
    custom_model_data: 11100
  flags:
    custom_uuid: <util.random.uuid>
  lore:
    - <&f>This bucket shows how much candy
    - <&f>You have donated during the halloween 2021 event!
    - <&d><player.flag[candy_donated]><&f> Candies donated!
