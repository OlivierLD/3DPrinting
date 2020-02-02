/**
 * @author OlivierLD
 *
 * Cylinder with toric grrove (for balls)
 * and related widgets (screws, fixing foot)
 *
 * Includes at the bottom many tests and showcases.
 */

use <./mechanical.parts.scad>

/**
 * ringDiam: the ring diameter at its thickest
 * torusDiam: the diametere of the torus
 * => the total diameter would be (ringDiam + torusDiam)
 */
module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 
 
module groovedCylinder(cylinderHeight, extDiam, torusDiam, intDiam, grooveDiam) {
	difference() {
		cylinder(h=cylinderHeight, d=extDiam, center=true, $fn=100);
		translate([0, 0, (cylinderHeight / 2) + 0.1]) { // Higher than previously, some slack for ball bearings...
			torus(torusDiam, grooveDiam);
		}
		// Hole in the middle
		cylinder(h=cylinderHeight * 1.1, d=intDiam, center=true, $fn=100);
	}
}

module fixingFoot(heightAndLength, width, screwDiam, wallMinThickness, hbScrews=false) {
	screwLength = 30;
	screwTop = 20;
	difference() {
		rotate([0, -90, 0]) {
			linear_extrude(height=width, center=true) {
				difference() {
					square(heightAndLength, center=true);
					translate([heightAndLength / 2, heightAndLength / 2]) {
						circle(d=heightAndLength, $fn=50);
					}
				}
			}
		}
		rotate([0, 90, 0]) {
			translate([- wallMinThickness - (heightAndLength / 2), wallMinThickness + (heightAndLength / 2), 0]) {
				hull() {
					torus(heightAndLength, width * 0.9); 
				}
			}
		}
		// 0.2: drilling offset
		translate([0, heightAndLength * 0.2, -(screwLength + (heightAndLength / 2) - wallMinThickness)]) {
			if (hbScrews) {
				metalScrewHB(screwDiam, screwLength, screwTop);
			} else {
				metalScrewCS(screwDiam, screwLength, screwTop);
			}
		}
	}
}

// Tests
echo("For tests only");
echo("Use all.parts.scad for printing");

if (false) { // Grooved Cylinder
	cylHeight = 50;
	extDiam = 110;
	torusDiam = 100;
	intDiam = 90;
	ballsDiam = 5;

	groovedCylinder(cylHeight, extDiam, torusDiam, intDiam, ballsDiam);
}

if (true) { // Fixing foot
	fixingFoot(30, 30, 5, 5, true);
}

if (false) { // Grooved Cylinder with fixing feet
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

	translate([0, 0, cylHeight/ 2]) {
		groovedCylinder(cylHeight, extDiam, torusDiam, intDiam, ballsDiam);
	}
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
}
