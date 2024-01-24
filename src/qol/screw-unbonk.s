; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Prevents Samus from bonking her head against breakable blocks by
; spin jumping into them from directly below.

.org 082C4934h
	; Reduce spinjump startup by 1 frame
	.db		1
