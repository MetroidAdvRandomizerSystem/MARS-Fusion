; Overgrown Checkpoint

; Make 3rd scroll 2 blocks taller and move 1 block to right so that the
; missile block is visible from below
.org readptr(Sector2Scrolls + 15h * 4) + ScrollList_HeaderSize + Scroll_Size * 2
.area Scroll_Size
    .db     12h, 20h
    .db     09h, 15h
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea
