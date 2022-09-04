Collapse_world:
    type: world
    debug: false
    events:
        on player damages item_frame in:Collapse:
        - determine cancelled
        on player right clicks item_frame in:Collapse:
        - determine cancelled
        on player damages item_frame in:cronus:
        - determine cancelled
        on player right clicks item_frame in:cronus:
        - determine cancelled
        on player damages item_frame in:hephaestus:
        - determine cancelled
        on player right clicks item_frame in:hephaestus:
        - determine cancelled


