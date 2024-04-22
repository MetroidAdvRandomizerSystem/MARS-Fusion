; Room edits for open exploration, enemies, softlock prevention, etc.

; TODO: add scroll changes
; TODO: add pre-cocoon spriteset to S2-1B

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

.org Sector2Doors + 02h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
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

.org Sector2Doors + 1Bh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector2Doors + 1Fh * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     0Dh
.endarea

.org Sector2Doors + 23h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector2Doors + 2Fh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector2Doors + 5Fh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector2Doors + 71h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_ExitDistanceY - DoorEntry_Type + 1
    .db     DoorType_OpenHatch
    .skip   DoorEntry_SourceRoom - DoorEntry_Type - 1
    .db     0Dh
    .skip   DoorEntry_ExitDistanceX - DoorEntry_SourceRoom - 1
    .db     18h
    .db     00h
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

.org Sector2Doors + 2Ah * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

; Sector 2 - Zazabi Access
; add cocoon and kihunter spritesets to intact room state
.autoregion
@S2_ZazabiAccess_Spriteset1:
    .db     03h, 27h, 12h
    .db     05h, 2Dh, 12h
    .db     0Dh, 08h, 12h
    .db     0Dh, 0Ch, 12h
    .db     0Dh, 0Fh, 12h
    .db     0Eh, 15h, 12h
    .db     0Eh, 19h, 12h
    .db     11h, 14h, 02h
    .db     10h, 2Dh, 21h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.autoregion
@S2_ZazabiAccess_Spriteset2:
    .db     03h, 28h, 12h
    .db     04h, 2Ah, 23h
    .db     05h, 2Bh, 23h
    .db     05h, 2Dh, 12h
    .db     0Dh, 07h, 12h
    .db     0Dh, 0Bh, 12h
    .db     0Dh, 0Fh, 12h
    .db     0Eh, 15h, 12h
    .db     0Eh, 19h, 12h
    .db     0Fh, 0Fh, 23h
    .db     11h, 14h, 02h
    .db     11h, 19h, 23h
    .db     11h, 1Dh, 23h
    .db     14h, 15h, 24h
    .db     10h, 2Dh, 21h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org Sector2Levels + 11h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     19h
    .skip 2
    .dw     @S2_ZazabiAccess_Spriteset1
    .db     68h
    .db     47h
    .skip 2
    .dw     @S2_ZazabiAccess_Spriteset2
    .db     69h
.endarea

.autoregion
@S2_ZazabiAccess_CocoonSpriteset:
    .db     91h, 00h
    .db     89h, 02h
    .db     0, 0
.endautoregion

.autoregion
@S2_ZazabiAccess_KihunterSpriteset:
    .db     91h, 00h
    .db     8Ah, 02h
    .db     5Bh, 03h
    .db     5Ch, 03h
    .db     0, 0
.endautoregion

.org SpritesetList + 68h * 04h
.area 08h
    .dw     @S2_ZazabiAccess_CocoonSpriteset
    .dw     @S2_ZazabiAccess_KihunterSpriteset
.endarea

; Sector 2 - Data Hub
; repair door to data hub access
.org 084D5519h
.area 40Bh
.incbin "data/rooms/S2-1F-BG1.rlebg"
.endarea

.autoregion
@S2_DataHub_Clipdata:
.incbin "data/rooms/S2-1F-Clip.rlebg"
.endautoregion

.org Sector2Levels + 1Fh * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S2_DataHub_Clipdata
.endarea

.org Sector2Doors + 10h * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     1Fh
.endarea

.org Sector2Doors + 11h * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     1Fh
.endarea

.defineregion 084D526Eh, 0CEh
.defineregion Sector2Doors + 45h * DoorEntry_Size, DoorEntry_Size, 0FFh

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

; Sector 3 - Bob's Room
; remove event-based transitions leading to wrecked room state
.org Sector3Doors + 0Ch * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector3Doors + 14h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.defineregion Sector3Doors + 2Fh * DoorEntry_Size, DoorEntry_Size, 0FFh
.defineregion Sector3Doors + 30h * DoorEntry_Size, DoorEntry_Size, 0FFh
.defineregion Sector3Doors + 3Fh * DoorEntry_Size, DoorEntry_Size, 0FFh

; Sector 3 - BOX Access
; repair door to bob's room
.org 084FF05Fh
.area 300h
.incbin "data/rooms/S3-16-BG1.rlebg"
.endarea

.autoregion
@S3_BoxAccess_Clipdata:
.incbin "data/rooms/S3-16-Clip.rlebg"
.endautoregion

.org Sector3Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S3_BoxAccess_Clipdata
.endarea

.org Sector3Doors + 10h * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     16h
.endarea

.defineregion 084FEDE6h, 0A5h
.defineregion Sector3Doors + 23h * DoorEntry_Size, DoorEntry_Size, 0FFh

; Sector 3 - BOX Arena
; repair door to data room
.org 084FF5D1h
.area 256h
.incbin "data/rooms/S3-17-BG1.rlebg"
.endarea

.autoregion
@S3_BoxArena_Clipdata:
.incbin "data/rooms/S3-17-Clip.rlebg"
.endautoregion

.org Sector3Levels + 17h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S3_BoxArena_Clipdata
.endarea

.org Sector3Doors + 1Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector3Doors + 2Bh * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     17h
.endarea

.org Sector3Doors + 2Dh * DoorEntry_Size + DoorEntry_Destination
.area 1
    .db     2Eh
.endarea

.defineregion 084FF4AEh, 08Fh
.defineregion Sector3Doors + 24h * DoorEntry_Size, DoorEntry_Size, 0FFh

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
; TODO: move enemies on top of ladder pillar
.autoregion
@S5_NightmareTrainingGrounds_Bg1:
.incbin "data/rooms/S5-03-BG1.rlebg"
.endautoregion

.autoregion
@S5_NightmareTrainingGrounds_Clipdata:
.incbin "data/rooms/S5-03-Clip.rlebg"
.endautoregion

.org Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Bg1
.area 10h
    .dw     @S5_NightmareTrainingGrounds_Bg1
    .skip 4
    .dw     @S5_NightmareTrainingGrounds_Clipdata
.endarea

.org Sector5Doors + 03h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 0Ah * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 4Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.defineregion 08514F18h, 486h
.defineregion 085145A8h, 212h

; Sector 5 - Arctic Containment
; change the lv4 security door to crow's nest to a functional lv3 security door
.org 08516C61h
.area 652h
.incbin "data/rooms/S5-07-BG1.rlebg"
.endarea

.autoregion
@S5_ArcticContainment_Clipdata:
.incbin "data/rooms/S5-07-Clip.rlebg"
.endautoregion

.org Sector5Levels + 07h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_ArcticContainment_Clipdata
.endarea

.org Sector5Doors + 15h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 24h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 35h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_SourceRoom - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_SourceRoom - DoorEntry_Type - 1
    .db     07h
.endarea

.org Sector5Doors + 38h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_OpenHatch
.endarea

.org Sector5Doors + 55h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 64h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.defineregion 08516852h, 1AAh

; Sector 5 - Data Room
; merge the intact and destroyed data rooms into a single room
; seal off the destroyed upper half of the data room from the intact lower half
.org 08519419h
.area 19Fh
.incbin "data/rooms/S5-10-BG1.rlebg"
.endarea

.autoregion
@S5_DataRoom_Clipdata:
.incbin "data/rooms/S5-10-Clip.rlebg"
.endautoregion

.org Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_DataRoom_Clipdata
.endarea

.org Sector5Doors + 56h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     5Ch
.endarea

.org Sector5Doors + 59h * DoorEntry_Size + DoorEntry_SourceRoom
.area DoorEntry_YEnd - DoorEntry_SourceRoom + 1
    .db     10h
    .db     10h, 10h
    .db     0Fh, 12h
.endarea

.defineregion 085191A4h, 84h
.defineregion Sector5Doors + 23h * DoorEntry_Size, DoorEntry_Size, 0FFh
.defineregion Sector5Doors + 34h * DoorEntry_Size, DoorEntry_Size, 0FFh

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

.autoregion
@S5_SecurityShaftEast_Clipdata:
.incbin "data/rooms/S5-16-Clip.rlebg"
.endautoregion

.org Sector5Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_SecurityShaftEast_Clipdata
.endarea

.org Sector5Doors + 28h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     6Ch
.endarea

.org Sector5Doors + 2Ah * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     16h
.endarea

.defineregion 0851AA7Eh, 110h
.defineregion Sector5Doors + 29h * DoorEntry_Size, DoorEntry_Size, 0FFh

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

.org Sector5Doors + 37h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_OpenHatch
.endarea

; Sector 5 - Crow's Nest
; repair the door to arctic containment into a lv3 security door
.org 0851CC93h
.area 263h
.incbin "data/rooms/S5-24-BG1.rlebg"
.endarea

.autoregion
@S5_CrowsNest_Clipdata:
.incbin "data/rooms/S5-24-Clip.rlebg"
.endautoregion

.org Sector5Levels + 24h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_CrowsNest_Clipdata
.endarea

.org Sector5Doors + 57h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.defineregion 0851CAA6h, 0F0h

; Sector 6 - Zozoro Wine Cellar
; change the reforming bomb block to a never reforming bomb block to prevent
; softlocking from running out of power bombs
.org 085537C4h
.area 033h
.incbin "data/rooms/S6-0F-Clip.rlebg"
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
