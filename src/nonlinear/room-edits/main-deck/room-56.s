; Yakuza Arena
; Changes: Remove BG0, so that the open exit is always visible
.org MainDeckLevels + 56h * LevelMeta_Size + LevelMeta_Bg0Properties
    .db     0
.org MainDeckLevels + 56h * LevelMeta_Size + LevelMeta_Bg0
    .dw     NullBg
