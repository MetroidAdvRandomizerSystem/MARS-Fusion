; Prevents Samus's aim from getting locked into a diagonal without holding
; the diagonal aim button.

.org 08009B64h
.area 44h, 0
    ldr     r0, =HeldInput
    ldr     r1, =ButtonAssignments
    ldrh    r0, [r0]
    ldrh    r1, [r1, ButtonAssignments_DiagonalAim]
    and     r0, r1
    bne     @@set_arm_cannon_direction
    ldrb    r0, [r3, SamusState_ChargeCounter]
    ldrb    r1, [r3, SamusState_ProjectileType]
    orr     r0, r1
    bne     @@set_arm_cannon_direction
    mov     r0, #1
    strb    r0, [r3, SamusState_ArmSwing]
    b       08009D70h
@@set_arm_cannon_direction:
    ldr     r0, =SamusStateBackup
    ldrb    r0, [r0, SamusState_ArmCannonDirection]
    strb    r0, [r3, SamusState_ArmCannonDirection]
    sub     r0, #1
    lsl     r0, #18h
    lsr     r0, #18h
    cmp     r0, #2
    bhi     @@set_arm_cannon_forward
    b       08009D70h
@@set_arm_cannon_forward:
    b       08009D6Ch
    .pool
.endarea
