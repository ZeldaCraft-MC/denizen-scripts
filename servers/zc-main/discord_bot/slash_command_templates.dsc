# Discord slash command templates. Only run once.

msg_reply_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> "name:Dm Reply" type:message
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> "name:Reply Through Dms" type:message

force_ticket_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:force_ticket
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> "name:force ticket" type:message
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> "name:force ticket" type:message
    - definemap options:
        1:
          type: user
          name: user
          description: The user you want to force a ticket on
        2:
          type: string
          name: message
          description: The message you want to start the ticket with
        3:
          type: attachment
          name: attachment
          description: Attach something you want to show in the ticket
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:force_ticket "description:Force a user into a ticket" options:<[options]>

check_mod_cmds_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:warnings
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:tempbans
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:permbans
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:unbans
    - definemap options:
        1:
          type: string
          name: ign
          description: The players in game name
          required: true
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:warnings "description:Look at a players their warnings!" options:<[options]>
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:tempbans "description:Look at a players their tempbans!" options:<[options]>
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:permbans "description:Look at a players their permabns!" options:<[options]>
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:unbans "description:Look at a players their unbans!" options:<[options]>
    #- ~discordcommand id:zc-info perms group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:warnings enabled:false enable_for:<list[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>
    #- ~discordcommand id:zc-info perms group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:tempbans enabled:false enable_for:<list[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>
    #- ~discordcommand id:zc-info perms group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:permbans enabled:false enable_for:<list[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>
    #- ~discordcommand id:zc-info perms group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:unbans enabled:false enable_for:<list[<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Game<&sp>Master]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Mod]>|<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>].role[Admin]>]>

help_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:help
    - definemap options:
        1:
          type: string
          name: command
          description: What command you want help with
          required: false
          choices:
            1:
              name: Help command
              value: help
            2:
              name: Times command
              value: times
            3:
              name: Bal command
              value: bal
            4:
              name: Baltop command
              value: baltop
            5:
              name: Stats command
              value: stats
            6:
              name: Finished command
              value: finished
            7:
              name: Votes command
              value: votes
            8:
              name: Vote timer command
              value: vote_timer
            9:
              name: Voters command
              value: voters
            10:
              name: Total votes command
              value: total_votes
            11:
              name: Linkmc command
              value: linkmc
            12:
              name: Class command
              value: class
            13:
              name: Report command
              value: report
            14:
              name: Suggestion command
              value: suggestion
            15:
              name: Ban appeal command
              value: ban_appeal
            16:
              name: Ticket command
              value: ticket
            17:
              name: Trusted command
              value: trusted
            18:
              name: Helper command
              value: helper
            19:
              name: Builder command
              value: builder
            20:
              name: Moderator command
              value: moderator
            21:
              name: Interactions command
              value: interactions
            22:
              name: McMMOstats command
              value: mcmmostats
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:help "description:Shows help about commands" options:<[options]>

report_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:report
    - definemap options:
        1:
          type: string
          name: type
          description: What report would you like to do
          required: true
          choices:
            1:
              name: Bug
              value: bug
            2:
              name: Player / User
              value: user
            3:
              name: Grief
              value: grief
        2:
          type: string
          name: message
          description: the message you want to show (with coords if you'r reporting a grief)
          required: false
        3:
          type: string
          name: user
          description: the user you want to report (only used by user reports)
          required: false
        4:
          type: attachment
          name: attachment
          description: Attach something you want to show in your report
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:report "description:report something or someone" options:<[options]>

votes_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:votes "description:Shows all the voting links"

stats_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The name of the player.
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:stats "description:Shows the player's zcrpg stats" options:<[options]>

finished_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The name of the player.
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:finished "description:Shows the player's finished dungeons" options:<[options]>

times_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The name of the player.
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:times "description:Shows the player's current timings" options:<[options]>

bal_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The name of the player.
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:bal "description:Shows the player's current balance" options:<[options]>

baltop_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: page
          description: The page number you want to look at
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:baltop "description:Shows the top balances of the server" options:<[options]>

ticket_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:ticket
    - definemap options:
        1:
          type: string
          name: message
          description: The message you want to start a ticket iwth
          required: false
        2:
          type: attachment
          name: attachment
          description: Attach something you want to show in your ticket
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:ticket "description:Create a ticket" options:<[options]>

suggestion_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:suggestion
    - definemap options:
        1:
          type: string
          name: message
          description: The message you want to send with your suggestion
          required: false
        2:
          type: attachment
          name: attachment
          description: Attach something you want to show in your suggestion
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:suggestion "description:Create a suggestion" options:<[options]>

vote_timer_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:vote_timer
    - definemap options:
        1:
          type: string
          name: player
          description: the name of the player you want to see the cooldown off
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:vote_timer "description:View the cooldown on the voting sites" options:<[options]>

total_votes_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:total_votes "description:View the total amount of votes"

interactions_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info create name:interactions "description:View the current interactions you have with the bot"

voters_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:voters
    - definemap options:
        1:
          type: integer
          name: page
          description: number of the page you want to see
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:voters "description:Shows top voters" options:<[options]>

ban_appeal_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:ban_appeal
    - definemap options:
        1:
          type: string
          name: ign
          description: What is your in game name (ign)
          required: true
        2:
          type: string
          name: circumstances
          description: Explain the circumstances surrounding your ban
          required: false
        3:
          type: string
          name: reason
          description: Why should we remove or reconsider your ban
          required: false
        4:
          type: string
          name: message
          description: Do you have anything else to say to staff or players about your ban
          required: false
        5:
          type: attachment
          name: attachment
          description: Attach something you want to show in your suggestion
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:ban_appeal "description:Lets you create a ban appeal" options:<[options]>

trusted_app_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:trusted
    - definemap options:
        1:
          type: string
          name: ign
          description: What is your in game name (ign)
          required: true
        2:
          type: string
          name: reason
          description: Why do you want to become trusted?
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:trusted "description:Lets you create a trusted application." options:<[options]>

helper_app_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:helper
    - definemap options:
        1:
          type: string
          name: ign
          description: What is your in game name (ign)
          required: true
        2:
          type: number
          name: age
          description: What is your age?
          required: false
        3:
          type: string
          name: reason
          description: Why do you want to become a helper?
          required: false
        4:
          type: string
          name: helped
          description: Who have you already helped? Please provide examples of what you did to help those players.
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:helper "description:Let you create a helper application" options:<[options]>

build_app_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:builder
    - definemap options:
        1:
          type: string
          name: ign
          description: What is your in game name (ign)
          required: true
        2:
          type: string
          name: time_zone
          description: What time zone are you in? (GMT+?)
          required: false
        3:
          type: number
          name: age
          description: What is your age
          required: false
        4:
          type: string
          name: reason
          description: Why do you feel you should be builder? Do you have any specific skills that would help achieve this?
          required: false
        5:
          type: string
          name: experience
          description: Do you have any previous experiencee with worldedit? if so, how familiar are you with its commands?
          required: false
        6:
          type: string
          name: responsible
          description: Will you be responsible, respectful and co-operative with the staff and other builders?
          required: false
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:builder "description:Start a builders application" options:<[options]>

forcelink_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:force_link
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:forcelink type:message
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:forcelink type:user
    - definemap options:
        1:
          type: user
          name: user
          description: The user you want to force a link with
        2:
          type: string
          name: ign
          description: The player name you want to force a link with
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:force_link "description:Force a user to link their minecraft account" options:<[options]>

linkmc_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: In game name
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:linkmc "description:Allows you to link your minecraft and discord account together" options:<[options]>

mcmmostats_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The name of the player.
          required: false
        2:
          type: string
          name: skill
          description: The skill you want to look at
          required: false
          choices:
            1:
              name: Excavation
              value: excavation
            2:
              name: Fishing
              value: fishing
            3:
              name: Herbalism
              value: herbalism
            4:
              name: Mining
              value: mining
            5:
              name: Woodcutting
              value: woodcutting
            6:
              name: Archery
              value: archery
            7:
              name: Axes
              value: axes
            8:
              name: Swords
              value: swords
            9:
              name: Taming
              value: taming
            10:
              name: Unarmed
              value: unarmed
            11:
              name: Acrobatics
              value: acrobatics
            12:
              name: Alchemy
              value: alchemy
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:mcmmostats "description:Allows you to look up a players McMMO statistics" options:<[options]>

class_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:class
    - definemap options:
        1:
          type: string
          name: role
          description: choose the class you want to be
          required: false
          choices:
            1:
              name: Hylian
              value: hylian
            2:
              name: Zora
              value: zora
            3:
              name: Goron
              value: goron
            4:
              name: Minish
              value: minish
            5:
              name: Yiga
              value: yiga
            6:
              name: Twili
              value: twili
            7:
              name: Sheikah
              value: sheikah
            8:
              name: Rito
              value: rito
            9:
              name: Remove
              value: remove
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:class "description:Bring up the menu for classes" options:<[options]>

mod_app_cmd_run_once:
  type: task
  debug: false
  script:
    #- ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:moderator
    - definemap options:
        1:
          type: string
          name: ign
          description: What is your in game name (ign)
          required: true
        2:
          type: string
          name: time_zone
          description: What time zone are you in? (GMT+?)
          required: true
        3:
          type: number
          name: age
          description: What is your age
          required: true
        4:
          type: string
          name: reason
          description: Why do you want to be mod?
          required: true
        5:
          type: string
          name: experience
          description: Do you have a good understanding of the commands a mod uses?(and list them)
          required: true
        6:
          type: string
          name: responsible
          description: Will you be responsible, calm, mature, and trustworthy?
          required: true
        7:
          type: string
          name: question_1
          description: Some users build has been griefed, what do you do?
          required: true
        8:
          type: string
          name: question_2
          description: Some users are arguing, what do you do?
          required: true
        9:
          type: string
          name: question_3
          description: A user is hurling abusive language at you, what do you do?
          required: true
        10:
          type: string
          name: question_4
          description: Someone enters another person's house without their permission, what do you do?
          required: true
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:moderator "description:Post a moderator application" options:<[options]>

tempban_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:tempban
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
        2:
          type: string
          name: reason
          description: The reason for this tempban
          required: true
        3:
          type: string
          name: time
          description: The duration of this tempban
          required: true
          choices:
            1:
              name: 1 hour
              value: 1h
            2:
              name: 1 day
              value: 1d
            3:
              name: 3 days
              value: 3d
            4:
              name: 5 days
              value: 5d
            5:
              name: 7 days
              value: 7d
            6:
              name: 2 weeks
              value: 14d
            7:
              name: 1 month
              value: 31d
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:tempban "description:Tempban a player for a certain time" options:<[options]>

permban_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:permban
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
        2:
          type: string
          name: reason
          description: The reason for this permban
          required: true
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:permban "description:Permban a player" options:<[options]>

warn_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:warn
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
        2:
          type: string
          name: reason
          description: The reason for this warn
          required: true
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:warn "description:Warn a player" options:<[options]>

mute_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:mute
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
        2:
          type: string
          name: time
          description: The duration of this mute
          required: true
          choices:
            1:
              name: 5 minutes
              value: 5m
            2:
              name: 10 minutes
              value: 10m
            3:
              name: 30 minutes
              value: 30m
            4:
              name: 1 hour
              value: 1h
            5:
              name: 2 hours
              value: 2h
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:mute "description:Mute a player ingame" options:<[options]>

jail_cmd_run_once:
  type: task
  debug: false
  script:
    - ~discordcommand id:zc-info delete group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:jail
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
        2:
          type: string
          name: time
          description: The duration of this jail
          required: true
          choices:
            1:
              name: 5 minutes
              value: 5m
            2:
              name: 10 minutes
              value: 10m
            3:
              name: 30 minutes
              value: 30m
            4:
              name: 1 hour
              value: 1h
            5:
              name: 2 hours
              value: 2h
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:jail "description:Put a player into jail" options:<[options]>

unjail_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:unjail "description:Unjail a certain player" options:<[options]>

unban_cmd_run_once:
  type: task
  debug: false
  script:
    - definemap options:
        1:
          type: string
          name: ign
          description: The in-game name of the player
          required: true
    - ~discordcommand id:zc-info create group:<discord[zc-info].group[<script[zc_bot_info].data_key[group_name]>]> name:unban "description:Unban a certain player" options:<[options]>
