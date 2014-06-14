piston-workspace
================

[![Build Status](https://travis-ci.org/PistonDevelopers/piston-workspace.svg)](https://travis-ci.org/PistonDevelopers/piston-workspace)

Git submodules of Piston projects

Piston is a user friendly open source game engine written in Rust,
started by Sven Nilsen (bvssvni).
The project is still in the early stages and under heavy development.

http://www.piston.rs/

## How to build Piston

Install the developer libraries for:

* [SDL2](http://www.libsdl.org/download-2.0.php)
* [SDL2_mixer](http://www.libsdl.org/projects/SDL_mixer/)
* [SDL2_mixer](http://www.libsdl.org/projects/SDL_ttf/)
* [GLFW 3.x](http://www.glfw.org/)

On OS X, you need to download the `.dmg` for `SDL2`, `SDL2_mixer` and `SDL2_ttf`
and copy the `.framework` file to `/Library/Frameworks`.
For more information, see https://github.com/PistonDevelopers/piston-workspace/issues/63

Open the Terminal window and type:

```
git clone --recursive https://github.com/PistonDevelopers/piston-workspace.git
cd piston-workspace
chmod +x build.sh
./build.sh
```

The script will spend 3-8 minutes to build all the libraries.

## Piston symlink files

A symlink file allows you to rebuild Piston without needing to copy the '.rlib' files each time.  
When you have built Piston, the symlinks should be located in the folder 'piston-symlinks/'.  
These can be copied and put in the 'target/cpu-vendor-os/lib/' folder in your project.  

To tell the Rust compiler to look for the Piston rlib file, add `extern crate piston;` to your source.  

## How to setup a new project

1. copy 'Makefile' from https://github.com/bvssvni/rust-empty to a new empty folder
2. open up the Terminal window and navigate to the project folder
3. type make run to create "hello world!" example
4. copy symlinks from 'piston-symlinks/' to the projects 'target/cpu-vendor-os/lib/' folder
5. add `extern crate piston;`, `extern crate graphics;` etc. to your source at top level

For more information about how to use Piston, see the [Piston tutorial](https://github.com/PistonDevelopers/piston/blob/master/learning%20materials/tutorial.md)

## How to generate documentation

You can generate the documentation of all the projects at once:

```
chmod +x docs.sh
./docs.sh
```

The generated documentation is located in the 'docs/' folder.

## How to upgrade to Rust master

This information is for PistonDevelopers:

```
chmod +x update.sh
./update.sh
```

If you find Piston-Workspace out of date, run this script and do a build.  
Check that there are no errors and send a pull request.  
