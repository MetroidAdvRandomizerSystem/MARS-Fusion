; Rewrites the credits format for space optimization and more flexibility.

.org 080A2138h
.area 8Ch
    ldrb    r1, [r4, #08h]
    cmp     r1, #07Fh
    bls     @@increment_scroll_counter
    mov     r0, #07Fh
    and     r0, r1
    strb    r0, [r4, #08h]
    bl      @IncrementRow
    ldrh    r0, [r4, #02h]
    ldrh    r1, [r4, #04h]
    cmp     r0, r1
    bne     @@check_twoline
    ldrh    r0, [r4, #06h]
    bl      @DrawCreditsLine
    cmp     r0, #0
    bge     @@set_next_row
    ldrb    r0, [r4, #01h]
    add     r0, #1
    strb    r0, [r4, #01h]
    b       @@increment_row_counter
@@set_next_row:
    ldrh    r1, [r4, #04h]
    add     r0, r1
    strh    r0, [r4, #04h]
    ldrh    r0, [r4, #06h]
    add     r0, #1
    strh    r0, [r4, #06h]
    b       @@queue_draw
@@check_twoline:
    ldrb    r0, [r4, #09h]
    cmp     r0, #0
    beq     @@queue_draw
    mov     r0, #0
    strb    r0, [r4, #09h]
    b       @@increment_row_counter
@@queue_draw:
    ldrb    r0, [r4]
    add     r0, #1
    strb    r0, [r4]
@@increment_row_counter:
    ldrh    r0, [r4, #02h]
    add     r0, #1
    strh    r0, [r4, #02h]
@@increment_scroll_counter:
    ldrb    r0, [r4, #08h]
    add     r0, #9
    strb    r0, [r4, #08h]
    ldr     r1, =03001226h
    ldrh    r0, [r1]
    add     r0, #9
    strh    r0, [r1]
    b       080A22D8h
    .pool
.endarea

.org 080A22E0h
.area 26Ch
.func @IncrementRow
    ; clear current row vram
    mov     r0, #0
    mov     r1, #1Fh << 1
    ldr     r2, =03001484h
    mov     r3, r2
    add     r2, #4Ah
    add     r3, #0Ah
@@bitfill_loop:
    strh    r0, [r2, r1]
    strh    r0, [r3, r1]
    sub     r1, #2
    cmp     r1, #0
    bge     @@bitfill_loop
    ; increment row counters
    ldr     r3, =03001484h
    ldrh    r0, [r3, #02h]
    lsl     r2, r0, #6
    add     r3, #8Ch
    mov     r0, #50h
    lsl     r0, #04h
    add     r0, r2
    lsl     r0, #15h
    lsr     r0, #15h
    mov     r1, #80h
    lsl     r1, #08h
    add     r0, r1
    str     r0, [r3]
    mov     r0, #54h
    lsl     r0, #04h
    add     r0, r2
    lsl     r0, #15h
    lsr     r0, #15h
    mov     r1, #80h
    lsl     r1, #08h
    add     r0, r1
    str     r0, [r3, #4]
    bx      lr
    .pool
.endfunc

.func @DrawCreditsLine
    push    { r4-r5 }
    ldr     r2, =Credits
    lsl     r1, r0, #3
    add     r0, r1
    lsl     r0, #2
    add     r2, r0
    mov     r5, r2
    ldrb    r1, [r5, CreditsLine_Type]
    cmp     r1, #CreditsLineType_Copyright4
    bls     @@switch_line_type
    b       @@return_skip
@@switch_line_type:
    add     r0, =@@branch_table
    ldrb    r0, [r0, r1]
    lsl     r0, #1
@@branch:
    add     pc, r0
    .align 4
@@branch_table:
    .db     (@@case_blue - @@branch - 4) >> 1
    .db     (@@case_red - @@branch - 4) >> 1
    .db     (@@case_white - @@branch - 4) >> 1
    .db     (@@return_skip - @@branch - 4) >> 1
    .db     (@@return_skip - @@branch - 4) >> 1
    .db     (@@return_skip - @@branch - 4) >> 1
    .db     (@@case_end - @@branch - 4) >> 1
    .db     (@@return_skip - @@branch - 4) >> 1
    .db     (@@return_skip - @@branch - 4) >> 1
    .db     (@@return_skip - @@branch - 4) >> 1
    .db     (@@case_copyright1 - @@branch - 4) >> 1
    .db     (@@case_copyright2 - @@branch - 4) >> 1
    .db     (@@case_copyright3 - @@branch - 4) >> 1
    .db     (@@case_copyright4 - @@branch - 4) >> 1
.if ((@@return_skip - @@branch - 4) >> 1) >= (1 << 8)
    .error "Branch table overflowed"
.endif
    .align 2
@@case_blue:
    mov     r4, #0
    b       @@write_oneline
@@case_red:
    mov     r4, #1
    lsl     r4, #0Ch
@@write_oneline:
    add     r2, #CreditsLine_Text
    ldr     r3, =03001484h
    add     r3, #0Ah
@@write_oneline_loop:
    ldrb    r1, [r2]
    cmp     r1, #0
    bne     @@write_oneline_check_uppercase
    b       @@return_skip
@@write_oneline_check_uppercase:
    mov     r0, r1
    sub     r0, #41h
    cmp     r0, #26
    bhs     @@write_oneline_check2E
    mov     r0, #0FCh
    lsl     r0, #4
    add     r0, r1
    b       @@write_oneline_char
@@write_oneline_check2E:
    mov     r0, #10h
    lsl     r0, #08h
    cmp     r1, #2Eh
    bne     @@write_oneline_check2C
    add     r0, #1Bh
    b       @@write_oneline_char
@@write_oneline_check2C:
    cmp     r1, #2Ch
    bne     @@write_oneline_check26
    add     r0, #1Ch
    b       @@write_oneline_char
@@write_oneline_check26:
    cmp     r1, #26h
    bne     @@write_oneline_loop_inc
    add     r0, #1Dh
@@write_oneline_char:
    add     r0, r4
    strh    r0, [r3]
@@write_oneline_loop_inc:
    add     r2, #1
    add     r3, #2
    b       @@write_oneline_loop
@@case_white:
    add     r2, #CreditsLine_Text
    ldr     r3, =03001484h
    mov     r0, #1
    strb    r0, [r3, #09h]
    mov     r4, r3
    add     r3, #0Ah
    add     r4, #4Ah
@@write_twoline_loop:
    ldrb    r1, [r2]
    cmp     r1, #0
    beq     @@return_twoline_skip
    ; check uppercase letters
    mov     r0, r1
    sub     r0, #41h
    cmp     r0, #26
    bhs     @@write_twoline_check_lowercase
    sub     r0, r1, #1
    strh    r0, [r4]
    sub     r0, #20h
    strh    r0, [r3]
    b       @@write_twoline_loop_inc
@@write_twoline_check_lowercase:
    sub     r0, #20h
    cmp     r0, #26
    bhs     @@write_twoline_check2E
    sub     r0, r1, #1
    strh    r0, [r3]
    add     r0, #20h
    strh    r0, [r4]
    b       @@write_twoline_loop_inc
@@write_twoline_check2E:
    cmp     r1, #2Eh
    bne     @@write_twoline_check2C
    mov     r0, #5Bh
    strh    r0, [r4]
    b       @@write_twoline_loop_inc
@@write_twoline_check2C:
    cmp     r1, #2Ch
    bne     @@write_twoline_check2D
    mov     r0, #5Ch
    strh    r0, [r4]
    b       @@write_twoline_loop_inc
@@write_twoline_check2D:
    cmp     r1, #2Dh
    bne     @@write_twoline_check2B
    mov     r0, #3Ah
    strh    r0, [r3]
    b       @@write_twoline_loop_inc
@@write_twoline_check2B:
    cmp     r1, #2Bh
    bne     @@write_twoline_loop_inc
    mov     r0, #7Ah
    strb    r0, [r3]
    mov     r0, #5Bh
    strh    r0, [r4]
@@write_twoline_loop_inc:
    add     r2, #1
    add     r3, #2
    add     r4, #2
    b       @@write_twoline_loop
@@case_end:
    mov     r0, #1
    neg     r0, r0
    b       @@return
@@case_copyright1:
    mov     r1, #8
    ldr     r2, =03001484h
    add     r2, #1Ah
@@case_copyright1_write_loop:
    mov     r0, r1
    add     r0, #98h
    strh    r0, [r2]
    add     r1, #1
    add     r2, #2
    cmp     r1, #15h
    ble     @@case_copyright1_write_loop
    b       @@return_skip
@@case_copyright2:
    mov     r1, #6
    ldr     r2, =03001484h
    add     r2, #16h
@@case_copyright2_write_loop:
    mov     r0, r1
    add     r0, #0BAh
    strh    r0, [r2]
    add     r1, #1
    add     r2, #2
    cmp     r1, #17h
    ble     @@case_copyright2_write_loop
    b       @@return_skip
@@case_copyright3:
    mov     r0, #0DCh
    mov     r1, #4
    ldr     r2, =03001484h
    add     r2, #12h
@@case_copyright3_write_loop:
    mov     r0, r1
    add     r0, #0DCh
    strh    r0, [r2]
    add     r1, #1
    add     r2, #2
    cmp     r1, #19h
    ble     @@case_copyright3_write_loop
    b       @@return_skip
@@case_copyright4:
    mov     r0, #0FAh
    mov     r1, #6
    ldr     r2, =03001484h
    add     r2, #15h
@@case_copyright4_write_loop:
    mov     r0, r1
    add     r0, #0FAh
    strh    r0, [r2]
    add     r1, #1
    add     r2, #2
    cmp     r1, #17h
    ble     @@case_copyright4_write_loop
    b       @@return_skip
@@return_skip:
    ldrb    r0, [r5, CreditsLine_Skip]
    add     r0, #1
    b       @@return
@@return_twoline_skip:
    ldrb    r0, [r5, CreditsLine_Skip]
    add     r0, #2
@@return:
    pop     { r4-r5 }
    bx      lr
    .pool
.endfunc
.endarea

.org Credits
.area 2B98h
.incbin "data/credits.bin"
.endarea

