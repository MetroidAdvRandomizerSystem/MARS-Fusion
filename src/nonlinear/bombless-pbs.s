; Allow power bombs to be used without the base bombs upgrade

.org 08005EBEh
.area 1Ah
	ldrb	r1, [r0, SamusUpgrades_ExplosiveUpgrades]
	lsr		r0, r1, ExplosiveUpgrade_Bombs + 1
	bcs		08005EE0h
	lsr		r0, r1, ExplosiveUpgrade_PowerBombs + 1
	bcc		08005EE0h
	ldrb	r0, [r2, SamusState_SecondaryWeaponSelect]
	lsr		r0, #5
	bcc		08005EE0h
	b		08005ED4h
.endarea
