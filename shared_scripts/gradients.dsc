rgb_lin:
  type: procedure
  debug: false
  definitions: rgb
  script:
    - define rgb <[rgb].parse[div[255]]>
    - define out <list>
    - foreach <[rgb]>:
      - if <[value]> <= 0.04045:
        - define out:->:<[value].div[12.92]>
      - else:
        - define out:->:<[value].add[0.055].div[1.055].power[2.4]>
    - determine <[out]>

to_rgb:
  type: procedure
  debug: false
  definitions: lin
  script:
    - define out <list>
    - foreach <[lin]>:
      - if <[value]> <= 0.0031308:
        - define f <[value].mul[12.92]>
      - else:
        - define f <[value].power[<element[1].div[2.4]>].mul[1.055].sub[0.055]>
      - define out:->:<[f].mul[255.9999].round_down>
    - determine <[out].separated_by[,]>

lerp:
  type: procedure
  debug: false
  definitions: c1|c2|frac
  script:
    - determine <[c1].mul[<element[1].sub[<[frac]>]>].add[<[c2].mul[<[frac]>]>]>

gradient:
  type: procedure
  debug: false
  definitions: text|start|end|format|gamma
  script:
    - if !<[format].exists>:
      - define format <empty>
    - if !<[gamma].exists>:
      - define gamma 0.43

    - define gamma_inv <element[1].div[<[gamma]>]>
    - define start_rgb <color[<[start]>].rgb.split[,]>
    - define end_rgb <color[<[end]>].rgb.split[,]>

    - define start_lin <[start_rgb].proc[rgb_lin]>
    - define end_lin <[end_rgb].proc[rgb_lin]>

    - define bright_start <[start_lin].sum.power[<[gamma]>]>
    - define bright_end <[end_lin].sum.power[<[gamma]>]>

    - define out <list>
    - define steps <[text].length.sub[0]>
    - foreach <[text].split[]> as:char:
      - define color <list>
      - define step <[loop_index].sub[1]>
      - define intensity <proc[lerp].context[<[bright_start]>|<[bright_end]>|<[step].div[<[steps]>]>].power[<[gamma_inv]>]>
      - foreach <[start_lin]>:
        - define color:->:<proc[lerp].context[<[value]>|<[end_lin].get[<[loop_index]>]>|<[step].div[<[steps]>]>]>
      - define sum <[color].sum>
      - if <[sum]> != 0:
        - define color <[color].parse[mul[<[intensity]>].div[<[sum]>]]>
      - define out:->:<&color[<[color].proc[to_rgb]>]><[format]><[char]>
    - determine <[out].unseparated>
