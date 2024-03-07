.gba
.open "obj/base.gba", "m4rs.gba", 08000000h

.table "data/text.tbl"

; Assembly-time flags
.definelabel DEBUG, 1
.definelabel OPTIMIZE, 1
.definelabel QOL, 1
.definelabel PHYSICS, 0
.definelabel NONLINEAR, 1
.definelabel RANDOMIZER, 1

.definelabel ABILITY_FROM_TANK, 0
.definelabel BOMBLESS_PBS, 1

.include "inc/constants.inc"
.include "inc/enums.inc"
.include "inc/functions.inc"
.include "inc/macros.inc"
.include "inc/structs.inc"

StartingItems equ 0828D2ACh
HintTargets equ 085766ECh
ReservedSpace equ 087FE000h
ReservedSpace_Len equ 1000h
MinorLocations equ 087FF000h
MinorLocations_Len equ 100
MajorLocations equ 087FF200h
MajorLocations_Len equ 21
TankIncrements equ 087FF220h
RequiredMetroidCount equ 087FF227h
StartingLocation equ 087FF228h

; Mark end-of-file padding as free space
@@EOF equ 0879F87Ch ; 0879ECC8h
.defineregion @@EOF, ReservedSpace - @@EOF, 0FFh

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
.elseif RANDOMIZER
.include "src/optimization/item-check.s"
.endif

; Quality of life patches
; Patches providing non-essential but convenient features
.if QOL
.notice "Applying quality of life patches..."
.include "src/qol/completion-seconds.s"
.include "src/qol/cross-sector-maps.s"
.include "src/qol/fast-doors.s"
.include "src/qol/fast-elevators.s"
.include "src/qol/map-info.s"
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
.include "src/nonlinear/demos.s"
.include "src/nonlinear/room-states.s"
.include "src/nonlinear/main-missiles.s"
.include "src/nonlinear/major-completion.s"
.include "src/nonlinear/messages.s"
.include "src/nonlinear/misc-progress.s"
.include "src/nonlinear/missile-stacking.s"
.include "src/nonlinear/music.s"
.include "src/nonlinear/new-game-init.s"
.include "src/nonlinear/null-event.s"
.include "src/nonlinear/operations-room.s"
.include "src/nonlinear/security-unlock.s"
.include "src/nonlinear/split-suits.s"
.include "src/nonlinear/story-flags.s"

.if !DEBUG
.include "src/nonlinear/item-select.s"
.endif
.if BOMBLESS_PBS
.include "src/nonlinear/bombless-pbs.s"
.endif
.endif

; Randomizer patches
; Patches making randomization of the game possible
.if RANDOMIZER
.notice "Applying randomizer patches..."
.include "src/randomizer/hints.s"
.include "src/randomizer/less-map-info.s"
.include "src/randomizer/start-warp.s"
.include "src/randomizer/start-location.s"
.include "src/randomizer/tank-majors.s"
.endif

.close
