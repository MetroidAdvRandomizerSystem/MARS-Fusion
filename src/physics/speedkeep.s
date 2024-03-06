; Retains Samus's speed

.org 08006240h
.area 50h, 0
    ; don't accelerate past speed cap, but do retain previous speed
    sxth    r2, r1
    sxth    r1, r0
    ldr     r3, =SamusState
    ldrh    r0, [r3, SamusState_Direction]
    lsr     r0, Button_Right + 1
    mov     r0, SamusState_VelocityX
    ldrsh   r0, [r3, r0]
    bcs     @@noNegate
    neg     r0, r0
@@noNegate:
    cmp     r0, r2
    bge     @@return
    add     r0, r1
    cmp     r0, r2
    bls     @@setVelocity
    mov     r0, r2
@@setVelocity:
    ldrh    r2, [r3, SamusState_Direction]
    lsr     r2, Button_Right + 1
    bcs     @@noNegateSet
    neg     r0, r0
@@noNegateSet:
    strh    r0, [r3, SamusState_VelocityX]
@@return:
    bx      lr
    .pool
.endarea
