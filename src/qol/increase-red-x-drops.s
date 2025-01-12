; Increases the probability of Red X drops to a minimum of 1/256. Any enemy that is already more likely to drop a Red X will not be affected.
; The probability calculations are out of 1024 (0x0400). For X Drops this must add up precisely - so take from Yellow X chance
; In the ROM Data, the Weights/Probabilities are laid out as YellowXWeight/GreenXWeight/RedXWeight
; In the following comments, "originally 337/C8/1" would mean that the sprites original drop rates were:
; Yellow X: 337h (823/1024)
; Green  X:  C8h (200/1024)
; Red    X:   1h (  1/1024)
; When replacing the Weights, it needs to be set in that same order.

.org SpriteStats + Hornoad_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Halzyn_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D3/12C/1
    .dh 02D0h
    .dh 012Ch
    .dh 0004h

.org SpriteStats + Moto_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D3/12C/1
    .dh 02D0h
    .dh 012Ch
    .dh 0004h

.org SpriteStats + Yameba_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h
    
.org SpriteStats + Zeela_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Zombie_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 20B/1F4/1
    .dh 0208h
    .dh 01F4h
    .dh 0004h
    
.org SpriteStats + Geemer_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 3F4/A/2
    .dh 03F2h
    .dh 000Ah
    .dh 0004h

.org SpriteStats + Waver_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 305/FA/1
    .dh 0302h;
    .dh 00FAh;
    .dh 0004h;

.org SpriteStats + Sciser_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Sidehopper_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 20B/1F4/1
    .dh 0208h
    .dh 01F4h
    .dh 0004h

.org SpriteStats + Dessgeega_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 322/DC/2
    .dh 0320h
    .dh 00DCh
    .dh 0004h

.org SpriteStats + Zoro_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 305/FA/1
    .dh 0302h;
    .dh 00FAh;
    .dh 0004h;


.org SpriteStats + KihunterFlying_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + KihunterGround_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Reo_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 369/96/1
    .dh 0366h
    .dh 0096h
    .dh 0004h
    
.org SpriteStats + Namihe_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D1/12C/3
    .dh 02D0h
    .dh 012Ch
    .dh 0004h

.org SpriteStats + Fune_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D1/12C/3
    .dh 02D0h
    .dh 012Ch
    .dh 0004h


.org SpriteStats + Geruda_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + SkulteraSmallNotLarge_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Sova_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 39B/64/1
    .dh 0398h
    .dh 0064h
    .dh 0004h

.org SpriteStats + Yard_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 26E/190/2
    .dh 026Ch
    .dh 0190h
    .dh 0004h

.org SpriteStats + Evir_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 209/1F4/3
    .dh 0208h
    .dh 01F4h
    .dh 0004h;
    
.org SpriteStats + Bull_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Memu_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 39B/64/1
    .dh 0398h
    .dh 0064h
    .dh 0004h

.org SpriteStats + Choot_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + GoldSciser_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 175/28A/1
    .dh 0172h
    .dh 028Ah
    .dh 0004h

.org SpriteStats + Owtch_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 369/96/1
    .dh 0366h
    .dh 0096h
    .dh 0004h

.org SpriteStats + Puyo_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 39B/64/1
    .dh 0398h
    .dh 0064h
    .dh 0004h

.org SpriteStats + SkulteraSmall_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 337/C8/1
    .dh 0334h
    .dh 00C8h
    .dh 0004h

.org SpriteStats + Zozoro_Id * SpriteStats_Size + SpriteStats_YellowXWeight
    ; originally 2D3/12C/1
    .dh 02D0h
    .dh 012Ch
    .dh 0004h