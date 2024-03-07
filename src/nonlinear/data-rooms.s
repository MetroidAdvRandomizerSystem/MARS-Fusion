; Allows data downloads regardless of the event.

.org 08074F30h
.area 40h, 0
.func CheckOrDownloadDataUpgrade
    push    { lr }
    mov     r2, r0
    ldr     r0, =CurrArea
    ldrb    r0, [r0]
    add     r1, =@@DataRoomLocations
    ldrb    r0, [r1, r0]
    ldr     r1, =MiscProgress
    ldr     r1, [r1, MiscProgress_MajorLocations]
    lsr     r1, r0
    lsr     r1, #1
    bcs     @@fail
    cmp     r2, #0
    beq     @@success
    bl      ObtainMajorLocation
@@success:
    mov     r0, #1
    b       @@return
@@fail:
    mov     r0, #0
@@return:
    pop     { pc }
    .align 4
@@DataRoomLocations:
    .db     MajorLocation_MainDeckData
    .db     0FFh
    .db     MajorLocation_TROData
    .db     MajorLocation_PYRData
    .db     MajorLocation_AQAData
    .db     MajorLocation_ARCData
    .db     0FFh
    .db     MajorLocation_ARCData2  ; second sector 5 download
    .pool
.endfunc
.endarea
