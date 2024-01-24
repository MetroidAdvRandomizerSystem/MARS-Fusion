; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Enables the in-game debug menu, accessed via the Samus status screen.

.org 08076A2Eh
	mov		r0, r9
	strb	r0, [r4, #2]

.org 0856F71Ch
.incbin "data/debug-map.gfx"
