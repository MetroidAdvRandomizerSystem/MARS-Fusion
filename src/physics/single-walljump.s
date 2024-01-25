; Allows Samus to turn around during a walljump while gaining height

.org 08007952h
	nop :: nop :: nop :: nop

; .org 08007960h
;	add		r0, (1 << Button_Up) | (1 << Button_Down)
;	and		r0, r3
