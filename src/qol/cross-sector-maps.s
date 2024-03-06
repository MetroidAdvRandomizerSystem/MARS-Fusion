; Change the map screen to show the next sector instead of the current sector
; tank counts when the select button is pressed

.autoregion
    .align 2
.func CycleSectorMaps
    push    { r4, lr }
    cmp     r0, #0
    beq     @@cycle_sector
    ldr     r0, =CurrArea
    ldrb    r4, [r0]
    ldr     r1, =03000B85h
    mov     r0, #0
    strb    r0, [r1]
    ldr     r1, =0300163Ah
    b       @@reenable_loc_flash
@@cycle_sector:
    ldr     r2, =03001696h
    ldrb    r0, [r2]
    add     r0, #1
    sub     r1, r0, Area_NOC + 1
    asr     r1, #1Fh
    and     r0, r1
    strb    r0, [r2]
    mov     r4, r0
    ldr     r1, =MenuSprites + 12h * MenuSprite_Size
    lsl     r0, #1
    add     r0, #MenuSpriteGfx_MainDeckSignTurningOn
    strb    r0, [r1, MenuSprite_Graphic]
    ldr     r1, =CurrArea
    ldrb    r0, [r1]
    ldr     r1, =0300163Ah
    cmp     r0, r4
    beq     @@reenable_loc_flash
    mov     r0, #0
    b       @@set_loc_flash
@@reenable_loc_flash:
    mov     r0, #1
@@set_loc_flash:
    strb    r0, [r1]
    mov     r0, r4
    ldr     r1, =02034000h
    bl      08077084h
    mov     r0, r4
    bl      0807576Ch
    ldr     r1, =DMA3
    ldr     r0, =02034000h
    str     r0, [r1, DMA_SAD]
    ldr     r0, =0600E000h
    str     r0, [r1, DMA_DAD]
    ldr     r0, =80000400h
    str     r0, [r1, DMA_CNT]
    ldr     r0, [r1, DMA_CNT]
    mov     r0, #1
    bl      08075988h
    add     r1, =@@MapStartCoords
    lsl     r0, r4, #1
    add     r1, r0
    ldr     r2, =030016DCh
    ldr     r3, =BgPositions
    ldrb    r0, [r1]
    strb    r0, [r2]
    add     r0, #(200h >> 3) - 15
    lsl     r0, #3
    strh    r0, [r3, BgPositions_Bg3X]
    ldrb    r0, [r1, #1]
    strb    r0, [r2, #1]
    add     r0, #(200h >> 3) - 10
    lsl     r0, #3
    strh    r0, [r3, BgPositions_Bg3Y]
    pop     { r4, pc }
    .pool
    .align 4
@@MapStartCoords:
    .db     13, 8
    .db     8, 4
    .db     5, 2
    .db     10, 6
    .db     10, 7
    .db     6, 5
    .db     7, 6
.endfunc
.endautoregion

.org 0807686Ch
.area 06h
    mov     r0, #1
    bl      CycleSectorMaps
.endarea

.org 08075720h
.area 14h
    mov     r0, #0
    bl      CycleSectorMaps
    b       0807572Ch
.endarea
