/**
 * Cylinder with toric grrove (for balls)
 * and related widgets (screws, fixing foot)
 *
 * Screws specs: 
 * - countersunk: https://us.misumi-ec.com/vona2/detail/221005020316/
 * - metric hex bolts: http://stsindustrial.com/a2-hex-cap-screw-technical-data/
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

// Countresunk. [dk, k]
M3_CS = [6.72, 1.86];
M4_CS = [8.96, 2.48];
M5_CS = [11.20, 3.1];
M6_CS = [13.44, 3.72];
M8_CS = [17.92, 4.96];

// Hex Bolt [h, f]. h: Head thickness, f: head spanner size (ex: M6, f: 10)
M2_HB = [1.525, 4];
M25_HB = [1.825, 5];
M3_HB = [2.125, 5.5];
M4_HB = [2.925, 7];
M5_HB = [3.65, 8];
M6_HB = [4.15, 10];
M8_HB = [5.45, 13];

// TODO Washers, nuts

function getCSScrewDims(diam) = 
	(diam == 3) ? M3_CS :
	(diam == 4) ? M4_CS :
	(diam == 5) ? M5_CS :
	(diam == 6) ? M6_CS :
	(diam == 8) ? M8_CS :
  [0, 0];

function getHBScrewDims(diam) = 
	(diam == 2) ? M2_HB :
	(diam == 2.5) ? M25_HB :
	(diam == 3) ? M3_HB :
	(diam == 4) ? M4_HB :
	(diam == 5) ? M5_HB :
	(diam == 6) ? M6_HB :
	(diam == 8) ? M8_HB :
  [0, 0];

/**
 * A countersunk metal screw 
 * Can be used for the screw itself, or the hole it needs.
 * diameter can be one of 3, 4, 5, 6, or 8
 * Use a top greater than 0 for difference().
 */
module metalScrewCS(diam, length, top=0) {
	//echo (str("Diam:", diam, "mm"));
	dims = getCSScrewDims(diam);
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

/**
 * A hex bolt metal screw 
 * Can be used for the screw itself, or the hole it needs.
 * diameter can be one of 2, 2.5, 3, 4, 5, 6, or 8
 * Use a top greater than 0 for difference().
 */
module metalScrewHB(diam, length, top=0) {
	//echo (str("Diam:", diam, "mm"));
	dims = getHBScrewDims(diam);
	h = dims[0];
	s = dims[1];

	union() {
		if (top > 0) {
			translate([0, 0, length - 0.01]) {
				cylinder(h=top + 0.01, d=s, $fn=6); // 6 faces
			}
		}
		translate([0, 0, length]) {
			cylinder(h=h, d=s, center=false, $fn=6); // 6 faces
		}
		translate([0, 0, 0.1]) {
			cylinder(h=length + 0.1, d=diam, $fn=50);
		}
	}
}

/**
 * A hex nut
 * Can be used for the screw itself, or the hole it needs.
 * diameter can be one of 2, 2.5, 3, 4, 5, 6, or 8
 * Use a top greater than 0 for difference().
 */
module hexNut(diam, top=0) {
	//echo (str("Diam:", diam, "mm"));
	dims = getHBScrewDims(diam);
	h = dims[0];
	s = dims[1];

	length = 0;
	
	difference() {
		union() {
			if (top > 0) {
				translate([0, 0, length - 0.01]) {
					cylinder(h=top + 0.01, d=s, $fn=6); // 6 faces
				}
			}
			translate([0, 0, length]) {
				cylinder(h=h, d=s, center=false, $fn=6); // 6 faces
			}
		}
		translate([0, 0, -2]) {
			cylinder(h=h + 4, d=diam, $fn=50);
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
			metalScrewCS(screwDiam, screwLength, screwTop);
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

if (false) { // CS Screw test
	screwDiam = 5;
	screwLen = 30;

	translate([-20, 0, 0]) {
		metalScrewCS(screwDiam, screwLen);
	}
	translate([20, 0, 0]) {
		difference() {
			cube(16);
			translate([8, 8, -20]) { // Try #translate ;)
				metalScrewCS(screwDiam, screwLen, 10);
			}
		}
	}
	
	for (i=[3, 4, 5, 6, 8]) {
		translate([-15 * i, 0, 0]) {
			metalScrewCS(i, screwLen);
		}
	}
}

if (false) { // HB Screw test
	screwLen = 30;

	translate([20, 0, 0]) {
		difference() {
			cube(16);
			translate([8, 8, -23.5]) { // Try #translate ;)
				metalScrewHB(6, screwLen, 10);
			}
		}
	}

	for (i=[2, 2.5, 3, 4, 5, 6, 8]) {
		translate([-15 * i, 0, 0]) {
			metalScrewHB(i, screwLen);
		}
	}
}

if (true) { // Hex Nut test
	
	cubeSize = 16;
	diam = 6;
	translate([20, 5, 0]) {
		difference() {
			cube(cubeSize);
			translate([cubeSize / 2, cubeSize / 2, cubeSize - getHBScrewDims(6)[0]]) { // Try #translate ;)
				hexNut(diam, top=10); 
			}
		}
	}

	translate([20, - 5 - cubeSize, 0]) {
		difference() {
			cube(cubeSize);
			translate([cubeSize / 2, cubeSize / 2, cubeSize - getHBScrewDims(6)[0]]) { // Try #translate ;)
				hull() { hexNut(diam, top=10); }
			}
		}
	}

	for (i=[2, 2.5, 3, 4, 5, 6, 8]) {
		translate([-15 * i, 0, 0]) {
			hexNut(i);
		}
	}
}

if (false) { // Fixing foot
	fixingFoot(30, 30, 5, 5);
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
