# needs custom texturepack for the custom.fart_reverb
# dcaff approved
dcaff95_shovel:
  type: item
  debug: false
  material: netherite_shovel
  data:
    discover: true
  display name: Dcaff's shovel
  enchantments:
    - unbreaking: 3
  lore:
    - The ground shakes from these unheavenly sounds.
  recipes:
    1:
      type: shaped
      input:
      - dirt|dirt|dirt
      - dirt|netherite_shovel|dirt
      - dirt|dirt|dirt

fart_Reverb:
  type: world
  events:
    on player breaks block with:dcaff95_shovel:
    - playsound <player> sound:custom.fart_reverb custom
