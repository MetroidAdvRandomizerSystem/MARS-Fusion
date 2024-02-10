; Allows tanks to grant any upgrade.
; Depends on the optimization/item-check.s patch

.autoregion
	.align 2
.func LoadTankGfx
	ldr		r3, =RoomTanks
	lsl		r0, #2
	add		r3, r0
	ldr		r0, =MinorLocations
	lsl		r1, #2
	add		r1, r0
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

.org 0806C3CEh
.area 1Ah
	ldr		r1, =RoomTanks
	lsl		r0, r5, #2
	add		r1, r0
	ldrb	r0, [r1, RoomTanks_Upgrade]
	bl		ObtainUpgrade
	b		0806C436h
	.pool
.endarea

.autoregion
	.align 4
@TankTiles:
.incbin "data/major-tanks.gfx"
.endautoregion
