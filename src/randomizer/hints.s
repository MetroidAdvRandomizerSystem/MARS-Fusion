; Repurposes nav room briefings for hints.

.org 0807A2E8h
.area 32h
	; Use current nav room to index nav briefing array
	ldr		r0, =CurrentNavRoom
	ldrb	r2, [r0]
	lsl		r0, r2, #2
	lsl		r1, r2, #3
	add		r0, r1
	add		r0, r3, r0
	ldrb	r1, [r0, NavBriefing_Dialogue]
	cmp		r2, #1
	b		0807A31Ah
	.pool
.endarea

.org 0807A6D2h
	; Don't set previous conversation flag for hints
	cmp		r0, #1
	bgt		0807A6E6h

; Placeholder hint
.org 086CECB2h
.area 8Ch
	.stringn "No traces of your equipment\n"
	.string  "from this Navigation Room."
.endarea

.org 0879D514h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h
	.dw		086CECB2h, 086CECB2h

; Disable minimap targets by default
.org HintTargets
	.fill 8 * 11

.org 08575A6Ch
	; Repurpose nav briefing array as a nav room lookup
	.db		Area_MainDeck, 11h
	.db		00h, 00h, 00h, 00h
	.db		02h
	.db		01h
	.db		00h
	.skip 3
	.db		Area_MainDeck, 0Ah
	.db		00h, 00h, 00h, 00h
	.db		03h
	.db		02h
	.db		00h
	.skip 3
	.db		Area_MainDeck, 21h
	.db		00h, 00h, 00h, 00h
	.db		04h
	.db		03h
	.db		00h
	.skip 3
	.db		Area_SRX, 03h
	.db		00h, 00h, 00h, 00h
	.db		05h
	.db		04h
	.db		00h
	.skip 3
	.db		Area_ARC, 03h
	.db		00h, 00h, 00h, 00h
	.db		06h
	.db		05h
	.db		00h
	.skip 3
	.db		Area_TRO, 03h
	.db		00h, 00h, 00h, 00h
	.db		07h
	.db		06h
	.db		00h
	.skip 3
	.db		Area_AQA, 03h
	.db		00h, 00h, 00h, 00h
	.db		08h
	.db		07h
	.db		00h
	.skip 3
	.db		Area_PYR, 03h
	.db		00h, 00h, 00h, 00h
	.db		09h
	.db		08h
	.db		00h
	.skip 3
	.db		Area_NOC, 03h
	.db		00h, 00h, 00h, 00h
	.db		0Ah
	.db		09h
	.db		00h
	.skip 3
	.db		Area_MainDeck, 39h
	.db		00h, 00h, 00h, 00h
	.db		0Bh
	.db		0Ah
	.db		00h
	.skip 3
	.db		Area_MainDeck, 43h
	.db		00h, 00h, 00h, 00h
	.db		0Ch
	.db		0Bh
	.db		00h
	.skip 3
