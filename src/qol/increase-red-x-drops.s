; Increases the probability of Red X drops to a minimum of 1/256. Any enemy that is already more likely to drop a Red X will not be affected.
; The probability calculations are out of 1024 (0x0400). For X Drops this must add up precisely - so take from Yellow X chance 

.org SpriteStats + Hornoad_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Halzyn_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D3/12C/1
    .db 0D0h
    .db 02h

    .db 02Ch
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Moto_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D3/12C/1
    .db 0D0h 
    .db 02h

    .db 02Ch 
    .db 01h

    .db 04h 
    .db 00h

.org SpriteStats + Yameba_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h
    
.org SpriteStats + Zeela_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Zombie_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 20B/1F4/1
    .db 008h
    .db 02h

    .db 0F4h
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Geemer_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 3F4/A/2
    .db 0F2h
    .db 03h

    .db 0Ah
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Waver_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 305/FA/1
    .db 02h
    .db 03h

    .db 0FAh
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Sciser_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Sidehopper_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 20B/1F4/1
    .db 008h
    .db 02h

    .db 0F4h
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Dessgeega_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 322/DC/2
    .db 020h
    .db 03h

    .db 0DCh
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Zoro_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 305/FA/1
    .db 02h
    .db 03h

    .db 0FAh
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + KihunterFlying_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + KihunterGround_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Reo_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 369/96/1
    .db 066h 
    .db 03h

    .db 096h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Namihe_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D1/12C/3
    .db 0D0h 
    .db 02h

    .db 02Ch
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Fune_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D1/12C/3
    .db 0D0h 
    .db 02h

    .db 02Ch
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Geruda_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + SkulteraSmallNotLarge_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Sova_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 39B/64/1
    .db 098h 
    .db 03h

    .db 064h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Yard_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 26E/190/2
    .db 06Ch 
    .db 02h

    .db 090h
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Evir_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 209/1F4/3
    .db 008h 
    .db 02h

    .db 0F4h
    .db 01h

    .db 04h
    .db 00h

.org SpriteStats + Bull_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Memu_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 39B/64/1
    .db 098h 
    .db 03h

    .db 064h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Choot_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + GoldSciser_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 175/28A/1
    .db 072h 
    .db 01h

    .db 08Ah
    .db 02h

    .db 04h
    .db 00h

.org SpriteStats + Owtch_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 369/96/1
    .db 066h 
    .db 03h

    .db 096h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Puyo_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 39B/64/1
    .db 098h 
    .db 03h

    .db 064h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + SkulteraSmall_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .db 034h 
    .db 03h

    .db 0C8h
    .db 00h

    .db 04h
    .db 00h

.org SpriteStats + Zozoro_Stats * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D3/12C/1
    .db 0D0h
    .db 02h

    .db 02Ch
    .db 01h

    .db 04h
    .db 00h