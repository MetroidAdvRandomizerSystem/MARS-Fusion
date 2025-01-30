; Changes: 
; - Always spawn Hornoad.
; - Change Hornoad Palette to RoS themed
; - Hornoad always drops Red X


; Always spawn hornoad. This is the location of the CheckOnEvent_NavBeforeQuarantineBay function
; which spawns the hornoad if the vanilla event counter == 1. Because events have changed, we can
; override this function to always spawn the hornoad.
.org 08060DB2h
.area 0Fh, 0
    mov r0, #1
    pop r1
    bx  r1
.endarea

; Change QuarantineBayHornoad Palette
.org SpritePalettePtrs + QuarantineBayHornoad_Id * 4
    .dw 085A1E58h ; Unused Palette from Opening, RoS Themed Hornoad

; Adjust Red X Probability
.org SpriteStats + QuarantineBayHornoad_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    .dh 0000h
    .dh 0000h
    .dh 0400h

; Adjust Hornoad Sprite Data Properties in Quarantine Bay to use X Probability table
.org 0847F0D3h
    .skip 3 ; Hornoad is second sprite in Quarantine Bay
    .skip 2 ; Leave X/Y Position the same
    .db 021h