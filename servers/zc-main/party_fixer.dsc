party_recover_task:
  type: task
  debug: false
  script:
    - foreach <yaml[lost_data].read[Parties].keys> as:ol_party:
      - define name <yaml[lost_data].read[Parties].get[<[ol_party]>].get[name]||none>
      - execute as_server "party rename <[ol_party]> <[name]>"
      - wait 1t
