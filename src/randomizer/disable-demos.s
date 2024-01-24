; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Disables title screen demos to prevent any item location spoilers.

.org 08087428h
.area 14h, 0
	b		08087460h
.endarea
