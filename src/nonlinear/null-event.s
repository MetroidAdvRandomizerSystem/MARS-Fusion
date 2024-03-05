; Reworks event 0 as a dummy event indicating no particular event is active.

; TODO: add events for go mode and after defeating sa-x

.org 086CE8B0h
.region 0BEA0h
@DefaultDialogue:
	.dh		0B003h
	.stringn "The [COLOR=3]SA-X[/COLOR] has discovered and\n"
	.stringn "destroyed a top secret[NEXT]"
	.stringn "[COLOR=3]Metroid[/COLOR] breeding facility.[NEXT]"
	.stringn "It released several infant\n"
	.stringn "Metroids into the station.[NEXT]"
	.stringn "Find and capture them, and use\n"
	.stringn "them to lure out the SA-X.[NEXT]"
	.stringn "Then initiate the station's\n"
	.stringn "self-destruct sequence.[NEXT]"
	.stringn "Uplink at [COLOR=2]Navigation Rooms[/COLOR]\n"
	.stringn "along the way.[NEXT]"
	.stringn "I can scan the station for\n"
	.stringn "useful equipment from there.[OBJECTIVE]"
	.string  "Good. Move out."
@DefaultConfirmDialogue:
	.string  "Get going."
@DefaultObjective:
	.string  "Find the infant Metroids."
.endregion

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
