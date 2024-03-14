; Room edits for open exploration, enemies, softlock prevention, etc.

; Debug room data
.defineregion 083C2A48h, 3 * 90h
.defineregion 083C2C10h, 3Ch
.defineregion 083F1548h, 0C56h

; Main Deck - Crew Quarters West
; remove power bomb geron
.org MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     63h
    .skip 2
    .dw     08470F0Ch
    .db     33h
    .db     0
    .skip 2
    .dw     083BF884h
    .db     0
.endarea
.defineregion 08470FB2h, 0Fh

; Main Deck - Operations Deck
; change operations room lv4 security door to lv0 security
.org 08471668h
.area 2DBh
.incbin "data/rooms/S0-0D-BG1.rlebg"
.endarea
.org 08471182h
.area 0C3h
.incbin "data/rooms/S0-0D-Clip.rlebg"
.endarea

; Main Deck - Central Hub
; keep power bomb geron always loaded
.org MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     0847283Bh
    .db     33h
    .db     0
    .skip 2
    .dw     083BF884h
    .db     0
.endarea
.defineregion 08472AB0h, 03h

; Main Deck - Eastern Hub
; remove geron in front of recharge station
.org MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_MapX - LevelMeta_Spriteset0
    .dw     0847344Fh
    .db     19h
    .db     63h
    .skip 2
    .dw     0847334Ch
    .db     19h
    .db     0
    .skip 2
    .dw     083BF884h
    .db     0
.endarea
.defineregion 084736C9h, 12h

; Main Deck - Sector Hub
; keep main elevator always active
.org MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     08473F3Ah
    .db     02h
    .db     0
    .skip 2
    .dw     083BF884h
    .db     0
.endarea
.defineregion 08474195h, 27h

; Main Deck - Maintenance Shaft
; repair maintenance crossing and add a geron
.org 08476337h
.area 492h
.incbin "data/rooms/S0-23-BG1.rlebg"
.endarea
.org 08475E47h
.area 4F0h
.incbin "data/rooms/S0-23-BG2.rlebg"
.endarea

.autoregion
@MaintenanceShaft_Spriteset0:
    .db     05h, 0Eh, 25h
    .db     15h, 0Bh, 03h
    .db     19h, 0Ch, 12h
    .db     20h, 07h, 38h
    .db     46h, 0Bh, 22h
    .db     39h, 0Ch, 24h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org MainDeckLevels + 23h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset1Event - LevelMeta_Spriteset0
    .dw     @MaintenanceShaft_Spriteset0
    .db     19h
.endarea

.defineregion 084767C9h, 12h

; Main Deck - Maintenance Crossing
; repair so the crossing is traversable and add a geron
.org 0847690Fh
.area 100h
.incbin "data/rooms/S0-24-BG1.rlebg"
.endarea
.org 0847683Dh
.area 0D2h
.incbin "data/rooms/S0-24-BG2.rlebg"
.endarea
.org 084767DCh
.area 61h
.incbin "data/rooms/S0-24-Clip.rlebg"
.endarea

.autoregion
@MaintenanceCrossing_Spriteset0:
    .db     07h, 0Ch, 24h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset1Event - LevelMeta_Spriteset0
    .dw     @MaintenanceCrossing_Spriteset0
    .db     19h
.endarea

.defineregion 08476A0Fh, 03h

; Main Deck - Silo Access
; move zoro cocoon
.org 08479091h
.area 03h
    .db     15h, 05h, 14h
.endarea

.org 08478E46h
.area 03h
    .db     15h, 05h, 14h
.endarea

; Main Deck - Operations Room
; change lv4 security door to lv0 security
.org 084814F8h
.area 0F8h
.incbin "data/rooms/S0-52-BG1.rlebg"
.endarea
.org 08481382h
.area 3Ch
.incbin "data/rooms/S0-52-Clip.rlebg"
.endarea

; Sector 2 - Data Hub Access
; move cocoon and kihunter spritesets to intact room state
.org Sector2Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     19h
    .skip 2
    .dw     084D5246h
    .db     13h
    .db     47h
    .skip 2
    .dw     084D50FCh
    .db     1Eh
.endarea

; Sector 2 - Central Shaft
; make door to reo room functional
; remove hatch to ripper roost
; move zoro out of the way of ripper roost
; move cocoon and kihunter spritesets to intact room state
.org 084D0D55h
.area 4E1h
.incbin "data/rooms/S2-0D-BG1.rlebg"
.endarea
.org 084D07ACh
.area 1F0h
.incbin "data/rooms/S2-0D-Clip.rlebg"
.endarea

.org 084D1236h + 1 * 03h
.area 03h
    .db     1Bh, 05h, 24h
.endarea

.org 084D9BDFh + 1 * 03h
.area 03h
    .db     1Bh, 05h, 14h
.endarea

.org 084D96BEh + 2 * 03h
.area 03h
    .db     1Bh, 05h, 14h
.endarea

.org Sector2Levels + 0Dh * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     19h
    .skip 2
    .dw     084D9BDFh
    .db     13h
    .db     47h
    .skip 2
    .dw     084D96BEh
    .db     1Eh
.endarea

; Sector 2 - Dessgeega Dormitory
; add cocoon and kihunter spritesets to intact room state
.org Sector2Levels + 0Eh * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     19h
    .skip 2
    .dw     084D8F6Fh
    .db     13h
    .db     47h
    .skip 2
    .dw     084D8E00h
    .db     1Eh
.endarea

; Sector 2 - Zazabi Access
; add cocoon and kihunter spritesets to intact room state
; TODO

; Sector 2 - Data Hub
; repair door to data hub access
.org 084D5519h
.area 40Bh
.incbin "data/rooms/S2-1F-BG1.rlebg"
.endarea
.org 084D526Eh
.area 0CEh
.incbin "data/rooms/S2-1F-Clip.rlebg"
.endarea

; Sector 2 - Ripper Roost
; move bottom crumble block up one to prevent softlocks without bombs
.org 084DA9F0h
.area 10Ah
.incbin "data/rooms/S2-32-Clip.rlebg"
.endarea

; Sector 2 - Crumble City
; replace one of the shot blocks in the morph tunnel below the top item
; with a crumble block to prevent softlocks without bombs
.org 084DB404h
.area 121h
.incbin "data/rooms/S2-36-Clip.rlebg"
.endarea

; Sector 3 - BOX Access
; repair door to bob's room
.org 084FF05Fh
.area 300h
.incbin "data/rooms/S3-16-BG1.rlebg"
.endarea
.org 084FEDE6h
.area 0A5h
.incbin "data/rooms/S3-16-Clip.rlebg"
.endarea

; Sector 3 - BOX Arena
; repair door to data room
.org 084FF5D1h
.area 256h
.incbin "data/rooms/S3-17-BG1.rlebg"
.endarea
.org 084FF4AEh
.area 08Fh
.incbin "data/rooms/S3-17-Clip.rlebg"
.endarea

; Sector 4 - Security Bypass
; prevent several softlocks without bombs
.org 0853F5C3h
.area 57Ah
.incbin "data/rooms/S4-22-BG1.rlebg"
.endarea
.org 0853F25Ah
.area 1B1h
.incbin "data/rooms/S4-22-Clip.rlebg"
.endarea

; Sector 4 - Drain Pipe
; keep puffer always active
.org Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     20h
    .skip 2
    .dw     0854032Eh
    .db     23h
    .db     0
    .skip 2
    .dw     083BF884h
    .db     0
.endarea

.defineregion 085403DBh, 2Ah

; Sector 5 - Nightmare Training Grounds
; restructure the room to have a speedbooster runway across the top
; add speedbooster blocks above the power bomb blocks
.org 08514F18h
.area 486h
.incbin "data/rooms/S5-03-BG1.rlebg"
.endarea
.org 085145A8h
.area 212h
.incbin "data/rooms/S5-03-Clip.rlebg"
.endarea

; Sector 5 - Arctic Containment
; change the lv4 security door to crow's nest to a functional lv3 security door
.org 08516C61h
.area 652h
.incbin "data/rooms/S5-07-BG1.rlebg"
.endarea
.org 08516852h
.area 1AAh
.incbin "data/rooms/S5-07-Clip.rlebg"
.endarea

; Sector 5 - Data Room
; merge the intact and destroyed data rooms into a single room
; seal off the destroyed upper half of the data room from the intact lower half
.org 08519419h
.area 19Fh
.incbin "data/rooms/S5-10-BG1.rlebg"
.endarea
.org 085191A4h
.area 84h
.incbin "data/rooms/S5-10-Clip.rlebg"
.endarea

.org 085195B8h
.area 03h
    .db     14h, 09h, 11h
.endarea

.org Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Spriteset0Id
.area 01h
    .db     0Ch
.endarea

; Sector 5 - Security Shaft East
; repair the door to kago blockade
.org 0851AC8Ah
.area 2EBh
.incbin "data/rooms/S5-16-BG1.rlebg"
.endarea
.org 0851AA7Eh
.area 110h
.incbin "data/rooms/S5-16-Clip.rlebg"
.endarea

; Sector 5 - Ripper Road
; replace lv0 door to arctic containment with an open hatch
.org 0851BA76h
.area 1B3h
.incbin "data/rooms/S5-1A-BG1.rlebg"
.endarea
.org 0851B9C4h
.area 0A4h
.incbin "data/rooms/S5-1A-Clip.rlebg"
.endarea

; Sector 5 - Crow's Nest
; repair the door to arctic containment into a lv3 security door
.org 0851CC93h
.area 263h
.incbin "data/rooms/S5-24-BG1.rlebg"
.endarea
.org 0851CAA6h
.area 0F0h
.incbin "data/rooms/S5-24-Clip.rlebg"
.endarea

; Sector 6 - Zozoro Wine Cellar
; change the reforming bomb block to a never reforming bomb block to prevent
; softlocking from running out of power bombs
.org 085537C4h
.area 033h
.incbin "data/rooms/S6-0F-BG1.rlebg"
.endarea

; Sector 6 - Big Shell 1
; Remove the crumble block into the long morph tunnel to prevent softlocks
; without power bombs
.org 085554DDh
.area 1EFh
.incbin "data/rooms/S6-1B-BG1.rlebg"
.endarea
.org 085553BAh
.area 0B5h
.incbin "data/rooms/S6-1B-Clip.rlebg"
.endarea
