; Copyright (c) 2022 Callie "AntyMew" LeFave and contributors
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; Common functions for use in other non-linearity patches.

.autoregion
.func ObtainAbility
	push	{ lr }
	cmp		r0, EventUpgradeInfo_Len
	bhs		@@return
	ldr		r2, =EventUpgradeInfo
	lsl		r0, #3
	add		r2, r0
	ldrb	r0, [r2, EventUpgradeInfo_Message]
	ldr		r1, =LastAbility
	strb	r0, [r1]
	ldr		r3, =SamusUpgrades
	ldrb	r0, [r2, EventUpgradeInfo_BeamUpgrades]
	ldrb	r1, [r3, SamusUpgrades_BeamUpgrades]
	orr		r0, r1
	strb	r0, [r3, SamusUpgrades_BeamUpgrades]
	ldrb	r0, [r2, EventUpgradeInfo_ExplosiveUpgrades]
	ldrb	r1, [r3, SamusUpgrades_ExplosiveUpgrades]
	orr		r0, r1
	strb	r0, [r3, SamusUpgrades_ExplosiveUpgrades]
	ldrb	r0, [r2, EventUpgradeInfo_SuitUpgrades]
	ldrb	r1, [r3, SamusUpgrades_SuitUpgrades]
	orr		r0, r1
	strb	r0, [r3, SamusUpgrades_SuitUpgrades]
@@return:
	pop		{ pc }
	.pool
.endfunc
.endautoregion

.org 080798F8h
.area 48h, 0
	; get message index
	ldr		r7, =MessagesByLanguage
	ldr		r6, =Language
	ldr		r1, =LastAbility
	ldrb	r2, [r1]
	b		08079952h
	.pool
.endarea
