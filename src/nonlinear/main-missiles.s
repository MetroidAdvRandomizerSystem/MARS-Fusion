; Patches behavior that assumes having any form of missiles allows the player
; to use missiles.

.org 080123EAh
	mov		r0, #1 << ExplosiveUpgrade_Missiles

.org 08012458h
	mov		r0, #1 << ExplosiveUpgrade_Missiles

.org 080124AEh
	mov		r0, #1 << ExplosiveUpgrade_Missiles

.org 080124D6h
	mov		r0, #1 << ExplosiveUpgrade_Missiles

.org 0802C2A8h
	mov		r0, #1 << ExplosiveUpgrade_Missiles

.org 08071AAEh
	mov		r0, #1 << ExplosiveUpgrade_Missiles
