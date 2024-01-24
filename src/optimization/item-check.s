; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Optimizes the size of item collection info in memory.
; The arrays of room IDs and item positions are replaced with a bit array,
; with room IDs and item positions stored in ROM instead.
; This patch saves a significant amount of memory, freeing up large chunks in
; both external WRAM and SRAM.

.autoregion
; Gets the index of the passed collectible item in the currently loaded room.
; This index will be a number from 0 to 99 if found, else it will be -1.
.func GetItemIndex
	; r0 = x pos, r1 = y pos
	push	{ r4, lr }
	lsl		r4, r1, #8h
	orr		r4, r0
	ldr		r1, =CurrArea
	ldrb	r0, [r1]
	ldrb	r1, [r1, CurrRoom - CurrArea]
	ldr		r2, =@ItemsByArea
	lsl		r0, #2
	ldr		r2, [r2, r0]
	; binary search for room id
	; r1 = target, r2 = curr ptr
	ldrb	r0, [r2, #8]
	cmp		r0, r1
	bge		@@bsearch_1
	add		r2, #7
@@bsearch_1:
	ldrb	r0, [r2, #4]
	cmp		r0, r1
	bge		@@bsearch_2
	add		r2, #4
@@bsearch_2:
	ldrb	r0, [r2, #2]
	cmp		r0, r1
	bge		@@bsearch_3
	add		r2, #2
@@bsearch_3:
	ldrb	r0, [r2, #1]
	cmp		r0, r1
	bge		@@bsearch_4
	add		r2, #1
@@bsearch_4:
	ldrb	r0, [r2, #1]
	cmp		r0, r1
	bne		@@fail
	add		r2, #17
	ldrb	r1, [r2]
	ldrb	r2, [r2, #1]
	ldr		r3, =@ItemPositions
	; r1 = offset, r2 = end offset, r3 = array, r4 = position
@@lsearch:
	ldrh	r0, [r3, r1]
	cmp		r0, r4
	beq		@@success
	add		r1, #2
	cmp		r1, r2
	blt		@@lsearch
@@fail:
	mov		r0, #0
	mvn		r0, r0
	b		@@exit
	.pool
@@success:
	lsr		r0, r1, #1
@@exit:
	pop		{ r4, pc }
.endfunc
.endautoregion

.autoregion
.align 4
@ItemsByArea:
	.dw		@@Items_MainDeck
	.dw		@@Items_Sector1
	.dw		@@Items_Sector2
	.dw		@@Items_Sector3
	.dw		@@Items_Sector4
	.dw		@@Items_Sector5
	.dw		@@Items_Sector6
.endautoregion

; Sector items structure:
; - Number of rooms containing items (max 16)
; - Sorted array of rooms containing items
; - Array of pointers to each room's contiguous item position list

.autoregion
@@Items_MainDeck:
	.db		07h, 11h, 23h, 26h, 2Dh, 2Fh, 32h, 33h
	.db		39h, 45h, 48h, 49h, 54h
	.fill	16 - (. - @@Items_MainDeck), 0FFh
	.db		@Items_MainDeck_Room07 - @ItemPositions
	.db		@Items_MainDeck_Room11 - @ItemPositions
	.db		@Items_MainDeck_Room23 - @ItemPositions
	.db		@Items_MainDeck_Room26 - @ItemPositions
	.db		@Items_MainDeck_Room2D - @ItemPositions
	.db		@Items_MainDeck_Room2F - @ItemPositions
	.db		@Items_MainDeck_Room32 - @ItemPositions
	.db		@Items_MainDeck_Room33 - @ItemPositions
	.db		@Items_MainDeck_Room39 - @ItemPositions
	.db		@Items_MainDeck_Room45 - @ItemPositions
	.db		@Items_MainDeck_Room48 - @ItemPositions
	.db		@Items_MainDeck_Room49 - @ItemPositions
	.db		@Items_MainDeck_Room54 - @ItemPositions
	.db		@Items_Sector1_Room05 - @ItemPositions
.endautoregion

.autoregion
@@Items_Sector1:
	.db		05h, 11h, 1Eh, 27h, 28h, 2Bh, 2Ch, 2Fh
	.db		32h, 34h
	.fill	16 - (. - @@Items_Sector1), 0FFh
	.db		@Items_Sector1_Room05 - @ItemPositions
	.db		@Items_Sector1_Room11 - @ItemPositions
	.db		@Items_Sector1_Room1E - @ItemPositions
	.db		@Items_Sector1_Room27 - @ItemPositions
	.db		@Items_Sector1_Room28 - @ItemPositions
	.db		@Items_Sector1_Room2B - @ItemPositions
	.db		@Items_Sector1_Room2C - @ItemPositions
	.db		@Items_Sector1_Room2F - @ItemPositions
	.db		@Items_Sector1_Room32 - @ItemPositions
	.db		@Items_Sector1_Room34 - @ItemPositions
	.db		@Items_Sector2_Room06 - @ItemPositions
.endautoregion

.autoregion
@@Items_Sector2:
	.db		14
	.db		06h, 09h, 0Ah, 11h, 15h, 19h, 1Bh, 1Fh
	.db		21h, 2Ah, 2Fh, 32h, 36h, 37h
	.fill	16 - (. - @@Items_Sector2), 0FFh
	.db		@Items_Sector2_Room06 - @ItemPositions
	.db		@Items_Sector2_Room09 - @ItemPositions
	.db		@Items_Sector2_Room0A - @ItemPositions
	.db		@Items_Sector2_Room11 - @ItemPositions
	.db		@Items_Sector2_Room15 - @ItemPositions
	.db		@Items_Sector2_Room19 - @ItemPositions
	.db		@Items_Sector2_Room1B - @ItemPositions
	.db		@Items_Sector2_Room1F - @ItemPositions
	.db		@Items_Sector2_Room21 - @ItemPositions
	.db		@Items_Sector2_Room2A - @ItemPositions
	.db		@Items_Sector2_Room2F - @ItemPositions
	.db		@Items_Sector2_Room32 - @ItemPositions
	.db		@Items_Sector2_Room36 - @ItemPositions
	.db		@Items_Sector2_Room37 - @ItemPositions
	.db		@Items_Sector3_Room03 - @ItemPositions
.endautoregion

.autoregion
@@Items_Sector3:
	.db		12
	.db		03h, 06h, 08h, 09h, 0Ch, 13h, 1Ch, 1Eh
	.db		21h, 22h, 23h, 25h
	.fill	16 - (. - @@Items_Sector3), 0FFh
	.db		@Items_Sector3_Room03 - @ItemPositions
	.db		@Items_Sector3_Room06 - @ItemPositions
	.db		@Items_Sector3_Room08 - @ItemPositions
	.db		@Items_Sector3_Room09 - @ItemPositions
	.db		@Items_Sector3_Room0C - @ItemPositions
	.db		@Items_Sector3_Room13 - @ItemPositions
	.db		@Items_Sector3_Room1C - @ItemPositions
	.db		@Items_Sector3_Room1E - @ItemPositions
	.db		@Items_Sector3_Room21 - @ItemPositions
	.db		@Items_Sector3_Room22 - @ItemPositions
	.db		@Items_Sector3_Room23 - @ItemPositions
	.db		@Items_Sector3_Room25 - @ItemPositions
	.db		@Items_Sector4_Room06 - @ItemPositions
.endautoregion

.autoregion
@@Items_Sector4:
	.db		13
	.db		06h, 0Ah, 0Dh, 0Fh, 11h, 17h, 18h, 1Ch
	.db		21h, 24h, 26h, 29h, 2Eh
	.fill	16 - (. - @@Items_Sector4), 0FFh
	.db		@Items_Sector4_Room06 - @ItemPositions
	.db		@Items_Sector4_Room0A - @ItemPositions
	.db		@Items_Sector4_Room0D - @ItemPositions
	.db		@Items_Sector4_Room0F - @ItemPositions
	.db		@Items_Sector4_Room11 - @ItemPositions
	.db		@Items_Sector4_Room17 - @ItemPositions
	.db		@Items_Sector4_Room18 - @ItemPositions
	.db		@Items_Sector4_Room1C - @ItemPositions
	.db		@Items_Sector4_Room21 - @ItemPositions
	.db		@Items_Sector4_Room24 - @ItemPositions
	.db		@Items_Sector4_Room26 - @ItemPositions
	.db		@Items_Sector4_Room29 - @ItemPositions
	.db		@Items_Sector4_Room2E - @ItemPositions
	.db		@Items_Sector5_Room04 - @ItemPositions
.endautoregion

.autoregion
@@Items_Sector5:
	.db		14
	.db		04h, 0Ch, 0Eh, 12h, 16h, 17h, 1Ah, 1Eh
	.db		21h, 22h, 24h, 2Fh, 32h, 33h
	.fill	16 - (. - @@Items_Sector5), 0FFh
	.db		@Items_Sector5_Room04 - @ItemPositions
	.db		@Items_Sector5_Room0C - @ItemPositions
	.db		@Items_Sector5_Room0E - @ItemPositions
	.db		@Items_Sector5_Room12 - @ItemPositions
	.db		@Items_Sector5_Room16 - @ItemPositions
	.db		@Items_Sector5_Room17 - @ItemPositions
	.db		@Items_Sector5_Room1A - @ItemPositions
	.db		@Items_Sector5_Room1E - @ItemPositions
	.db		@Items_Sector5_Room21 - @ItemPositions
	.db		@Items_Sector5_Room22 - @ItemPositions
	.db		@Items_Sector5_Room24 - @ItemPositions
	.db		@Items_Sector5_Room2F - @ItemPositions
	.db		@Items_Sector5_Room32 - @ItemPositions
	.db		@Items_Sector5_Room33 - @ItemPositions
	.db		@Items_Sector6_Room00 - @ItemPositions
.endautoregion

.autoregion
@@Items_Sector6:
	.db		9
	.db		00h, 0Fh, 12h, 18h, 1Ah, 1Eh, 22h, 26h
	.db		27h
	.fill	16 - (. - @@Items_Sector6), 0FFh
	.db		@Items_Sector6_Room00 - @ItemPositions
	.db		@Items_Sector6_Room0F - @ItemPositions
	.db		@Items_Sector6_Room12 - @ItemPositions
	.db		@Items_Sector6_Room18 - @ItemPositions
	.db		@Items_Sector6_Room1A - @ItemPositions
	.db		@Items_Sector6_Room1E - @ItemPositions
	.db		@Items_Sector6_Room22 - @ItemPositions
	.db		@Items_Sector6_Room26 - @ItemPositions
	.db		@Items_Sector6_Room27 - @ItemPositions
	.db		@ItemPositions_End
.endautoregion

.autoregion
.align 2
@ItemPositions:
@Items_MainDeck_Room07:
	.db		0Dh, 0Eh
@Items_MainDeck_Room11:
	.db		09h, 14h
@Items_MainDeck_Room23:
	.db		0Eh, 41h
@Items_MainDeck_Room26:
	.db		35h, 0Ah
@Items_MainDeck_Room2D:
	.db		04h, 04h
@Items_MainDeck_Room2F:
	.db		04h, 03h
@Items_MainDeck_Room32:
	.db		36h, 08h
@Items_MainDeck_Room33:
	.db		05h, 1Dh
@Items_MainDeck_Room39:
	.db		0Ch, 0Ah
@Items_MainDeck_Room45:
	.db		1Dh, 1Dh
@Items_MainDeck_Room48:
	.db		0Dh, 09h
@Items_MainDeck_Room49:
	.db		06h, 0Ah
@Items_MainDeck_Room54:
	.db		0Eh, 0Ah
@Items_Sector1_Room05:
	.db		1Bh, 0Ah
@Items_Sector1_Room11:
	.db		08h, 06h
	.db		19h, 08h
	.db		2Ch, 13h
@Items_Sector1_Room1E:
	.db		0Fh, 08h
@Items_Sector1_Room27:
	.db		04h, 05h
@Items_Sector1_Room28:
	.db		0Ch, 08h
@Items_Sector1_Room2B:
	.db		0Dh, 0Bh
@Items_Sector1_Room2C:
	.db		04h, 08h
@Items_Sector1_Room2F:
	.db		0Ah, 02h
@Items_Sector1_Room32:
	.db		06h, 08h
@Items_Sector1_Room34:
	.db		0Dh, 07h
@Items_Sector2_Room06:
	.db		1Dh, 08h
@Items_Sector2_Room09:
	.db		0Dh, 04h
@Items_Sector2_Room0A:
	.db		13h, 23h
@Items_Sector2_Room11:
	.db		2Ch, 07h
@Items_Sector2_Room15:
	.db		1Dh, 04h
@Items_Sector2_Room19:
	.db		04h, 08h
@Items_Sector2_Room1B:
	.db		1Ch, 07h
@Items_Sector2_Room1F:
	.db		28h, 07h
@Items_Sector2_Room21:
	.db		15h, 08h
@Items_Sector2_Room2A:
	.db		05h, 08h
@Items_Sector2_Room2F:
	.db		1Dh, 10h
@Items_Sector2_Room32:
	.db		03h, 07h
	.db		03h, 18h
@Items_Sector2_Room36:
	.db		04h, 05h
	.db		09h, 0Eh
@Items_Sector2_Room37:
	.db		07h, 04h
	.db		0Ah, 1Ah
@Items_Sector3_Room03:
	.db		3Ch, 0Dh
@Items_Sector3_Room06:
	.db		05h, 11h
@Items_Sector3_Room08:
	.db		09h, 09h
	.db		16h, 0Dh
@Items_Sector3_Room09:
	.db		2Ah, 08h
@Items_Sector3_Room0C:
	.db		0Ch, 19h
@Items_Sector3_Room13:
	.db		13h, 0Dh
	.db		2Bh, 0Ah
@Items_Sector3_Room1C:
	.db		0Ch, 07h
	.db		24h, 1Bh
@Items_Sector3_Room1E:
	.db		04h, 0Dh
@Items_Sector3_Room21:
	.db		0Fh, 0Ah
@Items_Sector3_Room22:
	.db		0Ah, 0Fh
@Items_Sector3_Room23:
	.db		04h, 1Bh
	.db		0Fh, 56h
@Items_Sector3_Room25:
	.db		0Fh, 03h
@Items_Sector4_Room06:
	.db		16h, 1Dh
@Items_Sector4_Room0A:
	.db		0Ch, 1Dh
@Items_Sector4_Room0D:
	.db		18h, 09h
	.db		26h, 0Fh
@Items_Sector4_Room0F:
	.db		2Ch, 05h
@Items_Sector4_Room11:
	.db		17h, 14h
@Items_Sector4_Room17:
	.db		39h, 13h
@Items_Sector4_Room18:
	.db		28h, 07h
@Items_Sector4_Room1C:
	.db		09h, 06h
@Items_Sector4_Room21:
	.db		0Ah, 0Dh
@Items_Sector4_Room24:
	.db		03h, 07h
@Items_Sector4_Room26:
	.db		16h, 0Ah
	.db		2Ah, 05h
@Items_Sector4_Room29:
	.db		0Fh, 04h
@Items_Sector4_Room2E:
	.db		04h, 0Ah
@Items_Sector5_Room04:
	.db		05h, 05h
	.db		14h, 08h
@Items_Sector5_Room0C:
	.db		03h, 0Ah
@Items_Sector5_Room0E:
	.db		0Dh, 03h
@Items_Sector5_Room12:
	.db		03h, 03h
@Items_Sector5_Room16:
	.db		03h, 30h
@Items_Sector5_Room17:
	.db		0Eh, 06h
@Items_Sector5_Room1A:
	.db		04h, 06h
@Items_Sector5_Room1E:
	.db		17h, 07h
@Items_Sector5_Room21:
	.db		0Eh, 03h
@Items_Sector5_Room22:
	.db		0Eh, 08h
@Items_Sector5_Room24:
	.db		08h, 08h
@Items_Sector5_Room2F:
	.db		04h, 0Ah
@Items_Sector5_Room32:
	.db		0Dh, 08h
@Items_Sector5_Room33:
	.db		0Bh, 03h
@Items_Sector6_Room00:
	.db		29h, 12h
@Items_Sector6_Room0F:
	.db		03h, 03h
@Items_Sector6_Room12:
	.db		0Fh, 03h
	.db		1Dh, 14h
@Items_Sector6_Room18:
	.db		1Dh, 09h
@Items_Sector6_Room1A:
	.db		05h, 06h
@Items_Sector6_Room1E:
	.db		09h, 0Dh
	.db		13h, 08h
@Items_Sector6_Room22:
	.db		0Eh, 08h
@Items_Sector6_Room26:
	.db		2Dh, 06h
@Items_Sector6_Room27:
	.db		21h, 0Ah
@ItemPositions_End:
.endautoregion