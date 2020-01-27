## README

- The idea is to extend the project featured [here](https://github.com/OlivierLD/raspberry-coffee/tree/master/Project.Trunk/SunFlower). In the original project, the panel is moved by some small micro-servos. This was used mostly to validate the software part, the one used to get to the sun's position.

- Here we want to use stepper motors, more powerful. If that works, extending the idea to manipulate bigger panels should not be a problem. Gears and other worm gears provide the possibility to change the power ratio, depending on the weight of the panels to move.

- I started from the hardware of [this instructable](https://www.instructables.com/id/Ammo-Can-Solar-Power-Supply/), and now want to have the solar panel powering the battery facing the sun as long as the sun is in the sky. This is what the device presented her is all about.

### How-to
- To print the different parts, in `OpenSCAD`, use the script named `parts.printer.scad`.
	- Comment or un-comment the function calls at the bottom of the script.
- To visualize the current state of the art, open `the.full.stand.scad` in `OpenSCAD`.

#### First preview

![Animated](./images/sunflower.gif)

---
