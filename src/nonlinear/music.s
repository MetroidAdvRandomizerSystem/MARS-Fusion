; Overrides vanilla music behavior. Guts functionality for most sub-event
; specific songs.

.org 08070180h
.region 142Ch, 0
.func UpdateSubEvent
	push	{ r4-r6, lr }
	mov		r4, r0
	ldr		r1, =CurrArea
	ldrb	r5, [r1]
	cmp		r5, Area_NOC
	bls		@@checkTrigger
	pop		{ r4-r6, pc }
@@checkTrigger:
	sub		r0, #21h
	cmp		r0, #1
	bhi		@@areaSwitchDone
	ldr		r1, =DestinationRoom
	ldrb	r6, [r1]
	ldr		r2, =MiscProgress
	add		r1, =@@areaBranchTable
	ldrb	r0, [r1, r5]
	lsl		r0, #1
@@branch:
	add		pc, r0
	.align 4
@@areaBranchTable:
	.db		(@@case_MainDeck - @@branch - 4) >> 1
	.db		(@@case_SRX - @@branch - 4) >> 1
	.db		(@@case_TRO - @@branch - 4) >> 1
	.db		(@@case_PYR - @@branch - 4) >> 1
	.db		(@@case_AQA - @@branch - 4) >> 1
	.db		(@@case_ARC - @@branch - 4) >> 1
	.db		(@@case_NOC - @@branch - 4) >> 1
	.align 2
@@case_MainDeck:
	; leaving arachus fight room
	cmp		r6, #0Eh
	bne		@@case_MainDeck_check26
	ldr		r1, =030019F1h
	ldrb	r0, [r1]
	cmp		r0, MusicType_BossAmbience
	bne		@@areaSwitchDone
	mov		r0, #1Eh
	mov		r1, MusicType_Transient
	mov		r2, #60
	b		@@tryPlay
@@case_MainDeck_check26:
	; arachnus fight room
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Arachnus + 1
	bcs		@@areaSwitchDone
	cmp		r6, #26h
	bne		@@case_MainDeck_check56
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_MainDeck_check56:
	; yakuza fight room
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Yakuza + 1
	bcs		@@areaSwitchDone
	cmp		r6, #56h
	bne		@@areaSwitchDone
	mov		r0, #18h
	mov		r1, MusicType_Transient
	mov		r2, #50
	b		@@tryLock
@@case_SRX:
	; charge core-x fight room
	cmp		r6, #28h
	bne		@@case_SRX_check28
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_ChargeCoreX + 1
	bcs		@@areaSwitchDone
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_SRX_check28:
	; ridley fight room
	cmp		r6, #1Bh
	bne		@@areaSwitchDone
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Ridley + 1
	bcs		@@areaSwitchDone
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_TRO:
	; zazabi fight room
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Zazabi + 1
	bcs		@@areaSwitchDone
	cmp		r6, #12h
	bne		@@case_TRO_check16
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_TRO_check16:
	; nettori fight room
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Nettori + 1
	bcs		@@areaSwitchDone
	cmp		r6, #16h
	bne		@@areaSwitchDone
	mov		r0, #44h
	mov		r1, MusicType_BossMusic
	mov		r2, #50
	b		@@tryLock
@@case_PYR:
	b		@@areaSwitchDone
@@case_AQA:
	; leaving serris tank to main sector
	cmp		r6, #1Eh
	bne		@@case_AQA_check1F
	ldr		r1, =030019F1h
	ldrb	r0, [r1]
	cmp		r0, MusicType_AQA1
	bne		@@areaSwitchDone
	mov		r0, #09h
	mov		r1, MusicType_Transient
	mov		r2, #60
	b		@@tryPlay
@@case_AQA_check1F:
	; serris tank
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Serris + 1
	bcs		@@areaSwitchDone
	cmp		r6, #1Fh
	bne		@@case_AQA_check2A
	mov		r0, #5Fh
	mov		r1, MusicType_AQA1
	mov		r2, #60
	b		@@tryPlay
@@case_AQA_check2A:
	; serris fight room
	cmp		r6, #2Ah
	bne		@@areaSwitchDone
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #40
	b		@@tryLock
@@case_ARC:
	; nightmare fight room
	ldrb	r0, [r2, MiscProgress_Bosses]
	lsr		r0, Boss_Nightmare + 1
	bcs		@@areaSwitchDone
	cmp		r6, #14h
	bne		@@areaSwitchDone
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #50
	b		@@tryLock
@@case_NOC:
@@areaSwitchDone:
	ldr		r1, =CurrSubEvent
	ldrh	r0, [r1]
@@subeventSwitch:
	cmp		r0, #00h	; Adam intro started
	beq		@@case_00
	cmp		r0, #01h	; Adam intro finished
	beq		@@case_01
	cmp		r0, #9Ah	; Escape sequence started
	beq		@@case_00
	cmp		r0, #9Bh	; Escape sequence
	beq		@@case_9B
	b		@@return
@@case_00:
	; Increment sub-event and return
	strb	r0, [r1, PrevSubEvent - CurrSubEvent]
	add		r0, #1
	strb	r0, [r1]
	b		@@return
@@case_01:
	; start main deck music
	cmp		r4, #3
	bne		@@return
	mov		r0, #1Eh
	mov		r1, MusicType_Transient
	b		@@playMusic
@@case_9B:
	; escape sequence omega encounter
	cmp		r5, Area_MainDeck
	bne		@@return
	cmp		r6, #3Fh
	bne		@@return
	mov		r0, #58h
	mov		r1, MusicType_BossMusic
	mov		r2, #0
	b		@@tryPlay
@@tryLock:
	cmp		r4, #22h
	bne		@@fadeOut
	push	{ r0-r2 }
	mov		r0, #3Fh
	bl		LockHatches
	pop		{ r0-r2 }
@@tryPlay:
	cmp		r4, #21h
	beq		@@fadeOut
	cmp		r4, #22h
	beq		@@playMusic
	b		@@return
@@fadeOut:
	mov		r0, r2
	bl		Music_FadeOut
	b		@@return
@@playMusic:
	bl		Music_Play
@@return:
	pop		{ r4-r6, pc }
	.pool
.endfunc
.endarea
