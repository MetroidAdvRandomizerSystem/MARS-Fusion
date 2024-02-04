; Modifies various enemies to use less space in the MiscProgress structure.

; atmospheric stabilizer checks
.org 0802C772h
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_AtmoStabilizers]
	.skip 12h
	.pool

.org 0802C896h
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_AtmoStabilizers]
	.skip 32h
	.pool

.org 0802D0B8h
	ldr		r0, =MiscProgress
	ldrb	r2, [r0, MiscProgress_AtmoStabilizers]
	.skip 44h
	.pool

.org 0802D37Ah
	ldr		r2, =MiscProgress
	ldrb	r0, [r2, MiscProgress_AtmoStabilizers]
	orr		r1, r0
	strb	r1, [r2, MiscProgress_AtmoStabilizers]
	.skip 1Ah
	.pool

; missile core x barrier checks
.org 08029D7Ah
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_NormalXBarriers]
	.skip 16h
	.pool

.org 08029EB0h
	ldr		r2, =MiscProgress
	ldrb	r0, [r2, MiscProgress_NormalXBarriers]
	orr		r1, r0
	strb	r1, [r2, MiscProgress_NormalXBarriers]
	.skip 10h
	.pool

; super missile core x barrier checks
.org 08041EB2h
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_SuperXBarriers]
	.skip 16h
	.pool

.org 08041FE8h
	ldr		r2, =MiscProgress
	ldrb	r0, [r2, MiscProgress_SuperXBarriers]
	orr		r1, r0
	strb	r1, [r2, MiscProgress_SuperXBarriers]
	.skip 10h
	.pool

; power bomb core x barrier checks
.org 0804221Eh
	ldr		r0, =MiscProgress
	ldrb	r0, [r0, MiscProgress_PowerXBarriers]
	.skip 16h
	.pool

.org 08042374h
	ldr		r2, =MiscProgress
	ldrb	r0, [r2, MiscProgress_PowerXBarriers]
	orr		r1, r0
	strb	r1, [r2, MiscProgress_PowerXBarriers]
	.skip 10h
	.pool

; eyedoor checks
.org 08042E8Ch
	ldr		r2, =MiscProgress
	ldrh	r0, [r2, MiscProgress_Eyedoors]
	orr		r1, r0
	strh	r1, [r2, MiscProgress_Eyedoors]
	.skip 1Ch
	.pool

.org 08042EFAh
	ldr		r0, =MiscProgress
	ldrh	r0, [r0, MiscProgress_Eyedoors]
	.skip 12h
	.pool
