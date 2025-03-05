; Cultivation Station
; Change the single bomb block to shot block to prevent potential softlock
.if ANTI_SOFTLOCK

.org readptr(Sector2Levels + 0Ah * LevelMeta_Size + LevelMeta_Clipdata)
.area 11Ah
.incbin "data/rooms/S2-0A-Clip.rlebg"
.endarea

.endif
