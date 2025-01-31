; Hijack code when loading pause screen
.org 0807B90Eh
    bl @LoadRoomName

.autoregion
    .align 2
; Load the current room name. When the code is hijacked, it expects both r2 and r7 to contain the
; address to the text. The code will use r2 to iterate along the text string, but r7 needs the 
; original address
.func @LoadRoomName
    push    { r0, r1, r3 }
    ldr     r2, =RoomNamesAddr
    ldr     r3, =CurrArea
    ldrb    r3, [r3]
    lsl     r3, #2
    ldr     r3, [r2, r3] ; Address of Area Name Table
    ldr     r2, =CurrRoom
    ldrb    r2, [r2]
    lsl     r2, #2
    ldr     r7, [r3, r2]
    ldr     r2, [r7]
    pop     { r0, r1, r3 }
    bx      lr

.endfunc
@UnknownRoom:
    .string  "Unknown Room"
.pool
.endautoregion

.org RoomNamesAddr
.area 1Ch
    .align 4
    .dw     @@Names_MainDeck
    .dw     @@Names_Sector1
    .dw     @@Names_Sector2
    .dw     @@Names_Sector3
    .dw     @@Names_Sector4
    .dw     @@Names_Sector5
    .dw     @@Names_Sector6
.endarea

.region 56h * 4
@@Names_MainDeck:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom
.endregion

.region 35h * 4
@@Names_Sector1:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom
.endregion

.region 3Ch * 4
@@Names_Sector2:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
.endregion

.region 26h * 4
@@Names_Sector3:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom
.endregion

.region 2Fh * 4
@@Names_Sector4:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom
.endregion

.region 33h * 4
@@Names_Sector5:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom
.endregion

.region 28h * 4
@@Names_Sector6:
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
    .dw     @UnknownRoom, @UnknownRoom, @UnknownRoom, @UnknownRoom
.endregion