#!/bin/bash

CURRENT_DIR=$(pwd)
echo $CURRENT_DIR

echo "--- updating piston-workspace"
git checkout master
git pull origin master

echo "--- updating cgmath-rs"
cd cgmath-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating rust-portaudio"
cd rust-portaudio
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating gl-rs"
cd gl-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating piston"
cd piston
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating rust-image"
cd rust-image
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating glfw-rs"
cd glfw-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating rust-sdl2"
cd rust-sdl2
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating rust-sdl2_mixer"
cd rust-sdl2_mixer
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating rust-sdl2_ttf"
cd rust-sdl2_ttf
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating hgl-rs"
cd hgl-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

echo "--- updating rust-graphics"
cd rust-graphics
git checkout master
git pull origin master
cd $CURRENT_DIR

