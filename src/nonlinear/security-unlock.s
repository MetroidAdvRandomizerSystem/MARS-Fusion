; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Allows security rooms to unlock security level regardless of the event.
; Additionally splits security levels such that unlocking a higher security
; level will not also unlock lower security levels. This behavior can be
; reverted by including the bitmasks of lower security levels in the
; SecurityUnlockEvent structs.

; TODO: debug menu security set via event

.org 08074F70h
.region 8Ch, 0
.func UpdateSecurityLevel
	push	{ r4, lr }
	mov		r4, r0
	ldr		r3, =SamusUpgrades
	ldrb	r1, [r3, SamusUpgrades_SecurityLevel]
	ldr		r0, =CurrArea
	ldrb	r0, [r0]
	sub		r0, #2
	cmp		r0, #4
	bhs		@@retZero
	ldr		r2, =SecurityUnlockEvents
	lsl		r0, #3
	add		r2, r0
	ldrb	r0, [r2, SecurityUnlockEvent_SecurityLevel]
	orr		r0, r1
	cmp		r0, r1
	beq		@@retZero
	cmp		r4, #0
	beq		@@ret
	mov		r4, r0
	strb	r0, [r3, SamusUpgrades_SecurityLevel]
	ldr		r1, =LastAbility
	ldrb	r0, [r2, SecurityUnlockEvent_Message]
	strb	r0, [r1]
	mov		r1, r0
	mov		r0,	#2
	bl		SetEventEffect
	mov		r0, r4
	b		@@ret
@@retZero:
	mov		r0, #0
@@ret:
	pop		{ r4, pc }
	.pool
.endfunc
.endarea

; SetEvent fixes
.org 08074A72h
	mov		r0, 00000b
.org 08074A82h
	mov		r1, 00001b
.org 08074A90h
	mov		r0, 00011b
.org 08074AA4h
	mov		r0, 00111b
.org 08074AB8h
	mov		r0, 01111b
.org 08074ACCh
	mov		r0, 11111b
.org 08074AF8h
	mov		r0, 00000b

.org 08065B74h
	; Security hatch flashing
	cmp		r0, #0
	beq		08065BBEh
.org 08065B9Ch
.area 22h, 0
	ldrb	r0, [r1, #1]
	ldr		r1, =08408264h
	lsl		r0, #5
	add		r1, r0
	ldr		r2, =05000028h
	ldrb	r3, [r3]
	cmp		r3, #0
@@loop:
	beq		08065BBEh
	add		r1, #4
	add		r2, #4
	lsr		r3, #1
	bcc		@@loop
	ldr		r0, [r1]
	str		r0,	[r2]
	b		@@loop
@@end:
.endarea
.org 08065C28h
	.pool

.org 0806CB5Eh
	; Check if door can open
	cmp		r1, 0b11111
.org 0806CBACh
.area 1Ch, 0
	tst		r1, r5
	beq		0806CBDCh
	bic		r1, r5
	lsl		r0, r1, #2
	add		r2, r0, r6
	ldrb	r0, [r2]
	lsr		r0, #5
	mov		r1, r10
	ldrb	r1, [r1, SamusUpgrades_SecurityLevel]
	lsr		r1, r0
	lsr		r1, #1
	bcc		0806CBE2h
.endarea

.org 08077F04h
.area 0Ah, 0
	; Check locks on map menu
	lsr		r0, r3
	mov		r6, #1
	and		r6, r0
.endarea
.org 08077E9Ch
.area 0Ah, 0
	lsr		r0, r3
	mov		r6, #1
	and		r6, r0
.endarea

.org 0807D66Ah
.area 12h, 0
	; Update debug menu
	ldr		r5, =SamusUpgrades
	ldrb	r3, [r5, SamusUpgrades_SecurityLevel]
	mov		r2, #4
	sub		r2, r4
	mov		r1, #1
	lsl		r1, r2
	eor		r1, r3
	b		@@contDebugUpdate
.endarea
	.skip 4
	.pool
.area 14h, 0
@@contDebugUpdate:
	strb	r1, [r5, SamusUpgrades_SecurityLevel]
	ldr		r2, =SecurityLevelFlash
	strb	r1, [r2]
	ldr		r2, =03000BD0h
	strb	r1, [r2, #9]
	b		#0807DADAh
	.pool
.endarea

.org 0807DDECh
.area 08h
	; Draw debug menu
	lsr		r0, r2
	lsr		r0, #1
	bcs		@@securityPass
	b		@@securityFail
.endarea
	.skip 24h
.area 0Ah, 0
@@securityFail:
	mov		r4, #3
	b		@@cont
@@securityPass:
	mov		r4, #9
.endarea
@@cont:

.org 0828D2B9h
	; Security level at game start
	.db		1 << SecurityLevel_Lv0

.org SecurityUnlockEvents
.area SecurityUnlockEvent_Size, 0
	.db		1 << SecurityLevel_Lv1
	.db		Area_TRO
	.db		12h
	.db		13h
	.db		23h
	.db		SecurityLevel_Lv1 - 1
.endarea
.area SecurityUnlockEvent_Size, 0
	.db		1 << SecurityLevel_Lv2
	.db		Area_PYR
	.db		22h
	.db		23h
	.db		37h
	.db		SecurityLevel_Lv2 - 1
.endarea
.area SecurityUnlockEvent_Size, 0
	.db		1 << SecurityLevel_Lv4
	.db		Area_AQA
	.db		52h
	.db		53h
	.db		7Dh
	.db		SecurityLevel_Lv4 - 1
.endarea
.area SecurityUnlockEvent_Size, 0
	.db		1 << SecurityLevel_Lv3
	.db		Area_ARC
	.db		36h
	.db		37h
	.db		4Bh
	.db		SecurityLevel_Lv3 - 1
.endarea
