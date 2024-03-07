; Prevents SA-X from becoming invincible due to oversights with hp checks.

.org 0801B250h
.area 3Ch, 0
    ; prevent sa-x samus form from missing death trigger due to being frozen
    push    { r4-r5, lr }
    ldr     r4, =CurrentEnemy
    mov     r5, r4
    add     r5, #20h
@@check_freeze:
    ldrb    r0, [r5, Enemy_Pose - 20h]
    cmp     r0, #50h
    bhi     @@switch_pose
    bl      08017B5Ch
    cmp     r0, #0
    beq     @@check_hit
    ldrh    r0, [r4, Enemy_Health]
    cmp     r0, #0
    beq     @@unfreeze
    b       0801B50Ch
@@unfreeze:
    strb    r0, [r5, Enemy_FreezeTimer - 20h]
    strb    r0, [r5, Enemy_Palette - 20h]
@@check_hit:
    bl      080157FCh
    ldrb    r0, [r5, Enemy_OnHitTimer - 20h]
    mov     r1, #7Fh
    and     r0, r1
    cmp     r0, #16
    bne     @@switch_pose
@@set_hit_pose:
    mov     r0, #4Fh
    strb    r0, [r5, Enemy_Pose - 20h]
    mov     r0, #9Ch
    bl      Sfx_Play
@@switch_pose:
    ldrb    r0, [r5, Enemy_Pose - 20h]
.endarea
    .skip 10h
.area 04h
    .pool
.endarea

.org 08050938h
.area 40h
    ; prevent sa-x monster form from missing death trigger between poses
    push    { lr }
    mov     r2, r0
    ldr     r1, =CurrentEnemy
    ldrh    r0, [r1, Enemy_Health]
    cmp     r0, #0
    beq     @@hit
    add     r1, #Enemy_OnHitTimer
    ldrb    r0, [r1]
    mov     r1, #7Fh
    and     r0, r1
    cmp     r0, #8
    bne     @@return_false
@@hit:
    cmp     r2, #0
    bne     @@airborne
    bl      080511E0h
    b       @@play_hit_sfx
@@airborne:
    bl      08051108h
@@play_hit_sfx:
    mov     r0, #0FFh
    add     r0, #0E0h
    bl      08002854h
    mov     r1, #1
    b       @@return
@@return_false:
    mov     r0, #0
@@return:
    pop     { pc }
    .pool
.endarea
