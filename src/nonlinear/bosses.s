; Allows bosses to be fought, killed, and absorbed regardless of the event.

; TODO: fix BOX spawning
; TODO: fix projectile vfx and sfx when hitting zazabi
; TODO: test all bosses

.org 08025400h
.area 38h, 0
	; check arachnus and zazabi kill status before spawning
	ldrb	r0, [r5, Enemy_Id]
	cmp		r0, EnemyId_Arachnus_CoreXNucleus
	beq		@@checkArachnus
	cmp		r0, EnemyId_Zazabi_CoreXNucleus
	bne		08025438h
	mov		r0, MajorLocation_Zazabi
	mov		r4, #4Bh
	mov		r1, #5Eh
	mov		r12, r1
	b		@@checkStatus
@@checkArachnus:
	mov		r0, MajorLocation_Arachnus
@@checkStatus:
	ldr		r1, =MiscProgress
	ldr		r1, [r1, MiscProgress_MajorLocations]
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
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_ChargeCoreX + 1
	bcc		0802D60Ch
	strb	r3, [r4, Enemy_Status]
	b		0802D6BCh
	.pool
.endarea

; check wide core-x kill status before spawning
.org 08060E54h
.area 20h
	ldr		r1, =MiscProgress
	ldr		r0, [r1, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_WideCoreX + 1
	bcc		@@boss_alive
	ldrh	r0, [r1, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_BoilerCooling + 1
	bcc		@@boiler_console_active
	mov		r0, #0
	bx		lr
@@boss_alive:
	mov		r0, #1
	bx		lr
@@boiler_console_active:
	mov		r0, #2
	bx		lr
	.pool
.endarea

.org 0803A08Ah
.area 2Ah, 0
	ldr		r2, =CurrentEnemy
	mov		r0, Enemy_IgnoreSamusCollisionTimer
	mov		r5, #1
	strb	r5, [r2, r0]
	mov		r4, #0
	mov		r5, #2
	b		0803A0B4h
	.pool
.endarea

.org 08043D24h
.area 20h, 0
	; check nettori kill status before spawning
	mov		r7, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Nettori + 1
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
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Serris + 1
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
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_XBox + 1
	bcc		08051ADCh
	strb	r7, [r4, Enemy_Status]
	b		08051C82h
	.pool
.endarea

.org 08060C90h
.area 18h
	; check if NOC data room is not destroyed
	ldr		r1, =MiscProgress
	ldr		r0, [r1, MiscProgress_StoryFlags]
	lsl		r0, 1Fh - StoryFlag_NocDataDestroyed
	ldrh	r1, [r1, MiscProgress_MajorLocations]
	lsl		r1, 1Fh - MajorLocation_MegaCoreX
	orr		r0, r1
	mvn		r0, r0
	lsr		r0, 1Fh
	bx		lr
	.pool
.endarea

.autoregion
	.align 2
.func SetNocDataDestroyed
	; unlock doors in NOC data room
	ldr		r2, =MiscProgress
	ldrh	r0, [r2, MiscProgress_StoryFlags]
	mov		r1, #1 << StoryFlag_NocDataDestroyed
	orr		r0, r1
	strh	r0, [r2, MiscProgress_StoryFlags]
.endfunc
.func SetDoorUnlockTimer
	ldr		r1, =DoorUnlockTimer
	mov		r0, #60
	strb	r0, [r1]
	bx		lr
	.pool
.endfunc
.endautoregion

.org 08043A72h
.area 06h
	bl		SetNocDataDestroyed
	nop
.endarea

.org 08057564h
.area 24h, 0
	; check varia core-x kill status before spawning
	mov		r6, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_MegaCoreX + 1
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
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Ridley + 1
	bcc		0805B5B4h
	mov		r0, #0
	strb	r0, [r1, Enemy_Status]
	b		0805B5FCh
	.pool
.endarea

.org 0805BDB8h
.area 20h, 0
	; check yakuza kill status before spawning
	mov		r6, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Yakuza + 1
	bcc		0805BDD8h
	strb	r6, [r4, Enemy_Status]
	b		0805BEA0h
	.pool
.endarea

.org 08063614h
.area 2Ch
	; hide bg0 in yakuza fight room if yakuza is dead
	ldr		r0, =MiscProgress
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Yakuza + 1
	bcc		0806367Eh
	ldr		r2, =03000070h
	ldrh	r0, [r2]
	mov		r1, #1
	lsl		r1, #8
	bic		r0, r1
	strh	r0, [r2]
	ldr		r1, =0300004Ah
	mov		r0, #0
	strb	r0, [r1]
	b		0806367Eh
	.pool
.endarea

.org 08063B74h
.area 28h
	; hide bg0 in yakuza fight room if yakuza has just been killed
	ldr		r0, =MiscProgress
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Yakuza + 1
	bcc		08063C2Ah
	ldr		r2, =03000070h
	ldrh	r0, [r2]
	mov		r1, #1
	lsl		r1, #8
	bic		r0, r1
	strh	r0, [r2]
	ldr		r1, =03000008h
	strh	r0, [r1]
	b		08063AD4h
	.pool
.endarea

.org 0805DDD4h
.area 20h, 0
	; check nightmare kill status before spawning
	mov		r7, #0
	ldr		r4, =CurrentEnemy
	ldr		r0, =MiscProgress
	ldr		r0, [r0, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Nightmare + 1
	bcc		0805DDF4h
	strb	r7, [r4, Enemy_Status]
	b		0805DFA0h
	.pool
.endarea

.org 080369A0h
.area 3Ch
	; set box kill status
	ldr		r1, =CurrentEnemy
	mov		r2, r1
	add		r2, #20h
	ldr		r0, =08347BD8h
	str		r0, [r1, Enemy_GfxPointer]
	mov		r3, #0
	strh	r3, [r1, Enemy_Animation]
	strb	r3, [r1, Enemy_AnimationFrame]
	strb	r3, [r2, Enemy_Timer0 - 20h]
	strb	r3, [r2, Enemy_VelocityY - 20h]
	mov		r0, #44h
	strb	r0, [r2, Enemy_Pose - 20h]
	add		r2, #03000784h - CurrentEnemy - 20h
	ldr		r0, =08342DF0h
	str		r0, [r2]
	strh	r3, [r2, #04h]
	strb	r3, [r2, #06h]
	add		r1, #MiscProgress - CurrentEnemy
	ldrh	r0, [r1, MiscProgress_StoryFlags]
	mov		r2, #1 << StoryFlag_BoxDefeated
	orr		r0, r2
	strh	r0, [r1, MiscProgress_StoryFlags]
	bx		lr
	.pool
.endarea

.org 08037FDCh
.area 0Ch
	; unlock doors after killing box
	bl		SetDoorUnlockTimer
	nop
.endarea

.org 08060D38h
.area 18h, 0
	; check if box is dead or defeated
	ldr		r1, =MiscProgress
	ldrh	r0, [r1, MiscProgress_StoryFlags]
	lsl		r0, #1Fh - StoryFlag_BoxDefeated
	ldr		r1, [r1, MiscProgress_MajorLocations]
	lsl		r1, #1Fh - MajorLocation_XBox
	orr		r0, r1
	lsr		r0, #1Fh
	bx		lr
	.pool
.endarea

.org 08060D50h
.area 18h, 0
	; check if box is neither dead nor defeated
	ldr		r1, =MiscProgress
	ldrh	r0, [r1, MiscProgress_StoryFlags]
	lsl		r0, #1Fh - StoryFlag_BoxDefeated
	ldr		r1, [r1, MiscProgress_MajorLocations]
	lsl		r1, #1Fh - MajorLocation_XBox
	orr		r0, r1
	mvn		r0, r0
	lsr		r0, #1Fh
	bx		lr
	.pool
.endarea

.org 080382EAh
.area 04h, 0
	; box debris should always fall
	mov		r0, #0
.endarea

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

.autoregion
.func CheckOmegaMetroidVulnerable
	ldr		r0, =CurrEvent
	ldrb	r0, [r0]
	sub		r0, #6Bh
	blt		@@return_false
	mov		r0, #1
	bx		lr
@@return_false:
	mov		r0, #0
	bx		lr
	.pool
.endfunc
.endautoregion

.org 0801006Eh
.area 0Ah
	bl		CheckOmegaMetroidVulnerable
	cmp		r0, #0
	beq		08010096h
	nop
.endarea

.org 08025C52h
.area 12h, 0
	add		r1, =@@BossLocations
	ldrb	r0, [r4, Enemy_Id]
	sub		r0, EnemyId_Arachnus_CoreXNucleus
	beq		@@obtainAbility
	sub		r0, EnemyId_Zazabi_CoreXNucleus - EnemyId_Arachnus_CoreXNucleus
	cmp		r0, EnemyId_Ridley_CoreXNucleus - EnemyId_Zazabi_CoreXNucleus
	bhi		08025CE6h
	add		r0, #1
	b		@@obtainAbility
.endarea
	.skip 1Ch
.area 66h, 0
	.align 4
@@BossLocations:
	.db		MajorLocation_Arachnus
	.db		MajorLocation_Zazabi
	.db		MajorLocation_Serris
	.db		MajorLocation_MegaCoreX
	.db		MajorLocation_Yakuza
	.db		MajorLocation_Nightmare
	.db		MajorLocation_Ridley
	.align 2
@@obtainAbility:
	ldrb	r0, [r1, r0]
	bl		ObtainMajorLocation
	mov		r0, #60
	ldr		r1, =DoorUnlockTimer
	strb	r0, [r1]
	b		08025CE6h
	.pool
.endarea

.org 0802DDA0h
.area 10h, 0
	ldrb	r0, [r4, Enemy_Id]
	sub		r0, EnemyId_ChargeCoreXNucleus
	cmp		r0, EnemyId_XBox_CoreXNucleus - EnemyId_ChargeCoreXNucleus
	bhi		0802DDF4h
	add		r1, =@@BossLocations
	b		@@cont
	.align 4
@@BossLocations:
	.db		MajorLocation_ChargeCoreX
	.db		MajorLocation_WideCoreX
	.db		MajorLocation_Nettori
	.db		MajorLocation_XBox
.endarea
	.skip 1Ch
.area 28h, 0
@@cont:
	ldrb	r0, [r1, r0]
	bl		ObtainMajorLocation
	; wide core-x lets the boiler console unlock doors
	ldrb	r0, [r4, Enemy_Id]
	cmp		r0, #EnemyId_WideCoreXNucleus
	beq		0802DDF4h
	mov		r0, #60
	ldr		r1, =DoorUnlockTimer
	strb	r0, [r1]
	b		0802DDF4h
	.pool
.endarea
