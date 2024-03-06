; Patches the post-credits cutscene completion time with a seconds display.

.org 080A148Ah
    ; draw completion time
    ldr     r4, =GameTimer
    ; completion time hours, tens digit
    ldrb    r2, [r4, GameTimer_Hours]
    mov     r0, #205    ; \
    mul     r0, r2      ; | divide byte by 10
    lsr     r0, #11     ; /
    beq     @@skipcall1
    bl      @DrawDigit
@@skipcall1:
    add     r1, #10h
    ; completion time hours, ones digit
    mov     r7, #10
    mul     r0, r7
    sub     r0, r2, r0
    bl      @DrawDigit
    add     r1, #18h
    ; completion time minutes, tens digit
    ldrb    r2, [r4, GameTimer_Minutes]
    mov     r0, #205    ; \
    mul     r0, r2      ; | divide byte by 10
    lsr     r0, #11     ; /
    bl      @DrawDigit
    add     r1, #10h
    ; completion time minutes, ones digit
    mov     r7, #10
    mul     r0, r7
    sub     r0, r2, r0
    bl      @DrawDigit
    add     r1, #18h
    ; completion time seconds, tens digit
    ldrb    r2, [r4, GameTimer_Seconds]
    mov     r0, #205    ; \
    mul     r0, r2      ; | divide byte by 10
    lsr     r0, #11     ; /
    bl      @DrawDigit
    add     r1, #10h
    ; completion time seconds, ones digit
    mov     r7, #10
    mul     r0, r7
    sub     r0, r2, r0
    bl      @DrawDigit
    add     r1, #10h
    ; draw completion percentage
    ldr     r4, =0300151Eh
    ldrb    r2, [r4]
    ; completion percentage hundreds digit
    mov     r0, #164    ; \
    mul     r0, r2      ; | divide byte by 100
    lsr     r0, #14     ; /
    beq     @@skipcall2
    bl      @DrawDigit
@@skipcall2:
    add     r1, #10h
    ; completion percentage tens digit
    mov     r6, r0
    mov     r7, #100
    mul     r0, r7
    sub     r2, r0
    mov     r0, #205    ; \
    mul     r0, r2      ; | divide byte by 10
    lsr     r0, #11     ; /
    orr     r6, r0
    beq     @@skipcall3
    bl      @DrawDigit
@@skipcall3:
    add     r1, #10h
    ; completion percentage ones digit
    mov     r7, #10
    mul     r0, r7
    sub     r0, r2, r0
    bl      @DrawDigit
    b       @End
    .pool
    .fill 4
@DigitGfxDataP1:
    .db     08h, 00h, 0F0h, 00h, 0D5h, 41h, 00h, 00h, 0F0h, 00h, 0E0h, 41h, 02h, 00h, 0F0h, 80h
    .db     0EDh, 01h, 04h, 00h, 0F0h, 00h, 0F5h, 41h, 05h, 00h, 0F0h, 00h, 00h, 40h, 07h, 00h
    .db     0F0h, 80h, 0Dh, 00h, 09h, 00h, 0F0h, 00h, 15h, 40h, 0Ah, 00h, 0F0h, 00h, 20h, 40h
    .db     0Ch
    .fill 15
@DigitGfxDataP2:
    .db     04h, 00h, 0F0h, 00h, 0E8h, 41h, 0Eh, 00h, 0F0h, 00h, 0F3h, 41h, 10h, 00h, 0F0h, 00h
    .db     0FEh, 41h, 12h, 00h, 0F0h, 00h, 09h, 40h, 14h
    .fill 69

.func @DrawDigit
    ; r0: decimal digit
    ; r1: offset of destination object tile
    lsl     r6, r0, #6
    lsl     r7, r1, #2
    ldr     r1, =80000020h
    ldr     r5, =DMA3
    ldr     r0, =0874E650h
    add     r0, r6
    str     r0, [r5, DMA_SAD]
    ldr     r0, =06010000h
    add     r0, r7
    str     r0, [r5, DMA_DAD]
    str     r1, [r5, DMA_CNT]
    ldr     r1, =80000020h
    ldr     r0, =0874E8D0h
    add     r0, r6
    str     r0, [r5, DMA_SAD]
    ldr     r0, =06010400h
    add     r0, r7
    str     r0, [r5, DMA_DAD]
    str     r1, [r5, DMA_CNT]
    ldr     r1, =80000020h
    lsr     r0, r6, #6
    lsr     r1, r7, #2
    mov     pc, lr
    .pool
.endfunc

@End:
    pop     { r3-r4 }
    mov     r8, r3
    mov     r9, r4
    pop     { r4-r7, pc }

.org 0874DC5Ch
.dw @DigitGfxDataP1

.org 0874DC80h
.dw @DigitGfxDataP2

.org 0874DE60h
.dw @DigitGfxDataP1

.org 0874DE84h
.dw @DigitGfxDataP2

.org 0874DFECh
.dw @DigitGfxDataP1

.org 0874E010h
.dw @DigitGfxDataP2

.org 0874E1E4h
.dw @DigitGfxDataP1

.org 0874E208h
.dw @DigitGfxDataP2

.org 0874E454h
.dw @DigitGfxDataP1

.org 0874E478h
.dw @DigitGfxDataP2

.org 087944E4h
.incbin "data/ending-gfx/english.gfx"

.org 087957A8h
.incbin "data/ending-gfx/french.gfx"

.org 087969F4h
.incbin "data/ending-gfx/italian.gfx"

.org 08797D08h
.incbin "data/ending-gfx/spanish.gfx"

.org 08798FBCh
.incbin "data/ending-gfx/german.gfx"
