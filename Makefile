CC             = clang-8
CC_FLAGS       = -cc1 -triple=wasm32-unknown-unknown-wasm -emit-llvm -std=c11 -fvisibility hidden
LLC            = llc
LLC_FLAGS      = -filetype=obj
WAT2WASM       = wat2wasm
WAT2WASM_FLAGS = --relocatable
LD             = wasm-ld
LD_FLAGS       = --no-entry --export-dynamic

%.bc: %.c
	$(CC) $(CC_FLAGS) $< -o $@

%.obj: %.bc
	$(LLC) $(LLC_FLAGS) $< -o $@

%.obj: %.wat
	$(WAT2WASM) $(WAT2WASM_FLAGS) $< -o $@

%.wasm: a.obj b.obj c.obj
	$(LD) $(LD_FLAGS) $^ -o $@
	chmod a-x $@

all: module.wasm

clean:
	rm -f *.obj *.wasm

.PRECIOUS: a.obj b.obj c.obj
