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
GameMode_FileSelect equ 7
GameMode_Demo equ 12

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

; messages rearranged for nonlinear patches
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
Message_InfantMetroid equ 16h
Message_LastInfantMetroid equ 17h
Message_ObjectiveClearPrompt equ 18h
Message_ConfirmObjectivePrompt equ 19h
Message_SleepModePrompt1 equ 1Ah
Message_SleepModePrompt2 equ 1Bh
Message_SleepModePrompt3 equ 1Ch
Message_AtmosphericStabilizer1 equ 1Dh
Message_AtmosphericStabilizer2 equ 1Eh
Message_AtmosphericStabilizer3 equ 1Fh
Message_AtmosphericStabilizer4 equ 20h
Message_AtmosphericStabilizer5 equ 21h
Message_WaterLowered equ 22h
Message_BoilerCooling equ 23h
Message_AnimalsFreed equ 24h
Message_AuxiliaryPower equ 25h
Message_RestrictedSectorDetachment equ 26h
Message_EscapeSequence equ 27h
Message_SavePrompt equ 28h
Message_SaveComplete equ 29h
Message_AdamUplinkPrompt equ 2Ah
Message_ResupplyComplete equ 2Bh
Message_EnergyRechargeComplete equ 2Ch
Message_RechargeAllComplete equ 2Dh
Message_EnergyTankUpgrade equ 2Eh
Message_MissileTankUpgrade equ 2Fh
Message_PowerBombTankUpgrade equ 30h
Message_EnemyLocationAbnormal equ 31h
Message_IceTrapUpgrade equ 32h
Message_NothingUpgrade equ 33h

Tank_Missiles equ 1
Tank_Energy equ 2
Tank_PowerBombs equ 3

StandingFlag_Ground equ 00h
StandingFlag_Enemy equ 01h
StandingFlag_Midair equ 02h
StandingFlag_NoControl equ 03h

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

EnvironmentalHazard_None equ 0
EnvironmentalHazard_Water equ 1
EnvironmentalHazard_Lava equ 2
EnvironmentalHazard_Acid equ 3
EnvironmentalHazard_Heat equ 4
EnvironmentalHazard_Subzero equ 5
EnvironmentalHazard_Cold equ 6

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
EventEffect_AuxiliaryPower equ 7

MenuSpriteGfx_None equ 00h
MenuSpriteGfx_FlashingSquare equ 01h
MenuSpriteGfx_CursorRight equ 02h
MenuSpriteGfx_CursorDown equ 03h
MenuSpriteGfx_PreviewMarker equ 04h
MenuSpriteGfx_BigUpArrow equ 05h
MenuSpriteGfx_BigDownArrow equ 06h
MenuSpriteGfx_BigLeftArrow equ 07h
MenuSpriteGfx_BigRightArrow equ 08h
MenuSpriteGfx_SmallVerticalArrows equ 09h
MenuSpriteGfx_SmallDownArrow equ 0Ah
MenuSpriteGfx_MovingTextMarker equ 0Bh
MenuSpriteGfx_BlinkingTextMarker equ 0Ch
MenuSpriteGfx_OutOfSectorMarker equ 0Eh
MenuSpriteGfx_IntoSectorMarker equ 0Fh
MenuSpriteGfx_MapScanlineTrail equ 10h
MenuSpriteGfx_MapScanline equ 11h
MenuSpriteGfx_TargetMarkerBoxAbove equ 12h
MenuSpriteGfx_TargetMarkerBoxBelow equ 13h
MenuSpriteGfx_TargetMarkerBoxLeft equ 14h
MenuSpriteGfx_TargetMarkerBoxRight equ 15h
MenuSpriteGfx_TargetMarkerLineAbove equ 16h
MenuSpriteGfx_TargetMarkerLineBelow equ 17h
MenuSpriteGfx_StartMarkerLineUp equ 18h
MenuSpriteGfx_StartMarkerLineBelow equ 19h
MenuSpriteGfx_MainDeckSign equ 1Ah
MenuSpriteGfx_MainDeckSignTurningOn equ 1Bh
MenuSpriteGfx_Sector1Sign equ 1Ch
MenuSpriteGfx_Sector1SignTurningOn equ 1Dh
MenuSpriteGfx_Sector2Sign equ 1Eh
MenuSpriteGfx_Sector2SignTurningOn equ 1Fh
MenuSpriteGfx_Sector3Sign equ 20h
MenuSpriteGfx_Sector3SignTurningOn equ 21h
MenuSpriteGfx_Sector4Sign equ 22h
MenuSpriteGfx_Sector4SignTurningOn equ 23h
MenuSpriteGfx_Sector5Sign equ 24h
MenuSpriteGfx_Sector5SignTurningOn equ 25h
MenuSpriteGfx_Sector6Sign equ 26h
MenuSpriteGfx_Sector6SignTurningOn equ 27h
MenuSpriteGfx_StatusButton equ 28h
MenuSpriteGfx_ActiveStatusButton equ 29h
MenuSpriteGfx_SleepButton equ 2Ah
MenuSpriteGfx_ActiveSleepButton equ 2Bh
MenuSpriteGfx_Lv1Locked equ 2Ch
MenuSpriteGfx_Lv1Unlocked equ 2Dh
MenuSpriteGfx_Lv2Locked equ 2Eh
MenuSpriteGfx_LvUnlocked equ 2Fh
MenuSpriteGfx_Lv3Locked equ 30h
MenuSpriteGfx_Lv3Unlocked equ 31h
MenuSpriteGfx_Lv4Locked equ 32h
MenuSpriteGfx_Lv4Unlocked equ 33h
MenuSpriteGfx_ObjectiveButton equ 34h
MenuSpriteGfx_GameTimer equ 36h
MenuSpriteGfx_ETankCounter equ 37h
MenuSpriteGfx_MTankCounter equ 38h
MenuSpriteGfx_PBTankCounter equ 39h
MenuSpriteGfx_ETankComplete equ 3Ah
MenuSpriteGfx_MTankComplete equ 3Bh
MenuSpriteGfx_PBTankComplete equ 3Ch
MenuSpriteGfx_NavigationConsole equ 3Dh
MenuSpriteGfx_SamusNavigationConsole equ 3Eh

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
Upgrade_IceTrap equ 26
Upgrade_InfantMetroid equ 27
Upgrade_Invalid equ 0FFh

UpgradeSprite_Empty equ 0
UpgradeSprite_Missiles equ 1
UpgradeSprite_MorphBall equ 2
UpgradeSprite_ChargeBeam equ 3
UpgradeSprite_SecurityLevel1 equ 4
UpgradeSprite_Bombs equ 5
UpgradeSprite_HiJump equ 6
UpgradeSprite_Speedbooster equ 7
UpgradeSprite_SecurityLevel2 equ 8
UpgradeSprite_SuperMissiles equ 9
UpgradeSprite_VariaSuit equ 10
UpgradeSprite_SecurityLevel3 equ 11
UpgradeSprite_IceMissiles equ 12
UpgradeSprite_WideBeam equ 13
UpgradeSprite_PowerBombs equ 14
UpgradeSprite_SpaceJump equ 15
UpgradeSprite_PlasmaBeam equ 16
UpgradeSprite_GravitySuit equ 17
UpgradeSprite_SecurityLevel4 equ 18
UpgradeSprite_DiffusionMissiles equ 19
UpgradeSprite_WaveBeam equ 20
UpgradeSprite_ScrewAttack equ 21
UpgradeSprite_IceBeam equ 22
UpgradeSprite_MissileTank equ 23
UpgradeSprite_EnergyTank equ 24
UpgradeSprite_PowerBombTank equ 25
UpgradeSprite_Anonymous equ 26
UpgradeSprite_ShinyMissileTank equ 27
UpgradeSprite_ShinyPowerBombTank equ 28
UpgradeSprite_InfantMetroid equ 29

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
StoryFlag_NocDataDestroyed equ 3
StoryFlag_BoilerCooling equ 4
StoryFlag_AnimalsFreed equ 5
StoryFlag_AuxiliaryPower equ 6
StoryFlag_RestrictedSectorDetached equ 7

; alternate palette
AltTankPal0 equ 0000h
AltTankPal1 equ 0000h
AltTankPal2 equ 294Ah
AltTankPal3 equ 4210h
AltTankPal4 equ 56B5h
AltTankPal5 equ 6B5Ah
AltTankPal6 equ 77BDh
AltTankPal7 equ 0140h
AltTankPal8 equ 0240h
AltTankPal9 equ 27E9h
AltTankPalA equ 3900h
AltTankPalB equ 7E00h
AltTankPalC equ 02D6h
AltTankPalD equ 27FFh
AltTankPalE equ 0013h
AltTankPalF equ 043Fh

.sym on
