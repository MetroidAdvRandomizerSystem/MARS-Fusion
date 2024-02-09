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
	.stringn "orbit to collide with [COLOR=2]SR388[/COLOR].[OBJECTIVE]"
	.stringn "Start by searching the\n"
	.string  "[COLOR=2]Quarantine Bay[/COLOR]."
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

; Disable nav briefing
.org 08575A6Ch
	.fill 6, 0FFh
	.fill 6

; Disable minimap target
.org 085766E4h
	.fill 8
