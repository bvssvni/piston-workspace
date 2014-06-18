#!/bin/bash

MAKE=make
if [ "$OS" == "Windows_NT" ]; then
	MAKE=mingw32-make
fi

CGMATH_RS_RLIB=libcgmath-13b4a6e6-0.1.rlib
GL_RS_RLIB=libgl-8febb75e-0.1.rlib
GLFW_RS_RLIB=libglfw-38369174-0.1.rlib
RUST_GRAPHICS_RLIB=libgraphics-587c2edd-0.0.rlib
RUST_IMAGE_RLIB=libimage-42438c15-0.0.rlib
RUST_SDL2_RLIB=libsdl2-79c1f430-0.0.1.rlib
RUST_SDL2_MIXER_RLIB=libsdl2_mixer-1aa14961-0.1.rlib
RUST_SDL2_TTF_RLIB=libsdl2_ttf-efbbd9b9-0.1.rlib
PISTON_RLIB=libpiston-a1b791b5-0.0.rlib

# Get current target platform.
TARGET=$(rustc --version | awk "/host:/ { print \$2 }")
echo $TARGET

# Get current directory.
CURRENT_DIR=$(pwd)
echo $CURRENT_DIR

# ==== PATHS ====

CGMATH_RS_RLIB_PATH="$CURRENT_DIR/cgmath-rs/lib/$CGMATH_RS_RLIB"
GL_RS_RLIB_PATH="$CURRENT_DIR/gl-rs/target/$TARGET/lib/$GL_RS_RLIB"
GLFW_RS_RLIB_PATH="$CURRENT_DIR/glfw-rs/target/$TARGET/lib/$GLFW_RS_RLIB"
RUST_GRAPHICS_RLIB_PATH="$CURRENT_DIR/rust-graphics/target/$TARGET/lib/$RUST_GRAPHICS_RLIB"
RUST_IMAGE_RLIB_PATH="$CURRENT_DIR/rust-image/target/$TARGET/lib/$RUST_IMAGE_RLIB"
RUST_SDL2_RLIB_PATH="$CURRENT_DIR/rust-sdl2/build/lib/$RUST_SDL2_RLIB"
RUST_SDL2_MIXER_RLIB_PATH="$CURRENT_DIR/rust-sdl2_mixer/target/$TARGET/lib/$RUST_SDL2_MIXER_RLIB"
RUST_SDL2_TTF_RLIB_PATH="$CURRENT_DIR/rust-sdl2_ttf/target/$TARGET/lib/$RUST_SDL2_TTF_RLIB"
PISTON_RLIB_PATH="$CURRENT_DIR/piston/target/$TARGET/lib/$PISTON_RLIB"

# ==== BUILDING ====

echo "--- Building rust-graphics"
cd rust-graphics
$MAKE clean
$MAKE
cd $CURRENT_DIR

echo "--- Building rust-image"
cd rust-image
$MAKE clean
$MAKE
cd $CURRENT_DIR

echo "--- Building cgmath-rs"
cd cgmath-rs
$MAKE clean
$MAKE
cd $CURRENT_DIR

echo "--- Building glfw-rs"
cd glfw-rs
$MAKE clean
$MAKE link && $MAKE -f rust-empty.mk
cd $CURRENT_DIR

echo "--- Building gl-rs"
cd gl-rs
$MAKE -f rust-empty.mk clean
$MAKE gen-lib && $MAKE -f rust-empty.mk
cd $CURRENT_DIR

echo "--- Building rust-sdl2"
cd rust-sdl2
$MAKE clean
$MAKE gen-lib
$MAKE -f rust-empty.mk
cd $CURRENT_DIR

# Add symlinks to rust-sdl2_mixer
mkdir -p rust-sdl2_mixer/target/$TARGET/lib/
rm -f "$CURRENT_DIR/rust-sdl2_mixer/target/$TARGET/lib/$RUST_SDL2_RLIB"
ln -s $RUST_SDL2_RLIB_PATH "$CURRENT_DIR/rust-sdl2_mixer/target/$TARGET/lib/$RUST_SDL2_RLIB"

echo "--- Building rust-sdl2_mixer"
cd rust-sdl2_mixer
$MAKE clean
$MAKE
cd $CURRENT_DIR

# Add symlinks to rust-sdl2_ttf
mkdir -p rust-sdl2_ttf/target/$TARGET/lib/
rm -f "$CURRENT_DIR/rust-sdl2_ttf/target/$TARGET/lib/$RUST_SDL2_RLIB"
ln -s $RUST_SDL2_RLIB_PATH "$CURRENT_DIR/rust-sdl2_ttf/target/$TARGET/lib/$RUST_SDL2_RLIB"

echo "--- Building rust-sdl2_ttf"
cd rust-sdl2_ttf
$MAKE clean
$MAKE
cd $CURRENT_DIR

# Add symlinks to hgl-rs.
mkdir -p hgl-rs/target/$TARGET/lib/
rm -f "$CURRENT_DIR/hgl-rs/target/$TARGET/lib/$GL_RS_RLIB"
ln -s $GL_RS_RLIB_PATH "$CURRENT_DIR/hgl-rs/target/$TARGET/lib/$GL_RS_RLIB"

echo "--- Building hgl-rs"
cd hgl-rs
$MAKE clean
$MAKE
cd $CURRENT_DIR

# Add symlinks to piston.
mkdir -p piston/target/$TARGET/lib
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$GL_RS_RLIB"
ln -s $GL_RS_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$GL_RS_RLIB"
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$GLFW_RS_RLIB"
ln -s $GLFW_RS_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$GLFW_RS_RLIB"
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_GRAPHICS_RLIB"
ln -s $RUST_GRAPHICS_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_GRAPHICS_RLIB"
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_IMAGE_RLIB"
ln -s $RUST_IMAGE_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_IMAGE_RLIB"
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_RLIB"
ln -s $RUST_SDL2_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_RLIB"
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_MIXER_RLIB"
ln -s $RUST_SDL2_MIXER_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_MIXER_RLIB"
rm -f "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_TTF_RLIB"
ln -s $RUST_SDL2_TTF_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_TTF_RLIB"

echo "--- Building piston"
cd piston
$MAKE clean
$MAKE
cd $CURRENT_DIR

# Add symlinks to piston-symlinks.
mkdir -p piston-symlinks
rm -f "$CURRENT_DIR/piston-symlinks/$CGMATH_RS_RLIB"
ln -s $CGMATH_RS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$CGMATH_RS_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$GL_RS_RLIB"
ln -s $GL_RS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$GL_RS_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$GLFW_RS_RLIB"
ln -s $GLFW_RS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$GLFW_RS_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$RUST_GRAPHICS_RLIB"
ln -s $RUST_GRAPHICS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_GRAPHICS_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$RUST_IMAGE_RLIB"
ln -s $RUST_IMAGE_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_IMAGE_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_RLIB"
ln -s $RUST_SDL2_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_MIXER_RLIB"
ln -s $RUST_SDL2_MIXER_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_MIXER_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_TTF_RLIB"
ln -s $RUST_SDL2_TTF_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_TTF_RLIB"
rm -f "$CURRENT_DIR/piston-symlinks/$PISTON_RLIB"
ln -s $PISTON_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$PISTON_RLIB"

