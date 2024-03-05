; Overrides vanilla music behavior. Guts functionality for most sub-event
; specific songs.

.autoregion
	.align 2
.func Music_VariableFade
	push	{ lr }
	mov		r0, #10
	ldr		r1, =03004E58h
	ldrb	r1, [r1]
	cmp		r1, #4
	bne		@@call_fade
	mov		r0, #30
@@call_fade:
	bl		Music_FadeOut
	pop		{ pc }
	.pool
.endfunc
.endautoregion

.org Music_CheckSet + 2Ah
; Check currently playing slot for the desired track
.area 16h, 0
	mov		r0, MusicInfo_SlotSelect
	ldrb	r0, [r5, r0]
	lsl		r0, #1
	add		r0, MusicInfo_Slot1Track
	ldrh	r0, [r5, r0]
	cmp		r0, r4
	beq		080034DAh
	bl		Music_VariableFade
	strh	r6, [r5, MusicInfo_SlotSelect]
.endarea

.org 080715ACh
.area 44h
; Reorder function such that default music is set after calling UpdateSubEvent
.func SetRoomMusic
	push	{ r4-r5, lr }
	ldr		r2, =GameMode
	ldrh	r2, [r2]
	cmp		r2, #GameMode_Demo
	beq		@@return
	lsl		r4, r0, #18h
	lsr		r4, #18h - 2
	lsl		r5, r1, #18h
	lsr		r5, #18h
	ldr		r2, =DestinationRoom
	strb	r5, [r2]
	mov		r0, #21h
	bl		UpdateSubEvent
	cmp		r0, #1
	beq		@@return
	ldr		r1, =0879B8BCh
	ldr		r1, [r1, r4]
	lsl		r0, r5, #4
	sub		r0, r5
	lsl		r0, #2
	add		r1, r0
	ldrh	r0, [r1, #3Ah]
	bl		Music_CheckSet
@@return:
	pop		{ r4-r5, pc }
	.pool
.endfunc
.endarea

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
	bls		@@areaSwitch
	bl		@@areaSwitchDone
@@areaSwitch:
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
.if ((@@case_NOC - @@branch - 4) >> 1) >= (1 << 8)
	.error "Branch table overflowed"
.endif
	.align 2
@@case_MainDeck:
	; operations deck
	cmp		r6, #0Dh
	bne		@@case_MainDeck_check26
	ldrh	r0, [r2, MiscProgress_StoryFlags]
	lsr		r0, #StoryFlag_SaxDefeated + 1
	bcs		@@case_MainDeck_break
	mov		r0, #08h
	bl		LockHatches
	b		@@case_MainDeck_default
@@case_MainDeck_check26:
	; arachnus fight room
	cmp		r6, #26h
	bne		@@case_MainDeck_check36
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Arachnus + 1
	bcs		@@case_MainDeck_default
	ldr		r1, =MusicInfo + MusicInfo_Type
	ldrb	r0, [r1]
	cmp		r0, MusicType_BossAmbience
	beq		@@case_MainDeck_lockWithoutMusic
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_MainDeck_check36:
	cmp		r6, #36h
	bne		@@case_MainDeck_check4D
	ldrh	r0, [r2, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_AuxiliaryPower + 1
	bcs		@@case_MainDeck_default
	mov		r0, #0Fh
	mov		r1, #MusicType_Transient
	mov		r2, #10
	b		@@tryPlay
@@case_MainDeck_check4D:
.if !RANDOMIZER
	; restricted sector tube
	cmp		r6, #4Dh
	bne		@@case_MainDeck_check4F
	ldr		r1, =CurrEvent
	ldrb	r0, [r1]
	cmp		r0, #5Dh
	blt		@@case_MainDeck_break
	mov		r0, #0
	strb	r0, [r1]
	b		@@case_MainDeck_break
@@case_MainDeck_check4F:
	; restricted sector last room
	cmp		r6, #4Eh
	bne		@@case_MainDeck_check52
	ldr		r1, =CurrEvent
	mov		r0, #5Bh
	strb	r0, [r1]
	b		@@case_MainDeck_break
.endif
@@case_MainDeck_check52:
	; operations room
	cmp		r6, #52h
	bne		@@case_MainDeck_check54
	ldr		r1, =CurrEvent
	ldrb	r0, [r1]
	cmp		r0, #65h
	bgt		@@case_MainDeck_break
	b		@@case_MainDeck_default
@@case_MainDeck_check54:
	; arachus fight side room
	cmp		r6, #54h
	bne		@@case_MainDeck_check56
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Arachnus + 1
	bcs		@@case_MainDeck_default
	b		@@case_MainDeck_break
@@case_MainDeck_check56:
	; yakuza fight room
	cmp		r6, #56h
	bne		@@case_MainDeck_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Yakuza + 1
	bcs		@@case_MainDeck_default
	mov		r0, #18h
	mov		r1, MusicType_Transient
	mov		r2, #50
	b		@@tryLock
@@case_MainDeck_default:
	b		@@case_areaSwitch_default
@@case_MainDeck_break:
	b		@@areaSwitchDone
@@case_MainDeck_lockWithoutMusic:
	mov		r0, #3Fh
	bl		LockHatches
	b		@@areaSwitchDone
@@case_SRX:
	; charge core-x fight room
	cmp		r6, #28h
	bne		@@case_SRX_check28
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_ChargeCoreX + 1
	bcs		@@case_MainDeck_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_SRX_check28:
	; ridley fight room
	cmp		r6, #1Bh
	bne		@@case_MainDeck_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Ridley + 1
	bcs		@@case_MainDeck_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_TRO:
	; zazabi fight room
	cmp		r6, #12h
	bne		@@case_TRO_check14
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Zazabi + 1
	bcs		@@case_MainDeck_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_TRO_check14:
	; nettori backdoor
	cmp		r6, #14h
	bne		@@case_TRO_check16
	cmp		r4, #22h
	bne		@@case_MainDeck_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Nettori + 1
	bcs		@@case_MainDeck_default
	mov		r0, #02h
	bl		LockHatches
	b		@@case_areaSwitch_default
@@case_TRO_check16:
	; nettori fight room
	cmp		r6, #16h
	bne		@@case_areaSwitch_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Nettori + 1
	bcs		@@case_areaSwitch_default
	mov		r0, #44h
	mov		r1, MusicType_BossMusic
	mov		r2, #50
	b		@@tryLock
@@case_PYR:
	; box fight room
	cmp		r6, #17h
	bne		@@case_PYR_check19
	ldrh	r0, [r2, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_BoxDefeated + 1
	bcs		@@case_areaSwitch_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_XBox + 1
	bcs		@@case_areaSwitch_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_PYR_check19:
	cmp		r6, #19h
	bne		@@case_areaSwitch_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_WideCoreX + 1
	bcs		@@case_areaSwitch_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_AQA:
	cmp		r6, #0Ah
	bne		@@case_AQA_check1F
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Serris + 1
	bcs		@@case_areaSwitch_default
	b		@@areaSwitchDone
@@case_AQA_check1F:
	; serris tank
	cmp		r6, #1Fh
	bne		@@case_AQA_check2A
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Serris + 1
	bcs		@@case_areaSwitch_default
	ldr		r1, =MusicInfo + MusicInfo_Type
	ldrb	r0, [r1]
	cmp		r0, MusicType_AQA1
	beq		@@areaSwitchDone
	mov		r0, #5Fh
	mov		r1, MusicType_AQA1
	mov		r2, #60
	b		@@tryPlay
@@case_AQA_check2A:
	; serris fight room
	cmp		r6, #2Ah
	bne		@@case_areaSwitch_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Serris + 1
	bcs		@@case_areaSwitch_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #40
	b		@@tryLock
@@case_ARC:
	; nightmare fight room
	cmp		r6, #14h
	bne		@@case_areaSwitch_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_Nightmare + 1
	bcs		@@case_areaSwitch_default
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #50
	b		@@tryLock
@@case_NOC:
	; mega core-x eyedoor room
	cmp		r6, #0Ch
	bne		@@case_NOC_check0D
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_MegaCoreX + 1
	bcs		@@case_areaSwitch_default
	ldr		r1, =MusicInfo + MusicInfo_Type
	ldrb	r0, [r1]
	cmp		r0, MusicType_BossAmbience
	beq		@@areaSwitchDone
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryPlay
@@case_NOC_check0D:
	; mega core-x fight room
	cmp		r6, #0Dh
	bne		@@case_NOC_check10
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_MegaCoreX + 1
	bcs		@@case_areaSwitch_default
	ldr		r1, =MusicInfo + MusicInfo_Type
	ldrb	r0, [r1]
	cmp		r0, MusicType_BossAmbience
	bne		@@startMegaCoreAmbience
	cmp		r4, #22h
	beq		@@lockWithoutMusic
	b		@@areaSwitchDone
@@startMegaCoreAmbience:
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	mov		r2, #60
	b		@@tryLock
@@case_NOC_check10:
	; xbox fight room
	cmp		r6, #10h
	bne		@@case_NOC_check19
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_XBox + 1
	bcs		@@case_areaSwitch_default
	mov		r0, #1Bh
	mov		r1, MusicType_BossMusic
	mov		r2, #20
	b		@@tryLock
@@case_NOC_check19:
	; NOC data room
	cmp		r6, #19h
	bne		@@case_areaSwitch_default
	ldr		r0, [r2, MiscProgress_MajorLocations]
	lsr		r0, MajorLocation_MegaCoreX + 1
	bcs		@@case_areaSwitch_default
	ldrh	r0, [r2, MiscProgress_StoryFlags]
	lsr		r0, StoryFlag_NocDataDestroyed + 1
	bcs		@@areaSwitchDone
	cmp		r4, #22h
	bne		@@areaSwitchDone
@@lockWithoutMusic:
	mov		r0, #3Fh
	bl		LockHatches
	b		@@areaSwitchDone
@@case_areaSwitch_default:
	ldr		r1, =MusicInfo + MusicInfo_Type
	ldr		r2, =GameMode
	ldrh	r2, [r2]
	cmp		r2, #GameMode_Demo
	beq		@@areaSwitchDone
	mov		r0, MusicType_Transient
	strb	r0, [r1]
@@areaSwitchDone:
	ldr		r1, =CurrSubEvent
	ldrh	r0, [r1]
@@subeventSwitch:
	cmp		r0, #00h	; Adam intro started
	beq		@@case_00
	cmp		r0, #01h	; Adam intro finished
	beq		@@case_01
	cmp		r0, #6Bh	; Auxiliary power active
	beq		@@case_6B
	cmp		r0, #9Ah	; Escape sequence started
	beq		@@case_9A
	cmp		r0, #9Bh	; Escape sequence
	beq		@@case_9B
	b		@@return_false
@@case_00:
	; start first briefing music and increment subevent
	ldrb	r2, [r1, PrevSubEvent - CurrSubEvent]
	cmp		r2, #0FFh
	bne		@@return_false
	strb	r0, [r1, PrevSubEvent - CurrSubEvent]
	add		r0, #1
	strb	r0, [r1]
	mov		r0, #2Ah
	mov		r1, MusicType_MainDeck
	b		@@playMusic
@@case_01:
	; start main deck music and increment subevent
	cmp		r4, #3
	bne		@@return_false
	strb	r0, [r1, PrevSubEvent - CurrSubEvent]
	add		r0, #1
	strb	r0, [r1]
	mov		r0, #1Eh
	mov		r1, MusicType_Transient
	b		@@playMusic
@@case_6B:
	cmp		r4, #0Bh
	bne		@@return_false
	mov		r0, #2Eh
	mov		r1, #MusicType_Misc
	b		@@playMusic
@@case_9A:
	strb	r0, [r1, PrevSubEvent - CurrSubEvent]
	add		r0, #1
	strb	r0, [r1]
	b		@@return_true
@@case_9B:
	; escape sequence omega encounter
	cmp		r5, Area_MainDeck
	bne		@@return_true
	cmp		r6, #3Fh
	bne		@@return_true
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
	b		@@return_false
@@fadeOut:
	mov		r0, r2
	bl		Music_FadeOut
	b		@@return_true
@@playMusic:
	bl		Music_Play
@@return_true:
	mov		r0, #1
	pop		{ r4-r6, pc }
@@return_false:
	mov		r0, #0
	pop		{ r4-r6, pc }
	.pool
.endfunc
.endregion

.org 0803A170h
; Wide Core-X boss music
.area 2Ch
	push	{ lr }
	ldr		r2, =CurrentEnemy
	ldrh	r0, [r2, Enemy_Status]
	ldr		r1, =#8020h
	orr		r0, r1
	strh	r0, [r2, Enemy_Status]
	mov		r0, #2Ch
	strh	r0, [r2, Enemy_XParasiteTimer]
	add		r2, #20h
	mov		r0, #46h
	strb	r0, [r2, Enemy_Pose - 20h]
	mov		r0, #0
	strb	r0, [r2, Enemy_SamusCollision - 20h]
	mov		r0, #43h
	mov		r1, MusicType_BossMusic
	bl		Music_Play
	pop		{ pc }
	.pool
.endarea

.org 0802DBC4h
; Wide Core-X defeated music
.area 5Ch
	push	{ lr }
	ldr		r2, =CurrentEnemy
	mov		r3, r2
	add		r3, #20h
	mov		r0, #5Dh
	strb	r0, [r3, Enemy_Pose - 20h]
	mov		r0, #0Ch
	strb	r0, [r3, Enemy_SamusCollision - 20h]
	mov		r1, #0
	strh	r1, [r2, Enemy_Health]
	ldr		r0, =0300007Ah
	ldrb	r0, [r0]
	lsl		r0, #20h - 2
	lsr		r0, #20h - 2
	strb	r0, [r3, Enemy_BgPriority - 20h]
	mov		r0, #4
	strb	r0, [r3, Enemy_DrawOrder - 20h]
	strb	r1, [r3, Enemy_Palette - 20h]
	strb	r1, [r3, Enemy_Timer0 - 20h]
	strb	r1, [r3, Enemy_Timer1 - 20h]
	mov		r0, #1
	strb	r0, [r3, Enemy_VelocityX - 20h]
	strb	r0, [r3, Enemy_VelocityY - 20h]
	strb	r0, [r3, Enemy_IgnoreSamusCollisionTimer - 20h]
	bl		08025270h
	ldr		r0, =CurrentEnemy
	ldrb	r0, [r0, Enemy_Id]
	cmp		r0, #57h
	bne		@@return
	mov		r0, #18h
	mov		r1, MusicType_BossAmbience
	bl		Music_Play
@@return:
	pop		{ pc }
	.pool
.endarea

; Remove subevent 0 music handling from dialogue handling
.org 08079ED4h
	nop :: nop :: nop :: nop

; change default music in certain rooms

.org 083C2C4Ch + 07h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck station entrance
.org 083C2C4Ch + 08h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck recharge room
.org 083C2C4Ch + 09h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck navigation room east
.org 083C2C4Ch + 0Ah * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck crew quarters east
.org 083C2C4Ch + 0Bh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck habitation save room
.org 083C2C4Ch + 0Ch * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck crew quarters west
.org 083C2C4Ch + 0Eh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck maintenance corridor
.org 083C2C4Ch + 0Fh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck habitation deck entrance
.org 083C2C4Ch + 10h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck navigation room west
.org 083C2C4Ch + 12h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck central hub
.org 083C2C4Ch + 14h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck western hub
.org 083C2C4Ch + 15h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck eastern hub
.org 083C2C4Ch + 16h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck habitation maintenance
.org 083C2C4Ch + 17h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck quarantine access
.org 083C2C4Ch + 21h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck save room
.org 083C2C4Ch + 23h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck maintenance shaft
.org 083C2C4Ch + 24h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck maintenance crossing
.org 083C2C4Ch + 25h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck crew quarters save room
.org 083C2C4Ch + 26h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck arachnus arena
.org 083C2C4Ch + 28h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck main elevator
.org 083C2C4Ch + 2Ah * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck main elevator access
.org 083C2C4Ch + 2Dh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck maintenance storage
.org 083C2C4Ch + 2Eh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck sub-zero containment
.org 083C2C4Ch + 2Fh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck spitter speedway
.org 083C2C4Ch + 39h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck habitation storage
.org 083C2C4Ch + 3Ch * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck elevator to crew quarters
.org 083C2C4Ch + 3Dh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck elevator to operations deck
.org 083C2C4Ch + 45h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck habitation deck
.org 083C2C4Ch + 46h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck hornoad hallway
.org 083C2C4Ch + 47h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck quarantine bay
.org 083C2C4Ch + 48h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck western hub cache
.org 083C2C4Ch + 4Bh * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck elevator to habitation deck
.org 083C2C4Ch + 4Ch * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck elevator to central hub
.org 083C2C4Ch + 54h * LevelMeta_Size + LevelMeta_Music
	.dh		2Ch		; main deck the attic

.org 083C2C4Ch + 0Dh * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck operations deck
.org 083C2C4Ch + 20h * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck operations deck navigation room
.org 083C2C4Ch + 27h * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck operations deck data room
.org 083C2C4Ch + 2Ch * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck operations deck save room
.org 083C2C4Ch + 36h * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck auxiliary power station
.org 083C2C4Ch + 51h * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck operations deck recharge room
.org 083C2C4Ch + 52h * LevelMeta_Size + LevelMeta_Music
	.dh		2Eh		; main deck operations room

.org 083C40B0h + 12h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian shaft east
.org 083C40B0h + 13h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian save room east
.org 083C40B0h + 15h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian central hub
.org 083C40B0h + 16h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 golden pirate crossing
.org 083C40B0h + 17h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian hub west
.org 083C40B0h + 18h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian save room west
.org 083C40B0h + 19h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 genesis habitation
.org 083C40B0h + 1Ah * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 ridley arena access
.org 083C40B0h + 1Bh * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 ridley arena
.org 083C40B0h + 1Ch * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian central checkpoint
.org 083C40B0h + 1Dh * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 ripper maze access
.org 083C40B0h + 1Eh * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 ripper maze
.org 083C40B0h + 24h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 tourian entrance
.org 083C40B0h + 33h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 animorphs
.org 083C40B0h + 34h * LevelMeta_Size + LevelMeta_Music
	.dh		35h		; sector 1 animorphs cache
