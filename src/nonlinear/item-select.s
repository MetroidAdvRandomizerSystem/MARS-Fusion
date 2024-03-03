; Repurpose the samus status menu to enable and disable upgrades

.org 08077160h
	bl		SamusStatusMenu_Update

.org 08077488h
.area 04h, 0
	; always enable debug menu cursor
.endarea

.org 0807E834h
.region 458h
	.align 2
.func @InitUpgradeLookup
	push	{ r4-r6, lr }
	ldr		r1, =UpgradeLookup
	mov		r0, #0
	str		r0, [r1]
	str		r0, [r1, #4]
	str		r0, [r1, #8]
	str		r0, [r1, #12]
	str		r0, [r1, #16]
	str		r0, [r1, #20]
	add		r4, =@@UpgradeOrder
	ldr		r5, =UpgradesBackup
	ldr		r6, =MajorUpgradeInfo
@@loop_pool:
	ldr		r3, =UpgradeLookup
	ldrb	r0, [r4]
	cmp		r0, #0FFh
	beq		@@return
	add		r3, r0
@@loop_upgrade:
	add		r4, #1
	ldrb	r2, [r4]
	cmp		r2, #0FFh
	beq		@@loop_pool_inc
	lsl		r0, r2, #2
	add		r1, r6, r0
	ldrb	r0, [r1, MajorUpgradeInfo_Offset]
	sub		r0, #SamusUpgrades_BeamUpgrades - UpgradesBackup_BeamUpgrades
	ldrb	r0, [r5, r0]
	ldrb	r1, [r1, MajorUpgradeInfo_Bitmask]
	and		r0, r1
	beq		@@loop_upgrade
	strb	r2, [r3]
	add		r3, #2
	b		@@loop_upgrade
@@loop_pool_inc:
	add		r4, #1
	b		@@loop_pool
@@return:
	pop		{ r4-r6, pc }
	.pool
	.align 4
@@UpgradeOrder:
	.db		0 + 0 * 2
	.db		Upgrade_ChargeBeam, Upgrade_WideBeam, Upgrade_PlasmaBeam
	.db		Upgrade_WaveBeam, Upgrade_IceBeam, 0FFh
	.db		0 + 8 * 2
	.db		Upgrade_SuperMissiles, Upgrade_IceMissiles
	.db		Upgrade_DiffusionMissiles, 0FFh
	.db		1 + 0 * 2
	.db		Upgrade_PowerBombs, 0FFh
	.db		1 + 3 * 2
	.db		Upgrade_VariaSuit, Upgrade_GravitySuit, 0FFh
	.db		1 + 7 * 2
	.db		Upgrade_MorphBall, Upgrade_HiJump, Upgrade_Speedbooster
	.db		Upgrade_SpaceJump, Upgrade_ScrewAttack, 0FFh
	.db		0FFh
.endfunc

.align 2
.func @InitUpgrades
	push	{ r4, lr }
	bl		@InitUpgradeLookup
	ldr		r0, =UpgradesBackup
	ldrb	r2, [r0, UpgradesBackup_BeamUpgrades]
	cmp		r2, #0
	beq		@@init_missiles
	ldr		r0, =#0B18Ah
	ldr		r1, =#0600C982h
	ldr		r3, =SamusUpgrades
	ldrb	r3, [r3, SamusUpgrades_BeamUpgrades]
	add		r4, =@@BeamOrder
	bl		@InitLeftUpgrade
@@init_missiles:
	ldr		r0, =UpgradesBackup
	ldrb	r2, [r0, UpgradesBackup_ExplosiveUpgrades]
	lsr		r0, r2, #ExplosiveUpgrade_Missiles + 1
	bcc		@@init_bombs
	ldr		r0, =#0B234h
	ldr		r1, =#0600CB42h
	strh	r0, [r1]
	ldr		r0, =#0B0EAh
	add		r0, #20h
	strh	r0, [r1, #2]
	add		r0, #1
	strh	r0, [r1, #4]
	add		r0, #1
	strh	r0, [r1, #6]
	add		r0, #1
	strh	r0, [r1, #8]
	add		r0, #1
	strh	r0, [r1, #10]
	add		r0, #1
	strh	r0, [r1, #12]
	add		r0, #1
	strh	r0, [r1, #14]
	add		r0, #0F3h - 110h
	add		r1, #40h
	ldr		r3, =SamusUpgrades
	ldrb	r3, [r3, SamusUpgrades_ExplosiveUpgrades]
	add		r4, =@@MissileOrder
	bl		@InitLeftUpgrade
@@init_bombs:
	ldr		r0, =UpgradesBackup
	ldrb	r2, [r0, UpgradesBackup_ExplosiveUpgrades]
.if BOMBLESS_PBS
	mov		r0, #(1 << ExplosiveUpgrade_Bombs) | (1 << ExplosiveUpgrade_PowerBombs)
.else
	mov		r0, #(1 << ExplosiveUpgrade_Bombs)
.endif
	tst		r0, r2
	beq		@@init_suits
	ldr		r0, =#0B0EAh
	add		r0, #40h
	ldr		r1, =#0600C966h
	strh	r0, [r1]
	add		r0, #1
	strh	r0, [r1, #2]
	add		r0, #1
	strh	r0, [r1, #4]
	add		r0, #1
	strh	r0, [r1, #6]
	add		r0, #1
	strh	r0, [r1, #8]
	add		r0, #1
	strh	r0, [r1, #10]
	strh	r0, [r1, #12]
	add		r0, #1
	strh	r0, [r1, #14]
	add		r0, #1
	strh	r0, [r1, #16]
	add		r0, #1
	strh	r0, [r1, #18]
	add		r0, #0F8h - 132h
	add		r1, #40h
	ldr		r3, =SamusUpgrades
	ldrb	r3, [r3, SamusUpgrades_ExplosiveUpgrades]
	add		r4, =@@BombOrder
	bl		@InitRightUpgrade
@@init_suits:
	ldr		r0, =UpgradesBackup
	ldrb	r2, [r0, UpgradesBackup_SuitUpgrades]
	mov		r0, #(1 << SuitUpgrade_VariaSuit) | (1 << SuitUpgrade_GravitySuit)
	tst		r0, r2
	beq		@@init_misc
	ldr		r0, =#0B0EAh
	add		r0, #118h - 0EAh
	ldr		r1, =#0600CA66h
	ldr		r3, =SamusUpgrades
	ldrb	r3, [r3, SamusUpgrades_SuitUpgrades]
	add		r4, =@@SuitOrder
	bl		@InitRightUpgrade
@@init_misc:
	ldr		r0, =UpgradesBackup
	ldrb	r2, [r0, UpgradesBackup_SuitUpgrades]
	mov		r0, #(1 << SuitUpgrade_MorphBall) | (1 << SuitUpgrade_HiJump) \
			   | (1 << SuitUpgrade_Speedbooster) | (1 << SuitUpgrade_SpaceJump) \
			   | (1 << SuitUpgrade_ScrewAttack)
	tst		r0, r2
	beq		@@return
	ldr		r0, =#0B0EAh
	add		r0, #80h
	ldr		r1, =#0600CB26h
	strh	r0, [r1]
	add		r0, #1
	strh	r0, [r1, #2]
	add		r0, #1
	strh	r0, [r1, #4]
	add		r0, #1
	strh	r0, [r1, #6]
	add		r0, #1
	strh	r0, [r1, #8]
	add		r0, #12Fh - 16Eh
	strh	r0, [r1, #10]
	strh	r0, [r1, #12]
	add		r0, #1
	strh	r0, [r1, #14]
	add		r0, #1
	strh	r0, [r1, #16]
	add		r0, #1
	strh	r0, [r1, #18]
	add		r0, #18Eh - 132h
	add		r1, #40h
	ldr		r3, =SamusUpgrades
	ldrb	r3, [r3, SamusUpgrades_SuitUpgrades]
	add		r4, =@@MiscOrder
	bl		@InitRightUpgrade
@@return:
	pop		{ r4, pc }
	.pool
	.align 4
@@BeamOrder:
	.db		BeamUpgrade_ChargeBeam, 4
	.db		BeamUpgrade_WideBeam, 3
	.db		BeamUpgrade_PlasmaBeam, 4
	.db		BeamUpgrade_WaveBeam, 3
	.db		BeamUpgrade_IceBeam, 2
	.db		0FFh, 0FFh
	.align 4
@@MissileOrder:
	.db		ExplosiveUpgrade_SuperMissiles, 3
	.db		ExplosiveUpgrade_IceMissiles, 2
	.db		ExplosiveUpgrade_DiffusionMissiles, 5
	.db		0FFh, 0FFh
@@BombOrder:
	.db		ExplosiveUpgrade_PowerBombs, 4
	.db		0FFh, 0FFh
	.align 4
@@SuitOrder:
	.db		SuitUpgrade_VariaSuit, 3
	.db		SuitUpgrade_GravitySuit, 4
	.db		0FFh, 0FFh
	.align 4
@@MiscOrder:
	.db		SuitUpgrade_MorphBall, 6
	.db		SuitUpgrade_HiJump, 4
	.db		SuitUpgrade_Speedbooster, 8
	.db		SuitUpgrade_SpaceJump, 6
	.db		SuitUpgrade_ScrewAttack, 7
	.db		0FFh, 0FFh
.endfunc

	.align 2
.func @InitLeftUpgrade
	push	{ r5-r7, lr }
	mov		r7, r4
	mov		r6, r3
	mov		r5, r2
	mov		r4, r1
	mov		r3, r0
@@loop:
	ldrb	r2, [r7]
	cmp		r2, #0FFh
	beq		@@write_last_row
	mov		r0, r5
	lsr		r0, r2
	lsr		r0, #1
	bcc		@@loop_inc
	ldr		r0, =#0B22Ah
	add		r0, #254h - 22Ah
	strh	r0, [r4]
	mvn		r0, r6
	lsr		r0, r2
	lsl		r0, #1Fh
	lsr		r2, r0, #1Fh
	ldr		r0, =#0B22Ah
	add		r0, r2
	strh	r0, [r4, #2]
	lsl		r1, r2, #0Ch
	add		r0, r3, r1
	mov		r1, #0
	ldrb	r2, [r7, #1]
	add		r4, #4
@@write_text_loop:
	strh	r0, [r4]
	add		r0, #1
	add		r4, #2
	add		r1, #1
	cmp		r1, r2
	blt		@@write_text_loop
	ldr		r0, =#0B22Ah
	add		r0, #2
@@write_empty_loop:
	cmp		r1, #5
	bge		@@write_last_col
	strh	r0, [r4]
	add		r4, #2
	add		r1, #1
	b		@@write_empty_loop
@@write_last_col:
	add		r0, #1
	strh	r0, [r4]
	add		r4, #32h
@@loop_inc:
	add		r3, #20h
	add		r7, #2
	b		@@loop
@@write_last_row:
	ldr		r0, =#0B22Ah
	add		r0, #274h - 22Ah
	strh	r0, [r4]
	add		r0, #5
	strh	r0, [r4, #2]
	add		r0, #1
	strh	r0, [r4, #4]
	add		r0, #1
	strh	r0, [r4, #6]
	add		r0, #1
	strh	r0, [r4, #8]
	sub		r0, #7
	strh	r0, [r4, #10]
	add		r0, #1
	strh	r0, [r4, #12]
	add		r0, #1
	strh	r0, [r4, #14]
@@return:
	pop		{ r5-r7, pc }
	.pool
.endfunc

	.align 2
.func @InitRightUpgrade
	push	{ r5-r7, lr }
	mov		r7, r4
	mov		r6, r3
	mov		r5, r2
	mov		r4, r1
	mov		r3, r0
@@loop:
	ldrb	r2, [r7]
	cmp		r2, #0FFh
	beq		@@write_last_row
	mov		r0, r5
	lsr		r0, r2
	lsr		r0, #1
	bcc		@@loop_inc
	ldr		r0, =#0B22Ah
	add		r0, #254h - 22Ah
	strh	r0, [r4]
	mvn		r0, r6
	lsr		r0, r2
	lsl		r0, #1Fh
	lsr		r2, r0, #1Fh
	ldr		r0, =#0B22Ah
	add		r0, r2
	strh	r0, [r4, #2]
	lsl		r1, r2, #0Ch
	add		r0, r3, r1
	mov		r1, #0
	ldrb	r2, [r7, #1]
	add		r4, #4
@@write_text_loop:
	strh	r0, [r4]
	add		r0, #1
	add		r4, #2
	add		r1, #1
	cmp		r1, r2
	blt		@@write_text_loop
	cmp		r1, #8
	blt		@@init_empty_loop
@@speedbooster_special_case:
	sub		r4, #2
	lsr		r1, r6, #SuitUpgrade_Speedbooster + 1
	bcs		@@loop_inc_dest
	ldr		r0, =#0B1D6h
	strh	r0, [r4]
	b		@@loop_inc_dest
@@init_empty_loop:
	ldr		r0, =#0B22Ah
	add		r0, #2
@@write_empty_loop:
	cmp		r1, #7
	bge		@@write_last_col
	strh	r0, [r4]
	add		r4, #2
	add		r1, #1
	b		@@write_empty_loop
@@write_last_col:
	add		r0, #2
	strh	r0, [r4]
@@loop_inc_dest:
	add		r4, #2Eh
@@loop_inc:
	add		r3, #20h
	add		r7, #2
	b		@@loop
@@write_last_row:
	ldr		r0, =#0B22Ah
	add		r0, #278h - 22Ah
	strh	r0, [r4]
	add		r0, #1
	strh	r0, [r4, #2]
	add		r0, #1
	strh	r0, [r4, #4]
	add		r0, #1
	strh	r0, [r4, #6]
	sub		r0, #1
	strh	r0, [r4, #8]
	add		r0, #1
	strh	r0, [r4, #10]
	add		r0, #1
	strh	r0, [r4, #12]
	add		r0, #1
	strh	r0, [r4, #14]
	add		r0, #1
	strh	r0, [r4, #16]
	add		r0, #1
	strh	r0, [r4, #18]
@@return:
	pop		{ r5-r7, pc }
	.pool
.endfunc
.endregion

.org 0807E6ACh
.area 0A8h
	; initialize status screen with upgrade backup
	push	{ r4-r5, lr }
	ldr		r4, =UpgradesBackup
	ldr		r5, =SamusUpgrades
	ldrb	r0, [r4, UpgradesBackup_BeamUpgrades]
	ldrb	r1, [r5, SamusUpgrades_BeamUpgrades]
	orr		r0, r1
	strb	r0, [r4, UpgradesBackup_BeamUpgrades]
	ldrb	r0, [r4, UpgradesBackup_ExplosiveUpgrades]
	ldrb	r1, [r5, SamusUpgrades_ExplosiveUpgrades]
	orr		r0, r1
	strb	r0, [r4, UpgradesBackup_ExplosiveUpgrades]
	ldrb	r0, [r4, UpgradesBackup_SuitUpgrades]
	ldrb	r1, [r5, SamusUpgrades_SuitUpgrades]
	orr		r0, r1
	strb	r0, [r4, UpgradesBackup_SuitUpgrades]
	bl		@InitUpgrades
	mov		r0, #5
	ldrh	r1, [r5, SamusUpgrades_CurrEnergy]
	mov		r2, #6
	mov		r3, #0
	bl		0807E754h
	mov		r0, #6
	ldrh	r1, [r5, SamusUpgrades_MaxEnergy]
	mov		r2, #3
	mov		r3, #1
	bl		0807E754h
	ldrb	r0, [r4, SamusUpgrades_ExplosiveUpgrades]
	lsr		r0, #ExplosiveUpgrade_Missiles + 1
	bcs		@@write_missile_counts
	mov		r0, #1
	bl		0807EC8Ch
	b		@@check_pbs
@@write_missile_counts:
	mov		r0, #7
	ldrh	r1, [r5, SamusUpgrades_CurrMissiles]
	mov		r2, #6
	mov		r3, #0
	bl		0807E754h
	mov		r0, #8
	ldrh	r1, [r5, SamusUpgrades_MaxMissiles]
	mov		r2, #3
	mov		r3, #1
	bl		0807E754h
@@check_pbs:
	ldrb	r0, [r4, SamusUpgrades_ExplosiveUpgrades]
	lsr		r0, #ExplosiveUpgrade_PowerBombs + 1
	bcs		@@write_pb_counts
	mov		r0, #2
	bl		0807EC8Ch
	b		@@return
@@write_pb_counts:
	mov		r0, #9
	ldrb	r1, [r5, SamusUpgrades_CurrPowerBombs]
	mov		r2, #6
	mov		r3, #0
	bl		0807E754h
	mov		r0, #10
	ldrb	r1, [r5, SamusUpgrades_MaxPowerBombs]
	mov		r2, #3
	mov		r3, #1
	bl		0807E754h
@@return:
	pop		{ r4-r5, pc }
	.pool
.endarea

.org 0807E64Ch
.area 2Ch
	; init cursor
	push	{ lr }
	ldr		r2, =UpgradesBackup
	ldrb	r0, [r2, UpgradesBackup_BeamUpgrades]
	ldrb	r1, [r2, UpgradesBackup_ExplosiveUpgrades]
	ldrb	r2, [r2, UpgradesBackup_SuitUpgrades]
	orr		r0, r1
	orr		r0, r2
	beq		@@return
	mov		r0, #0
	mov		r1, #MenuSpriteGfx_CursorRight
	bl		0807486Ch
	ldr		r1, =MenuSprites
	mov		r0, #08h
	strh	r0, [r1, MenuSprite_XPos]
	mov		r0, #30h
	strh	r0, [r1, MenuSprite_YPos]
@@return:
	pop		{ pc }
	.pool
.endarea

.autoregion
	.align 2
.func SamusStatusMenu_Update
	push	{ r4-r7, lr }
	ldr		r2, =ToggleInput
	ldrh	r2, [r2]
	ldr		r4, =#03001488h
	add		r4, #030014ACh - 03001488h
	ldr		r0, =(1 << Button_B) | (1 << Button_L) | (1 << Button_R)
	tst		r0, r2
	beq		@@check_dpad_vertical
	ldr		r1, =#03001488h
	ldrb	r0, [r1, #3]
	cmp		r0, #0
	bne		@@check_dpad_vertical
	strb	r0, [r1, #2]
	ldr		r1, =MenuSprites
	strb	r0, [r1, #MenuSprite_Graphic]
	mov		r0, #7
	strb	r0, [r4]
	b		@@return
@@check_dpad_vertical:
	lsl		r0, r2, #1Fh - Button_Down
	lsl		r1, r2, #1Fh - Button_Up
	eor		r0, r1
	lsr		r0, #1Fh
	beq		@@check_dpad_horizontal
	asr		r1, #1Fh
	orr		r0, r1
@@check_dpad_horizontal:
	mov		r3, r0
	lsl		r0, r2, #1Fh - Button_Right
	lsl		r1, r2, #1Fh - Button_Left
	eor		r0, r1
	lsr		r0, #1Fh
	beq		@@move_cursor
	asr		r1, #1Fh
	orr		r0, r1
@@move_cursor:
	mov		r2, r0
	ldrh	r1, [r4, #4]
	lsr		r1, #3
	sub		r1, #6
	ldrh	r0, [r4, #6]
	lsr		r0, #7
	bl		SamusStatusMenu_MoveCursor
	add		r1, #6
	lsl		r1, #3
	strh	r1, [r4, #4]
	lsl		r1, r0, #3
	add		r0, r1
	lsl		r0, #4
	add		r0, #08h
	strh	r0, [r4, #6]
@@check_a:
	ldr		r2, =ToggleInput
	ldrh	r2, [r2]
	lsr		r0, r2, #Button_A + 1
	bcc		@@return
	ldrh	r6, [r4, #4]
	lsr		r6, #3
	sub		r6, #6
	lsl		r0, r6, #1
	ldrh	r5, [r4, #6]
	lsr		r5, #7
	add		r0, r5
	ldr		r1, =UpgradeLookup
	ldrb	r0, [r1, r0]
	lsl		r0, #2
	ldr		r3, =MajorUpgradeInfo
	add		r3, r0
	ldr		r2, =SamusUpgrades
	ldrb	r1, [r3, MajorUpgradeInfo_Offset]
	add		r2, r1
	ldrb	r0, [r2]
	ldrb	r1, [r3, MajorUpgradeInfo_Bitmask]
	eor		r0, r1
	strb	r0, [r2]
	and		r1, r0
@@set_bg1:
	ldr		r2, =#0600C800h
	ldrh	r0, [r4, #6]
	lsr		r0, #3
	add		r0, #1
	lsl		r0, #1
	add		r2, r0
	ldrh	r0, [r4, #4]
	lsr		r0, #3
	lsl		r0, #6
	add		r2, r0
	cmp		r1, #0
	bne		@@set_checked
	ldr		r0, =#0B22Bh
	b		@@set_checkbox
@@set_checked:
	ldr		r0, =#0B22Ah
@@set_checkbox:
	strh	r0, [r2]
	mov		r1, #0Bh ^ 0Ch
	lsl		r1, #0Ch
	ldrh	r0, [r2, #2]
	eor		r0, r1
	strh	r0, [r2, #2]
	ldrh	r0, [r2, #4]
	eor		r0, r1
	strh	r0, [r2, #4]
	ldrh	r0, [r2, #6]
	eor		r0, r1
	strh	r0, [r2, #6]
	ldrh	r0, [r2, #8]
	eor		r0, r1
	strh	r0, [r2, #8]
	ldrh	r0, [r2, #10]
	eor		r0, r1
	strh	r0, [r2, #10]
	ldrh	r0, [r4, #6]
	cmp		r0, #098h
	bne		@@return
	ldrh	r0, [r2, #12]
	eor		r0, r1
	strh	r0, [r2, #12]
	ldrh	r0, [r2, #14]
	eor		r0, r1
	strh	r0, [r2, #14]
	ldrh	r0, [r2, #16]
	add		r1, r0, #1
	lsl		r1, #20h - 0Ch
	lsr		r1, #20h - 0Bh
	cmp		r1, #1D6h >> 1
	bne		@@return
	mov		r1, #1D5h ^ 1D6h
	eor		r0, r1
	strh	r0, [r2, #16]
@@return:
	pop		{ r4-r7, pc }
	.pool
	.align 4
.endfunc
.endautoregion

.autoregion
	.align 2
.func SamusStatusMenu_MoveCursor
	; r0 = start x, r1 = start y, r2 = offset x, r3 = offset y
	; TODO: game hangs when moving horizontally between top row with missing
	; upgrades
	push	{ r4-r7, lr }
	mov		r4, r0
	mov		r5, r1
	mov		r6, r2
	mov		r7, r3
	cmp		r6, #0
	beq		@@check_offset_y
	add		r0, r4, r6
	cmp		r0, #1
	bls		@@find_closest
	mov		r6, #0
@@check_offset_y:
	cmp		r7, #0
	beq		@@return_prev
	b		@@scroll_vertical_first
@@scroll_vertical_loop:
	ldr		r1, =UpgradeLookup
	lsl		r0, #1
	add		r0, r4
	ldrb	r0, [r1, r0]
	cmp		r0, #Upgrade_None
	beq		@@scroll_vertical_inc
	lsl		r0, #2
	ldr		r1, =MajorUpgradeInfo
	add		r1, r0
	ldrb	r0, [r1, MajorUpgradeInfo_Offset]
	sub		r0, #SamusUpgrades_BeamUpgrades - UpgradesBackup_BeamUpgrades
	ldr		r2, =UpgradesBackup
	ldrb	r0, [r2, r0]
	ldrb	r1, [r1, MajorUpgradeInfo_Bitmask]
	tst		r0, r1
	bne		@@return_new
@@scroll_vertical_inc:
	add		r3, r7
@@scroll_vertical_first:
	add		r0, r5, r3
	cmp		r0, #12
	blo		@@scroll_vertical_loop
	b		@@return_prev
@@find_closest:
	mov		r3, #0
	b		@@find_closest_first
@@find_closest_loop:
	ldr		r1, =UpgradeLookup
	lsl		r0, #1
	add		r0, r4
	add		r0, r6
	ldrb	r0, [r1, r0]
	cmp		r0, #Upgrade_None
	beq		@@find_closest_inc
	lsl		r0, #2
	ldr		r1, =MajorUpgradeInfo
	add		r1, r0
	ldrb	r0, [r1, MajorUpgradeInfo_Offset]
	sub		r0, #SamusUpgrades_BeamUpgrades - UpgradesBackup_BeamUpgrades
	ldr		r2, =UpgradesBackup
	ldrb	r0, [r2, r0]
	ldrb	r1, [r1, MajorUpgradeInfo_Bitmask]
	tst		r0, r1
	bne		@@return_new
@@find_closest_inc:
	asr		r0, r3, #1Fh
	mvn		r3, r3
	sub		r3, r0
@@find_closest_first:
	add		r0, r5, r3
	cmp		r0, #12
	blo		@@find_closest_loop
	asr		r0, r3, #1Fh
	mvn		r3, r3
	sub		r3, r0
	add		r0, r5, r3
	cmp		r0, #12
	blo		@@find_closest_loop
@@return_prev:
	mov		r0, r4
	mov		r1, r5
	pop		{ r4-r7, pc }
@@return_new:
	add		r0, r4, r6
	add		r1, r5, r3
	pop		{ r4-r7, pc }
	.pool
.endfunc
.endautoregion

; graphics
.org 0856A254h
.area 2614h
.incbin "data/status.gfx"
.endarea

.org 085748ACh
.area 49Ch
.incbin "data/status-vram.bin"
.endarea

; palettes
.org 08565908h + 0Dh * 2
	.dh		7FE2h

.org 08565928h + 0Dh * 2
	.dh		5282h
