.sym off

Button_A equ 0
Button_B equ 1
Button_Select equ 2
Button_Start equ 3
Button_Right equ 4
Button_Left equ 5
Button_Up equ 6
Button_Down equ 7
Button_R equ 8
Button_L equ 9

GameMode_InGame equ 1

Area_MainDeck equ 0
Area_SRX equ 1
Area_TRO equ 2
Area_PYR equ 3
Area_AQA equ 4
Area_ARC equ 5
Area_NOC equ 6
Area_Debug1 equ 7
Area_Debug2 equ 8
Area_Debug3 equ 9

MusicType_Transient equ 0		; only lasts one room
MusicType_Briefing equ 1		; adam sector (de)briefings?
MusicType_MainDeck equ 2		; first visit to Main Deck
MusicType_SRX1 equ 3			; first visit to SRX
MusicType_TRO1 equ 4			; first visit to TRO
MusicType_AQA1 equ 5			; first visit to AQA
MusicType_BossAmbience equ 6	; pre and post boss fight ambience
MusicType_BossMusic equ 7		; boss fight music
MusicType_Chase equ 8			; SA-X chase music??
MusicType_Misc equ 10			; used all over the place, needs research
MuicType_Elevators equ 11		; used frequently, needs research
MusicType_GameIntro equ 13		; story intro sequence
MusicType_TitleIntro equ 15		; teaser intro
MusicType_TitleScreen equ 16	; self-explanatory
MusicType_TitleDemo equ 17		; title screen demonstration

Message_SecurityLevel1 equ 00h
Message_SecurityLevel2 equ 01h
Message_SecurityLevel3 equ 02h
Message_SecurityLevel4 equ 03h
Message_MissileUpgrade equ 04h
Message_SuperMissileUpgrade equ 05h
Message_BombUpgrade equ 06h
Message_PowerBombUpgrade equ 07h
Message_IceMissileUpgrade equ 08h
Message_DiffusionMissileUpgrade equ 09h
Message_MorphBallUpgrade equ 0Ah
Message_HiJumpUpgrade equ 0Bh
Message_ScrewAttackUpgrade equ 0Ch
Message_SpaceJumpUpgrade equ 0Dh
Message_SpeedboosterUpgrade equ 0Eh
Message_VariaSuitUpgrade equ 0Fh
Message_GravitySuitUpgrade equ 10h
Message_ChargeBeamUpgrade equ 11h
Message_WideBeamUpgrade equ 12h
Message_WaveBeamUpgrade equ 13h
Message_PlasmaBeamUpgrade equ 14h
Message_IceBeamUpgrade equ 15h
Message_AtmosphericStabilizer1 equ 16h
Message_AtmosphericStabilizer2 equ 17h
Message_AtmosphericStabilizer3 equ 18h
Message_AtmosphericStabilizer4 equ 19h
Message_AtmosphericStabilizer5 equ 1Ah
Message_WaterLowered equ 1Bh
Message_BoilerCooling equ 1Ch
Message_AnimalsFreed equ 1Dh
Message_AuxiliaryPower equ 1Eh
Message_RestrictedSectorDetachment equ 1Fh
Message_EscapeSequence equ 20h
Message_EnergyTankUpgrade equ 27h
Message_MissileTankUpgrade equ 28h
Message_PowerBombTankUpgrade equ 29h

Tank_Missiles equ 1
Tank_Energy equ 2
Tank_PowerBombs equ 3

SecurityLevel_Lv0 equ 0	; Gray doors
SecurityLevel_Lv1 equ 1	; Blue doors
SecurityLevel_Lv2 equ 2	; Green doors
SecurityLevel_Lv3 equ 3	; Yellow doors
SecurityLevel_Lv4 equ 4	; Red doors

BeamUpgrade_ChargeBeam equ 0
BeamUpgrade_WideBeam equ 1
BeamUpgrade_PlasmaBeam equ 2
BeamUpgrade_WaveBeam equ 3
BeamUpgrade_IceBeam equ 4

ExplosiveUpgrade_Missiles equ 0
ExplosiveUpgrade_SuperMissiles equ 1
ExplosiveUpgrade_IceMissiles equ 2
ExplosiveUpgrade_DiffusionMissiles equ 3
ExplosiveUpgrade_Bombs equ 4
ExplosiveUpgrade_PowerBombs equ 5

SuitUpgrade_HiJump equ 0
SuitUpgrade_Speedbooster equ 1
SuitUpgrade_SpaceJump equ 2
SuitUpgrade_ScrewAttack equ 3
SuitUpgrade_VariaSuit equ 4
SuitUpgrade_GravitySuit equ 5
SuitUpgrade_MorphBall equ 6
SuitUpgrade_OmegaSuit equ 7

EnemyId_MessageBox equ 21h
EnemyId_Arachnus_CoreXNucleus equ 3Fh
EnemyId_Zazabi_CoreXNucleus equ 44h
EnemyId_Serris_CoreXNucleus equ 45h
EnemyId_MegaCoreX_CoreXNucleus equ 46h
EnemyId_Yakuza_CoreXNucleus equ 47h
EnemyId_Nightmare_CoreXNucleus equ 48h
EnemyId_Ridley_CoreXNucleus equ 49h
EnemyId_ChargeCoreXNucleus equ 56h
EnemyId_WideCoreXNucleus equ 57h
EnemyId_Nettori_CoreXNucleus equ 58h
EnemyId_XBox_CoreXNucleus equ 59h

EnemyProps_SolidForProjectiles equ 3
EnemyProps_ImmuneToProjectiles equ 6

EnemyWeakness_ChargeBeam equ 0
EnemyWeakness_BeamOrBombs equ 1
EnemyWeakness_SuperMissiles equ 2
EnemyWeakness_Missiles equ 3
EnemyWeakness_PowerBombs equ 4
EnemyWeakness_SpeedboosterOrScrew equ 5
EnemyWeakness_Freezable equ 6

Projectile_NormalBeam equ 0
Projectile_ChargeBeam equ 1
Projectile_WideBeam equ 2
Projectile_PlasmaBeam equ 3
Projectile_WaveBeam equ 4
Projectile_ChargedNormalBeam equ 5
Projectile_ChargedChargeBeam equ 6
Projectile_ChargedWideBeam equ 7
Projectile_ChargedPlasmaBeam equ 8
Projectile_ChargedWaveBeam equ 9
Projectile_NormalMissile equ 10
Projectile_SuperMissile equ 11
Projectile_IceMissile equ 12
Projectile_DiffusionMissile equ 13
Projectile_ChargedDiffusionMissile equ 14
Projectile_BeamFlare equ 15
Projectile_Bomb equ 16
Projectile_PowerBomb equ 17
Projectile_DiffusionFlake equ 18

ProjectileStatus_Exists equ 0
ProjectileStatus_OnScreen equ 1
ProjectileStatus_Exploding equ 2
ProjectileStatus_IgnoreCollision equ 3
ProjectileStatus_AffectsClipdata equ 4
ProjectileStatus_VerticalFlip equ 5
ProjectileStatus_HorizontalFlip equ 6

ProjectileDir_Forward equ 1
ProjectileDir_ForwardUp equ 2
ProjectileDir_ForwardDown equ 3
ProjectileDir_Up equ 4
ProjectileDir_Down equ 5

ClipdataAction_RemoveSolid equ 1
ClipdataAction_MakeSolid equ 2
ClipdataAction_MakeStopEnemyBlock equ 3
ClipdataAction_EnemyLaser equ 5
ClipdataAction_Beam equ 6
ClipdataAction_Bomb equ 7
ClipdataAction_Missile equ 8
ClipdataAction_PowerBomb equ 9
ClipdataAction_Speedboost equ 10
ClipdataAction_GroundedSpeedboost equ 11
ClipdataAction_ScrewAttack equ 12
ClipdataAction_BombChain equ 13

EventEffect_WaterLowering equ 5

; non-vanilla enums

Upgrade_None equ 0
Upgrade_Missiles equ 1
Upgrade_MorphBall equ 2
Upgrade_ChargeBeam equ 3
Upgrade_SecurityLevel1 equ 4
Upgrade_Bombs equ 5
Upgrade_HiJump equ 6
Upgrade_Speedbooster equ 7
Upgrade_SecurityLevel2 equ 8
Upgrade_SuperMissiles equ 9
Upgrade_VariaSuit equ 10
Upgrade_SecurityLevel3 equ 11
Upgrade_IceMissiles equ 12
Upgrade_WideBeam equ 13
Upgrade_PowerBombs equ 14
Upgrade_SpaceJump equ 15
Upgrade_PlasmaBeam equ 16
Upgrade_GravitySuit equ 17
Upgrade_SecurityLevel4 equ 18
Upgrade_DiffusionMissiles equ 19
Upgrade_WaveBeam equ 20
Upgrade_ScrewAttack equ 21
Upgrade_IceBeam equ 22
Upgrade_MissileTank equ 23
Upgrade_EnergyTank equ 24
Upgrade_PowerBombTank equ 25

MajorLocation_MainDeckData equ 00h
MajorLocation_Arachnus equ 01h
MajorLocation_ChargeCoreX equ 02h
MajorLocation_TROSecurity equ 03h
MajorLocation_TROData equ 04h
MajorLocation_Zazabi equ 05h
MajorLocation_Serris equ 06h
MajorLocation_PYRSecurity equ 07h
MajorLocation_PYRData equ 08h
MajorLocation_MegaCoreX equ 09h
MajorLocation_ARCSecurity equ 0Ah
MajorLocation_ARCData equ 0Bh
MajorLocation_WideCoreX equ 0Ch
MajorLocation_ARCData2 equ 0Dh
MajorLocation_Yakuza equ 0Eh
MajorLocation_Nettori equ 0Fh
MajorLocation_Nightmare equ 10h
MajorLocation_AQASecurity equ 11h
MajorLocation_AQAData equ 12h
MajorLocation_XBox equ 13h
MajorLocation_Ridley equ 14h

StoryFlag_MissileHatch equ 0
StoryFlag_WaterLowered equ 1
StoryFlag_BoxDefeated equ 2

.sym on
