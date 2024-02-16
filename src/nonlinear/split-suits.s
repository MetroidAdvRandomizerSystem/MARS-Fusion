; Splits gravity suit functionality such that only varia protects from
; environmental damage, and damage reduction is incremental.
; Currently varia negates heat and cold damage, reduces lava and acid damage
; by 40%, and negates lava damage when gravity suit is also acquired.

.org 080062BCh
.area 1Ch
	; Environmental damage
	cmp		r4, #EnvironmentalHazard_Water
	bls		0800636Ah
	add		r2, =@@DamageTimers
	ldrb	r2, [r2, r4]
	ldr		r1, =SamusUpgrades
	ldrb	r1, [r1, SamusUpgrades_SuitUpgrades]
	lsr		r0, r1, SuitUpgrade_VariaSuit + 1
	bcc		@@check_timer
	sub		r0, r4, #EnvironmentalHazard_Heat
	cmp		r0, #EnvironmentalHazard_Cold
	bls		0800636Ah
	lsr		r1, SuitUpgrade_GravitySuit + 1
	bcs		@@check_full_suit_lava
	b		@@modify_timer
.endarea
.area 0Ch
	.skip 8
	.pool
.endarea
.area 86h
	.align 4
@@DamageTimers:
	.db		0, 0, 3, 1, 10, 4, 10
	.align 2
@@check_full_suit_lava:
	cmp		r4, #EnvironmentalHazard_Lava
	beq		0800636Ah
@@modify_timer:
	lsl		r0, r2, #1
	add		r2, #1
	lsr		r2, #1
	add		r2, r0
@@check_timer:
	mov		r6, #1
	ldrb	r0, [r5, SamusTimers_EnvironmentalDamage]
	cmp		r0, r2
	blt		0800636Ah
	mov		r7, #1
	sub		r0, r4, #EnvironmentalHazard_Heat
	cmp		r0, #EnvironmentalHazard_Cold
	bhi		0800636Ah
	mov		r0, #8Fh
	bl		Sfx_Play
	cmp		r4, #EnvironmentalHazard_Subzero
	bne		0800636Ah
	ldrb	r0, [r5, SamusTimers_SubzeroKnockback]
	add		r0, #1
	strb	r0, [r5, SamusTimers_SubzeroKnockback]
	cmp		r0, #87
	blt		0800636Ah
	mov		r0, #0
	strb	r0, [r5, SamusTimers_SubzeroKnockback]
	mov		r8, r6
	b		0800636Ah
.endarea

.org 0800FE72h
.area 1Ah
	; Contact damage reduction
	ldr		r5, =SamusUpgrades
	ldrb	r0, [r5, SamusUpgrades_SuitUpgrades]
	lsl		r1, r0,	#1Fh - SuitUpgrade_VariaSuit
	lsr		r1, #1Fh
	lsl		r0, #1Fh - SuitUpgrade_GravitySuit
	lsr		r0, #1Fh
	add		r0, r1
	lsl		r0, #1
	lsl		r1, r4, #1
	add		r1, r4
	lsl		r1, #1
	add		r0, r1
	b		@@cont
.endarea
.area 0Ch
	.skip 4
	.pool
.endarea
.area 28h
@@cont:
	ldr		r1, =082E493Ch
	b		0800FEB8h
	.pool
.endarea
