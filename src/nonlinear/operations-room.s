; Allows the operations room to be used regardless of the event.

.org 08039A14h
.area 24h, 0
    ; Init operations room pad
    ldr     r0, =CurrEvent
    ldrb    r0, [r0]
    cmp     r0, #Event_SaxDefeated
    bgt     08039A68h   ; escape already triggered
    mov     r1, #0
    mov     r5, #0
    mov     r0, r4
    add     r0, #2Fh
    b       08039A4Eh   ; pre-escape
    .pool
.endarea

.org  08039C42h
    ; Set escape sequence event
    bl      SetEvent

.org 08065282h
    ; Force operations deck event effect
    bgt     080652B8h
