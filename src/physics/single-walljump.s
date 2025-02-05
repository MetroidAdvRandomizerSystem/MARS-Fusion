; Hijack setting of Screw Attack Pose. If the pose was WallJumping (16h), set RAM flag
.org 080061D0h
    bl     @SetScrewWJFlag

.autoregion
.align 2
.func @SetScrewWJFlag
    push    { r0-r3 }
    ldr     r2, =SamusState
    ldrb    r0, [r2, SamusState_Pose]
    cmp     r0, #16h
    bne     @@default
    mov     r0, #1
    ldr     r2, =ScrewAttackWJFlag
    strb    r0, [r2]
    ldr     r2, =SamusState
@@default:
    ; Always set Pose to Screw
    mov     r0, #1Eh
    strb    r0, [r2, SamusState_Pose]
    pop     { r0-r3 }
    bl      0800623Ch ; Return to original code flow
    .pool
.endfunc
.endautoregion

; Hijack Spinning Pose Velocity Code. If the ScrewWJ flag is set, do not allow change of directions
; Until Vertical Velocity is <= 0
.org 080072D4h
    bl     @PreventDirectionChangeDuringScrewWJ
.autoregion
.align 2
.func @PreventDirectionChangeDuringScrewWJ
    push    { r2 }
    ; If pose isn't screw attack, allow, and turn flag off if it was on
    ldr     r2, =SamusState
    ldrb    r0, [r2, SamusState_Pose]
    cmp     r0, #1Eh
    bne     @@unsetScrewWJFlag
    ; Check Flag
    ldr     r2, =ScrewAttackWJFlag
    ldrb    r2, [r2]
    cmp     r2, #1
    bne     @@allow
    ldr     r2,=SamusState
    mov     r0, #1Ch
    ldrsh   r0, [r2, r0]
    cmp     r0, #0h
    bgt     @@prevent
@@unsetScrewWJFlag:
    ; Turn ScrewWJ flag off
    mov     r0, #0
    ldr     r2, =ScrewAttackWJFlag
    strb    r0, [r2]
@@allow:
    mov     r0, #0
    strh    r3, [r6, 12h]
    strh    r0, [r6, 1Ah]
    b       @@return
@@prevent:
    ldrh    r3, [r6, 12h]
@@return:
    ldrh    r1, [r6, 10h]
    pop    { r2 }
    bl      080072DCh
    .pool
.endfunc
.endautoregion