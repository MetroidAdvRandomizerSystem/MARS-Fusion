; Room edits for open exploration, enemies, softlock prevention, etc.

; Main Deck - Operations Deck
; change operations room lv4 security door to lv0 security
.org 08471668h
.area 2E4h
.incbin "data/rooms/S0-0D-BG1.rlebg"
.endarea
.org 08471182h
.area 0C3h
.incbin "data/rooms/S0-0D-Clip.rlebg"
.endarea

; Main Deck - Maintenance Shaft
; repair maintenance crossing
.org 08476337h
.area 4A5h
.incbin "data/rooms/S0-23-BG1.rlebg"
.endarea
.org 08475E47h
.area 4F0h
.incbin "data/rooms/S0-23-BG2.rlebg"
.endarea

; Main Deck - Maintenance Crossing
; repair so the crossing is traversable
.org 0847690Fh
.area 105h
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

; Main Deck - Operations Room
; change lv4 security door to lv0 security
.org 084814F8h
.area 100h
.incbin "data/rooms/S0-52-BG1.rlebg"
.endarea
.org 08481382h
.area 3Ch
.incbin "data/rooms/S0-52-Clip.rlebg"
.endarea

; Sector 2 - Central Shaft
;
.org 084D0D55h
.area 4FFh
.incbin "data/rooms/S2-0D-BG1.rlebg"
.endarea
.org 084D07ACh
.area 1F0h
.incbin "data/rooms/S2-0D-Clip.rlebg"
.endarea

; Sector 2 - Data Hub
; repair door to data hub access
.org 084D5519h
.area 42Bh
.incbin "data/rooms/S2-1F-BG1.rlebg"
.endarea
.org 084D526Eh
.area 0F5h
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
.area 306h
.incbin "data/rooms/S3-16-BG1.rlebg"
.endarea
.org 084FEDE6h
.area 0A5h
.incbin "data/rooms/S3-16-Clip.rlebg"
.endarea

; Sector 3 - BOX Arena
; repair door to data room
.org 084FF5D1h
.area 263h
.incbin "data/rooms/S3-17-BG1.rlebg"
.endarea
.org 084FF4AEh
.area 08Fh
.incbin "data/rooms/S3-17-Clip.rlebg"
.endarea

; Sector 4 - Security Bypass
; prevent several softlocks without bombs
.org 0853F5C3h
.area 5B1h
.incbin "data/rooms/S4-22-BG1.rlebg"
.endarea
.org 0853F25Ah
.area 1B1h
.incbin "data/rooms/S4-22-Clip.rlebg"
.endarea

; Sector 5 - Nightmare Training Grounds
; restructure the room to have a speedbooster runway across the top
; add speedbooster blocks above the power bomb blocks
.org 08514F18h
.area 4ACh
.incbin "data/rooms/S5-03-BG1.rlebg"
.endarea
.org 085145A8h
.area 212h
.incbin "data/rooms/S5-03-Clip.rlebg"
.endarea

; Sector 5 - Arctic Containment
; change the lv4 security door to crow's nest to a functional lv3 security door
.org 08516C61h
.area 687h
.incbin "data/rooms/S5-07-BG1.rlebg"
.endarea
.org 08516852h
.area 1AAh
.incbin "data/rooms/S5-07-Clip.rlebg"
.endarea

; Sector 5 - Data Room
; seal off the destroyed upper half of the data room from the intact lower half
.org 08519419h
.area 1A7h
.incbin "data/rooms/S5-10-BG1.rlebg"
.endarea
.org 085191A4h
.area 84h
.incbin "data/rooms/S5-10-Clip.rlebg"
.endarea

; Sector 5 - Security Shaft East
; repair the door to kago blockade
.org 0851AC8Ah
.area 306h
.incbin "data/rooms/S5-16-BG1.rlebg"
.endarea
.org 0851AA7Eh
.area 110h
.incbin "data/rooms/S5-16-Clip.rlebg"
.endarea

; Sector 5 - Ripper Road
; replace lv0 door to arctic containment with an open hatch
.org 0851BA76h
.area 1C2h
.incbin "data/rooms/S5-1A-BG1.rlebg"
.endarea
.org 0851B9C4h
.area 0A4h
.incbin "data/rooms/S5-1A-Clip.rlebg"
.endarea

; Sector 5 - Crow's Nest
; repair the door to arctic containment into a lv3 security door
.org 0851CC93h
.area 27Dh
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
.area 1F7h
.incbin "data/rooms/S6-1B-BG1.rlebg"
.endarea
.org 085553BAh
.area 0B5h
.incbin "data/rooms/S6-1B-Clip.rlebg"
.endarea
