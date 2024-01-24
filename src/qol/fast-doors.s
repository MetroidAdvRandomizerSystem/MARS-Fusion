; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Increases the speed of door transitions.
; Each door transition takes approximately 2/3 of its original time.

.org 0806E848h
.area 3Ch, 0
	; Halve time to fade for other hatches
	ldr		r6, =03001220h
	add		r5, r6, #2
	ldrh	r2, [r5]
	mov		r3, r2
	bne		@@else
	ldrh	r1, [r6]
	cmp		r1, #16
	bhs		0806E898h
	strh	r3, [r5]
	b		@@incrementCounter
	.pool
@@else:
	sub		r0, r2, #2
	asr		r2, r0, #1Fh
	bic		r0, r2
	strh	r0, [r5]
@@incrementCounter:
	ldrb	r1, [r6]
	add		r0, r1, #2
	sub		r1, 16 + 2
	asr		r1, #1Fh
	and		r0, r1
	strh	r0, [r6]
	b		0806E884h
.endarea

.org 0806EBA4h
.area 26h, 0
	; Align vertical screen position of hatch
	; 2x faster
	ldr		r0, =03004E0Ch
	ldr		r3, =030000C8h
	ldrh	r1, [r0, #02h]
	ldrh	r2, [r3, #12h]
	sub		r0, r1, r2
	beq		0806EBCAh
	add		r0, #2
	asr		r1, r0, #1Fh
	bic		r0, r1
	sub		r0, #4
	asr		r1, r0, #1Fh
	and		r0, r1
	add		r0, #2
	add		r0, r2
	strh	r0, [r3, #12h]
	b		0806ECF2h
.endarea
.org 0806EBF8h
	.pool

.org 0806EBE6h
	; Align horizontal position of hatch
	; 1.5x faster
	add		r0, #9
.org 0806EC04h
	sub		r0, #9
