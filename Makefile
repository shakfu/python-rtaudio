.PHONY: cmake clean test debug memtest

all: cmake

cmake:
	@mkdir -p build && cd build && cmake .. && make

test:
	@echo "testing"
	@mkdir -p build && cd build && cmake .. -DBUILD_TESTS=1 && make

clean:
	@rm -rf build

memtest:
	@mkdir -p build
	@cp tests/test_rtaudio_m.py build/
	@cd build && PYTHONMALLOC=debug PYTHONTRACEMALLOC=1 python3 test_rtaudio_m.py

debug: clean
	@mkdir -p build && cd build && cmake .. -DDEBUG=ON && make

test-rtaudio:
	@cd build && PYTHONMALLOC=debug PYTHONTRACEMALLOC=1 \
		../python/bin/python3.11d -c "import rtaudio;a=rtaudio.RtAudio()"
