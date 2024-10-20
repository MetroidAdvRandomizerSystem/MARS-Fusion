; Map downloads reveal full minimap info.

.org 08075804h
.area 08h
    tst     r0, r1
    beq     0807580Eh
    lsl     r0, r1, #20h - 0Ch
    lsr     r0, #20h - 0Ch
.endarea

.org 085657A8h
.area 20h
    .dh     2A25h, 7FFFh, 39CEh, 39CEh, 4800h, 2484h, 7FFFh, 03FFh
    .dh     7C00h, 43E2h, 249Fh, 03FFh, 7C00h, 43E2h, 249Fh, 03FFh
.endarea

; map adjustments to match room adjustments
.org readptr(MinimapDataPointers + Area_PYR * 4)
.area 1E3h
.incbin "data/maps/sector3.lz77"
.endarea
