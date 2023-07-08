CC := emcc
CFLAGS := -Wall -Wextra -Iinclude -O3 --no-entry -Wno-deprecated-declarations -Wno-deprecated-pragma -Wunused-command-line-argument -s EXPORTED_FUNCTIONS='["_mi_malloc","_malloc","free"]' -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall","cwrap"]' -s TOTAL_MEMORY=67108864 -s ALLOW_MEMORY_GROWTH=1 #-s DEMANGLE_SUPPORT=1 -g 
OUT_DIR := build

SRCS := src/alloc.c \
	src/alloc-aligned.c \
	src/alloc-posix.c \
	src/arena.c \
	src/bitmap.c \
	src/heap.c \
	src/init.c \
	src/options.c \
	src/os.c \
	src/page.c \
	src/random.c \
	src/segment.c \
	src/segment-map.c \
	src/stats.c \
	src/prim/wasi/prim.c
#	src/prim/window/prim.c

OBJS := $(patsubst src/%.c, $(OUT_DIR)/src/%.o, $(SRCS))
TARGET := mimalloc_wasm

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@

$(OUT_DIR)/src/%.o: src/%.c
	mkdir -p $(dir $@) # Create the directory if it does not exist
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OUT_DIR)
	rm mimalloc_wasm
	rm mimalloc_wasm.wasm
