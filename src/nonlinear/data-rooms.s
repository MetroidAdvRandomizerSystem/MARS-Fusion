; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Allows data downloads regardless of the event.

.org 08074F30h
.area 40h, 0
.func CheckOrDownloadDataUpgrade
	push	{ r4, lr }
	ldr		r1, =CurrArea
	ldrb	r4, [r1]
	mov		r2, #1
	lsl		r2, r4
@@checkDownloaded:
	ldr		r3, =MiscProgress
	ldrb	r1, [r3, MiscProgress_DataRooms]
	tst		r1, r2
	bne		@@fail
	cmp		r0, #0
	beq		@@success
	orr		r1, r2
	strb	r1, [r3, MiscProgress_DataRooms]
	add		r1, =@@AreaUpgradeLookup
	ldrb	r0, [r1, r4]
	bl		ObtainAbility
@@success:
	mov		r0, #1
	b		@@return
@@fail:
	mov		r0, #0
@@return:
	pop		{ r4, pc }
	.align 4
@@AreaUpgradeLookup:
.if RANDOMIZER
.notice "Data Room abilities @ " + tohex(.)
.endif
	.db		Ability_Missiles
	.skip 1
	.db		Ability_Bombs
	.db		Ability_SuperMissiles
	.db		Ability_DiffusionMissiles
	.db		Ability_IceMissiles
	.skip 1
	.db		Ability_PowerBombs	; second sector 5 download
	.pool
.endfunc
.endarea
