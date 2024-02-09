.gba
.open "metroid4.gba", "mfar.gba", 08000000h

.table "data/text.tbl"

; Assembly-time flags
.definelabel DEBUG, 1
.definelabel OPTIMIZE, 1
.definelabel QOL, 1
.definelabel PHYSICS, 0
.definelabel NONLINEAR, 1
.definelabel RANDOMIZER, 1

.definelabel ABILITY_FROM_TANK, 0

.include "inc/enums.inc"
.include "inc/functions.inc"
.include "inc/macros.inc"
.include "inc/structs.inc"

; Mark end-of-file padding as free space
.defineregion 0879ECC8h, 08800000h - 0879ECC8h, 0

; Debug mode patch
.if DEBUG
.notice "Applying debug patches..."
.include "src/debug.s"
.endif

; Optimization patches
; Patches intended to produce identical behavior to vanilla, but optimized
.if OPTIMIZE
.notice "Applying optimization patches..."
.include "src/optimization/item-check.s"
.endif

; Quality of life patches
; Patches providing non-essential but convenient features
.if QOL
.notice "Applying quality of life patches..."
.include "src/qol/completion-seconds.s"
.include "src/qol/fast-doors.s"
.include "src/qol/fast-elevators.s"
.include "src/qol/major-completion.s"
.include "src/qol/map-info.s"
.include "src/qol/maps-downloaded.s"
.include "src/qol/screw-unbonk.s"
.include "src/qol/skip-ending.s"
.include "src/qol/skip-intro.s"
.endif

; Physics patches
; Patches which alter Samus's movement physics
.if PHYSICS
.notice "Applying physics patches..."
.include "src/physics/air-momentum.s"
.include "src/physics/single-walljump.s"
.include "src/physics/speedkeep.s"
.endif

; Non-linearity patches
; Patches which mitigate or remove linear story restrictions
; Forced if randomizer flag is on
.if NONLINEAR || RANDOMIZER
.notice "Applying non-linearity patches..."
.include "src/nonlinear/common.s"
.include "src/nonlinear/beam-stacking.s"
.include "src/nonlinear/bosses.s"
.include "src/nonlinear/data-rooms.s"
; .include "src/nonlinear/event-spritesets.s"
.include "src/nonlinear/misc-progress.s"
.include "src/nonlinear/music.s"
.include "src/nonlinear/null-event.s"
.include "src/nonlinear/operations-room.s"
.include "src/nonlinear/security-unlock.s"
.include "src/nonlinear/story-flags.s"
.endif

; Randomizer patches
; Patches making randomization of the game possible
.if RANDOMIZER
.notice "Applying randomizer patches..."
.include "src/randomizer/disable-demos.s"
.include "src/randomizer/ship-warp.s"
.endif

.close
