; Patches behavior that assumes having any form of missiles allows the player
; to use missiles.

.org 080060FCh
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif

.org 080123EAh
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif

.org 08012458h
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif

.org 080124AEh
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif

.org 080124D6h
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif

.org 0802C2A8h
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif

.org 08071AAEh
.if MISSILES_WITHOUT_MAINS
    mov     r0, #(1 << ExplosiveUpgrade_Missiles) \
        | (1 << ExplosiveUpgrade_SuperMissiles) \
        | (1 << ExplosiveUpgrade_IceMissiles) \
        | (1 << ExplosiveUpgrade_DiffusionMissiles)
.else
    mov     r0, #1 << ExplosiveUpgrade_Missiles
.endif
