IN ?= metroid4
BASE ?= base
OUT ?= mfar

FLIPS := ./tools/flips.exe
AS := ./tools/armips-a8d71f0.exe

all: $(OUT).gba

$(BASE).gba: $(IN).gba
	$(FLIPS) -a data/room-edits.bps metroid4.gba $(BASE).gba

$(OUT).gba: check $(BASE).gba
	$(AS) src/main.s

check: $(IN).gba
	md5sum -c $(IN).md5

stat: $(IN).gba
	$(AS) src/main.s -stat

clean:
	$(RM) $(BASE).gba
	$(RM) $(OUT).gba

.PHONY: all check clean
.INTERMEDIATE: $(OBJS)
