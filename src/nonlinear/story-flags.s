; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Patches miscellaneous story flags to be tracked separately from events.

; TODO: convert enemy set event checks to story flag checks
; TODO: set water lowered flag when exiting room with lowering event active

.org 08041984h
.area 38h, 0
	; missile hatch idle
	push	{ lr }
	ldr		r2, =CurrentEnemy
	mov		r3, r2
	add		r3, #20h
	mov		r0, #1
	strb	r0, [r3, Enemy_IgnoreSamusCollisionTimer - 20h]
	ldrb	r0, [r2, Enemy_Health]
	cmp		r0, #0
	bne		@@return
	mov		r0, #18h
	strb	r0, [r3, Enemy_Pose - 20h]
	mov		r0, #0
	strb	r0, [r3, Enemy_Timer0 - 20h]
	ldr		r2, =MiscProgress
	ldrb	r1, [r2, MiscProgress_StoryFlags]
	mov		r0, 1 << StoryFlag_MissileHatch
	orr		r0, r1
	strb	r0, [r2, MiscProgress_StoryFlags]
	mov		r0, #1
	bl		08041898h
@@return:
	pop		{ pc }
	.pool
.endarea

.org 080418EAh
.area 1Ah, 0
	; missile hatch initialize
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_MissileHatch + 1
	bcc		08041904h
	ldr		r1, =CurrentEnemy
	mov		r0, #0
	strb	r0, [r1, Enemy_Status]
	b		0804196Ah
	.pool
.endarea

.org 08064FFCh
	; water height check
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_WaterLowered + 1
	bcc		08065020h
.org 08065018h
	.pool

.org 08060D98h
.area 18h, 0
	; water lowered event check
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsl		r0, 1Fh - StoryFlag_WaterLowered
	lsr		r0, 1Fh
	bx		lr
	.pool
.endarea

.org 08060E3Ch
.area 18h, 0
	; pump room active event check
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_WaterLowered + 1
	sbc		r0, r0
	neg		r0, r0
	bx		lr
	.pool
.endarea

.org 08030ECCh
.area 34h, 0
	; electric wire idle
	push	{ lr }
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_WaterLowered + 1
	bcc		@@return
	ldr		r1, =CurrentEnemy
	ldrh	r0, [r1, Enemy_Animation]
	cmp		r0, #0
	bne		@@return
	add		r1, Enemy_Pose
	mov		r0, #18h
	strb	r0, [r1]
	lsl		r0, #3
	add		r0, 117h - 0C0h
	;bl		Sfx_Play
@@return:
	pop		{ pc }
	.pool
.endarea

.org 08030FCCh
.area 1Ch, 0
	; electric water damage update
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_WaterLowered + 1
	bcc		@@return
	ldr		r1, =CurrentEnemy
	mov		r0, #0
	strh	r0, [r1, Enemy_Status]
@@return:
	pop		{ pc }
	.pool
.endarea

.org 08031038h
.area 1Ch, 0
	; electric water update
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_WaterLowered + 1
	bcc		@@return
	ldr		r1, =CurrentEnemy
	mov		r0, #0
	strh	r0, [r1, Enemy_Status]
@@return:
	pop		{ pc }
	.pool
.endarea

.org 08063956h
.area 52h, 0
	; update water lowered flag
	ldr		r5, =03004E4Ch
	ldr		r1, =MiscProgress
	ldrb	r0, [r1, MiscProgress_StoryFlags]
	mov		r1, 1 << StoryFlag_WaterLowered
	orr		r0, r1
	ldr		r1, =MiscProgress
	strb	r0, [r1, MiscProgress_StoryFlags]
	ldrh	r0, [r5, #8]
	add		r0, #1
	strh	r0, [r5, #8]
	mov		r1, #28h
	lsl		r1, #4
	cmp		r0, r1
	blt		@@checkScreenShake
	strh	r1, [r5, #8]
	mov		r0, #8Fh
	lsl		r0, #1
	bl		08002738h
	mov		r0, r5
	sub		r0, 03004E4Ch - 03004E3Ah
	strb	r4, [r0]
	mov		r6, #2
@@checkScreenShake:
	ldr		r0, =030000F0h
	ldrb	r0, [r0]
	cmp		r0, #0
	bne		@@skipScreenShake
	mov		r0, #14h
	mov		r1, #81h
	bl		0806258Ch
@@skipScreenShake:
	b		08063C2Ah
	.pool
.endarea

.org 080395E2h
	; start water lowering event effect
	mov		r0, EventEffect_WaterLowering
	bl		0806368Ch
