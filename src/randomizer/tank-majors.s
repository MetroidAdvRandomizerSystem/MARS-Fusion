; Allows tanks to grant any upgrade.
; Depends on the optimization/item-check.s patch

; Note: Problem spritesets are 2E (S3-17), 39 (S6-19), 48 (S5-2D, S5-2E),
; 5C (S1-33), 5E (S5-0F), and 60 (S5-09, S5-0D, S5-2C)
; Placing an item in any of these rooms would cause the message box to
; overwrite existing sprite slots

.autoregion
	.align 2
.func LoadTankGfx
	ldr		r3, =RoomTanks
	lsl		r0, #2
	add		r3, r0
	; TODO: replace tank bg0 and clipdata
	ldrb	r0, [r1, MinorLocation_Upgrade]
	strb	r0, [r3, RoomTanks_Upgrade]
	ldrb	r2, [r1, MinorLocation_Sprite]
	strb	r2, [r3, RoomTanks_Sprite]
	ldr		r3, =DMA3
	ldr		r1, =@TankTiles
	lsl		r0, r2, #9
	add		r1, r0
	str		r1, [r3, DMA_SAD]
	ldr		r1, =06004A00h
	lsr		r0, r2, #7
	add		r1, r0
	str		r1, [r2, DMA_DAD]
	ldr		r0, =80000040h
	str		r0, [r2, DMA_CNT]
	ldr		r0, [r2, DMA_CNT]
	bx		lr
	.pool
.endfunc
.endautoregion

.org 08069A98h
.area 6Ch
.func UpdateTankAnimation
	push	{ r4, lr }
	ldr		r4, =RoomTanks
	mov		r3, #0
@@loop:
	ldrb	r0, [r4, RoomTanks_Upgrade]
	cmp		r0, #0
	beq		@@loop_inc
	ldrb	r0, [r4, RoomTanks_AnimationDelay]
	add		r0, #1
	strb	r0, [r4, RoomTanks_AnimationDelay]
	cmp		r0, #5
	blt		@@loop_inc
	mov		r0, #0
	strb	r0, [r4, RoomTanks_AnimationDelay]
	ldrb	r0, [r4, RoomTanks_AnimationFrame]
	add		r0, #1
	lsl		r0, #20h - 2
	lsr		r0, #20h - 2
	strb	r0, [r4, RoomTanks_AnimationFrame]
	ldr		r2, =DMA3
	ldr		r1, =@TankTiles
	lsl		r0, #7
	add		r1, r0
	ldrb	r0, [r4, RoomTanks_Sprite]
	lsl		r0, #9
	add		r1, r0
	str		r1, [r2, DMA_SAD]
	ldr		r1, =06004A00h
	lsl		r0, r3, #7
	add		r1, r0
	str		r1, [r2, DMA_DAD]
	ldr		r0, =80000040h
	str		r0, [r2, DMA_CNT]
	ldr		r0, [r2, DMA_CNT]
@@loop_inc:
	add		r4, #4
	add		r3, #1
	cmp		r3, #3
	blt		@@loop
	pop		{ r4, pc }
	.pool
.endfunc
.endarea

; Obtain upgrade from tank and set message and fanfare
.org 0806C3CEh
.area 1Ah
	ldr		r1, =RoomTanks
	sub		r0, r5, #1
	lsl		r0, #2
	add		r1, r0
	ldrb	r0, [r1, RoomTanks_Upgrade]
	bl		ObtainUpgrade
	ldr		r1, =TimeStopTimer
	b		@@cont
	.pool
.endarea
	.skip 18h
.area 46h
@@cont:
	mov		r0, #100 >> 3
	lsl		r0, #3
	strh	r0, [r1]
	mov		r5, #0
	ldr		r0, =LastAbility
	ldrb	r0, [r0]
	cmp		r0, Message_IceBeamUpgrade
	bls		0806C446h
	sub		r0, #15h
	mov		r5, r0
	b		0806C446h
	.pool
.endarea

; force check if message box sprite graphics are loaded
.org 0802A93Ah
	nop :: nop

; check temporary tank data for tank deletion
.org 0802ABB0h
.area 10h, 0
	ldr		r0, =03004FA4h
	ldrh	r0, [r0]
	cmp		r0, #0
	beq		0802ABC0h
	bl		0806C498h
.endarea
	.skip 12h
	pop		{ pc }
	.pool

; cleanup temporary tank data
.org 0806C4E2h
.area 06h
	str		r6, [r4]
	pop		{ r4-r6, pc }
.endarea

.autoregion
	.align 4
@TankTiles:
.incbin "data/major-tanks.gfx"
.endautoregion
