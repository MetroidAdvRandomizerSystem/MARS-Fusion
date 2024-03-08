; Converts floating-point arithmetic to fixed-point for calculating the size
; of a power bomb explosion. Saves an average of 10050 cycles per frame.

.org 08068130h
.area 28h
    ; In vanilla, the game mutiplies by 0.95 using floating-point arithmetic.
    ; Instead, we can used fixed-point multiplication with 243/256, which
    ; equals 0.949219 for an error of 0.000781 (0.0822%)
    mov     r1, 243
    bl      FixedPointMultiply
    mov     r8, r0
    mov     r0, r6
    mov     r1, 243
    bl      FixedPointMultiply
    b       08068158h
.endarea
