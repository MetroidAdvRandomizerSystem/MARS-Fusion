; Allows bosses to be fought, killed, and absorbed regardless of the event.

; TODO: fix BOX spawning
; TODO: fix projectile vfx and sfx when hitting zazabi
; TODO: test all bosses

.org 08025400h
.area 38h, 0
	; check arachnus and zazabi kill status before spawning
	ldrb	r0, [r5, Enemy_Id]
	sub		r0, EnemyId_Arachnus_CoreXNucleus
	beq		@@checkStatus
	sub		r0, EnemyId_Zazabi_CoreXNucleus - EnemyId_Arachnus_CoreXNucleus
	bne		08025438h
	mov		r0, Boss_Zazabi
	mov		r4, #4Bh
	mov		r1, #5Eh
	mov		r12, r1
@@checkStatus:
	ldr		r1, =MiscProgress
	ldrh	r1, [r1, MiscProgress_Bosses]
	lsr		r1, r0
	lsr		r1, #1
	bcs		08025438h
	b		08025444h
	.pool
.endarea

.org 0802D5E4h
.area 28h, 0
	; check charge core-x kill status before spawning
	ldr		r4, =CurrentEnemy
	mov		r0, Enemy_IgnoreSamusCollisionTimer
	mov		r5, #1
	strb	r5, [r4, r0]
	mov		r3, #0
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_ChargeCoreX + 1
	bcc		0802D60Ch
	strb	r3, [r4, Enemy_Status]
	b		0802D6BCh
	.pool
.endarea

.org 0803A08Ah
.area 2Ah, 0
	; check wide core-x kill status before spawning
	ldr		r4, =CurrentEnemy
	mov		r0, Enemy_IgnoreSamusCollisionTimer
	mov		r5, #1
	strb	r5, [r4, r0]
	mov		r2, r4
	mov		r4, #0
	mov		r5, #2
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_WideCoreX + 1
	bcc		0803A0B4h
	strb	r4, [r2, Enemy_Status]
	b		0803A0FCh
	.pool
.endarea

.org 08043D24h
.area 20h, 0
	; check nettori kill status before spawning
	mov		r7, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_Nettori + 1
	bcc		08043D44h
	strb	r7, [r4, Enemy_Status]
	b		08043E44h
	.pool
.endarea

.org 08047820h
.area 20h, 0
	; check serris kill status before spawning
	mov		r7, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_Serris + 1
	bcc		08047840h
	strb	r7, [r4, Enemy_Status]
	b		0804797Ch
	.pool
.endarea

.org 08051ABCh
.area 20h, 0
	; check x-box kill status before spawning
	mov		r7, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_XBox + 1
	bcc		08051ADCh
	strb	r7, [r4, Enemy_Status]
	b		08051C82h
	.pool
.endregion

.org 08057564h
.area 24h, 0
	; check varia core-x kill status before spawning
	mov		r6, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_MegaCoreX + 1
	bcc		08057588h
	strb	r6, [r4, Enemy_Status]
	b		08057694h
	.pool
.endarea

.org 0805B592h
.area 22h, 0
	; check ridley kill status before spawning
	mov		r4, #0
	mov		r5, #8
	ldr		r1, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_Ridley + 1
	bcc		0805B5B4h
	mov		r0, #0
	strb	r0, [r1, Enemy_Status]
	b		0805B5FCh
	.pool
.endregion

.org 0805BDB8h
.area 20h, 0
	; check yakuza kill status before spawning
	mov		r6, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_Yakuza + 1
	bcc		0805BDD8h
	strb	r6, [r4, Enemy_Status]
	b		0805BEA0h
	.pool
.endarea

.org 0805DDD4h
.area 20h, 0
	; check nightmare kill status before spawning
	mov		r7, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsr		r0, Boss_Nightmare + 1
	bcc		0805DDF4h
	strb	r7, [r4, Enemy_Status]
	b		0805DFA0h
	.pool
.endarea

.org 08060D38h
.area 18h, 0
	; check if box is dead or defeated
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	lsl		r1, r0, 1Fh - Boss_Box
	lsr		r1, 1Fh
	lsl		r0, 1Fh - Boss_XBox
	lsr		r0, 1Fh
	orr		r0, r1
	bx		lr
	.pool
.endarea

.org 08060D50h
.area 18h, 0
	; check if box is not dead or defeated
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Bosses]
	mvn		r0, r0
	lsl		r1, r0, 1Fh - Boss_Box
	lsr		r1, 1Fh
	lsl		r0, 1Fh - Boss_XBox
	lsr		r0, 1Fh
	and		r0, r1
	bx		lr
	.pool
.endarea

.org 08025AD4h
	; prevent core-x post-boss music from persisting
	mov		r1, MusicType_Transient

.org 0802E564h
	; prevent beam core-x post-boss music from persisting
	mov		r1, MusicType_Transient

.org 08045474h
.area 18h, 0
	; make zazabi take damage from any missile or charge beam projectile type
	sub		r1, r0, Projectile_ChargedNormalBeam
	cmp		r1, Projectile_ChargedDiffusionMissile - Projectile_ChargedNormalBeam
	bhi		080454FEh
	cmp		r1, Projectile_ChargedWaveBeam - Projectile_ChargedNormalBeam
	bhi		@@checkMissile
	mov		r2, #4
	cmp		r0, Projectile_ChargedChargeBeam
	bne		@@doDamage
	ldrb	r0, [r4, Projectile_Part]
	cmp		r0, #0
	beq		080454D4h
	b		@@doDamage
.endarea
	.skip 8
.area 1Ah, 0
@@checkMissile:
	cmp		r7, #7
	beq		080454FEh
	mov		r2, #8
@@doDamage:
	mov		r0, r5
	mov		r1, r6
	bl		SpawnParticleEffect
	mov		r0, #10
	bl		08084D00h
	b		080454AEh
.endarea

.org 08025C52h
.area 12h, 0
	ldrb	r0, [r4, Enemy_Id]
	add		r1, =@@BossIds
	mov		r2, #1
	add		r3, =@@BossAbilities
	ldr		r4, =MiscProgress
	b		@@cont
	.pool
.endarea
	.skip 1Ch
.area 66h, 0
	.align 4
@@BossIds:
	.db		Boss_Arachnus
	.db		Boss_Zazabi
	.db		Boss_Serris
	.db		Boss_MegaCoreX
	.db		Boss_Yakuza
	.db		Boss_Nightmare
	.db		Boss_Ridley
	.align 4
@@BossAbilities:
.if RANDOMIZER
.notice "Core-X boss abilities @ " + tohex(.)
.endif
	.db		Ability_MorphBall
	.db		Ability_HiJump
	.db		Ability_Speedbooster
	.db		Ability_VariaSuit
	.db		Ability_SpaceJump
	.db		Ability_GravitySuit
	.db		Ability_ScrewAttack
	.align 2
@@cont:
	sub		r0, EnemyId_Arachnus_CoreXNucleus
	beq		@@obtainAbility
	sub		r0, EnemyId_Zazabi_CoreXNucleus - EnemyId_Arachnus_CoreXNucleus
	cmp		r0, EnemyId_Ridley_CoreXNucleus - EnemyId_Zazabi_CoreXNucleus
	bhi		08025CE6h
	add		r0, #1
@@obtainAbility:
	ldrb	r1, [r1, r0]
	lsl		r2, r1
	ldrh	r1, [r4, MiscProgress_Bosses]
	orr		r1, r2
	strh	r1, [r4, MiscProgress_Bosses]
	ldrb	r0, [r3, r0]
	bl		ObtainAbility
	mov		r0, #60
	ldr		r1, =03000046h
	strb	r0, [r1]
	b		08025CE6h
	.pool
.endarea

.org 0802DDA0h
.area 10h, 0
	ldrb	r0, [r4, Enemy_Id]
	add		r1, =@@BossIds
	mov		r2, #1
	add		r3, =@@BossAbilities
	ldr		r4, =MiscProgress
	b		@@cont
	.pool
.endarea
	.skip 1Ch
.area 28h, 0
	.align 4
@@BossIds:
	.db		Boss_ChargeCoreX
	.db		Boss_WideCoreX
	.db		Boss_Nettori
	.db		Boss_XBox
	.align 4
@@BossAbilities:
.if RANDOMIZER
.notice "Beam Core-X boss abilities @ " + tohex(.)
.endif
	.db		Ability_ChargeBeam
	.db		Ability_WideBeam
	.db		Ability_PlasmaBeam
	.db		Ability_WaveBeam
	.align 2
@@cont:
	sub		r0, EnemyId_ChargeCoreXNucleus
	cmp		r0, EnemyId_XBox_CoreXNucleus - EnemyId_ChargeCoreXNucleus
	bhi		0802DDF4h
	ldrb	r1, [r1, r0]
	lsl		r2, r1
	ldrh	r1, [r4, MiscProgress_Bosses]
	orr		r1, r2
	strh	r1, [r4, MiscProgress_Bosses]
	ldrb	r0, [r3, r0]
	bl		ObtainAbility
	mov		r0, #60
	mov		r1, #03h
	lsl		r1, #18h
	add		r1, #46h
	strb	r0, [r1]
.endarea
