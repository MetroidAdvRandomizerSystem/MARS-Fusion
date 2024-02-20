; Moves or removes all vanilla messages to make space for custom messages

.org 0802A932h
.area 0Ch, 0
	; force check if message box sprite graphics are loaded
.endarea

.org 080797EEh
.area 08h, 0
	; bounds check non-major upgrade messages
	sub		r2, #Message_EnemyLocationAbnormal - (Message_AtmosphericStabilizer1 - 1) + 1
	asr		r0, r2, #1Fh
	and		r2, r0
	add		r2, #Message_EnemyLocationAbnormal + 1
.endarea

.org 0802AABCh
.area 08h, 0
	; spawn selection cursor in prompt messages
	cmp		r6, #Message_SavePrompt - (Message_AtmosphericStabilizer1 - 1)
	beq		0802AAC4h
	cmp		r6, #Message_AdamUplinkPrompt - (Message_AtmosphericStabilizer1 - 1)
	bne		0802AAE0h
.endarea

.org 0802AAE0h
.area 0Ch, 0
	; check for recharge or resupply
	mov		r0, r6
	sub		r0, #Message_ResupplyComplete - (Message_AtmosphericStabilizer1 - 1)
	cmp		r0, #Message_EnergyRechargeComplete - Message_ResupplyComplete
	bhi		0802AAF0h
.endarea

.org 0802AAF0h
.area 0Ah, 0
	; check for task complete messages
	mov		r0, r6
	sub		r0, #Message_AtmosphericStabilizer5 - (Message_AtmosphericStabilizer1 - 1)
	cmp		r0, #Message_AuxiliaryPower - Message_AtmosphericStabilizer5
	bhi		0802AB04h
.endarea

.org 0802AB40h
.area 08h, 0
	; skip handling prompt messages
	cmp		r2, #Message_SavePrompt - (Message_AtmosphericStabilizer1 - 1)
	beq		0802AB96h
	cmp		r2, #Message_AdamUplinkPrompt - (Message_AtmosphericStabilizer1 - 1)
	beq		0802AB96h
.endarea	

.org 0802AB82h
.area 04h, 0
	; set pose for saving the animals
	cmp		r4, #Message_AnimalsFreed - (Message_AtmosphericStabilizer1 - 1)
	bne		0802AB96h
.endarea

.org 0802AB6Ch
.area 04h, 0
	; set music for restricted sector detachment
	cmp		r2, #Message_RestrictedSectorDetachment - (Message_AtmosphericStabilizer1 - 1)
	bne		0802AB74h
.endarea

.org 0802AB74h
.area 04h, 0
	; set music for escape sequence
	cmp		r2, #Message_EscapeSequence - (Message_AtmosphericStabilizer1 - 1)
	bne		0802AB96h
.endarea

.org 0802ABA6h
.area 04h, 0
	; don't immediately allow movement while saving the animals
	cmp		r2, #Message_AnimalsFreed - (Message_AtmosphericStabilizer1 - 1)
	beq		0802ABC0h
.endarea

.org 0802ABB0h
.area 0Ch, 0
	; remove tank from map
	mov		r0, r2
	sub		r0, #Message_EnergyTankUpgrade - (Message_AtmosphericStabilizer1 - 1)
	cmp		r0, #Message_PowerBombTankUpgrade - Message_EnergyTankUpgrade
	bhi		0802ABC0h
.endarea

.org 0802ABF6h
.area 04h
	; uplink with adam
	cmp		r0, #Message_AdamUplinkPrompt - (Message_AtmosphericStabilizer1 - 1)
	bne		0802AC12h
.endarea

.org 0807A14Eh
	; get message for objective prompt
	add		r0, #Message_ObjectiveClearPrompt * 4

.org 0807BA50h
	; get messages for sleep mode prompt
	add		r0, #Message_SleepModePrompt1 * 4
.org 0807BB3Eh
	add		r0, #Message_SleepModePrompt3 * 4

.defineregion 0879C810h, 0C0h

.org 0879CDFCh
	.dw		@EnglishMessages

.autoregion
	.align 4
@EnglishMessages:
	.dw		086B489Ah	; security level 1
	.dw		086B4906h	; security level 2
	.dw		086B4974h	; security level 3
	.dw		086B49E4h	; security level 4
	.dw		086B4A4Eh	; main missiles
	.dw		086B4AB0h	; super missiles
	.dw		086B4B1Eh	; bombs
	.dw		086B4B8Ch	; main power bombs
	.dw		086B4C08h	; ice missiles
	.dw		086B4C7Ch	; diffusion missiles
	.dw		086B4Cf6h	; morph ball
	.dw		086B4D68h	; hi-jump
	.dw		086B4DC0h	; screw attack
	.dw		086B4E34h	; space jump
	.dw		086B4EB2h	; screw attack
	.dw		086B4F2Ch	; varia suit
	.dw		086B4FA4h	; gravity suit
	.dw		086B5010h	; charge beam
	.dw		086B508Ah	; wide beam
	.dw		086B50FCh	; wave beam
	.dw		086B5170h	; plasma beam
	.dw		086B51E6h	; ice beam
	.dw		086B5984h	; is your objective clear?
	.dw		086B59CCh	; confirm mission objective?
.if RANDOMIZER
	.dw		@EnglishMessage_WarpToShipLine1
	.dw		@EnglishMessage_WarpToShipLine2
.else
	.dw		086B5A18h	; sleep mode line 1
	.dw		086B5A78h	; sleep mode line 2
.endif
	.dw		086B5AEAh	; sleep mode line 3
	.dw		086B5256h	; atmospheric stabilizer 1
	.dw		086B52D8h	; atmospheric stabilizer 2
	.dw		086B5352h	; atmospheric stabilizer 3
	.dw		086B53D4h	; atmospheric stabilizer 4
	.dw		086B5454h	; atmospheric stabilizer 5
	.dw		086B54C4h	; water level lowered
	.dw		086B54F4h	; boiler cooling
	.dw		086B552Eh	; animals freed
	.dw		086B5570h	; auxiliary power
	.dw		086B55A8h	; restricted sector detaching
	.dw		086B5612h	; escape sequence starting
	.dw		086B5674h	; save prompt
	.dw		086B56A0h	; save complete
	.dw		086B56C4h	; adam uplink prompt
	.dw		086B56FAh	; ammunition resupply
	.dw		086B5742h	; energy recharge
	.dw		086B5784h	; ammo and energy recharge
	.dw		086B57CEh	; energy tank
	.dw		086B5834h	; missile tank
	.dw		086B589Eh	; power bomb tank
	.dw		086B5912h	; enemy location abnormal
	.dw		@EnglishMessage_IceTrap
	.dw		@EnglishMessage_Nothing
.endautoregion

.autoregion
	.align 2
@EnglishMessage_IceTrap:
	.string 56, "[INDENT]You are a FOOL!\n"
.endautoregion

.autoregion
	.align 2
@EnglishMessage_Nothing:
	.string 50, "[INDENT]Nothing acquired.\n"
.endautoregion

.if RANDOMIZER
.defineregion 086B5A18h, 60h
.defineregion 086B5A78h, 72h

.autoregion
	.align 2
@EnglishMessage_WarpToShipLine1:
	.stringn 64, "[INDENT]Warp to ship?\n"
	.string  10, "[INDENT]You will return to your ship,"
.endautoregion

.autoregion
	.align 2
@EnglishMessage_WarpToShipLine2:
	.stringn 19, "[INDENT]but your recent progress\n"
	.string  51, "[INDENT]will not be saved."
.endautoregion
.endif
