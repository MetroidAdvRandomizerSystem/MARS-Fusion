; Repointing Vanilla Pause Screen OAM Data so that we can append to the list

; TODO: See if we can force armips to error if null pointers are in this table
; Note: If you are adding more OAM sprites to this table, be sure to do the following:
; 1. MenuSpriteGfx_Size in enums.inc
; 2. Set the pointer for your new gfx to the index of this table such that it overwrites
;    the null pointer generated below. Failure to do this may result in a crash.
.autoregion
.align 4
PauseScreenOamData:
; Vanilla OAM Pointers
.incbin "metroid4.gba", VanillaPauseScreenOamData & 7FFFFFh, 230h

.org PauseScreenOamData + (MenuSpriteGfx_SelectMapChange * 4)
    .dw     @SelectMapChangeOamDataPointers

.org PauseScreenOamData + (MenuSpriteGfx_Lv0Locked * 4)
    .dw     @Lv0LockedOamDataPointers

.org PauseScreenOamData + (MenuSpriteGfx_Lv0Unlocked * 4)
    .dw     @Lv0UnlockedOamDataPointers
.endautoregion


; Replace Vanilla references to PauseScreenOamData
.org 08078A5Ch
.area 4
    .dw PauseScreenOamData
.endarea
.org 08078904h
.area 4
    .dw PauseScreenOamData
.endarea
.org 08078890h
.area 4
    .dw PauseScreenOamData
.endarea
.org 0807883Ch
.area 4
    .dw PauseScreenOamData
.endarea
.org 080787E8h
.area 4
    .dw PauseScreenOamData
.endarea
.org 0807876Ch
.area 4
    .dw PauseScreenOamData
.endarea
.org 08078700h
.area 4
    .dw PauseScreenOamData
.endarea
.org 080786ACh
.area 4
    .dw PauseScreenOamData
.endarea


; Add vanilla pause OAM Data to free space
.defineregion 0856F71Ch, 352Dh, 0

.autoregion
@PauseScreenObjGfx:
.incbin "data/pause-obj.gfx"
.endautoregion
.org PauseScreenGfxOamPointer
    .dw @PauseScreenObjGfx


; OAM Data Format
; See: https://problemkaputt.de/gbatek-lcd-obj-oam-attributes.htm for details
; .dh Number of objects
; .dh ObjAttr0
; .dh ObjAttr1
; .dh ObjAttr2
; ... Repeat for as many objects in the frame
; X/Y Coords are offsets of the coordinates set with initial positioning
; Negatives are 2's compliment
; Y Coord is caluclated as (OamYPosition + 4 + InitialPosition)
; X Coord is calculated as
;    ((*pauVar6)[1] & 0xfe00 | InitialPosition + OamXPosition + 4 & 0x1ff)
;    this seems to roughly be (InitialPosition + OamXPosition + 4) & 01FFh, but
;    does not seem to always calculate to this.


;; OAM DATA
; Select to Change Map
.autoregion
    .aligna 2
@SelectMapChangeOamData:
    .dh     4
    ; 2x2 Select Button Graphic
    .dh     (OBJ0_YCoordinate & 007h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 007h) | OBJ1_Size_16x16
    .dh     (OBJ2_Character   & 3BEh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 00Bh) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 010h) | OBJ1_Size_32x8
    .dh     (OBJ2_Character   & 377h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 012h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 002h) | OBJ1_Size_32x8
    .dh     (OBJ2_Character   & 3B8h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 012h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 022h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 3BCh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)
.endautoregion

; Level 0 Security Locked/Unlocked
.autoregion
@Lv0LockedOamData:
    .dh 3
    ; L0 Sprite
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 1E8h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 0C0h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 1F8h) | OBJ1_Size_8x8
    .dh     (OBJ2_Character   & 0C2h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    ; lock Text
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 000h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 1CCh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

@Lv0UnlockedOamData:
    .dh 3
    ; L0 Sprite
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 1E8h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 1B0h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 1F8h) | OBJ1_Size_8x8
    .dh     (OBJ2_Character   & 1B2h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    ; Open Text
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 000h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 1ECh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)
.endautoregion


; OAM Data Pointer Format
; .dw Pointer, Timer (in frames, specify 0FFh for no animation)
; repeat above for each frame
; .dd 0 ; mark end with null DWORD
.autoregion
    .aligna 4
@SelectMapChangeOamDataPointers:
    .dw     @SelectMapChangeOamData
    .dw     0FFh
    .dd     0
@Lv0LockedOamDataPointers:
    .dw     @Lv0LockedOamData
    .dw     0FFh
    .dd     0
@Lv0UnlockedOamDataPointers:
    .dw     @Lv0UnlockedOamData
    .dw     0FFh
    .dd     0
.endautoregion
