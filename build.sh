#!/bin/bash

GL_RS_RLIB=libgl-8febb75e-0.1.rlib
GLFW_RS_RLIB=libglfw-38369174-0.1.rlib
RUST_GRAPHICS_RLIB=libgraphics-587c2edd-0.0.rlib
RUST_PNG_RLIB=libpng-1a4a27fd-0.1.rlib
RUST_SDL2_RLIB=libsdl2-79c1f430-0.0.1.rlib
PISTON_RLIB=libpiston-a1b791b5-0.0.rlib

# Fetch data from submodule repositories.
git submodule init
git submodule update

# Get current target platform.
TARGET=$(rustc --version | awk "/host:/ { print \$2 }")
echo $TARGET

# Get current directory.
CURRENT_DIR=$(pwd)
echo $CURRENT_DIR

# ==== PATHS ====

GL_RS_RLIB_PATH="$CURRENT_DIR/gl-rs/lib/$GL_RS_RLIB"
GLFW_RS_RLIB_PATH="$CURRENT_DIR/glfw-rs/lib/$GLFW_RS_RLIB"
RUST_GRAPHICS_RLIB_PATH="$CURRENT_DIR/rust-graphics/target/$TARGET/lib/$RUST_GRAPHICS_RLIB"
RUST_PNG_RLIB_PATH="$CURRENT_DIR/rust-png/target/$TARGET/lib/$RUST_PNG_RLIB"
RUST_SDL2_RLIB_PATH="$CURRENT_DIR/rust-sdl2/build/lib/$RUST_SDL2_RLIB"
PISTON_RLIB_PATH="$CURRENT_DIR/piston/target/$TARGET/lib/$PISTON_RLIB"

# ==== BUILDING ====

echo "--- Building rust-graphics"
cd rust-graphics
make clean
make
cd $CURRENT_DIR

echo "--- Building rust-png"
cd rust-png
make clean
make
cd $CURRENT_DIR

echo "--- Building glfw-rs"
cd glfw-rs
make clean
make
cd $CURRENT_DIR

echo "--- Building gl-rs"
cd gl-rs
make clean
make
cd $CURRENT_DIR

echo "--- Building rust-sdl2"
cd rust-sdl2
make clean
make
cd $CURRENT_DIR

# Add symlinks to hgl-rs.
mkdir -p hgl-rs/target/$TARGET/lib/
ln -s $GL_RS_RLIB_PATH "$CURRENT_DIR/hgl-rs/target/$TARGET/lib/$GL_RS_RLIB"

echo "--- Building hgl-rs"
cd hgl-rs
make clean
make
cd $CURRENT_DIR

# Add symlinks to piston.
mkdir -p piston/target/$TARGET/lib
ln -s $GL_RS_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$GL_RS_RLIB"
ln -s $GLFW_RS_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$GLFW_RS_RLIB"
ln -s $RUST_GRAPHICS_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_GRAPHICS_RLIB"
ln -s $RUST_PNG_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_PNG_RLIB"
ln -s $RUST_SDL2_RLIB_PATH "$CURRENT_DIR/piston/target/$TARGET/lib/$RUST_SDL2_RLIB"

cd piston
make clean
make
cd $CURRENT_DIR

# Add symlinks to piston-symlinks.
mkdir -p piston-symlinks
ln -s $GL_RS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$GL_RS_RLIB"
ln -s $GLFW_RS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$GLFW_RS_RLIB"
ln -s $RUST_GRAPHICS_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_GRAPHICS_RLIB"
ln -s $RUST_PNG_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_PNG_RLIB"
ln -s $RUST_SDL2_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$RUST_SDL2_RLIB"
ln -s $PISTON_RLIB_PATH "$CURRENT_DIR/piston-symlinks/$PISTON_RLIB"

