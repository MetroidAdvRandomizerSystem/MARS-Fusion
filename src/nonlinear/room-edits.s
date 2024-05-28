; Room edits for open exploration, enemies, softlock prevention, etc.

; TODO: patch scroll behavior such that if no scroll zones are found,
; extended scrolls with unbroken tiles will be treated as fallbacks.

; Debug room data
.defineregion 083C2A48h, 3 * 90h
.defineregion 083C2C10h, 3Ch
.defineregion 083F1548h, 0C56h

; Main Deck - Docking Bay Shaft
; remove event-based transitions to wrecked Silo Access
.if RANDOMIZER
.org MainDeckDoors + 0Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org MainDeckDoors + 0Fh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea
.endif

; Main Deck - Crew Quarters West
; remove power bomb geron
.defineregion readptr(MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1), 0Fh

.org MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_GoMode
    .skip 2
    .dw     readptr(MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     33h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Main Deck - Operations Deck
; change operations room lv4 security door to lv0 security
.org readptr(MainDeckLevels + 0Dh * LevelMeta_Size + LevelMeta_Bg1)
.area 2DBh
.incbin "data/rooms/S0-0D-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 0Dh * LevelMeta_Size + LevelMeta_Clipdata)
.area 0C3h
.incbin "data/rooms/S0-0D-Clip.rlebg"
.endarea

; Main Deck - Central Hub
; keep power bomb geron always loaded
.defineregion readptr(MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset0), 03h

.org MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     readptr(MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     33h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Main Deck - Eastern Hub
; remove geron in front of recharge station
.defineregion readptr(MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset0), 12h

.org MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_MapX - LevelMeta_Spriteset0
    .dw     readptr(MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     19h
    .db     63h
    .skip 2
    .dw     readptr(MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     19h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Main Deck - Sector Hub
; keep main elevator always active
.defineregion readptr(MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset0), 27h

.org MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     readptr(MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     02h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Main Deck - Main Elevator Shaft
; remove event-based transition
.org MainDeckDoors + 32h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_NoHatch
.endarea

; Main Deck - Maintenance Shaft
; repair maintenance crossing and add a geron
.org readptr(MainDeckLevels + 23h * LevelMeta_Size + LevelMeta_Bg1)
.area 492h
.incbin "data/rooms/S0-23-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 23h * LevelMeta_Size + LevelMeta_Bg2)
.area 4F0h
.incbin "data/rooms/S0-23-BG2.rlebg"
.endarea

.defineregion readptr(MainDeckLevels + 52h * LevelMeta_Size + LevelMeta_Spriteset0), 12h

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

; Main Deck - Maintenance Crossing
; repair so the crossing is traversable and add a geron
.org readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Bg1)
.area 100h
.incbin "data/rooms/S0-24-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Bg2)
.area 0D2h
.incbin "data/rooms/S0-24-BG2.rlebg"
.endarea

.org readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Clipdata)
.area 61h
.incbin "data/rooms/S0-24-Clip.rlebg"
.endarea

.defineregion readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Spriteset0), 03h

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

; Main Deck - Main Elevator Access
; remove event-based transition
.org MainDeckDoors + 4Ah * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     61h
.endarea

.org MainDeckDoors + 5Ch * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org MainDeckDoors + 5Dh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Main Deck - Silo Access
; move zoro cocoon
.org readptr(MainDeckLevels + 30h * LevelMeta_Size + LevelMeta_Spriteset0)
.area 03h
    .db     15h, 05h, 14h
.endarea

.org readptr(MainDeckLevels + 30h * LevelMeta_Size + LevelMeta_Spriteset1)
.area 03h
    .db     15h, 05h, 14h
.endarea

; Main Deck - Operations Room
; change lv4 security door to lv0 security
; remove event-based transition leading to wrecked Operations Deck
.org readptr(MainDeckLevels + 52h * LevelMeta_Size + LevelMeta_Bg1)
.area 0F8h
.incbin "data/rooms/S0-52-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 52h * LevelMeta_Size + LevelMeta_Clipdata)
.area 3Ch
.incbin "data/rooms/S0-52-Clip.rlebg"
.endarea

.if RANDOMIZER
.org MainDeckDoors + 0C2h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea
.endif

; Sector 1 - Atmospheric Stabilizer Northwest
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 04h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea

; Sector 1 - Charge Core Exit
; fix screen scroll when entering room from Charge Core Arena
.defineregion readptr(Sector1Scrolls + 01h * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 1 - Moto Manor
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea

; Sector 1 - Atmospheric Stabilizer Southeast
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 0Fh * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea

; Sector 1 - Lava Lake Annex
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 14h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea

; Sector 1 - Sciser Playground
; fix screen scroll when entering room from Charge Core Access
.defineregion readptr(Sector1Scrolls + 07h * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 1 scroll table fixes
.org Sector1Scrolls
.area 30h
    .dw     readptr(Sector1Scrolls + 00h * 4)
    .dw     readptr(Sector1Scrolls + 02h * 4)
    .dw     readptr(Sector1Scrolls + 03h * 4)
    .dw     readptr(Sector1Scrolls + 04h * 4)
    .dw     readptr(Sector1Scrolls + 05h * 4)
    .dw     readptr(Sector1Scrolls + 06h * 4)
    .dw     readptr(Sector1Scrolls + 08h * 4)
    .dw     readptr(Sector1Scrolls + 09h * 4)
    .dw     readptr(Sector1Scrolls + 0Ah * 4)
    .dw     readptr(Sector1Scrolls + 0Bh * 4)
.endarea

; Sector 2 - Data Hub Access
; move cocoon and kihunter spritesets to intact room state
.org Sector2Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_ZazabiAbsorbed
    .skip 2
    .dw     readptr(Sector2Levels + 1Eh * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     13h
    .db     Event_ReactorOutage
    .skip 2
    .dw     readptr(Sector2Levels + 1Eh * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     1Eh
.endarea

.org Sector2Doors + 02h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

; Sector 2 - Owtch Cache A
; TODO: fix screen scroll when custom start is behind bomb blocks

; Sector 2 - Central Shaft
; make door to reo room functional
; remove hatch to ripper roost
; move zoro out of the way of ripper roost
; move cocoon and kihunter spritesets to intact room state
.org readptr(Sector2Levels + 0Dh * LevelMeta_Size + LevelMeta_Bg1)
.area 4E1h
.incbin "data/rooms/S2-0D-BG1.rlebg"
.endarea

.org readptr(Sector2Levels + 0Dh * LevelMeta_Size + LevelMeta_Clipdata)
.area 1F0h
.incbin "data/rooms/S2-0D-Clip.rlebg"
.endarea

.org readptr(Sector2Levels + 0Dh * LevelMeta_Size + LevelMeta_Spriteset0) + 1 * 03h
.area 03h
    .db     1Bh, 05h, 24h
.endarea

.org readptr(Sector2Levels + 2Eh * LevelMeta_Size + LevelMeta_Spriteset0) + 1 * 03h
.area 03h
    .db     1Bh, 05h, 14h
.endarea

.org readptr(Sector2Levels + 2Eh * LevelMeta_Size + LevelMeta_Spriteset1) + 2 * 03h
.area 03h
    .db     1Bh, 05h, 14h
.endarea

.org Sector2Levels + 0Dh * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_ZazabiAbsorbed
    .skip 2
    .dw     readptr(Sector2Levels + 2Eh * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     13h
    .db     Event_ReactorOutage
    .skip 2
    .dw     readptr(Sector2Levels + 2Eh * LevelMeta_Size + LevelMeta_Spriteset1)
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
    .db     Event_ZazabiAbsorbed
    .skip 2
    .dw     readptr(Sector2Levels + 2Ch * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     13h
    .db     Event_ReactorOutage
    .skip 2
    .dw     readptr(Sector2Levels + 2Ch * LevelMeta_Size + LevelMeta_Spriteset1)
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
    .db     Event_ZazabiAbsorbed
    .skip 2
    .dw     @S2_ZazabiAccess_Spriteset1
    .db     68h
    .db     Event_ReactorOutage
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

; Sector 2 - Zazabi Arena
; fix screen scroll when entering room from Zazabi Speedway
.org readptr(Sector2Scrolls + 05h * 4) + ScrollList_HeaderSize
.area Scroll_Size
    .db     02h, 2Eh
    .db     02h, 0Eh
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea

; Sector 2 - Entrance Hub Underside
; add room state with zoros
.autoregion
@S2_EntranceHubUnderside_Spriteset0:
    .db     03h, 09h, 24h
    .db     0Fh, 0Fh, 24h
    .db     10h, 0Dh, 02h
    .db     12h, 0Eh, 26h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org Sector2Levels + 1Bh * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_MapX - LevelMeta_Spriteset0
    .dw     @S2_EntranceHubUnderside_Spriteset0
    .db     12h
    .db     19h
    .skip 2
    .dw     readptr(Sector2Levels + 1Bh * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     13h
    .db     4Eh
    .skip 2
    .dw     readptr(Sector2Levels + 1Bh * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     1Eh
.endarea

; Sector 2 - Data Hub
; repair door to data hub access
.defineregion readptr(Sector2Levels + 1Fh * LevelMeta_Size + LevelMeta_Clipdata), 0CEh

.org readptr(Sector2Levels + 1Fh * LevelMeta_Size + LevelMeta_Bg1)
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

.org Sector2Doors + 13h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector2Doors + 45h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 2 - Ripper Roost
; move bottom crumble block up one to prevent softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector2Levels + 32h * LevelMeta_Size + LevelMeta_Clipdata)
.area 10Ah
.incbin "data/rooms/S2-32-Clip.rlebg"
.endarea
.endif

; Sector 2 - Crumble City
; replace one of the shot blocks in the morph tunnel below the top item
; with a crumble block to prevent softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector2Levels + 36h * LevelMeta_Size + LevelMeta_Clipdata)
.area 121h
.incbin "data/rooms/S2-36-Clip.rlebg"
.endarea
.endif

; Sector 3 - Security Access
; remove sidehoppers on speedbooster runway to prevent near softlock with neither charge nor missiles
; move sidehoppers below runway to prevent them from clipping into the wall
.org readptr(Sector3Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset1)
.area 27h
    .db     04h, 24h, 0A4h
    .db     05h, 1Fh, 0A4h
    .db     05h, 29h, 0A4h
    .db     06h, 1Dh, 02h
    .db     14h, 29h, 23h
    .db     14h, 2Ch, 23h
    .db     0FFh, 0FFh, 0FFh
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

.org Sector3Doors + 2Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector3Doors + 30h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector3Doors + 3Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 3 - BOX Access
; repair door to bob's room
.defineregion readptr(Sector3Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata), 0A5h

.org readptr(Sector3Levels + 16h * LevelMeta_Size + LevelMeta_Bg1)
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

.org Sector3Doors + 23h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 3 - BOX Arena
; repair door to data room
.defineregion readptr(Sector3Levels + 17h * LevelMeta_Size + LevelMeta_Clipdata), 08Fh

.org readptr(Sector3Levels + 17h * LevelMeta_Size + LevelMeta_Bg1)
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

.org Sector3Doors + 2Dh * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     2Eh
.endarea

.org Sector3Doors + 24h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 4 - Serris Escape
; TODO: fix screen scrolls when custom start is behind the bomb blocks
; scroll 0 (11, 02) -> (2E, 17), scroll 1 (02, 16) -> (2E, 1F)

; Sector 4 - Pump Control Access
; fix screen scrolls when entering from Pump Control Save Room
.org readptr(Sector4Scrolls + 03h * 4) + ScrollList_HeaderSize
.area Scroll_Size
    .db     02h, 10h
    .db     02h, 29h
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea

; Sector 4 - Cheddar Bay
; fix screen scrolls when entering from Security Bypass
.org readptr(Sector4Scrolls + 05h * 4) + ScrollList_HeaderSize + Scroll_Size * 1
.area Scroll_Size
    .db     02h, 20h
    .db     02h, 0Ch
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea

; Sector 4 - Waterway
; add flooded room state
.autoregion
@S4_Waterway_Spriteset0:
    .db     03h, 09h, 17h
    .db     03h, 0Bh, 17h
    .db     03h, 10h, 17h
    .db     03h, 13h, 17h
    .db     03h, 17h, 17h
    .db     04h, 08h, 12h
    .db     04h, 18h, 12h
    .db     07h, 10h, 11h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org Sector4Levels + 1Ch * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     @S4_Waterway_Spriteset0
    .db     0Eh
    .db     Event_WaterLevelLowered
    .skip 2
    .dw     readptr(Sector4Levels + 1Ch * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     1Dh
.endarea

; Sector 4 - Security Bypass
; prevent several softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector4Levels + 22h * LevelMeta_Size + LevelMeta_Bg1)
.area 57Ah
.incbin "data/rooms/S4-22-BG1.rlebg"
.endarea

.org readptr(Sector4Levels + 22h * LevelMeta_Size + LevelMeta_Clipdata)
.area 1B1h
.incbin "data/rooms/S4-22-Clip.rlebg"
.endarea
.endif

; Sector 4 - Drain Pipe
; keep puffer always active
.defineregion readptr(Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1), 2Ah

.org Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_WaterLevelLowered
    .skip 2
    .dw     readptr(Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     23h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Sector 4 - Aquarium Storage
; make kago always block missile tank
.defineregion readptr(Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset1), 24h

.org Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset1Event
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Sector 5 - Nightmare Training Grounds
; restructure the room to have a speedbooster runway across the top
; add speedbooster blocks above the power bomb blocks
.defineregion readptr(Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Bg1), 486h
.defineregion readptr(Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Clipdata), 212h

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

.org readptr(Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset0)
.area 06h
    .db     10h, 1Ch, 25h
    .db     10h, 23h, 25h
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

.org Sector5Doors + 0Bh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 0Ch * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 0Dh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 50h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Arctic Containment
; change the lv4 security door to crow's nest to a functional lv3 security door
.defineregion readptr(Sector5Levels + 07h * LevelMeta_Size + LevelMeta_Clipdata), 1AAh

.org readptr(Sector5Levels + 07h * LevelMeta_Size + LevelMeta_Bg1)
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

.org Sector5Doors + 1Bh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 1Ch * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 1Dh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 1Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 39h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 46h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Frozen Tower
; remove event-based transitions
.org Sector5Doors + 17h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 2Fh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_NoHatch
.endarea

.org Sector5Doors + 30h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 5Eh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 5Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 60h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Data Room
; merge the intact and destroyed data rooms into a single room
; seal off the destroyed upper half of the data room from the intact lower half
.defineregion readptr(Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata), 84h

.org readptr(Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Bg1)
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

.org readptr(Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Spriteset0)
.area 03h
    .db     14h, 09h, 11h
.endarea

.org Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Spriteset0Id
.area 01h
    .db     0Ch
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

.org Sector5Doors + 23h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 34h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Security Shaft East
; repair the door to kago blockade
.defineregion readptr(Sector5Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata), 110h

.org readptr(Sector5Levels + 16h * LevelMeta_Size + LevelMeta_Bg1)
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

.org Sector5Doors + 29h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Ripper Road
; replace lv0 door to arctic containment with an open hatch
.org readptr(Sector5Levels + 1Ah * LevelMeta_Size + LevelMeta_Bg1)
.area 1B3h
.incbin "data/rooms/S5-1A-BG1.rlebg"
.endarea

.org readptr(Sector5Levels + 1Ah * LevelMeta_Size + LevelMeta_Clipdata)
.area 0A4h
.incbin "data/rooms/S5-1A-Clip.rlebg"
.endarea

.org Sector5Doors + 37h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_OpenHatch
.endarea

; Sector 5 - Crow's Nest
; repair the door to arctic containment into a lv3 security door
.defineregion readptr(Sector5Levels + 24h * LevelMeta_Size + LevelMeta_Clipdata), 0F0h

.org readptr(Sector5Levels + 24h * LevelMeta_Size + LevelMeta_Bg1)
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

; Sector 5 - Groznyj Grad
; fix screen scrolls when entering from Security Shaft East
.defineregion readptr(Sector5Scrolls + 0Fh * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 5 scroll table fixes
.org Sector5Scrolls
.area 4Ch
    .dw     readptr(Sector5Scrolls + 00h * 4)
    .dw     readptr(Sector5Scrolls + 01h * 4)
    .dw     readptr(Sector5Scrolls + 02h * 4)
    .dw     readptr(Sector5Scrolls + 03h * 4)
    .dw     readptr(Sector5Scrolls + 04h * 4)
    .dw     readptr(Sector5Scrolls + 05h * 4)
    .dw     readptr(Sector5Scrolls + 06h * 4)
    .dw     readptr(Sector5Scrolls + 07h * 4)
    .dw     readptr(Sector5Scrolls + 08h * 4)
    .dw     readptr(Sector5Scrolls + 09h * 4)
    .dw     readptr(Sector5Scrolls + 0Ah * 4)
    .dw     readptr(Sector5Scrolls + 0Bh * 4)
    .dw     readptr(Sector5Scrolls + 0Ch * 4)
    .dw     readptr(Sector5Scrolls + 0Dh * 4)
    .dw     readptr(Sector5Scrolls + 0Eh * 4)
    .dw     readptr(Sector5Scrolls + 10h * 4)
    .dw     readptr(Sector5Scrolls + 11h * 4)
    .dw     readptr(Sector5Scrolls + 12h * 4)
.endarea

; Sector 6 - Zozoro Wine Cellar
; change the reforming bomb block to a never reforming bomb block to prevent
; softlocking from running out of power bombs
.if ANTI_SOFTLOCK
.org readptr(Sector6Levels + 0Fh * LevelMeta_Size + LevelMeta_Clipdata)
.area 033h
.incbin "data/rooms/S6-0F-Clip.rlebg"
.endarea
.endif

; Sector 6 - X-BOX Arena
; change the top crumble block into a shot block to mitigate accidentally
; entering a point of no return
.org readptr(Sector6Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata)
.area 0B3h
.incbin "data/rooms/S6-10-Clip.rlebg"
.endarea

; Sector 6 - Forbidden Entrance
; fix screen scrolls when entering room from XBOX Access
.defineregion readptr(Sector6Scrolls + 02h * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 6 - Missile Storage
; TODO: fix screen scrolls when custom start is behind bomb blocks

; Sector 6 - Big Shell 1
; Remove the crumble block into the long morph tunnel to prevent softlocks
; without power bombs
.if ANTI_SOFTLOCK
.org readptr(Sector6Levels + 1Bh * LevelMeta_Size + LevelMeta_Bg1)
.area 1EFh
.incbin "data/rooms/S6-1B-BG1.rlebg"
.endarea

.org readptr(Sector6Levels + 1Bh * LevelMeta_Size + LevelMeta_Clipdata)
.area 0B5h
.incbin "data/rooms/S6-1B-Clip.rlebg"
.endarea
.endif

; Sector 6 - Big Shell 2
; fix screen scrolls when entering room from Blue X Blockade
.defineregion readptr(Sector6Scrolls + 0Fh * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 6 scroll table fixes
.org Sector6Scrolls
.area 50h
    .dw     readptr(Sector6Scrolls + 00h * 4)
    .dw     readptr(Sector6Scrolls + 01h * 4)
    .dw     readptr(Sector6Scrolls + 03h * 4)
    .dw     readptr(Sector6Scrolls + 04h * 4)
    .dw     readptr(Sector6Scrolls + 05h * 4)
    .dw     readptr(Sector6Scrolls + 06h * 4)
    .dw     readptr(Sector6Scrolls + 07h * 4)
    .dw     readptr(Sector6Scrolls + 08h * 4)
    .dw     readptr(Sector6Scrolls + 09h * 4)
    .dw     readptr(Sector6Scrolls + 0Ah * 4)
    .dw     readptr(Sector6Scrolls + 0Bh * 4)
    .dw     readptr(Sector6Scrolls + 0Ch * 4)
    .dw     readptr(Sector6Scrolls + 0Dh * 4)
    .dw     readptr(Sector6Scrolls + 0Eh * 4)
    .dw     readptr(Sector6Scrolls + 10h * 4)
    .dw     readptr(Sector6Scrolls + 11h * 4)
    .dw     readptr(Sector6Scrolls + 12h * 4)
    .dw     readptr(Sector6Scrolls + 13h * 4)
.endarea
