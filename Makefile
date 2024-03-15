IN ?= metroid4
BASE := base
OUT := m4rs

OBJ_DIR := ./obj
DEMO_DIR := ./src/demos
DEMO_FILES := $(wildcard $(DEMO_DIR)/demo-*.s)

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

$(DEMO_DIR)/demos-combined.s: $(DEMO_FILES)
	cat $(DEMO_FILES) >> $@

clean:
	$(RM) $(OBJ_DIR)/*
	$(RM) $(OUT).gba
	echo -n "" > $(DEMO_DIR)/demos-combined.s

.PHONY: all check clean $(DEMO_DIR)/demos-combined.s
.INTERMEDIATE: $(OBJS)
