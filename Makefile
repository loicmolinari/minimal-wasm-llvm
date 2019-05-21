CC             = clang-8
CC_FLAGS       = -cc1 -triple=wasm32-unknown-unknown-wasm -emit-llvm -std=c11 -fvisibility hidden
LLC            = llc
LLC_FLAGS      = -filetype=obj $(LC_FLAGS_CFG)
WAT2WASM       = wat2wasm
WAT2WASM_FLAGS = --relocatable
LD             = wasm-ld
LD_FLAGS       = --no-entry --export-dynamic

%.bc: %.c
	$(CC) $(CC_FLAGS) $< -o $@

%.o: %.bc
	$(LLC) $(LLC_FLAGS) $< -o $@

%.o: %.wat
	$(WAT2WASM) $(WAT2WASM_FLAGS) $< -o $@

%.wasm: a.o b.o c.o
	$(LD) $(LD_FLAGS) $^ -o $@
	chmod a-x $@

all: module.wasm

.PRECIOUS: a.o b.o c.o
