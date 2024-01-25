Language equ 03000011h

LastAbility equ 0300001Bh
SecurityLevelFlash equ 0300001Ch
PowerOutageSecurityBackup equ 0300001Dh

CurrArea equ 0300002Ch
CurrRoom equ 0300002Dh
CurrSubEvent equ 03000060h
PrevSubEvent equ 03000062h
CurrEvent equ 03000B87h

CurrentClipdataAction equ 03000053h

ToggleInput equ 030011ECh

ArmCannonPos equ 03000B80h
.sym off
ArmCannonPos_X equ 00h
ArmCannonPos_Y equ 02h
.sym on

GameTimer equ 03000138h
.sym off
GameTimer_Hours equ 00h
GameTimer_Minutes equ 01h
GameTimer_Seconds equ 02h
GameTimer_Frames equ 03h
GameTimer_Maxed equ 04h
.sym on

MiscProgress equ 030006AEh
.sym off
MiscProgress_AtmoStabilizers equ 00h
MiscProgress_NormalXBarriers equ 02h
MiscProgress_SuperXBarriers equ 04h
MiscProgress_PowerXBarriers equ 06h
MiscProgress_Eyedoors equ 08h
MiscProgress_StoryFlags equ 0Ah	; \
MiscProgress_DataRooms equ 0Bh	; | non-vanilla, added by non-linear patches
MiscProgress_Bosses equ 0Ch		; /
.sym on

CurrentEnemy equ 030006BCh
EnemyList equ 03000140h
.sym off
Enemy_Status equ 00h
Enemy_Health equ 14h
Enemy_Animation equ 16h
Enemy_Id equ 1Dh
Enemy_SpritesetGfxSlot equ 1Fh
Enemy_Palette equ 20h
Enemy_Pose equ 24h
Enemy_IgnoreSamusCollisionTimer equ 26h
Enemy_Timer0 equ 2Eh
Enemy_Timer1 equ 2Fh
Enemy_FreezeTimer equ 32h
Enemy_StandingOnFlag equ 33h
Enemy_Properties equ 34h
Enemy_FreezePaletteOffset equ 35h
.sym on

CurrentProjectile equ 03000B60h
ProjectileList equ 03000960h
.sym off
ProjectileList_Len equ 16
Projectile_Status equ 00h
Projectile_OamPointer equ 04h
Projectile_PosY equ 08h
Projectile_PosX equ 0Ah
Projectile_AnimFrame equ 0Ch
Projectile_AnimCounter equ 0Eh
Projectile_Type equ 0Fh
Projectile_Direction equ 10h
Projectile_Stage equ 12h
Projectile_Part equ 13h
Projectile_VertOffscreenRange equ 14h
Projectile_HorizOffscreenRange equ 15h
Projectile_BboxTop equ 16h
Projectile_BboxBottom equ 18h
Projectile_BboxLeft equ 1Ah
Projectile_BboxRight equ 1Ch
Projectile_Timer equ 1Eh
Projectile_ParentSlot equ 1Fh
Projectile_Size equ 20h
.sym on

SamusState equ 03001244h
SamusStateBackup equ 03001270h
.sym off
SamusState_Pose equ 01h
SamusState_ForcedMovement equ 03h
SamusState_ArmCannonDirection equ 07h
SamusState_ProjectileCooldown equ 0Ah
SamusState_SoloWaveDirection equ 0Bh	; non-vanilla
SamusState_ChargeCounter equ 0Ch
SamusState_DiagonalAim equ 0Dh
SamusState_Direction equ 12h
SamusState_PositionX equ 16h
SamusState_PositionY equ 18h
SamusState_VelocityX equ 1Ah
SamusState_VelocityY equ 1Ch
SamusState_Animation equ 22h
.sym on

SamusUpgrades equ 03001310h
.sym off
SamusUpgrades_CurrEnergy equ 00h
SamusUpgrades_MaxEnergy equ 02h
SamusUpgrades_CurrMissiles equ 04h
SamusUpgrades_MaxMissiles equ 06h
SamusUpgrades_CurrPowerBombs equ 08h
SamusUpgrades_MaxPowerBombs equ 09h
SamusUpgrades_BeamUpgrades equ 0Ah
SamusUpgrades_ExplosiveUpgrades equ 0Bh
SamusUpgrades_SuitUpgrades equ 0Ch
SamusUpgrades_SecurityLevel equ 0Dh
SamusUpgrades_MapDownloads equ 0Eh
SamusUpgrades_LowHealthFlag equ 0Fh
.sym on

DestinationRoom equ 03004E3Ch

EventUpgradeInfo equ 08575FB4h
.sym off
EventUpgradeInfo_Len equ 19
EventUpgradeInfo_BeamUpgrades equ 00h
EventUpgradeInfo_ExplosiveUpgrades equ 01h
EventUpgradeInfo_SuitUpgrades equ 02h
EventUpgradeInfo_ChangesSuit equ 03h
EventUpgradeInfo_Message equ 04h
EventUpgradeInfo_SubEvent equ 06h
EventUpgradeInfo_Size equ 08h
.sym on

SecurityUnlockEvents equ 085760C8h
.sym off
SecurityUnlockEvents_Len equ 4
SecurityUnlockEvent_SecurityLevel equ 00h
SecurityUnlockEvent_Area equ 01h
SecurityUnlockEvent_PrevEvent equ 02h
SecurityUnlockEvent_NewEvent equ 03h
SecurityUnlockEvent_SubEvent equ 04h
SecurityUnlockEvent_Message equ 05h	; non-vanilla
SecurityUnlockEvent_Size equ 8
.sym on

MessagesByLanguage equ 0879CDF4h

DMA0 equ 040000B0h
DMA1 equ 040000BCh
DMA2 equ 040000C8h
DMA3 equ 040000D4h
.sym off
DMA_SAD equ 00h
DMA_DAD equ 04h
DMA_CNT equ 08h
.sym on
