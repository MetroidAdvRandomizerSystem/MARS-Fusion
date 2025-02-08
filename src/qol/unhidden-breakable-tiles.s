.org RemoveNeverReformBlocksAndCollectedTanks
.area 10h, 0
    .skip 0Ah
    bl      RevealHiddenBreakableTiles
.endarea

.autoregion
    .align 2
.func RevealHiddenBreakableTiles
    push    { r4-r7 }
    mov     r7, r11
    mov     r6, r10
    mov     r5, r9
    mov     r4, r8
    push    { r4 - r7 }
    ; Check if we should reveal the tiles
    ldr     r0, =@@RevealHiddenTilesFlag
    ldrb    r0, [r0]
    cmp     r0, #0
    beq     @@return
    b       @@load_room_info

@@RevealHiddenTilesFlag:
.if UNHIDDEN_BREAKABLE_TILES
    .dh     01h
.else
    .dh     00h
.endif

@@load_room_info:
    ldr     r7, =LevelLayers + LevelLayers_Clipdata
    ldrh    r6, [r7, LevelLayer_Rows]       ; height
    ldrh    r5, [r7, LevelLayer_Stride]     ; width
    ldr     r7, [r7]
    sub     sp, #8
    str     r5, [sp]                        ; keep width
    str     r6, [sp, #4]                    ; keep height
    mov     r5, #0
    mov     r6, #0

@@loop:
    mov     r1, r7
    ldr     r3, [sp]
    mov     r2, r6
    mul     r2, r3          ; height * room width
    add     r2, r2, r5      ; + width
    lsl     r2, #1
    add     r1, r2
    ldrh    r0, [r7, r2]    ; tile pos = tile + (width + (height * room width))
    cmp     r0, #00h        ; Skip Air Block
    beq     @@inc_width
    cmp     r0, #10h        ; Skip Solid Block
    beq     @@inc_width



@@inc_width:
    add     r5, #1
    ldr     r0, [sp]
    cmp     r5, r0
    ble     @@loop
@@inc_height:
    add     r6, #1
    ldr     r0, [sp, #4]
    cmp     r6, r0
    beq     @@return
    ldr     r5, [sp]
    b       @@loop

@@return:

    mov    r0, #40h
    mov     r1, 5
    mov     r2, 5
    bl      SetBg1Tile

    add     sp, #8
    pop     { r4-r7 }
    mov     r11, r7
    mov     r10, r6
    mov     r9, r5
    mov     r8, r4
    pop     { r4 - r7}
    pop     { r0 }
    bx      r0
    .pool
.endfunc
.endautoregion

.autoregion
    .align 2
@ClipDataReplacements:
   ;.db Clip to check, replacement clip
    .db 5Ah, 40h    ; Crumble Blocks
    .db 55h, 41h    ; Bomb Block (never reform)
    .db 56h, 41h    ; Bomb Block (reform)
    .db 58h, 42h    ; Speed Block (no reform)
    .db 6Bh, 42h    ; Speed Block (reform)
    .db 54h, 43h    ; Missile Block (never reform)
    .db 5Eh, 43h    ; Missile Block (no reform)
    .db 57h, 44h    ; PBomb Block
    .db 59h, 45h    ; Screw Attack Block
    .dh 0FFFFh ;
.endautoregion
