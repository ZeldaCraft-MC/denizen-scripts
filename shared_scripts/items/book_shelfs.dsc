use_bookshelf_i:
  type: item
  material: bookshelf
  debug: false
  display name: <&f>Usable bookshelf
  lore:
  - <&f>Stores any kind of book you want
  recipes:
    1:
        type: shaped
        output_quantity: 8
        input:
        - bookshelf|bookshelf|bookshelf
        - bookshelf|chest|bookshelf
        - bookshelf|bookshelf|bookshelf

use_bookshelf_w:
  type: world
  debug: false
  events:
    on player places use_bookshelf_i:
    - if !<player.has_flag[bookshelfs]>:
      - define num 1
    - else:
      - define num <player.flag[bookshelfs].keys.last.add[1]>
    - flag <context.location> bookshelf.<player>:<[num]>
    - flag player bookshelfs.<[num]>.loc:<context.location>
    - flag player bookshelfs.<[num]>.inv:<list>
    on player right clicks block location_flagged:bookshelf:
    - if <player.is_sneaking>:
      - stop
    - determine passively cancelled
    - if <context.location.material.name> != bookshelf:
      - flag <context.location> bookshelf:!
      - stop
    - define p <context.location.flag[bookshelf].keys.first>
    - define num <context.location.flag[bookshelf].get[<[p]>]>
    - flag player current_bookshelf.items:<[p].flag[bookshelfs.<[num]>.inv]>
    - inventory open d:use_bookshelf_inv
    - flag player current_bookshelf.num:<[num]>
    - flag player current_bookshelf.p:<[p]>
    on player clicks item in use_bookshelf_inv:
    - if !<context.item.material.name.advanced_matches[*book]>:
      - stop
    - ratelimit <player> 4t
    - if <context.clicked_inventory> == <context.inventory>:
      - give <context.item> to:<player.inventory>
      - take slot:<context.slot> quantity:64 from:<context.inventory>
      - define items <context.inventory.list_contents>
      - flag <player.flag[current_bookshelf.p].as_player> bookshelfs.<player.flag[current_bookshelf.num]>.inv:<[items]>
      - foreach <server.online_players_flagged[current_bookshelf]> as:p:
        - if <[p].flag[current_bookshelf.p]> == <player.flag[current_bookshelf.p]> && <[p].flag[current_bookshelf.num]> == <player.flag[current_bookshelf.num]>:
          - flag <[p]> current_bookshelf.items:<player.flag[current_bookshelf.p].as_player.flag[bookshelfs.<player.flag[current_bookshelf.num]>.inv]>
          - flag <[p]> no_close_e expire:2t
          - inventory open d:use_bookshelf_inv player:<[p]>
    - else:
      - if !<context.inventory.can_fit[<context.item>]>:
        - stop
      - give <context.item> to:<context.inventory>
      - take slot:<context.slot> quantity:64 from:<player.inventory>
      - define items <context.inventory.list_contents>
      - flag <player.flag[current_bookshelf.p].as_player> bookshelfs.<player.flag[current_bookshelf.num]>.inv:<[items]>
      - foreach <server.online_players_flagged[current_bookshelf]> as:p:
        - if <[p].flag[current_bookshelf.p]> == <player.flag[current_bookshelf.p]> && <[p].flag[current_bookshelf.num]> == <player.flag[current_bookshelf.num]>:
          - flag <[p]> current_bookshelf.items:<player.flag[current_bookshelf.p].as_player.flag[bookshelfs.<player.flag[current_bookshelf.num]>.inv]>
          - flag <[p]> no_close_e expire:2t
          - inventory open d:use_bookshelf_inv player:<[p]>
    on player closes use_bookshelf_inv:
    - if <player.has_flag[no_close_e]>:
      - stop
    - define items <context.inventory.list_contents>
    - if !<player.has_flag[current_bookshelf]> || !<player.flag[current_bookshelf.p].as_player.has_flag[bookshelfs.<player.flag[current_bookshelf.num]>]>:
      - narrate "Something went wrong we gave you the books back just incase!"
      - give <[items]>
      - stop
    - flag <player.flag[current_bookshelf.p].as_player> bookshelfs.<player.flag[current_bookshelf.num]>.inv:<[items]>
    - flag player current_bookshelf:!
    on bookshelf burns location_flagged:bookshelf:
    - run return_books def:<context.location>
    on block destroyed by explosion location_flagged:bookshelf:
    - run return_books def:<context.location>
    on block fades location_flagged:bookshelf:
    - run return_books def:<context.location>
    on piston extends:
    - if <context.blocks.filter[has_flag[bookshelf]].is_empty>:
      - stop
    - foreach <context.blocks.filter[has_flag[bookshelf]]> as:loc:
      - define p <[loc].flag[bookshelf].keys.first>
      - define num <[loc].flag[bookshelf].get[<[p]>]>
      - flag <[loc].add[<context.direction>]> bookshelf.<[p]>:<[num]>
      - flag <[loc]> bookshelf:!
    on piston retracts:
    - if <context.blocks.filter[has_flag[bookshelf]].is_empty>:
      - stop
    - foreach <context.blocks.filter[has_flag[bookshelf]]> as:loc:
      - define p <[loc].flag[bookshelf].keys.first>
      - define num <[loc].flag[bookshelf].get[<[p]>]>
      - flag <[loc].add[<context.direction>]> bookshelf.<[p]>:<[num]>
      - flag <[loc]> bookshelf:!
    on player breaks block location_flagged:bookshelf:
    - run return_books def:<context.location>
    - determine use_bookshelf_i
    on entity changes block location_flagged:bookshelf:
    - run return_books def:<context.location>

return_books:
  type: task
  debug: false
  definitions: loc
  script:
    - if <[loc].material.name> != bookshelf:
      - flag <[loc]> bookshelf:!
      - stop
    - define p <[loc].flag[bookshelf].keys.first.as_player>
    - define num <[loc].flag[bookshelf].get[<[p]>]>
    - if <[p].is_online>:
      - if !<[p].flag[bookshelfs.<[num]>.inv].is_empty>:
        - narrate "A bookshelf has been broken, the books got put in your inventory"
      - give <[p].flag[bookshelfs.<[num]>.inv]> to:<[p].inventory>
      - flag <[p]> bookshelfs.<[num]>:!
    - else:
      - drop <[p].flag[bookshelf.<[num]>.inv]> <[loc]> delay:10s
      - flag <[p]> bookshelfs.<[num]>:!
    - flag <[loc]> bookshelf:!

use_bookshelf_inv:
  type: inventory
  inventory: hopper
  title: Bookshelf
  debug: false
  gui: true
  procedural items:
    - define items <player.flag[current_bookshelf.items]>
    - determine <[items]>
  slots:
  - [] [] [] [] []
