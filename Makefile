IN ?= metroid4
BASE := base
OUT := m4rs

OBJ_DIR := ./obj

FLIPS := ./tools/flips.exe
AS := ./tools/armips-a8d71f0.exe

all: $(OUT).gba

$(OBJ_DIR):
	mkdir $@

$(OBJ_DIR)/$(BASE).gba: $(IN).gba $(OBJ_DIR)
	$(FLIPS) -a data/room-edits.bps $< $@

$(OUT).gba: check $(OBJ_DIR)/$(BASE).gba
	$(AS) src/main.s

check: $(IN).gba
	md5sum -c $(IN).md5

dist: $(IN).gba $(OUT).gba
	$(FLIPS) -c $^ $(OUT).bps

stat: $(IN).gba
	$(AS) src/main.s -stat

clean:
	$(RM) $(OBJ_DIR)/*
	$(RM) $(OUT).gba

.PHONY: all check clean
.INTERMEDIATE: $(OBJS)
