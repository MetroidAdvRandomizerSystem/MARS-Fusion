; Enables the in-game debug menu, accessed via the Samus status screen.

.org 08076A2Eh
    mov     r0, r9
    strb    r0, [r4, #2]

; Graphics moved to src/randomizer/menu-edits.s
