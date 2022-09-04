denizen_autosaver:
    type: world
    debug: false
    events:
        on delta time minutely every:15:
        - announce to_console "Autosaving Denizen data and Citizens NPCs..."
        - adjust server save
        - wait 1s
        - adjust server save_citizens
