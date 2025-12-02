.PHONY: build clean configure

export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

configure:
	cmake -S . -B build -DwxWidgets_ROOT_DIR="${HOME}/.local/wxwidgets/linux-cmake-wx-3.3.1"

build:
	cmake --build build

run:
	cmake --build build --target run

deploy: configure build run

clean:
	rm -rf build
