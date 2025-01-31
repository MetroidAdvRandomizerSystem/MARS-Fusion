; change operations deck level 4 doors to level 0 doors
.org readptr(MiniMapDataPointers + Area_MainDeck * 4)
.area 24Bh
.incbin "data/maps/00-maindeck.lz77"
.endarea

; removed minimap square left of L2 security
.org readptr(MinimapDataPointers + Area_PYR * 4)
.area 1E3h
.incbin "data/maps/03-sector3.lz77"
.endarea

; replace level 4 door tiles to level 3 when navigating destroyed sector 5
.org readptr(MinimapDataPointers + Area_ARC * 4)
.area 1F5h
.incbin "data/maps/05-sector5.lz77"
.endarea

; this map is used for main deck after detachment of secret labratory
; change operations deck level 4 doors to level 0 doors
.defineregion readptr(MiniMapDataPointers + Area_Debug3 * 4), 245h
.org MiniMapDataPointers + Area_Debug3 * 4
.area 04h
    .dw @MainDeckAlternateMinimap
.endarea

.autoregion
@MainDeckAlternateMinimap:
.incbin "data/maps/09-maindeck.lz77"
.endautoregion
