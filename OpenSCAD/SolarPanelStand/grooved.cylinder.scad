/**
 * Cylinder with toric grrove (for balls)
 * and related widgets (screws, fixing foot)
 *
 * Screws specs: https://us.misumi-ec.com/vona2/detail/221005020316/
 */


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

function getScrewDims(diam) = 
	(diam == 3) ? [6.72, 1.86] :
	(diam == 4) ? [8.96, 2.48] :
	(diam == 5) ? [11.20, 3.1] :
	(diam == 6) ? [13.44, 3.72] :
	(diam == 8) ? [17.92, 4.96] :
  [0, 0];

/**
 * A countersunk metal screw 
 * Can be used for the screw itself, or the hole it needs.
 * diameter can be one of 3, 4, 5, 6, or 8
 */
module metalScrew(diam, length, top=0) {
	//echo (str("Diam:", diam, "mm"));
	dims = getScrewDims(diam);
	dk = dims[0];
	k = dims[1];
	//echo (str("Diam:", diam, "mm, k:", k, ", dk:", dk));
	union() {
		if (top > 0) {
			translate([0, 0, length - 0.01]) {
				cylinder(h=top + 0.01, d=dk, $fn=50);
			}
		}
		translate([0, 0, length - k]) {
			cylinder(h=k, d1=diam, d2=dk, center=false, $fn=50);
		}
		translate([0, 0, 0.1]) {
			cylinder(h=length - k + 0.1, d=diam, $fn=50);
		}
	}
}

module fixingFoot(heightAndLength, width, screwDiam, wallMinThickness) {
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
			metalScrew(screwDiam, screwLength, screwTop);
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

if (false) { // Screw test
	screwDiam = 5;
	screwLen = 30;

	translate([-20, 0, 0]) {
		metalScrew(screwDiam, screwLen);
	}
	translate([20, 0, 0]) {
		difference() {
			cube(16);
			translate([8, 8, -20]) { // Try #translate ;)
				metalScrew(screwDiam, screwLen, 10);
			}
		}
	}
	
	for (i=[3, 4, 5, 6, 8]) {
		translate([-15 * i, 0, 0]) {
			metalScrew(i, screwLen);
		}
	}
}

if (false) { // Fixing foot
	fixingFoot(30, 30, 5, 5);
}

if (true) { // Grooved Cylinder with fixing feet
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
