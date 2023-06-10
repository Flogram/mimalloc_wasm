CC := emcc
CFLAGS := -Wall -Wextra -Iinclude -O3 -Wno-deprecated-declarations -Wno-deprecated-pragma

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

OBJS := $(patsubst src/%.c, src/%.o, $(SRCS))
TARGET := mimalloc_wasm

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)
