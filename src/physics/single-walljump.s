; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Allows Samus to turn around during a walljump while gaining height

.org 08007952h
	nop :: nop :: nop :: nop

; .org 08007960h
;	add		r0, (1 << Button_Up) | (1 << Button_Down)
;	and		r0, r3
