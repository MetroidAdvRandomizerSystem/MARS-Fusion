; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Prevents hatches from locking due to events or navigation rooms.

.org 08063230h
	mov		r0, #0
	bx		lr

.org 08063D40h
	mov		r0, #0
	bx		lr
