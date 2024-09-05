IN ?= metroid4
OUT := m4rs

OBJ_DIR := ./obj
BIN_DIR := ./bin

ifeq ($(OS),Windows_NT)
	FLIPS := ./tools/flips.exe
	AS := ./tools/armips-a8d71f0.exe
else
	# Assume unix just has it in PATH
	FLIPS := flips
	AS := armips
endif

OPTIONALS := bombless_pbs
OPTIONALS += missiles_without_mains
OPTIONALS += anti_softlock
OPTIONALS += unhidden_map

OBJS := $(OPTIONALS:%=$(OBJ_DIR)/%.gba)
PATCHES := $(OPTIONALS:%=$(BIN_DIR)/%.ips)

all: $(BIN_DIR)/m4rs.gba

$(OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

$(BIN_DIR)/$(OUT).gba: check | $(BIN_DIR)
	$(AS) src/main.s
	cp $(OBJ_DIR)/$(OUT).gba $@

$(OBJ_DIR)/base.gba: $(BIN_DIR)/$(OUT).gba | $(OBJ_DIR)
	cp $< $@

$(OBJ_DIR)/%.gba: check | $(OBJ_DIR)
	$(AS) -definelabel $* 1 src/main.s
	mv $(OBJ_DIR)/$(OUT).gba $@

$(BIN_DIR)/%.ips: $(OBJ_DIR)/%.gba $(OBJ_DIR)/base.gba
	$(FLIPS) -c $(OBJ_DIR)/base.gba $< $@

$(BIN_DIR)/$(OUT).bps: $(OBJ_DIR)/base.gba
	$(FLIPS) -c $(IN).gba $< $@

check: $(IN).gba
	md5sum -c $(IN).md5

dist: $(PATCHES) $(BIN_DIR)/$(OUT).bps

clean:
	$(RM) $(OBJ_DIR)/*
	$(RM) $(BIN_DIR)/*

.PHONY: all check clean dist
.INTERMEDIATE: $(OBJS)
