; Reworks demos to work properly with non-linear patches.

.org 080717BCh
.area 110h
	; init demo memory
	ldr		r1, =CurrentDemo
	ldrb	r1, [r1]
	lsl		r1, #19h
	lsr		r1, #19h
	lsl		r2, r1, #3
	sub		r2, r1
	lsl		r1, r2, #2
	ldr		r2, =DemoMemory
	add		r2, r1
	cmp		r0, #0
	bne		@@second_step_init
	ldr		r1, =CurrArea
	ldrb	r0, [r2, DemoMemory_Area]
	strb	r0, [r1]
	mov		r0, #0
	strb	r0, [r1, CurrRoom - CurrArea]
	ldrb	r0, [r2, DemoMemory_PrevDoor]
	strb	r0, [r1, PrevDoor - CurrArea]
	ldrb	r0, [r2, DemoMemory_SecurityLevel]
	ldr		r1, =SamusUpgrades
	ldrb	r0, [r2, DemoMemory_SecurityLevel]
	strb	r0, [r1, SamusUpgrades_SecurityLevel]
	ldrb	r0, [r2, DemoMemory_MapDownloads]
	strb	r0, [r1, SamusUpgrades_MapDownloads]
	ldrb	r0, [r2, DemoMemory_BeamUpgrades]
	strb	r0, [r1, SamusUpgrades_BeamUpgrades]
	ldrb	r0, [r2, DemoMemory_ExplosiveUpgrades]
	strb	r0, [r1, SamusUpgrades_ExplosiveUpgrades]
	ldrb	r0, [r2, DemoMemory_SuitUpgrades]
	strb	r0, [r1, SamusUpgrades_SuitUpgrades]
	ldrh	r0, [r2, DemoMemory_MaxEnergy]
	strh	r0, [r1, SamusUpgrades_MaxEnergy]
	ldrh	r0, [r2, DemoMemory_CurrEnergy]
	strh	r0, [r1, SamusUpgrades_CurrEnergy]
	ldrh	r0, [r2, DemoMemory_MaxMissiles]
	strh	r0, [r1, SamusUpgrades_MaxMissiles]
	ldrh	r0, [r2, DemoMemory_CurrMissiles]
	strh	r0, [r1, SamusUpgrades_CurrMissiles]
	ldrb	r0, [r2, DemoMemory_MaxPowerBombs]
	strb	r0, [r1, SamusUpgrades_MaxPowerBombs]
	ldrb	r0, [r2, DemoMemory_CurrPowerBombs]
	strb	r0, [r1, SamusUpgrades_CurrPowerBombs]
	ldr		r1, =SamusState
	ldrh	r0, [r2, DemoMemory_SamusDirection]
	strh	r0, [r1, SamusState_Direction]
	mov		r0, #0
	strb	r0, [r1, SamusState_Pose]
	add		r1, #20h
	strb	r0, [r1, SamusState_AnimationFrame - 20h]
	strb	r0, [r1, SamusState_Animation - 20h]
	ldr		r0, =DemoTanksCollected
	ldr		r1, =TanksCollected
	ldr		r0, [r0]
	str		r0, [r1]
	bx		lr
@@second_step_init:
	ldr		r1, =SamusState
	ldrh	r0, [r2, DemoMemory_SamusXPos]
	strh	r0, [r1, SamusState_PositionX]
	ldrh	r0, [r2, DemoMemory_SamusYPos]
	strh	r0, [r1, SamusState_PositionY]
	ldr		r1, =CurrentDemo
	ldrb	r0, [r1]
	lsl		r0, #19h
	lsr		r0, #19h
	strb	r0, [r1]
	mov		r0, #0
	ldr		r1, =ShortFrameCounter
	strb	r0, [r1]
	ldr		r1, =LongFrameCounter
	strh	r0, [r1]
	bx		lr
	.pool
.endarea

.org 0807DF04h
.area 60h
	bx		lr
.endarea

.org DemoMemory + 0 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		1 << BeamUpgrade_ChargeBeam
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs)
	.db		(1 << SuitUpgrade_MorphBall) 
	.dh		0

.org DemoMemory + 1 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		1 << BeamUpgrade_ChargeBeam
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs) \
		  | (1 << ExplosiveUpgrade_SuperMissiles) | (1 << ExplosiveUpgrade_IceMissiles)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster) | (1 << SuitUpgrade_VariaSuit)
	.dh		0

.org DemoMemory + 2 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		1 << BeamUpgrade_ChargeBeam
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump)
	.dh		0

.org DemoMemory + 3 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		0
	.db		1 << ExplosiveUpgrade_Missiles
	.db		0
	.dh		0

.org DemoMemory + 4 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		0
	.db		1 << ExplosiveUpgrade_Missiles
	.db		1 << SuitUpgrade_MorphBall
	.dh		0

.org DemoMemory + 5 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		(1 << BeamUpgrade_ChargeBeam) | (1 << BeamUpgrade_WideBeam) \
		  | (1 << BeamUpgrade_PlasmaBeam) | (1 << BeamUpgrade_WaveBeam)
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs) \
		  | (1 << ExplosiveUpgrade_SuperMissiles) | (1 << ExplosiveUpgrade_IceMissiles) \
		  | (1 << ExplosiveUpgrade_PowerBombs) | (1 << ExplosiveUpgrade_DiffusionMissiles)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster) | (1 << SuitUpgrade_VariaSuit) \
		  | (1 << SuitUpgrade_SpaceJump) | (1 << SuitUpgrade_GravitySuit) \
		  | (1 << SuitUpgrade_ScrewAttack)
	.dh		0

.org DemoMemory + 6 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		1 << BeamUpgrade_ChargeBeam
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster)
	.dh		0

.org DemoMemory + 7 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		(1 << BeamUpgrade_ChargeBeam) | (1 << BeamUpgrade_WideBeam)
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs) \
		  | (1 << ExplosiveUpgrade_SuperMissiles) | (1 << ExplosiveUpgrade_IceMissiles) \
		  | (1 << ExplosiveUpgrade_PowerBombs)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster) | (1 << SuitUpgrade_VariaSuit)
	.dh		0

.org DemoMemory + 8 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		1 << BeamUpgrade_ChargeBeam
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs) \
		  | (1 << ExplosiveUpgrade_SuperMissiles)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster)
	.dh		0

.org DemoMemory + 9 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		(1 << BeamUpgrade_ChargeBeam) | (1 << BeamUpgrade_WideBeam) \
		  | (1 << BeamUpgrade_PlasmaBeam)
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs) \
		  | (1 << ExplosiveUpgrade_SuperMissiles) | (1 << ExplosiveUpgrade_IceMissiles) \
		  | (1 << ExplosiveUpgrade_PowerBombs) | (1 << ExplosiveUpgrade_DiffusionMissiles)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster) | (1 << SuitUpgrade_VariaSuit) \
		  | (1 << SuitUpgrade_SpaceJump) | (1 << SuitUpgrade_GravitySuit)
	.dh		0

.org DemoMemory + 10 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		0
	.db		1 << ExplosiveUpgrade_Missiles
	.db		0
	.dh		0

.org DemoMemory + 11 * DemoMemory_Size + DemoMemory_BeamUpgrades
	.db		(1 << BeamUpgrade_ChargeBeam) | (1 << BeamUpgrade_WideBeam) \
		  | (1 << BeamUpgrade_PlasmaBeam) | (1 << BeamUpgrade_WaveBeam)
	.db		(1 << ExplosiveUpgrade_Missiles) | (1 << ExplosiveUpgrade_Bombs) \
		  | (1 << ExplosiveUpgrade_SuperMissiles) | (1 << ExplosiveUpgrade_IceMissiles) \
		  | (1 << ExplosiveUpgrade_PowerBombs) | (1 << ExplosiveUpgrade_DiffusionMissiles)
	.db		(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
		  | (1 << SuitUpgrade_Speedbooster) | (1 << SuitUpgrade_VariaSuit) \
		  | (1 << SuitUpgrade_SpaceJump) | (1 << SuitUpgrade_GravitySuit) \
		  | (1 << SuitUpgrade_ScrewAttack)
	.dh		0
