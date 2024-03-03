; Reworks event 0 as a dummy event indicating no particular event is active.

.org 086CE8B0h
.area 402h
@DefaultDialogue:
	.dh		0B003h
	.stringn "Locate and acquire [COLOR=3]Missiles[/COLOR],\n"
	.stringn "[COLOR=3]Charge Beam[/COLOR], and [COLOR=3]Plasma Beam[/COLOR],[NEXT]"
	.stringn "and release [COLOR=1]Level 4 security\n"
	.stringn "locks[/COLOR].[NEXT]"
	.stringn "Then go to the [COLOR=2]Operations\n"
	.stringn "Room[/COLOR] and modify the station's[NEXT]"
	.stringn "orbit to collide with [COLOR=2]SR388[/COLOR].[NEXT]"
	.stringn "Uplink at [COLOR=2]Navigation Rooms[/COLOR]\n"
	.stringn "along the way.[NEXT]"
	.stringn "I can scan the station for\n"
	.stringn "useful equipment from there.[OBJECTIVE]"
	.string  "Good. Move out."
@DefaultConfirmDialogue:
	.string  "Get going."
@DefaultObjective:
	.stringn "Find Charge Beam, Plasma Beam,\n"
	.string  "Missiles, and Level 4 security."
.endarea

.org 0879D50Ch
	.dw		@DefaultDialogue
	.dw		@DefaultConfirmDialogue

.org 0879D6D4h
	.dw		@DefaultObjective

; Disable locks
.org 083C88F8h
	.skip 1
	.fill 3

; Dummy out nav room event increment
.org 08074EACh
.area 4Ah
	push	{ r4-r5, lr }
	mov		r5, #0
	b		08074EF6h
.endarea

; Disable minimap target
.org 085766E4h
	.fill 8
