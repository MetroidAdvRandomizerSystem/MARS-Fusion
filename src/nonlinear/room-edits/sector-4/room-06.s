; Reservoir East

; Moves Scizer on Post-Water Pump to be back at the wall instead of at the floor
.org readptr(Sector4Levels + 06h * LevelMeta_Size + LevelMeta_Spriteset1) + (3 * Spriteset_SpriteSize)
.area 3
    .db 0Dh, 26h, 23h
.endarea


; Replace shot-blocks to power bomb tank with never-reform variant
.if ANTI_SOFTLOCK

.org readptr(Sector4Levels + 06h * LevelMeta_Size + LevelMeta_Clipdata)
.area 1D1h
.incbin "data/rooms/S4-06-Clip.rlebg"
.endarea

.endif
