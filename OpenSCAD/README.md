# OpenSCAD models

> On Debian, Ubuntu and friends (All downloads: <https://www.openscad.org/downloads.html>):
```
 $ sudo apt-get install openscad
```
> Or from the source: <https://github.com/openscad/openscad>

Each directory contains the code (`.scad`) along with the generated `stl` files (for visualization, when it makes any sense).

> The `stl` files describe the shape of the parts to print.
> Depending on the kind of material you will use (plastic, resin, metal, ceramic...),
> you will need to prepare those files for the specificities of your printer.
> This is where programs like `Cura Ultimaker` come in. This one will for example,
> turn the `stl` files into `gcode` ones. You can also generate a single `gcode` from several `stl`. There are good reasons for those two types fo files to exist.

> The development path becomes in this case `scad` > `stl` > `gcode`.

### Stuff to look at
- Blender to OpenSCAD: <https://mathgrrl.com/hacktastic/2015/10/beefy-trophy-baking-meshes-into-openscad-from-blender/>

- [Octoprint](https://octoprint.org/)! Works great from a Raspberry Pi, really cool stuff.

- [The 3D print zone](https://the3dprintzone.com/). Articles, videos, tutorials, etc.
