; Always show extra info (sector completion, in-game time) on map screen.
; Normally requires a save file which has previously completed the game.

.org 08077F60h
	mov		r0, #1
