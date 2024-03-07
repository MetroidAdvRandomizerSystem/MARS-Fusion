; Retains Samus's air velocity

.org 08009208h
.area 18h, 0
    ; retain upwards and horizontal velocity on unspin
    mov     r0, #4
    strb    r0, [r2, SamusState_Pose]
    mov     r1, SamusState_VelocityY
    ldrsh   r0, [r3, r1]
    asr     r1, r0, #1Fh
    bic     r0, r1
    strh    r0, [r2, SamusState_VelocityY]
    ldrh    r0, [r2, SamusState_PositionY]
    add     r0, #20
    strh    r0, [r2, SamusState_PositionY]
    b       080093A8h
.endarea

.org 08006B0Ah
    ; no horizontal decelleration in straight jump
    beq     08006B3Eh

.org 08009A9Ch
    .dw     @MidairMorph

.org 08009BA8h
.area 34h, 0
    ; space optimize the previous switch case
    mov     r0, #1
    mov     r1, SamusState_Animation
    strb    r0, [r3, r1]
    ldr     r0, =SamusStateBackup
    ldrb    r0, [r0, SamusState_ArmCannonDirection]
    cmp     r0, #3
    bhi     @@break
    b       08009D6Ch
@@break:
    b       08009D52h
@MidairMorph:
    ; retain upwards and horizontal velocity on midair morph
    ldr     r2, =SamusStateBackup
    ldrh    r0, [r2, SamusState_VelocityX]
    strh    r0, [r3, SamusState_VelocityX]
    mov     r1, SamusState_VelocityY
    ldrsh   r0, [r2, r1]
    asr     r1, r0, #1Fh
    bic     r0, r1
    strh    r0, [r3, SamusState_VelocityY]
    b       08009BDCh
    .pool
.endarea

.org 0800779Ch
    ; no instant decelleration at peak of morph jump
    nop

.org 08009600h
.area 40h, 0
    ldr     r4, =SamusState
    ldr     r3, =SamusStateBackup
    mov     r0, SamusState_VelocityY
    ldrsh   r0, [r3, r0]
    neg     r0, r0
    cmp     r0, #128
    ble     08009640h
    mov     r0, 03001330h - SamusStateBackup
    ldrb    r0, [r3, r0]
    cmp     r0, #0
    bne     08009640h
    ldrh    r0, [r4, SamusState_PositionY]
    add     r0, #1
    ldrh    r1, [r4, SamusState_PositionX]
    bl      08069100h
    cmp     r0, #3
    beq     08009640h
    ldr     r3, =SamusStateBackup
    mov     r0, #1
    strb    r0, [r4, SamusState_ForcedMovement]
    ldrh    r0, [r3, SamusState_VelocityX]
    strh    r0, [r4, SamusState_VelocityX]
    mov     r0, #50
    strh    r0, [r4, SamusState_VelocityY]
    b       080096C4h
    .pool
.endarea
