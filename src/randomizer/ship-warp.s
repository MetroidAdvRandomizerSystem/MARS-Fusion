; Allows warp to ship from the sleep mode menu.

.org 086B5A18h
.area 60h, 0
	.stringn 64, "[INDENT]Warp to ship?\n"
	.string  10, "[INDENT]You will return to your ship,"
.endarea
.area 72h, 0
	.stringn 19, "[INDENT]but your recent progress\n"
	.string  51, "[INDENT]will not be saved."
.endarea

.org 0856F71Ch
.incbin "data/warp-map.gfx"

.autoregion
	.align 4
.func ReloadAtShip
	push	{ r4-r5, lr }
	ldr		r1, =SaveData
	ldr		r0, =SaveSlot
	ldrb	r0, [r0]
	lsl		r0, #2
	ldr		r1, [r1, r0]
	mov		r0, Area_MainDeck
	strb	r0, [r1, SaveData_Area]
	mov		r0, #0
	strb	r0, [r1, SaveData_Room]
	strb	r0, [r1, SaveData_PreviousDoor]
	add		r1, #SaveData_BG0XPosition
	mov		r0, #1088 >> 4
	lsl		r0, #4
	strh	r0, [r1, SaveData_BG0XPosition - SaveData_BG0XPosition]
	strh	r0, [r1, SaveData_BG1XPosition - SaveData_BG0XPosition]
	strh	r0, [r1, SaveData_BG2XPosition - SaveData_BG0XPosition]
	strh	r0, [r1, SaveData_BG3XPosition - SaveData_BG0XPosition]
	mov		r0, #128
	strh	r0, [r1, SaveData_BG0YPosition - SaveData_BG0XPosition]
	strh	r0, [r1, SaveData_BG1YPosition - SaveData_BG0XPosition]
	strh	r0, [r1, SaveData_BG2YPosition - SaveData_BG0XPosition]
	strh	r0, [r1, SaveData_BG3YPosition - SaveData_BG0XPosition]
	add		r1, #SaveData_SamusState - SaveData_BG0XPosition
	mov		r0, #1600 >> 4
	lsl		r0, #4
	strh	r0, [r1, SamusState_PositionX]
	ldr		r0, =#703
	strh	r0, [r1, SamusState_PositionY]
	add		r1, #SaveData_MusicSlot1 - SaveData_SamusState
	mov		r0, #1Eh
	strh	r0, [r1]
	mov		r0, #2Ah
	strh	r0, [r1, SaveData_MusicSlot2 - SaveData_MusicSlot1]
	mov		r0, #0
	strb	r0, [r1, SaveData_MusicSlotSelect - SaveData_MusicSlot1]
	strb	r0, [r1, SaveData_MusicUnk1 - SaveData_MusicSlot1]
	strh	r0, [r1, SaveData_MusicUnk2 - SaveData_MusicSlot1]
	bl		08080968h
	ldr		r1, =GameMode
	cmp		r0, #0
	beq		@@intro
	mov		r0, #GameMode_InGame
	strh	r0, [r1]
	ldr		r1, =NonGameplayFlag
	mov		r0, #0
	strb	r0, [r1]
	b		@@reinit_audio
@@intro:
	mov		r0, #GameMode_FileSelect
	strh	r0, [r1]
	ldr		r1, =SubGameMode2
	mov		r0, #1
	strb	r0, [r1]
@@reinit_audio:
	ldr		r5, =04000082h
	ldrh	r4, [r5]
	bl		InitializeAudio
	strh	r4, [r5]
@@exit:
	pop		{ r4-r5, pc }
	.pool
.endfunc
.endautoregion

.org 0807EE04h
	mov		r0, #0
	strb	r0, [r3, #6]
	nop :: nop

.org 0807EE12h
.area 6Eh
	ldr		r4, =03001488h
	ldrb	r3, [r4, #2]
	cmp		r3, #1
	bgt		@@fade
	ldr		r2, =030016ECh
	ldrh	r0, [r2]
	ldr		r1, =0FEFFh
	and		r0, r1
	strh	r0, [r2]
	mov		r0, #1
	mov		r1, #0
	bl		0807486Ch
	b		0807EE82h
@@fade:
	cmp		r3, #8
	bge		@@reload
	lsr		r3, #1
	bcc		0807EE82h
	ldr		r1, =0300121Eh
	ldrh	r0, [r1]
	add		r0, #1
	strh	r0, [r1]
	b		0807EE82h
@@reload:
	bl		ReloadAtShip
	b		0807EE82h
	.pool
.endarea
