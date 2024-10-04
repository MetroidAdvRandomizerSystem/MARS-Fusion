; Splits gravity suit functionality such that only varia protects from
; environmental damage, and damage reduction is incremental.
; Currently varia negates heat and cold damage, reduces lava and acid damage
; by 40%, and negates lava damage when gravity suit is also acquired.

; NOTE: Damage tick sfx can occur extremely often at higher values of heat,
; subzero, or cold hazard damage. Worth looking into if problems with the
; sound engine start occurring.

.org 08006290h
.area 168h
    push    { r4-r5, lr }
    ldr     r5, =SamusTimers
    ldr     r1, =SamusState
    ldrb    r0, [r1, SamusState_Pose]
    cmp     r0, #3Eh
    beq     @@clear_timers
    ldrh    r0, [r1, SamusState_PositionY]
    ldrh    r1, [r1, SamusState_PositionX]
    bl      08068E70h
    mov     r4, r0
    sub     r0, #EnvironmentalHazard_Lava
    cmp     r0, #EnvironmentalHazard_Cold - EnvironmentalHazard_Lava
    bhi     @@clear_timers
    ldr     r1, =EnvironmentalHazardDps
    ldrb    r2, [r1, r0]
    ldrb    r3, [r5, SamusTimers_EnvironmentalDamage]
    add     r3, r2
    ldr     r1, =SamusUpgrades
    ldrb    r1, [r1, SamusUpgrades_SuitUpgrades]
    lsr     r0, r1, #SuitUpgrade_VariaSuit + 1
    bcc     @@full_damage
    sub     r0, r4, #EnvironmentalHazard_Heat
    cmp     r0, #EnvironmentalHazard_Cold - EnvironmentalHazard_Heat
    bls     @@clear_timers
    lsr     r1, #SuitUpgrade_GravitySuit + 1
    bcc     @@reduced_damage
    cmp     r4, #EnvironmentalHazard_Lava
    beq     @@clear_timers
@@reduced_damage:
    mov     r1, #150
    b       @@divrem_damage
@@full_damage:
    mov     r1, #60
@@divrem_damage:
    mov     r0, #0
    cmp     r3, r1
    blt     @@decrement_energy
@@divrem_damage_loop:
    add     r0, #1
    sub     r3, r1
    cmp     r3, r1
    bge     @@divrem_damage_loop
@@decrement_energy:
    strb    r3, [r5, SamusTimers_EnvironmentalDamage]
    cmp     r0, #0
    beq     @@check_infrequent_damage_sfx
    ldr     r2, =SamusUpgrades
    ldrh    r1, [r2, SamusUpgrades_CurrEnergy]
    sub     r1, r0
    asr     r0, r1, #1Fh
    bic     r1, r0
    strh    r1, [r2, SamusUpgrades_CurrEnergy]
    ldrb    r0, [r5, SamusTimers_EnvironmentalDamageVfx]
    cmp     r0, #0
    bhi     @@check_damage_tick_sfx
    mov     r0, #5
    strb    r0, [r5, SamusTimers_EnvironmentalDamageVfx]
@@check_damage_tick_sfx:
    sub     r0, r4, #EnvironmentalHazard_Heat
    cmp     r0, #EnvironmentalHazard_Cold - EnvironmentalHazard_Heat
    bhi     @@check_infrequent_damage_sfx
    mov     r0, #8Fh
    bl      Sfx_Play
@@check_infrequent_damage_sfx:
    ldrb    r1, [r5, SamusTimers_EnvironmentalDamageSfx]
    add     r1, #1
    strb    r1, [r5, SamusTimers_EnvironmentalDamageSfx]
    sub     r0, r4, #EnvironmentalHazard_Lava
    cmp     r0, #EnvironmentalHazard_Acid - EnvironmentalHazard_Lava
    bhi     @@check_damage_grunt_sfx
    cmp     r1, #1
    beq     @@play_rapid_damage_sfx
    cmp     r1, #26
    bne     @@check_damage_grunt_sfx
@@play_rapid_damage_sfx:
    mov     r0, #8Bh
    bl      Sfx_Play
    b       @@check_knockback
@@check_damage_grunt_sfx:
    cmp     r1, #50
    beq     @@play_damage_grunt_sfx
    b       @@check_knockback
@@play_damage_grunt_sfx:
    mov     r0, #88h
    bl      08003B78h
    mov     r0, #0
    strb    r0, [r5, SamusTimers_EnvironmentalDamageSfx]
@@check_knockback:
    cmp     r4, #EnvironmentalHazard_Subzero
    bne     @@check_hp
    ldrb    r0, [r5, SamusTimers_SubzeroKnockback]
    add     r0, #1
    strb    r0, [r5, SamusTimers_SubzeroKnockback]
    cmp     r0, #87
    blt     @@check_hp
    mov     r0, #0
    strb    r0, [r5, SamusTimers_SubzeroKnockback]
    b       @@return_true
@@check_hp:
    ldr     r1, =SamusUpgrades
    ldrh    r0, [r1, SamusUpgrades_CurrEnergy]
    cmp     r0, #0
    bne     @@return_false
@@return_true:
    mov     r0, #1
    b       @@return
@@clear_timers:
    mov     r0, #0
    strb    r0, [r5, SamusTimers_EnvironmentalDamage]
    strb    r0, [r5, SamusTimers_EnvironmentalDamageSfx]
    strb    r0, [r5, SamusTimers_EnvironmentalDamageVfx]
@@return_false:
    mov     r0, #0
@@return:
    ldrb    r1, [r5, SamusTimers_EnvironmentalDamageVfx]
    sub     r1, #1
    asr     r2, r1, #1Fh
    bic     r1, r2
    strb    r1, [r5, SamusTimers_EnvironmentalDamageVfx]
    pop     { r4-r5, lr }
    .pool
.endarea

.org EnvironmentalHazardDps
.area 05h
    .db     20  ; lava
    .db     60  ; acid
    .db     6   ; heat
    .db     15  ; subzero
    .db     6   ; cold
.endarea

.org 0800FE72h
.area 1Ah
    ; Contact damage reduction
    ldr     r5, =SamusUpgrades
    ldrb    r0, [r5, SamusUpgrades_SuitUpgrades]
    lsl     r1, r0, #1Fh - SuitUpgrade_VariaSuit
    lsr     r1, #1Fh
    lsl     r0, #1Fh - SuitUpgrade_GravitySuit
    lsr     r0, #1Fh
    add     r0, r1
    lsl     r0, #1
    lsl     r1, r4, #1
    add     r1, r4
    lsl     r1, #1
    add     r0, r1
    b       @@cont
.endarea
.area 0Ch
    .skip 4
    .pool
.endarea
.area 28h
@@cont:
    ldr     r1, =082E493Ch
    b       0800FEB8h
    .pool
.endarea
