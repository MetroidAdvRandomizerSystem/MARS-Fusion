; Repurpose the samus status menu to enable and disable upgrades

.org 08077160h
	bl		SamusStatusMenu_Update

.org 0807748Ah
	nop

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
	add		r0, #10h
	strh	r0, [r4, #6]
@@check_a:
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
	ldr		r1, =@UpgradeLookup
	lsl		r0, #1
	add		r0, r4
	ldrb	r0, [r1, r0]
	cmp		r0, #Upgrade_None
	beq		@@scroll_vertical_inc
	lsl		r0, #2
	ldr		r1, =MajorUpgradeInfo
	add		r1, r0
	ldrb	r0, [r1, MajorUpgradeInfo_Offset]
	ldr		r2, =SamusUpgrades
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
	ldr		r1, =@UpgradeLookup
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
	ldr		r2, =SamusUpgrades
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
	adc		r3, r0
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

.autoregion
@UpgradeLookup:
	.db		Upgrade_ChargeBeam,			Upgrade_PowerBombs
	.db		Upgrade_WideBeam,			Upgrade_None
	.db		Upgrade_PlasmaBeam,			Upgrade_None
	.db		Upgrade_WaveBeam,			Upgrade_VariaSuit
	.db		Upgrade_IceBeam,			Upgrade_GravitySuit
	.db		Upgrade_None,				Upgrade_None
	.db		Upgrade_None,				Upgrade_None
	.db		Upgrade_None,				Upgrade_MorphBall
	.db		Upgrade_SuperMissiles,		Upgrade_HiJump
	.db		Upgrade_IceMissiles,		Upgrade_Speedbooster
	.db		Upgrade_DiffusionMissiles,	Upgrade_SpaceJump
	.db		Upgrade_None,				Upgrade_ScrewAttack
.endautoregion
