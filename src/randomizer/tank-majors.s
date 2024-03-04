; Allows tanks to grant any upgrade.
; Depends on the optimization/item-check.s patch

; Note: Problem spritesets are 2E (S3-17), 39 (S6-19), 48 (S5-2D, S5-2E),
; 5C (S1-33), 5E (S5-0F), and 60 (S5-09, S5-0D, S5-2C)
; Placing an item in any of these rooms would cause the message box to
; overwrite existing sprite slots

.autoregion
	.align 2
.func LoadTankGfx
	push	{ r4-r5, lr }
	mov		r3, r1
	mov		r5, r0
	ldr		r2, =RoomTanks
	lsl		r0, #2
	add		r2, r0
	ldr		r0, =GameMode
	ldrb	r0, [r0]
	cmp		r0, #GameMode_Demo
	bne		@@set_tank_info
	mov		r0, #Upgrade_None
	strb	r0, [r2, RoomTanks_Upgrade]
	mov		r4, #UpgradeSprite_Anonymous
	strb	r4, [r2, RoomTanks_Sprite]
	b		@@load_tank_vram
@@set_tank_info:
	ldrb	r0, [r3, MinorLocation_Upgrade]
	strb	r0, [r2, RoomTanks_Upgrade]
	ldrb	r4, [r3, MinorLocation_Sprite]
	strb	r4, [r2, RoomTanks_Sprite]
	cmp		r4, #UpgradeSprite_DiffusionMissiles
	beq		@@set_bg1
	cmp		r4, #UpgradeSprite_SecurityLevel1
	beq		@@set_bg1
	cmp		r4, #UpgradeSprite_SecurityLevel2
	beq		@@set_bg1
	cmp		r4, #UpgradeSprite_SecurityLevel3
	beq		@@set_bg1
	cmp		r4, #UpgradeSprite_SecurityLevel4
	beq		@@set_bg1
	cmp		r4, #UpgradeSprite_Speedbooster
	bne		@@load_tank_vram
@@set_bg1:
	ldr		r2, =LevelData + LevelData_Bg1
	ldrh	r0, [r2, LevelLayer_Stride]
	ldrb	r1, [r3, MinorLocation_YPos]
	mul		r0, r1
	ldrb	r1, [r3, MinorLocation_XPos]
	add		r0, r1
	lsl		r0, #1
	ldr		r2, [r2, LevelLayer_Data]
	add		r2, r0
	ldrh	r0, [r2]
	sub		r0, #40h
	cmp		r0, #10h
	bhs		@@load_tank_vram
	mov		r0, r5
	add		r0, #53h
	strh	r0, [r2]
@@load_tank_vram:
	cmp		r4, #UpgradeSprite_ShinyPowerBombTank
	bls		@@load_tiles
	mov		r4, #UpgradeSprite_Empty
@@load_tiles:
	ldr		r2, =DMA3
	ldr		r1, =@TankTiles
	lsl		r0, r4, #9
	add		r1, r0
	str		r1, [r2, DMA_SAD]
	ldr		r1, =06004A00h
	lsr		r0, r4, #7
	add		r1, r0
	str		r1, [r2, DMA_DAD]
	ldr		r0, =80000040h
	str		r0, [r2, DMA_CNT]
	ldr		r0, [r2, DMA_CNT]
@@return:
	pop		{ r4-r5, pc }
	.pool
.endfunc
.endautoregion

.org 0806AEC4h
	bl		RevealTank

.autoregion
	.align 2
.func RevealTank
	push	{ r4-r5, lr }
	mov		r4, r0
	ldrh	r0, [r4, #4]
	sub		r0, #27h
	cmp		r0, #29h - 27h
	bhi		@@return_false
	mvn		r1, r0
	lsl		r1, #1Eh
	lsr		r1, #1Fh
	eor		r0, r1
	mov		r5, r0
	ldr		r1, =RoomTanks
	lsl		r0, #2
	add		r1, r0
	ldrb	r1, [r1, RoomTanks_Sprite]
	cmp		r1, #UpgradeSprite_DiffusionMissiles
	beq		@@set_alt_palette
	cmp		r1, #UpgradeSprite_SecurityLevel1
	beq		@@set_alt_palette
	cmp		r1, #UpgradeSprite_SecurityLevel2
	beq		@@set_alt_palette
	cmp		r1, #UpgradeSprite_SecurityLevel3
	beq		@@set_alt_palette
	cmp		r1, #UpgradeSprite_SecurityLevel4
	beq		@@set_alt_palette
	cmp		r1, #UpgradeSprite_Speedbooster
	bne		@@set_tile
@@set_alt_palette:
	mov		r0, r5
	add		r0, #53h
	ldrh	r1, [r4, #2]
	ldrh	r2, [r4]
	bl		SetBg1Tile
	b		@@set_clipdata
@@set_tile:
	ldr		r0, =#801Ch
	add		r0, r5
	ldrh	r1, [r4, #2]
	ldrh	r2, [r4]
	bl		SetSpecialBg1Tile
@@set_clipdata:
	ldr		r0, =#801Ch
	add		r0, r5
	ldrh	r1, [r4, #2]
	ldrh	r2, [r4]
	bl		SetClipdata
	mov		r0, #1
	pop		{ r4-r5, pc }
@@return_false:
	mov		r0, #0
	pop		{ r4-r5, pc }
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
	cmp		r0, #UpgradeSprite_ShinyPowerBombTank
	bls		@@load_tiles
	mov		r0, #UpgradeSprite_Empty
@@load_tiles:
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

.org 0802AAAEh
.area 04h
	; prolong major item fanfare so it can't interrupt audio clips
	; last resort solution, but prevents several audio related bugs
	mov		r0, #410 >> 1
	lsl		r0, #1
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
	cmp		r0, #Message_LastInfantMetroid
	bls		0806C446h
	sub		r0, #Message_AtmosphericStabilizer1 - 1
	mov		r5, r0
	b		0806C446h
	.pool
.endarea

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

; tileset 08
.org 0846A612h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 0846F134h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tilesets 09 and 40
.org 084C98B6h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084CCCC0h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tilesets 0B and 1E
.org 08410A46h + 53h * 8
	.dh		0D050h, 0D051h, 0D052h, 0D053h, 0D054h, 0D055h, 0D056h, 0D057h, 0D058h, 0D059h, 0D05Ah, 0D05Bh
.org 08407E9Ch + 0Bh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 0E
.org 08495E7Eh + 53h * 8
	.dh		0C050h, 0C051h, 0C052h, 0C053h, 0C054h, 0C055h, 0C056h, 0C057h, 0C058h, 0C059h, 0C05Ah, 0C05Bh
.org 08498808h + 0Ah * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 12
.org 08467D02h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 0846E6F4h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 13
.org 084639EEh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 0846DCB4h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 19
.org 08409FA6h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 08406B5Ch + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 1B
.org 0846617Ah + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 0846E2F4h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 1F
.org 084C712Ah + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084CC5C0h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 20
.org 084C7EAEh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084CC780h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 21
.org 084F3D1Eh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084F21F8h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 22
.org 084F4D22h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084F23B8h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 28
.org 084F6B2Ah + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 084F27B8h + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 29
.org 08496C82h + 53h * 8
	.dh		0D050h, 0D051h, 0D052h, 0D053h, 0D054h, 0D055h, 0D056h, 0D057h, 0D058h, 0D059h, 0D05Ah, 0D05Bh
.org 08498AC8h + 0Bh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 2A
.org 084F7B2Eh + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 084F2A58h + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 2B
.org 0852FA5Eh + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 085352F0h + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 2F
.org 0852FA5Eh + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 085352F0h + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 30
.org 08510DAAh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 08510868h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 31
.org 0851222Eh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 08510A28h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 34
.org 085310E2h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 085355D0h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 38
.org 08466EFEh + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 0846E4B4h + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 3D
.org 08468706h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 0846E8B4h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 3E
.org 0854E702h + 53h * 8
	.dh		0D050h, 0D051h, 0D052h, 0D053h, 0D054h, 0D055h, 0D056h, 0D057h, 0D058h, 0D059h, 0D05Ah, 0D05Bh
.org 0854D53Ch + 0Bh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 43
.org 0840CDB2h + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 0840719Ch + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 48
.org 084094A2h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084060DCh + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 54
.org 08469D0Eh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 0846EF74h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 56
.org 0853326Ah + 53h * 8
	.dh		0E050h, 0E051h, 0E052h, 0E053h, 0E054h, 0E055h, 0E056h, 0E057h, 0E058h, 0E059h, 0E05Ah, 0E05Bh
.org 08535950h + 0Ch * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 57
.org 084100C2h + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 08407CDCh + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 58
.org 0849507Ah + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 08498648h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 5B
.org 085348EEh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 08535B10h + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF

; tileset 5E
.org 0840E9BAh + 53h * 8
	.dh		0F050h, 0F051h, 0F052h, 0F053h, 0F054h, 0F055h, 0F056h, 0F057h, 0F058h, 0F059h, 0F05Ah, 0F05Bh
.org 084078DCh + 0Dh * 32
	.dh 	AltTankPal0, AltTankPal1, AltTankPal2, AltTankPal3, AltTankPal4, AltTankPal5, AltTankPal6, AltTankPal7
	.dh 	AltTankPal8, AltTankPal9, AltTankPalA, AltTankPalB, AltTankPalC, AltTankPalD, AltTankPalE, AltTankPalF
