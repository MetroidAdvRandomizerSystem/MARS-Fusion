; Changes event-based spriteset checks to check various progression flags
; instead of comparing against the linear event counter.

; NOTES:
; uninterruptable sequences:
;	operations deck escape (08-0A)
;	security robot in sector 3 (26-27)
;	past mega core-x eyedoor (32-33)

; operations deck elevator sabo (08):
;	S0-3C
;	S0-0D => S0-4A
; arachnus defeated (0A):
;	S0-3C, S0-46
; main deck elevator door destroyed (0D):
;	S0-29 => S0-2A, S0-4A => S0-0D
; all stabilizers reactivated (10):
;	S1-05, S1-07
; bombs downloaded (16):
;	S2-03 => S2-1E, S2-07 => S2-1F
; zazabi defeated (19):
;	S2-00, S2-04, S2-05, S2-09, S2-0A, S2-11, S2-13, S2-1F
;	S2-0D => S2-2E, S2-0E => S2-2C
; water level lowered (20):
;	S4-03, S4-05, S4-06, S4-14, S4-15, S4-21, S4-24
; en route to PYR 1 (21):
;	S4-05
; green doors unlocked (23):
;	S3-00, S3-03, S3-05, S3-06, S3-0A, S3-1B, S3-1E
; super missiles downloaded (26):
;	S3-06 => S3-18, S3-07 => S3-16
; security robot destroying data room (27):
;	S3-12 => S3-17
; escaped sector 6 SA-X (31):
;	S6-1C
; sector 6 data room destroyed (32):
;	S6-19
; defeated mega core-x (33):
;	S6-03, S6-04, S6-05, S6-06, S6-07, S6-08, S6-0A
;	S6-09 => S6-21
; downloaded ice missiles (3A):
;	S5-08, S5-18, S5-27
; boiler cooling reactivated (3D):
;	S3-05, S3-0A, S5-00
;	S3-11 => S3-1D
; save the animals (3E):
;	S0-0C, S0-12, S0-18
; downloaded power bombs (42):
;	S5-08, S5-09, S5-18
;	S5-15 => S5-16, S5-27 => S5-28
; escaped sector 5 SA-X (44):
;	S5-2B
; en route to gunship (45):
;	S0-22 => S0-2B
; main reactor shutdown (46):
;	S0-15
;	S0-2B => S0-22
; en route to main reactor (47):
;	S0-06, S0-30, S2-00, S2-04, S2-05, S2-09, S2-0A, S2-11,
;	S2-13, S2-1E, S2-1F, S2-2C, S2-2E
; auxiliary power active (4B):
;	S0-31
; escaped main reactor SA-X (4D):
;	S2-3B
; nettori defeated (4E):
;	S2-1B, S2-1C
;	S0-31 => S0-3B, S2-20 => S2-23, S2-39 => S2-3A
; sector 5 flooded (4F):
;	S5-03 => S5-06, S5-05 => S5-10, S5-07 => S5-0F, S5-0D => S5-2C
; nightmare defeated (51):
;	S4-24, S4-26
; no entry without authorization (59):
;	S6-10
; restricted sector invaded by sa-x (5C):
;	S0-4E => S0-4F
; restricted sector detached (5F):
;	S0-4D => S0-11
; ridley defeated (60):
;	S1-04, S1-0C, S1-0F, S1-14
; permission for orbit change granted (63):
;	S0-0C, S0-0D, S0-0E, S0-15
;	S2-2E => S2-55
; escape sequence (67):
;	S0-06, S0-07, S0-26, S0-2E
;	S0-03 => S0-04, S0-30 => S0-53

.org 080648DAh
.area 26h, 0
	mov		r5, r1
	cmp		r0, #0
	beq		@@check_spriteset_1
	bl		CheckEvent
	cmp		r0, #0
	beq		@@check_spriteset_1
	mov		r0, #2
	b		@@set_spriteset
@@check_spriteset_1:
	add		r0, sp, #20h
	ldrb	r0, [r0, LevelMeta_Spriteset1Event - 20h]
	cmp		r0, #0
	beq		@@set_spriteset_0
	bl		CheckEvent
	cmp		r0, #0
	beq		@@set_spriteset_0
	mov		r0, #1
	b		@@set_spriteset
.endarea
	.skip	0Ch
.area 38h, 0
@@set_spriteset_0:
	mov		r0, #0
@@set_spriteset:
	strb	r0, [r4]
	lsl		r0, #3
	add		r1, sp, #20h
	add		r1, r0
	ldrb	r0, [r1, LevelMeta_Spriteset0Id - 20h]
	ldr		r2, =SpritesetId
	strb	r0, [r2]
	ldr		r0, [r1, LevelMeta_Spriteset0 - 20h]
	str		r0, [r5, #08h]
	b		08064944h
	.pool
.endarea

.autoregion
	.align 2
.func CheckEvent
	cmp		r0, #6Dh
	bhi		@@case_default
	mov		r1, r0
	ldr		r3, =@@eventCases
	mov		r2, 1 << log2(27)
	ldrb	r0, [r3, 27 - (1 << log2(27))]
	cmp		r0, r1
	bhi		@@bsearch_loop
	add		r3, 27 - (1 << log2(27))
@@bsearch_loop:
	ldrb	r0, [r3, r2]
	cmp		r0, r1
	bhi		@@bsearch_iter
	add		r3, r2
@@bsearch_iter:
	lsr		r2, #1
	bne		@@bsearch_loop
	ldrb	r0, [r3]
	cmp		r0, r1
	bne		@@case_default
	add		r3, @@eventBranchTable - @@eventCases
	ldrb	r0, [r3]
	lsl		r0, #1
	ldr		r3, =MiscProgress
	ldr		r2, =SamusUpgrades
	b		@@branch
@@case_default:
	mov		r0, #0
	bx		lr
	.pool
	.align 4
@@eventCases:
	.db		08h, 0Ah, 0Dh, 10h, 16h, 19h, 20h, 21h
	.db		23h, 31h, 32h, 33h, 3Ah, 3Dh, 3Eh, 42h
	.db		44h, 46h, 47h, 4Bh, 4Dh, 4Eh, 51h, 59h
	.db		60h, 63h, 67h
@@eventBranchTable:
	.db		(@@case_08 - @@branch - 4) >> 1
	.db		(@@case_0A - @@branch - 4) >> 1
	.db		(@@case_0D - @@branch - 4) >> 1
	.db		(@@case_10 - @@branch - 4) >> 1
	.db		(@@case_16 - @@branch - 4) >> 1
	.db		(@@case_19 - @@branch - 4) >> 1
	.db		(@@case_20 - @@branch - 4) >> 1
	.db		(@@case_21 - @@branch - 4) >> 1
	.db		(@@case_23 - @@branch - 4) >> 1
	.db		(@@case_31 - @@branch - 4) >> 1
	.db		(@@case_32 - @@branch - 4) >> 1
	.db		(@@case_33 - @@branch - 4) >> 1
	.db		(@@case_3A - @@branch - 4) >> 1
	.db		(@@case_3D - @@branch - 4) >> 1
	.db		(@@case_3E - @@branch - 4) >> 1
	.db		(@@case_42 - @@branch - 4) >> 1
	.db		(@@case_44 - @@branch - 4) >> 1
	.db		(@@case_46 - @@branch - 4) >> 1
	.db		(@@case_47 - @@branch - 4) >> 1
	.db		(@@case_4B - @@branch - 4) >> 1
	.db		(@@case_4D - @@branch - 4) >> 1
	.db		(@@case_4E - @@branch - 4) >> 1
	.db		(@@case_51 - @@branch - 4) >> 1
	.db		(@@case_59 - @@branch - 4) >> 1
	.db		(@@case_60 - @@branch - 4) >> 1
	.db		(@@case_63 - @@branch - 4) >> 1
	.db		(@@case_67 - @@branch - 4) >> 1
	.align 2
@@branch:
	add		pc, r0
	nop
@@case_08:
	; operations deck elevator sabotaged
.if !RANDOMIZER
	ldrb	r0, [r3, MiscProgress_DataRooms]
	lsr		r0, Area_MainDeck
	ldr		r1, [r3, MiscProgress_MajorLocations]
	lsr		r1, MajorLocation_Arachnus
	bic		r0, r1
	mov		r1, #1
	and		r0, r1
.else
	mov		r0, #0
.endif
	bx		lr
@@case_0A:
	; arachnus defeated
	ldr		r0, [r3, MiscProgress_MajorLocations]
	lsl		r0, 1Fh - MajorLocation_Arachnus
	lsr		r0, 1Fh
	bx		lr
@@case_0D:
	; TODO: main deck elevator door destroyed by SA-X
.if RANDOMIZER
	mov		r0, #1
.endif
	bx		lr
@@case_10:
	; all atmospheric stabilizers reactivated
	ldrb	r0, [r3, MiscProgress_AtmoStabilizers]
	mov		r1, 11111b - 1
	sub		r0, r1, r0
	lsr		r0, #1Fh
	bx		lr
@@case_16:
	; downloaded bombs
.if !RANDOMIZER
	ldrb	r0, [r2, SamusUpgrades_ExplosiveUpgrades]
	lsl		r0, 1Fh - ExplosiveUpgrade_Bombs
	lsr		r0, 1Fh
.else
	; TODO: fixme
.endif
	bx		lr
@@case_19:
	; zazabi defeated, zoros in cocoons
	ldr		r0, [r3, MiscProgress_MajorLocations]
	lsl		r0, 1Fh - MajorLocation_Zazabi
	lsr		r0, 1Fh
	bx		lr
@@case_20:
	; sector 4 water level lowered
	ldrh	r0, [r3, MiscProgress_StoryFlags]
	lsl		r0, 1Fh - StoryFlag_WaterLowered
	lsr		r0, 1Fh
	bx		lr
@@case_21:
	; TODO: sector 4 complete, gold crab locks inactive
.if RANDOMIZER
	mov		r0, #1
.endif
	bx		lr
@@case_23:
	; green doors unlocked, sector 3 awakened
	ldrb	r0, [r2, SamusUpgrades_SecurityLevel]
	lsl		r0, 1Fh - SecurityLevel_Lv2
	lsr		r0, 1Fh
	bx		lr
@@case_31:
	; TODO: escaped sector 6 SA-X
.if RANDOMIZER
	mov		r0, #1
.endif
	bx		lr
@@case_32:
	; sector 6 data room destroyed
	ldr		r0, [r3, MiscProgress_StoryFlags]
	lsl		r0, 1Fh - StoryFlag_NocDataDestroyed
	ldrh	r1, [r3, MiscProgress_MajorLocations]
	lsl		r1, 1Fh - MajorLocation_MegaCoreX
	orr		r0, r1
	lsr		r0, 1Fh
	bx		lr
@@case_33:
	; defeated mega core-x
	ldr		r0, [r3, MiscProgress_MajorLocations]
	lsl		r0, 1Fh - MajorLocation_MegaCoreX
	lsr		r0, 1Fh
	bx		lr
@@case_3A:
	; downloaded ice missiles
	; 	S5-08, S5-18, S5-27
.if RANDOMIZER
	; maybe split S5-18 and S5-27
.endif
	bx		lr
@@case_3D:
	; boiler cooling reactivated
	; 	S3-05, S3-0A, S5-00
@@case_3E:
	; save the animals
	; 	S0-0C, S0-12, S0-18
.if RANDOMIZER
	; decide when to place PB barriers in main deck
.endif
	bx		lr
@@case_42:
	; downloaded power bombs
	ldrb	r0, [r2, SamusUpgrades_ExplosiveUpgrades]
	lsl		r0, 1Fh - ExplosiveUpgrade_PowerBombs
	lsr		r0, 1Fh
	bx		lr
@@case_44:
	; escaped sector 5 SA-X
	; 	S5-2B
.if RANDOMIZER
	mov		r0, #1
.endif
	bx		lr
@@case_46:
	; main reactor shutdown
	; 	S0-15
.if RANDOMIZER
	mov		r0, #0
.endif
	bx		lr
@@case_47:
	; en route to main reactor
	; 	S0-06, S0-30, S2-00, S2-04, S2-05, S2-09, S2-0A, S2-11,
	;	S2-13, S2-1E, S2-1F, S2-2C, S2-2E
@@case_4B:
	; auxiliary power active
	; 	S0-31
@@case_4D:
	; escaped main reactor SA-X
	; 	S2-3B
.if RANDOMIZER
	mov		r0, #1
.endif
	bx		lr
@@case_4E:
	; nettori defeated
	ldr		r0, [r3, MiscProgress_MajorLocations]
	lsl		r0, 1Fh - MajorLocation_Nettori
	lsr		r0, 1Fh
	bx		lr
@@case_51:
	; nightmare defeated
	; 	S4-24, S4-26
@@case_59:
	; no entry without authorization
	; 	S6-10
.if RANDOMIZER
	ldr		r0, [r3, MiscProgress_MajorLocations]
	mvn		r0, r0
	lsl		r0, 1Fh - MajorLocation_XBox
	lsr		r0, 1Fh
.endif
	bx		lr
@@case_60:
	; ridley defeated
	; 	S1-04, S1-0C, S1-0F, S1-14
.if !RANDOMIZER
	bx		lr
.endif
@@case_63:
	; permission for orbit change granted
	; 	S0-0C, S0-0D, S0-0E, S0-15
.if RANDOMIZER
	; check for go-mode
.endif
	bx		lr
@@case_67:
	; escape sequence
	; 	S0-06, S0-07, S0-26, S0-2E
.endfunc
.endautoregion
