piston-workspace
================

Git submodules of Piston projects

## How to build Piston

```
git clone --recursive https://github.com/PistonDevelopers/piston-workspace.git
cd piston-workspace
chmod +x build.sh
./build.sh
```

## Piston '.rlib' files

The Piston '.rlib' files are located in 'piston-workspace/piston/target/cpu-vendor-os/lib'.

## How to upgrade to Rust master

This information is for PistonDevelopers:

```
chmod +x update.sh
./update.sh
```

If you find Piston-Workspace out of date, run this script and do a build.  
Check that there are no errors and send a pull request.  
