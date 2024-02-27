; Reworks demos to work properly with non-linear patches.

.org 0807DF04h
.area 60h
	push	{ r4-r6, lr }
	cmp		r0, #Upgrade_None
	beq		@@return
	cmp		r0, #Upgrade_IceBeam
	blo		@@init_registers
	mov		r0, #Upgrade_IceBeam
@@init_registers:
	mov		r6, r0
	ldr		r5, =MajorUpgradeInfo
	ldr		r4, =SamusUpgrades
	mov		r3, #Upgrade_Missiles
@@loop:
	cmp		r3, r6
	bgt		@@return
	lsl		r0, r3, #2
	add		r2, r5, r0
	ldrb	r1, [r2, MajorUpgradeInfo_Bitmask]
	ldrb	r2, [r2, MajorUpgradeInfo_Offset]
	ldrb	r0, [r4, r2]
	orr		r0, r1
	strb	r0, [r4, r2]
	add		r3, #1
	b		@@loop
@@return:
	pop		{ r4-r6, pc }
	.pool
.endarea

.org 083E3F6Ch + 0 * 1Ch + 08h
	.db		Upgrade_Bombs

.org 083E3F6Ch + 1 * 1Ch + 08h
	.db		Upgrade_IceMissiles

.org 083E3F6Ch + 2 * 1Ch + 08h
	.db		Upgrade_HiJump

.org 083E3F6Ch + 3 * 1Ch + 08h
	.db		Upgrade_Missiles

.org 083E3F6Ch + 4 * 1Ch + 08h
	.db		Upgrade_MorphBall

.org 083E3F6Ch + 5 * 1Ch + 08h
	.db		Upgrade_ScrewAttack

.org 083E3F6Ch + 6 * 1Ch + 08h
	.db		Upgrade_Speedbooster

.org 083E3F6Ch + 7 * 1Ch + 08h
	.db		Upgrade_PowerBombs

.org 083E3F6Ch + 8 * 1Ch + 08h
	.db		Upgrade_SuperMissiles

.org 083E3F6Ch + 9 * 1Ch + 08h
	.db		Upgrade_DiffusionMissiles

.org 083E3F6Ch + 10 * 1Ch + 08h
	.db		Upgrade_Missiles

.org 083E3F6Ch + 11 * 1Ch + 08h
	.db		Upgrade_ScrewAttack
