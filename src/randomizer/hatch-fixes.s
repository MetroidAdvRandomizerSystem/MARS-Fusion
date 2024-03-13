; Hatch fixes that are needed for door lock shuffle

; allow more than 2 lockable hatches that are open
.org 080654ACh
.area 2Ch
    ; check all hatch slots from 5 to 0
    ldr     r0, =HatchData
    mov     r6, #5
    mov     r2, #1
@@loop:
    lsl     r1, r6, #2
    ldrb    r1, [r0, r1]
    and     r1, r2
    cmp     r1, #0
    beq     080654D8h
    sub     r6, #1
    cmp     r6, #0
    blt     08065534h
    b       @@loop
    .pool
.endarea

; determine hatch facing direction from x exit distance
.org 08065500h
.area 0Ch
    ldrb    r0, [r7, DoorEntry_ExitDistanceX]
    cmp     r0, #80h
    bcs     08065524h
    b       0806550Ch
.endarea
