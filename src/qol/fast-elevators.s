; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Doubles the speed of elevators.

.org 08009BFCh
	; Elevator up speed
	mov		r0, #8

.org 08009C0Ch
	; Elevator down speed
	.dh		-8
