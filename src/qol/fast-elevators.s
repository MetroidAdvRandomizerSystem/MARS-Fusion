; Doubles the speed of elevators.

.org 08009BFCh
    ; Elevator up speed
    mov     r0, #8

.org 08009C0Ch
    ; Elevator down speed
    .dh     -8
