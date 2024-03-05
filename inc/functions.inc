InitializeAudio equ 08002298h
Sfx_Play equ 0800270Ch
Music_CheckSet equ 08003498h
Music_CheckPlay equ 080034F4h
Music_Play equ 08003538h
Music_FadeOut equ 080036F0h

SpawnPrimarySprite equ 0800FBC8h

LockHatches equ 08063070h
ChangeSuit equ 08063190h
SetEventEffect equ 0806342Ch
SetBg1Tile equ 0806C614h
SetSpecialBg1Tile equ 0806C6E4h
SetClipdata equ 0806C82Ch
SpawnParticleEffect equ 080730E4h
SetEvent equ 08074890h

SetTankAsCollected equ 0806CCF8h
RemoveCollectedTanks equ 0806CE40h
MinimapSetCollectedItems equ 08075884h
MapScreenCountTanks equ 08075D28h

GetCharWidth equ 08079118h
RenderChar equ 08079438h

CheckProjectiles equ 0808116Ch
SpawnProjectile equ 080811BCh
SpawnSecondaryProjectile equ 0808125Ch
LoadBeamGfx equ 08081E5Ch
LoadMissileGfx equ 08082010h

Projectile_Move equ 08082120h
Projectile_UpdateClipdata equ 0808222Ch
Projectile_DamageEnemy equ 080835F8h
Beam_MoveParts equ 08082464h
Beam_SetTrail equ 080827E0h
WaveBeam_MoveParts equ 0808252Ch
WaveBeam_UpdateClipdata equ 080821ECh
IceBeam_DamageEnemy equ 08083A4Ch

Enemy_GetWeakness equ 08083044h
Enemy_StartOnHitTimer equ 08083B78h
Enemy_MakesDebrisWhenHit equ 08082FECh
Enemy_CreateDebris equ 08083090h
Enemy_CreatePlasmaDebris equ 080831C4h

Divide equ 080A3468h
memcpy equ 080A4EF0h
memset equ 080A4F50h
