#!/bin/bash

CURRENT_DIR=$(pwd)
echo $CURRENT_DIR

cd gl-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

cd piston
git checkout master
git pull origin master
cd $CURRENT_DIR

cd rust-image
git checkout master
git pull origin master
cd $CURRENT_DIR

cd rust-png
git checkout master
git pull origin master
cd $CURRENT_DIR

cd glfw-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

cd rust-sdl2
git checkout master
git pull origin master
cd $CURRENT_DIR

cd hgl-rs
git checkout master
git pull origin master
cd $CURRENT_DIR

cd rust-graphics
git checkout master
git pull origin master
cd $CURRENT_DIR

