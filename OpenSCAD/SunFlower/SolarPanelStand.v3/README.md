### SunFlower, V3 <img src="../../cone.png" alt="WiP" width="48" height="48" align="middle">
This is a work in progress...

To discover - or learn - what this does, start with `printing.scad`.

This will look a lot like the SunFlower V2, but all the gears will be 3D printed too, no need to buy them, only the stepper motors are required, no extra axis, no worm gear.

For now, look in the `stl` folder to visualize the part designs.

## Script Hierarchy

![Hierarchy](./scad.relationship.01.png)

### Data
- Bevel Gear:
	- Gear: 40 teeth
	- Pinion: 20 teeth

### Pictures

![The new parts](./images/01.3.parts.jpg)

New parts:
- Bevel gear with its base
- Smaller top base, will hold the base of the bevel gear
- Bottom base, with a socket for the motor holding the pinion

![Top assembled](./images/02.top.assembled.jpg)

- Bevel gear and top base together

![Ball bearing](./images/03.base.ball.bearing.jpg)

- Bottom ball bearing

### Lessons learned
The 3D printed gears (specially the pinion, on the motor axis) are difficult to lock in place. The PLA seems not to be strong enough to hold the screws and bolts...
Metallic gears would not have this problem.

Something to keep in mind for V4.
