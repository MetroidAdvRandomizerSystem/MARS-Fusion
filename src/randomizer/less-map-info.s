; Permanently hides sector completion info from the map screen to prevent any
; spoilers from counting tanks.

.org 08075E70h
.region 44h
    b       08075EB4h
.endregion

.org 08075F40h
.area 10h, 0
    b       080761B4h
.endarea
    .skip 18h
.region 24Ch, 0
.endregion

.org 08077FA0h
    nop :: nop

.org 0807801Ah
.region 0C4h
    b       08077F76h
.endregion
