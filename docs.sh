
CURRENT_DIR=$(pwd)
echo $CURRENT_DIR

rm -rf "docs"
mkdir -p "docs"

echo "--- rust-graphics"
cd rust-graphics
make doc
cp -a doc ../docs/rust-graphics
cd $CURRENT_DIR

echo "--- piston"
cd piston
make doc
cp -a doc ../docs/piston
cd $CURRENT_DIR

echo "--- rust-image"
cd rust-image
make doc
cp -a doc ../docs/rust-image
cd $CURRENT_DIR

echo "--- rust-sdl2"
cd rust-sdl2
rustdoc src/sdl2/lib.rs
cp -a doc ../docs/rust-sdl2
cd $CURRENT_DIR

echo "--- rust-sdl2_mixer"
cd rust-sdl2_mixer
make doc
cp -a doc ../docs/rust-sdl2_mixer
cd $CURRENT_DIR

echo "--- glfw-rs"
cd glfw-rs
make doc
cp -a doc ../docs/glfw-rs
cd $CURRENT_DIR

echo "--- gl-rs"
cd gl-rs
make doc
cp -a doc ../docs/gl-rs
cd $CURRENT_DIR

echo "--- hgl-rs"
cd hgl-rs
make doc
cp -a doc ../docs/hgl-rs
cd $CURRENT_DIR


