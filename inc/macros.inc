; zero extend halfword, backported from ARMv6
.macro uxth, dst, src
    lsl     dst, src, #10h
    lsr     dst, #10h
.endmacro

; zero extend byte, backported from ARMv6
.macro uxtb, dst, src
    lsl     dst, src, #18h
    lsr     dst, #18h
.endmacro

; sign extend halfword, backported from ARMv6
.macro sxth, dst, src
    lsl     dst, src, #10h
    asr     dst, #10h
.endmacro

; sign extend byte, backported from ARMv6
.macro sxtb, dst, src
    lsl     dst, src, #18h
    asr     dst, #18h
.endmacro

; unsigned bit field extract, backported from ARMv6
.macro ubfx, dst, src, lsb, width
    lsl     dst, src, 20h - width - lsb
    lsr     dst, 20h - width
.endmacro

; signed bit field extract, backported from ARMv6
.macro sbfx, dst, src, lsb, width
    lsl     dst, src, 20h - width - lsb
    asr     dst, 20h - width
.endmacro

; branch with link and exchange, backported from ARMv5
.macro blx, reg
    mov     lr, reg
    bl      lr
.endmacro

; create an RGB555 color from an RGB888 hex code
.expfunc color(hex), (((hex & 0FFh) * 31 / 255) << 10) \
    | (((hex >> 8h & 0FFh) * 31 / 255) << 5) \
    | ((hex >> 10h) * 31 / 255)

.expfunc pop(int), (int > 0) ? (int & 1) + pop(int >> 1) : 0
.expfunc log2(int), (int > 1) ? 1 + log2(int >> 1) : 0

; formulas for fixed-point reciprocals for division by constants
; d = denominator, p = power of 2 of numerator
.expfunc unsigned_reciprocal(d, p), ((1 << p) - 1) / d + 1
.expfunc signed_reciprocal(d, p), (1 << p) / d + 1

; read pointer from source file
.expfunc readptr(pos), readu32("metroid4.gba", pos & 0xFFFFFF)
.expfunc readhword(pos), readu16("metroid4.gba", pos & 0xFFFFFF)
