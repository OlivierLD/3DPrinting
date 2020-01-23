/**
 * The full stand... Using other scad files.
 *
 * To set the required option, see the option variable at the bottom of the script.
 */
use <./grooved.cylinder.scad>

echo(version=version());

// Horizontal axis for the worm gear
module wormGearAxis(axisThickness, centerOffset, axisHeight, cylLen=150) {
	rotate([90, 0, 0]) {
		translate([centerOffset, axisHeight]) {
			cylinder(h=cylLen, d=axisThickness, center=true, $fn=50);
		}
	}
}


module footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness) {
	union() {
		// Grooved Cylinder
		translate([0, 0, cylHeight/ 2]) {
			groovedCylinder(cylHeight, extDiam, torusDiam, intDiam, ballsDiam);
		}

		// 3 Feet
		for (foot = [0:2]) {
			rotate([0, 0, (foot * (360 / 3))]) {
				translate([(extDiam / 2) + ((fixingFootSize / 2) - minWallThickness), 0, 0]) {
					rotate([0, 0, -90]) {
						translate([0, 0, fixingFootSize / 2]) {
							fixingFoot(fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
						}
					}
				}
			}
		}

		// Crosshair
		crosshairThickness = 2;
		crosshairBaseWidth = 5;
		points = [[0, 0], [0, crosshairBaseWidth * 2], [(extDiam / 2) + (fixingFootSize / 2) + (screwDiam / 2), crosshairBaseWidth]];
		paths = [[0, 1 ,2]];
		difference() {
			// A crosshair
			for (angle = [0, 120, 240]) {
				translate([0, 0, crosshairThickness / 2]) {
					linear_extrude(height=crosshairThickness, center=true) {				
						rotate([0, 0, angle]) {
							translate([0, -crosshairBaseWidth]) {
								polygon(points=points, paths=paths);
							}
						}		
					}
				}
			}
			// Axis
			color("gray") {
				cylinder(h=50, d=5, center=true);
			}
		}
	}
}

// A grooved cylinder, with 3 feet, and a crosshair.

cylHeight = 50;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;

fixingFootSize = 30;
fixingFootWidth = 30;
screwDiam = 5;
screwLen = 30;
minWallThickness = 5;

workGearAxisDiam = 10;

FULL_BASE = 1;
FULL_BASE_WITH_WORK_GEAR = 2;

option = FULL_BASE_WITH_WORK_GEAR;

if (option == FULL_BASE) {
  footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
} else if (option == FULL_BASE_WITH_WORK_GEAR) {
	difference() {
		footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
		#wormGearAxis(workGearAxisDiam, extDiam / 3, cylHeight / 2);	
	}
} else {
	echo(str("Unknown option ", option));
}


