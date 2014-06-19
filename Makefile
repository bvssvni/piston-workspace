target = $(shell rustc --version 2> /dev/null | awk "/host:/ { print \$$2 }")

gl_rs_path=$(shell pwd)/gl-rs
glfw_rs_path=$(shell pwd)/glfw-rs
rust_graphics_path=$(shell pwd)/rust-graphics
rust_image_path=$(shell pwd)/rust-image
rust_sdl2_path=$(shell pwd)/rust-sdl2
rust_sdl2_mixer_path=$(shell pwd)/rust-sdl2_mixer
rust_sdl2_ttf_path=$(shell pwd)/rust-sdl2_ttf
cgmath_rs_path=$(shell pwd)/cgmath-rs
rust_portaudio_path=$(shell pwd)/rust-portaudio
piston_path=$(shell pwd)/piston
symlinks_path=$(shell pwd)/piston-symlinks

gl_rs=$(gl_rs_path)/lib/libgl-8febb75e-0.1.rlib
glfw_rs=$(glfw_rs_path)/lib/libglfw-38369174-0.1.rlib
rust_graphics=$(rust_graphics_path)/target/$(target)/lib/libgraphics-587c2edd-0.0.rlib
rust_image=$(rust_image_path)/target/$(target)/lib/libimage-42438c15-0.0.rlib
rust_sdl2=$(rust_sdl2_path)/build/lib/libsdl2-79c1f430-0.0.1.rlib
rust_sdl2_mixer=$(rust_sdl2_mixer_path)/target/$(target)/lib/libsdl2_mixer-1aa14961-0.1.rlib
rust_sdl2_ttf=$(rust_sdl2_ttf_path)/target/$(target)/lib/libsdl2_ttf-efbbd9b9-0.1.rlib
cgmath_rs=$(cgmath_rs_path)/lib/libcgmath-13b4a6e6-0.1.rlib
rust_portaudio=$(rust_portaudio_path)/lib/libportaudio-896aa06e-0.1.rlib
piston=$(piston_path)/target/$(target)/lib/libpiston-a1b791b5-0.0.rlib

all: piston;
	@echo "--- Creating symlink path ---"
	mkdir -p $(symlinks_path)
	@echo "--- Removing symlinks if they exist ---"
	rm -f $(symlinks_path)/*
	@echo "--- Linking libs ---"
	ln -s $(gl_rs) $(glfw_rs) $(rust_graphics) $(rust_image) $(rust_sdl2) $(rust_sdl2_mixer) $(rust_sdl2_ttf) $(cgmath_rs) $(rust_portaudio) $(piston) $(symlinks_path)

gl_rs: $(gl_rs)

$(gl_rs):
	@echo "--- Building gl-rs ---"
	cd $(gl_rs_path); $(MAKE)

glfw_rs: $(glfw_rs)

$(glfw_rs):
	@echo "--- Building glfw-rs ---"
	cd $(glfw_rs_path); $(MAKE)

rust_graphics: $(rust_graphics)

$(rust_graphics):
	@echo "--- Building rust-graphics ---"
	cd $(rust_graphics_path); $(MAKE)

rust_image: $(rust_image)

$(rust_image):
	@echo "--- Building rust-image ---"
	cd $(rust_image_path); $(MAKE)

rust_sdl2: $(rust_sdl2)

$(rust_sdl2):
	@echo "--- Building rust-sld2 ---"
	cd $(rust_sdl2_path); $(MAKE) gen-lib && $(MAKE) -f rust-empty.mk

rust_sdl2_mixer: $(rust_sdl2_mixer)

$(rust_sdl2_mixer): $(rust_sdl2);
	@echo "--- Building rust-sld2-mixer ---"
	rm -f $(rust_sdl2_mixer_path)/target/$(target)/lib/*.rlib
	mkdir -p $(rust_sdl2_mixer_path)/target/$(target)/lib/
	ln -s $(rust_sdl2) $(rust_sdl2_mixer_path)/target/$(target)/lib/
	cd $(rust_sdl2_mixer_path); $(MAKE)

rust_sdl2_ttf: $(rust_sdl2_ttf)

$(rust_sdl2_ttf) : $(rust_sdl2);
	@echo "--- Building rust-sld2-ttf ---"
	rm -f $(rust_sdl2_ttf_path)/target/$(target)/lib/*.rlib
	mkdir -p $(rust_sdl2_ttf_path)/target/$(target)/lib/
	ln -s $(rust_sdl2) $(rust_sdl2_ttf_path)/target/$(target)/lib/
	cd $(rust_sdl2_ttf_path); $(MAKE)

cgmath_rs: $(cgmath_rs)

$(cgmath_rs):
	@echo "--- Building cgmath-rs ---"
	cd $(cgmath_rs_path); $(MAKE)

rust_portaudio: $(rust_portaudio)

$(rust_portaudio):
	@echo "--- Building rust-portaudio ---"
	cd $(rust_portaudio_path); $(MAKE)

piston: $(piston)

$(piston): gl_rs glfw_rs rust_graphics rust_image rust_sdl2 rust_sdl2_mixer rust_sdl2_ttf;
	@echo "--- Building piston ---"
	rm -f $(piston_path)/target/$(target)/lib/*.rlib
	mkdir -p $(piston_path)/target/$(target)/lib/
	ln -s $(gl_rs) $(glfw_rs) $(rust_graphics) $(rust_image) $(rust_sdl2) $(rust_sdl2_mixer) $(rust_sdl2_ttf) $(cgmath_rs) $(rust_portaudio) $(piston_path)/target/$(target)/lib/
	cd $(piston_path); $(MAKE) clean; $(MAKE) lib

clean:
	@echo "--- cleaning up ---"
	cd $(gl_rs_path); $(MAKE) clean; cd -;
	cd $(glfw_rs_path); $(MAKE) clean; cd -;
	cd $(rust_graphics_path); $(MAKE) clean; cd -;
	cd $(rust_image_path); $(MAKE) clean; cd -;
	cd $(rust_sdl2_path); $(MAKE) clean; cd -;
	cd $(rust_sdl2_mixer_path); $(MAKE) clean; cd -;
	cd $(rust_sdl2_ttf_path); $(MAKE) clean; cd -;
	cd $(cgmath_rs_path); $(MAKE) clean; cd -;
	cd $(rust_portaudio_path); $(MAKE) clean; cd -;
	cd $(piston_path); $(MAKE) clean; cd -;

.PHONY: all gl_rs glfw_rs rust_graphics rust_image rust_sdl2 rust_sdl2_mixer rust_sdl2_ttf cgmath_rs piston clean
