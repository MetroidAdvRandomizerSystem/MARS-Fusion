; Common functions for use in other non-linearity patches.

; TODO: Implement obtaining nothing from a check

.autoregion
	.align 2
.func ObtainMajorLocation
	ldr		r3, =MiscProgress
	mov		r2, #1
	lsl		r2, r0
	ldr		r1, [r3, MiscProgress_MajorLocations]
	orr		r1, r2
	str		r1, [r3, MiscProgress_MajorLocations]
	ldr		r1, =MajorLocations
	ldrb	r0, [r1, r0]
	b		ObtainUpgrade
	.pool
.endfunc
.func ObtainUpgrade
	cmp		r0, Upgrade_IceBeam
	bhi		@@checkMinors
	ldr		r3, =MajorUpgradeInfo
	lsl		r0, #2
	add		r3, r0
@@obtainMajor:
	ldr		r2, =SamusUpgrades
	ldrb	r0, [r3, MajorUpgradeInfo_Offset]
	add		r2, r0
	ldrb	r0, [r3, MajorUpgradeInfo_Bitmask]
	ldrb	r1, [r2]
	orr		r0, r1
	strb	r0, [r2]
	ldrb	r0, [r3, MajorUpgradeInfo_Message]
	b		@@setMessage
@@checkMinors:
	cmp		r0, Upgrade_PowerBombTank
	bhi		@@return
	ldr		r2, =SamusUpgrades
	cmp		r0, Upgrade_MissileTank
	bne		@@checkETank
	ldrb	r0, [r2, SamusUpgrades_CurrMissiles]
	add		r0, #5
	strb	r0, [r2, SamusUpgrades_CurrMissiles]
	ldrb	r0, [r2, SamusUpgrades_MaxMissiles]
	add		r0, #5
	strb	r0, [r2, SamusUpgrades_MaxMissiles]
.if ABILITY_FROM_TANK
	ldrb	r0, [r2, SamusUpgrades_ExplosiveUpgrades]
	lsr		r1, r0, ExplosiveUpgrade_Missiles + 1
	bcs		@@setMissileTankMessage
	mov		r1, 1 << ExplosiveUpgrade_Missiles
	orr		r0, r1
	strb	r0, [r2, SamusUpgrades_ExplosiveUpgrades]
	mov		r0, Message_MissileUpgrade
	b		@@setMessage
@@setMissileTankMessage:
.endif
	mov		r0, Message_MissileTankUpgrade
	b		@@setMessage
@@checkETank:
	cmp		r0, Upgrade_EnergyTank
	bne		@@checkPBTank
	ldrb	r0, [r2, SamusUpgrades_MaxEnergy]
	add		r0, #100
	strb	r0, [r2, SamusUpgrades_MaxEnergy]
	strb	r0, [r2, SamusUpgrades_CurrEnergy]
	mov		r0, Message_EnergyTankUpgrade
	b		@@setMessage
@@checkPBTank:
	cmp		r0, Upgrade_PowerBombTank
	bne		@@return
	ldrb	r0, [r2, SamusUpgrades_CurrPowerBombs]
	add		r0, #2
	strb	r0, [r2, SamusUpgrades_CurrPowerBombs]
	ldrb	r0, [r2, SamusUpgrades_MaxPowerBombs]
	add		r0, #2
	strb	r0, [r2, SamusUpgrades_MaxPowerBombs]
.if ABILITY_FROM_TANK
	ldrb	r0, [r2, SamusUpgrades_ExplosiveUpgrades]
	lsr		r1, r0, ExplosiveUpgrade_PowerBombs + 1
	bcs		@@setPBTankMessage
	mov		r1, 1 << ExplosiveUpgrade_PowerBombs
	orr		r0, r1
	mov		r0, Message_PowerBombUpgrade
	b		@@setMessage
@@setPBTankMessage:
.endif
	mov		r0, Message_PowerBombTankUpgrade
@@setMessage:
	ldr		r1, =LastAbility
	strb	r0, [r1]
@@return:
	bx		lr
	.pool
.endfunc
.endautoregion

.org 080798F8h
.area 48h, 0
	; get message index
	ldr		r7, =MessagesByLanguage
	ldr		r6, =Language
	ldr		r1, =LastAbility
	ldrb	r2, [r1]
	b		08079952h
	.pool
.endarea

.autoregion
.if RANDOMIZER
.notice "Bosses, data rooms, and security rooms @ " + tohex(.)
.endif
MajorLocations:
	.db		Upgrade_Missiles
	.db		Upgrade_MorphBall
	.db		Upgrade_ChargeBeam
	.db		Upgrade_SecurityLevel1
	.db		Upgrade_Bombs
	.db		Upgrade_HiJump
	.db		Upgrade_Speedbooster
	.db		Upgrade_SecurityLevel2
	.db		Upgrade_SuperMissiles
	.db		Upgrade_VariaSuit
	.db		Upgrade_SecurityLevel3
	.db		Upgrade_IceMissiles
	.db		Upgrade_WideBeam
	.db		Upgrade_PowerBombs
	.db		Upgrade_SpaceJump
	.db		Upgrade_PlasmaBeam
	.db		Upgrade_GravitySuit
	.db		Upgrade_SecurityLevel4
	.db		Upgrade_DiffusionMissiles
	.db		Upgrade_WaveBeam
	.db		Upgrade_ScrewAttack
.endautoregion

.autoregion
MajorUpgradeInfo:
	.db		00h
	.db		00h
	.db		00h
	.skip 1
	.db		SamusUpgrades_ExplosiveUpgrades
	.db		1 << ExplosiveUpgrade_Missiles
	.db		Message_MissileUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_MorphBall
	.db		Message_MorphBallUpgrade
	.skip 1
	.db		SamusUpgrades_BeamUpgrades
	.db		1 << BeamUpgrade_ChargeBeam
	.db		Message_ChargeBeamUpgrade
	.skip 1
	.db		SamusUpgrades_SecurityLevel
	.db		1 << SecurityLevel_Lv1
	.db		Message_SecurityLevel1
	.skip 1
	.db		SamusUpgrades_ExplosiveUpgrades
	.db		1 << ExplosiveUpgrade_Bombs
	.db		Message_BombUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_HiJump
	.db		Message_HiJumpUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_Speedbooster
	.db		Message_SpeedboosterUpgrade
	.skip 1
	.db		SamusUpgrades_SecurityLevel
	.db		1 << SecurityLevel_Lv2
	.db		Message_SecurityLevel2
	.skip 1
	.db		SamusUpgrades_ExplosiveUpgrades
	.db		1 << ExplosiveUpgrade_SuperMissiles
	.db		Message_SuperMissileUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_VariaSuit
	.db		Message_VariaSuitUpgrade
	.skip 1
	.db		SamusUpgrades_SecurityLevel
	.db		1 << SecurityLevel_Lv3
	.db		Message_SecurityLevel3
	.skip 1
	.db		SamusUpgrades_ExplosiveUpgrades
	.db		1 << ExplosiveUpgrade_IceMissiles
	.db		Message_IceBeamUpgrade
	.skip 1
	.db		SamusUpgrades_BeamUpgrades
	.db		1 << BeamUpgrade_WideBeam
	.db		Message_WideBeamUpgrade
	.skip 1
	.db		SamusUpgrades_ExplosiveUpgrades
	.db		1 << ExplosiveUpgrade_PowerBombs
	.db		Message_PowerBombUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_SpaceJump
	.db		Message_SpaceJumpUpgrade
	.skip 1
	.db		SamusUpgrades_BeamUpgrades
	.db		1 << BeamUpgrade_PlasmaBeam
	.db		Message_PlasmaBeamUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_GravitySuit
	.db		Message_GravitySuitUpgrade
	.skip 1
	.db		SamusUpgrades_SecurityLevel
	.db		1 << SecurityLevel_Lv4
	.db		Message_SecurityLevel4
	.skip 1
	.db		SamusUpgrades_ExplosiveUpgrades
	.db		1 << ExplosiveUpgrade_DiffusionMissiles
	.db		Message_DiffusionMissileUpgrade
	.skip 1
	.db		SamusUpgrades_BeamUpgrades
	.db		1 << BeamUpgrade_WaveBeam
	.db		Message_WaveBeamUpgrade
	.skip 1
	.db		SamusUpgrades_SuitUpgrades
	.db		1 << SuitUpgrade_ScrewAttack
	.db		Message_ScrewAttackUpgrade
	.skip 1
	.db		SamusUpgrades_BeamUpgrades
	.db		1 << BeamUpgrade_IceBeam
	.db		Message_IceBeamUpgrade
	.skip 1
.endautoregion
