emotes_command:
  type: command
  debug: false
  name: emotes
  description: A list of emotes.
  usage: /emotes
  script:
    - narrate "<gold>+---------- <yellow>Emotes: Page [<red>1<yellow>/<red>1<yellow>] <gold>----------+"
    - narrate "<yellow>/dance <gray>- ~(‾▿‾)~"
    - narrate "<yellow>/lenny <gray>- ( ͡° ͜ʖ ͡°)"
    - narrate "<yellow>/shrug <gray>- ¯<&bs>_(ツ)_/¯"
    - narrate "<yellow>/srs <gray>- (ಠ_ಠ)"
    - narrate "<yellow>/tableflip <gray>- (╯°□°）╯︵ ┻━┻"
    - narrate "<yellow>/tableback <gray>- ┬──┬ ノ( ゜-゜ノ)"
    - narrate "<yellow>/cool <gray>- (⌐■_■)"
    - narrate "<yellow>/stroll <gray>- ᕕ( ᐛ )ᕗ"
    - narrate "<yellow>/cry <gray>- ｡･ﾟﾟ･(˃д˂)･ﾟﾟ･｡"
    - narrate "<yellow>/beautiful <gray>- ಥ_ಥ"
    - narrate "<yellow>/yuno <gray>- ლ(ಠ益ಠლ)"
    - narrate "<yellow>/eyy <gray>- (☞ﾟ∀ﾟ)☞"
    - narrate "<yellow>/smug <gray>- (￣ω￣)"
    - narrate "<yellow>/oeyy <gray>- (☜ﾟ∀ﾟ☜)"

send_emote:
  type: task
  debug: false
  definitions: emote
  script:
    - definemap map:
        uuid: <player.uuid>
        name: <player.name>
        message: <[emote]>
        prefix: <player.proc[chat_prefix]>
        prefix_simple: <player.proc[chat_prefix_simple]>
        suffix: <player.chat_suffix.trim.parse_color>
        display_name: <player.display_name>
        flair_style: <player.flag[flair_style].if_null[<&r>]>
        skin_blob: <player.skin_blob>
    - announce PLAYER_MESSAGE=<[map]>
    - redis id:publisher publish:global_chat_<bungee.server> message:<[map]>
    - actionbar "<gold>Use <yellow>/emotes<gold> to view more!"

shrug_command:
  type: command
  debug: false
  name: shrug
  description: Idk???
  usage: /shrug
  script:
    - run send_emote def:¯<&bs>_(ツ)_/¯

smug_command:
  type: command
  debug: false
  name: smug
  description: SmugFace
  usage: /smug
  script:
    - run send_emote def:(￣ω￣)

lenny_command:
  type: command
  debug: false
  name: lenny
  description: Displays a lenny face.
  usage: /lenny
  script:
    - run send_emote "def:( ͡° ͜ʖ ͡°)"

tableflip_command:
  type: command
  debug: false
  name: tableflip
  description: FLIP A TABLE
  usage: /tableflip
  script:
    - run send_emote "def:(╯°□°）╯︵ ┻━┻"

tableback_command:
  type: command
  debug: false
  name: tableback
  description: put that table back. Poor table
  usage: /tableback
  script:
    - run send_emote "def:┬──┬ ノ( ゜-゜ノ)"

dance_command:
  type: command
  debug: false
  name: dance
  description: Do a little dance! Make a little love! Get down tonight!
  usage: /dance
  script:
    - run send_emote def:~(‾▿‾)~

srs_command:
  type: command
  debug: false
  name: srs
  description: ... Seriously?
  usage: /srs
  script:
    - run send_emote def:(ಠ_ಠ)

cool_command:
  type: command
  debug: false
  name: cool
  description: rock them shades
  usage: /cool
  script:
    - run send_emote def:(⌐■_■)

stroll_command:
  type: command
  debug: false
  name: stroll
  description: Dont stop me nowww!
  usage: /stroll
  script:
    - run send_emote "def:ᕕ( ᐛ )ᕗ"

cry_command:
  type: command
  debug: false
  name: cry
  description: Cry me a river!
  usage: /cry
  script:
    - run send_emote def:｡･ﾟﾟ･(˃д˂)･ﾟﾟ･｡

beautiful_command:
  type: command
  debug: false
  name: beautiful
  description: Just..so...BEAUTIFUL..
  usage: /beautiful
  script:
    - run send_emote def:ಥ_ಥ

yuno_command:
  type: command
  debug: false
  name: YUNO
  description: Y U NO??
  usage: /yuno
  script:
    - run send_emote def:ლ(ಠ益ಠლ)

eyy_command:
  type: command
  debug: false
  name: eyy
  description: Eyyyyyy!
  usage: /eyy
  script:
    - run send_emote def:(☞ﾟ∀ﾟ)☞

oeyy_command:
  type: command
  debug: false
  name: oeyy
  description: Eyyyyy!(The other way!)
  usage: /oeyy
  script:
    - run send_emote def:☜(ﾟ∀ﾟ☜)
