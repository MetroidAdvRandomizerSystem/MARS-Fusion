; Patches the post-credits cutscene completion percentage.
; Extends the vanilla behavior of counting all 100 minor items by adding
; major items and security level unlocks to the calculation.

.org 080A1FB6h
	; select clear time "score" (0-2)
	; score = max(0, 2 - floor(hours / 2))
.area 1Ah, 0
	ldrb	r0, [r2, GameTimer_Hours]
	lsr		r0, #1
	mov		r1, #2
	sub		r0, r1, r0
	asr		r1, r0, #1Fh	; \ minimum of 0
	bic		r0, r1			; /
	add		r7, #99h
	strb	r0, [r7]
	; calc etank completion
	ldr		r5, =SamusUpgrades
	ldrh	r0, [r5, SamusUpgrades_MaxEnergy]
	sub		r0, #99		; starting energy (99 in vanilla)
	mov		r1, #100	; energy per tank (100 in vanilla)
	b		@@p2
.endarea
	.skip 9Ch
.area 58h, 0
@@p2:
	bl		Divide
	asr		r1, r0, #1Fh	; \ minimum of 0
	bic		r0, r1			; /
	mov		r4, r0
	; calculate missile tank completion
	ldrh	r0, [r5, SamusUpgrades_MaxMissiles]
	sub		r0, #10		; starting missiles (10 in vanilla)
	mov		r1, #5		; missiles per tank (5 in vanilla)
	bl		Divide
	asr		r1, r0, #1Fh	; \ minimum of 0
	bic		r0, r1			; /
	add		r4, r0
	; calculate power bomb tank completion
	ldrb	r0, [r5, SamusUpgrades_MaxPowerBombs]
	sub		r0, #10		; starting pbs (10 in vanilla)
	mov		r1, #2		; pbs per tank (2 in vanilla)
	bl		Divide
	asr		r1, r0, #1Fh	; \ minimum of 0
	bic		r0, r1			; /
	add		r0, r4
	; calculate major upgrade completion
	; counts sum of bits via Kernighan's algorithm
	ldrh	r1, [r5, SamusUpgrades_BeamUpgrades]
	lsl		r1, #10h
.if NONLINEAR
	ldrh	r2, [r5, SamusUpgrades_SuitUpgrades]
.else
	ldrb	r2, [r5, SamusUpgrades_SuitUpgrades]
.endif
	orr		r1, r2
	beq		@@end
@@loop:
	add		r0, #1
	sub		r2, r1, #1
	and		r1, r2
	bne		@@loop
@@end:
.if !NONLINEAR
	ldrb	r1, [r5, SamusUpgrades_SecurityLevel]
	add		r1, #1
	add		r0, r1
.endif
	; subtract omega suit and grey doors
	sub		r0, #2
	; calculate completion percentage rounded down to nearest integer
	; total items = 118 in vanilla, 116 in MFOR, +4 for security levels
	mov		r2, #100
	mul		r0, r2
	mov		r1, RANDOMIZER ? 120 : 122
	bl		Divide
	sub		r0, #100		; \
	asr		r1, r0, #1Fh	; | maximum of 100
	and		r0, r1			; |
	add		r0, #100		; /
	strb	r0, [r7, #1h]
.endarea

.org 080A20E0h
.area 4, 0
	.pool
.endarea
