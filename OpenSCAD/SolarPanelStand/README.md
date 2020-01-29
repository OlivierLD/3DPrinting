## README

- The idea is to extend the project featured [here](https://github.com/OlivierLD/raspberry-coffee/tree/master/Project.Trunk/SunFlower). In the original project, the panel is moved by some small micro-servos. This was used mostly to validate the software part, the one used to get to the sun's position.

- Here we want to use stepper motors, more powerful. If that works, extending the idea to manipulate bigger panels should not be a problem. Gears and other worm gears provide the possibility to change the power ratio, depending on the weight of the panels to move.

- I started from the hardware of [this instructable](https://www.instructables.com/id/Ammo-Can-Solar-Power-Supply/), and now want to have the solar panel powering the battery facing the sun as long as the sun is in the sky. This is what the device presented her is all about.

### How-to
Different parameter sets can drive the printing process as well as the preview process. The same parameter sets (scripts) drive the two processes. Thnose parameter sets are held in files named like `param.set.**.scad`.

- To print the different parts, in `OpenSCAD`, use the script named `printing.scad`, which refers to scripts like `param.set.**.scad`, which hold distinct sets of parameters.
	- Comment or un-comment the function calls at the bottom of the `printing.scad` script.
	- Preview your part.
	- Generate the `stl` file.
- To visualize the current state of the art, open `the.full.stand.scad` in `OpenSCAD`. This script itself is driven by the same parameters as above, mentioned in the `include` statement, like `param.set.0*.scad`. Change the `include` statement in `the.full.stand.scad` to refer to the required set of parameters.

#### Examples
To view the full device, with the set of parameters contained in `param.set.03.scad`, modify the `include` statement in the `the.full.stand.scad` so it looks like this:
```
include <./param.set.03.scad>
```
and then run the script (or use `F5` or `F6`).

To prepare the bottom base for printing with the parameters of `param.set.03.scad`:
- Load `printing.scad` in `OpenSCAD`
- Make sure the `include` statement refers to `param.set.03.scad`
```
include <./param.set.03.scad>
```
- In the code editor, uncomment (remove the `/*` on top and the `*/` below) the call to the `printBase1` module:
```

printBase1(cylHeight, 
           extDiam, 
           torusDiam, 
           intDiam, 
           ballsDiam, 
           fixingFootSize, 
           fixingFootWidth, 
           fixingFootScrewDiam, 
           minFootWallThickness,
           verticalAxisDiam,
           wormGearAxisDiam,
           wormGearAxisRadiusOffset, 
           wormGearAxisHeight);

```
- Then render the part (use `F6`)
![Rendering](./images/rendering.png)
- Finally Export as STL (use `F7`)
- Your generated STL file is ready to be used on your 3D printer.

#### First preview

![Animated](./images/sunflower.gif)

> Note: `github` supports the rendering of `stl` files. Click them above to **see** them.


---
