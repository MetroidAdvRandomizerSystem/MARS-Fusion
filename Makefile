IN ?= metroid4
OUT ?= mfar

AS := ./armips-a8c277c.exe
AS_FLAGS += -strequ @@file $(IN).gba -strequ @@out $(OUT).gba

all: $(OUT).gba

$(OUT).gba: check $(IN).gba
	$(AS) src/main.s

check: $(IN).gba
	md5sum -c $(IN).md5

stat: $(IN).gba
	$(AS) src/main.s -stat

clean:
	$(RM) $(OUT).gba

.PHONY: all check clean
.INTERMEDIATE: $(OBJS)
