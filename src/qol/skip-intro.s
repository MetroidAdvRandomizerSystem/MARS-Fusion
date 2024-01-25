; Skips the intro cutscene, starting from the first Adam dialogue instead.

.org 0808777Eh
	mov		r0, #12

; Unused functions after this patch:

; Intro state 2
.defineregion 0808A044h, 0ACh
.defineregion 08089AB4h, 248h
.defineregion 08089CFCh, 348h

; Intro state 3
.defineregion 0808ABD0h, 98h
.defineregion 0808A638h, 254h
.defineregion 0808A88Ch, 344h

; Intro state 4
.defineregion 08087DF0h, 0A0h
.defineregion 08087A04h, 264h
.defineregion 08087C68h, 188h

; Intro state 5
.defineregion 080881A4h, 9Ch
.defineregion 08087E90h, 1D8h
.defineregion 08088068h, 13Ch

; Intro state 6
.defineregion 08088CC8h, 9Ch
.defineregion 08088240h, 26Ch
.defineregion 080889B0h, 318h

; Intro state 7
.defineregion 0808E6D4h, 0A8h
.defineregion 0808DF30h, 210h
.defineregion 0808E140h, 594h

; Intro state 8
.defineregion 0808CF80h, 0DCh
.defineregion 0808C670h, 204h
.defineregion 0808C874h, 158h
.defineregion 0808CD0Ch, 274h

; Unused graphics after this patch:
.defineregion 085980B0h, 08598898h - 085980B0h
.defineregion 08598AACh, 085FFF08h - 08598AACh
