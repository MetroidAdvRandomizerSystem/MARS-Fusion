.gba
.open "metroid4.gba", "reset-to-save.gba", 08000000h

.include "inc/constants.inc"
.include "inc/enums.inc"
.include "inc/functions.inc"
.include "inc/macros.inc"
.include "inc/structs.inc"

.defineregion 08012F8Ch, 25Ch, 00h

.autoregion
    .align 2
.func AutoReloadSave
    push    { r4-r5, lr }
    ldr     r4, =GameMode
    ldrh    r0, [r4]
    cmp     r0, #GameMode_Title
    beq     @@reset
    cmp     r0, #GameMode_FileSelect
    beq     @@reset
    cmp     r0, #GameMode_Demo
    bne     @@reload
@@reset:
    mov     r0, #GameMode_SoftReset
    strh    r0, [r4]
    b       @@exit
@@reload:
    bl      08080968h
    cmp     r0, #0
    beq     @@intro
    mov     r0, #GameMode_InGame
    strh    r0, [r4]
    mov     r0, #0
    ldr     r1, =SubGameMode1
    strh    r0, [r1]
    ldr     r1, =SubGameMode2
    strb    r0, [r1]
    ldr     r1, =NonGameplayFlag
    strb    r0, [r1]
    b       @@reinit_audio
@@intro:
    mov     r0, #GameMode_FileSelect
    strh    r0, [r4]
    ldr     r1, =SubGameMode2
    mov     r0, #1
    strb    r0, [r1]
    mov     r0, #0
    ldr     r1, =SubGameMode1
    strh    r0, [r1]
    ldr     r1, =NonGameplayFlag
    strb    r0, [r1]
@@reinit_audio:
    ldr     r5, =04000082h
    ldrh    r4, [r5]
    bl      InitializeAudio
    strh    r4, [r5]
@@exit:
    pop     { r4-r5, pc }
    .pool
.endfunc
.endautoregion

.org 080008D4h
.area 04h
    bl      AutoReloadSave
.endarea

.close
