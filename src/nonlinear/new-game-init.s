; Rewrite save metadata init to account for starting items and location.

.autoregion
	.align 2
.func @InitSaveMeta
	ldr		r1, =StartingItems
	ldrh	r0, [r1, SamusUpgrades_CurrEnergy]
	strh	r0, [r2, SaveMeta_CurrEnergy]
	ldrh	r0, [r1, SamusUpgrades_MaxEnergy]
	strh	r0, [r2, SaveMeta_MaxEnergy]
	ldrh	r0, [r1, SamusUpgrades_CurrMissiles]
	strh	r0, [r2, SaveMeta_CurrMissiles]
	ldrh	r0, [r1, SamusUpgrades_MaxMissiles]
	strh	r0, [r2, SaveMeta_MaxMissiles]
	ldrb	r0, [r1, SamusUpgrades_SuitUpgrades]
	strb	r0, [r2, SaveMeta_SuitUpgrades]
.if RANDOMIZER
	ldr		r1, =StartingLocation
	ldrb	r0, [r1, StartingLocation_Area]
	strb	r0, [r2, SaveMeta_Area]
.endif
	strb	r3, [r2, SaveMeta_Event]
	strb	r3, [r2, SaveMeta_IgtHours]
	strb	r3, [r2, SaveMeta_IgtMinutes]
	bx		lr
	.pool
.endfunc
.endautoregion

.org 08080926h
.area 14h
	bl		@InitSaveMeta
	b		0808093Ah
.endarea
