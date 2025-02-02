; Repointing Vanilla Pause Screen OAM Data so that we can append to the list


; TODO: Bug Hunting: For some reason, having this as an autoregion crashes the game.
; This seems to overwrite some defined free space region which causes popping a
; zero value (00h) into R15/PC

; TODO: See if we can force armips to error if null pointers are in this table
; Note: If you are adding more OAM sprites to this table, be sure to do the following:
; 1. MenuSpriteGfx_Size in enums.inc
; 2. Set the pointer for your new gfx to the index of this table such that it overwrites
;    the null pointer generated below. Failure to do this may result in a crash.
.org 0879EE00h
.area (MenuSpriteGfx_Size + 1) * 4, 0
.align 4
PauseScreenOamData:
.incbin "metroid4.gba", VanillaPauseScreenOamData & 7FFFFFh, 230h
.fill (MenuSpriteGfx_Size * 4) - (. - PauseScreenOamData), 0
.endarea


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
