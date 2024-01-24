; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Always show extra info (sector completion, in-game time) on map screen.
; Normally requires a save file which has previously completed the game.

.org 08077F60h
	mov		r0, #1
