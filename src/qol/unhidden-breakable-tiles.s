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
    mov     r1, r7          ; clipdata
    ldr     r3, [sp]
    mov     r2, r6
    mul     r2, r3          ; height * room width
    add     r2, r2, r5      ; + width
    lsl     r2, #1
    add     r0, r1, r2
    ldr     r1, =3001h
    cmp     r1, r2          ; don't read past Clipdata RAM
    beq     @@return
    ldrh    r0, [r7, r2]    ; tile pos = tile + (width + (height * room width))
    cmp     r0, #ClipdataTile_Air
    beq     @@inc_width
    cmp     r0, #ClipdataTile_Solid
    beq     @@inc_width
    cmp     r0, #ClipdataTile_DoorTransition
    beq     @@inc_width
    bl      @SearchForHiddenBlocks
    mov     r1, #0
    mvn     r1, r1
    lsl     r1, 10h
    lsr     r1, 10h
    cmp     r1, r0  ; if not FFFF
    bne     @@reveal_hidden_block
    b       @@inc_width

@@reveal_hidden_block:
    mov     r0, #40h    ; value
    mov     r1, r6      ; Y Pos
    mov     r2, r5      ; X Pos
    bl      SetSpecialBg1Tile

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
    mov     r5, #1
    b       @@loop

@@return:
    add     sp, #8
    pop     { r4-r7 }
    mov     r11, r7
    mov     r10, r6
    mov     r9, r5
    mov     r8, r4
    pop     { r4-r7 }
    pop     { r0 }
    bx      r0
    .pool
.endfunc
.endautoregion

.autoregion
    .align 2
@ClipDataReplacements:
   ;.db Clip to check, replacement clip
    .dh ClipdataTile_Crumble,            8000h  ;40h
    .dh ClipdataTile_BombNeverRevorm,    8000h  ;41h
    .dh ClipdataTile_BombReform,         8005h  ;41h
    .dh ClipdataTile_SpeedNoReform,      8008h  ;42h
    .dh ClipdataTile_SpeedReform,        8009h  ;42h
    .dh ClipdataTile_MissileNeverReform, 8000h  ;43h
    .dh ClipdataTile_MissileNoReform,    8000h  ;43h
    .dh ClipdataTile_PBomb,              8007h  ;44h
    .dh ClipdataTile_ScrewAttack,        800Ah  ;45h

    .dh ClipdataTile_MissileTankHidden,  8000h
    .dh ClipdataTile_EngergyTankHidden,  8000h
    .dh ClipdataTile_PBombTankHidden,    801Eh
    .dh 0FFFFh, 0FFFFh
.endautoregion


.autoregion
; input
; r0 = Block to Search For
; output
; ???
.align 2
.func @SearchForHiddenBlocks
    push    { r1-r4, lr }
    sub     sp, #4
    mov     r3, #0
    str     r3, [sp]
@@search:
    ldr     r3, [sp]
    lsl     r3, #1
    ldr     r4, =@ClipDataReplacements
    add     r4, r4, r3
    ldrh    r2, [r4]
    mov     r1, #0
    mvn     r1, r1
    lsl     r1, r1, 10h
    lsr     r1, r1, 10h     ; 0FFFFh
    cmp     r0, r1
    beq     @@return_none        ; return if end of list
    ; increment counter



@@return_replacement:
    ldr     r2, =@ClipDataReplacements+2
    ;mov     r2, r4
    add     r2, r2, r3
    ldrh    r2, [r2, #0]
    add     sp, #4
    pop     { r1-r4, pc }



@@return_none:
    ldr     r0, =0FFFFh
    add     sp, #4
    pop     { r1-r4, pc }

.endfunc
.endautoregion
