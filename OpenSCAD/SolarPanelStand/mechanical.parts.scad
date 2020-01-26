/**
 * @author OlivierLD
 *
 * Screws, bolts, nuts, washer, ball bearings, etc...
 * To be used as placeholders.
 *
 * Screws specs: 
 * - metric countersunk: https://us.misumi-ec.com/vona2/detail/221005020316/
 * - metric hex bolts: http://stsindustrial.com/a2-hex-cap-screw-technical-data/
 * - metric washers: https://www.mutualscrew.com/department/metric-flat-washers-din-125-11622.cfm
 *
 * Includes at the bottom many tests and showcases.
 */


// Countresunk. [dk, k] dk: head diameter, k head thickness.
M3_CS = [6.72, 1.86];
M4_CS = [8.96, 2.48];
M5_CS = [11.20, 3.1];
M6_CS = [13.44, 3.72];
M8_CS = [17.92, 4.96];

// Hex Nuts and Bolts [h, f]. h: Head thickness, f: head spanner size (ex: M6, f: 10)
M2_HB = [1.525, 4];
M25_HB = [1.825, 5];
M3_HB = [2.125, 5.5];
M4_HB = [2.925, 7];
M5_HB = [3.65, 8];
M6_HB = [4.15, 10];
M8_HB = [5.45, 13];

// Washer, [OD, thickness]
M3_W = [7, 0.55];
M35_W = [8, 0.55];
M4_W = [9, 0.9];
M5_W = [10, 1.1];
M6_W = [12, 1.8];
M8_W = [16, 1.8];

// Ball Bearings [ID, OD, Thickness]
BB_05 = [5, 16, 5];
BB_06 = [6, 19, 6];

function getBBDims(diam) =  // Ball bearings dims
  (diam == 5) ? BB_05 :
  (diam == 6) ? BB_06 :
	[0, 0];

function getCSScrewDims(diam) = // Countersunk dims
	(diam == 3) ? M3_CS :
	(diam == 4) ? M4_CS :
	(diam == 5) ? M5_CS :
	(diam == 6) ? M6_CS :
	(diam == 8) ? M8_CS :
  [0, 0];

function getHBScrewDims(diam) =  // Hex Bolts and Nuts dims
	(diam == 2) ? M2_HB :
	(diam == 2.5) ? M25_HB :
	(diam == 3) ? M3_HB :
	(diam == 4) ? M4_HB :
	(diam == 5) ? M5_HB :
	(diam == 6) ? M6_HB :
	(diam == 8) ? M8_HB :
  [0, 0];

function getWasherDims(diam) =  // Washer dims
	(diam == 3) ? M3_W :
	(diam == 3.5) ? M35_W :
	(diam == 4) ? M4_W :
	(diam == 5) ? M5_W :
	(diam == 6) ? M6_W :
	(diam == 8) ? M8_W :
  [0, 0];

module ballBearing(id) {
	dims = getBBDims(id); // [id, od, t]
	difference() {
		color("grey") {
			cylinder(h=dims[2], d=dims[1], $fn=100, center=true); 
		}
		cylinder(h=dims[2] * 1.1, d=dims[0], $fn=100, center=true); 
	}
}

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
 * Can be used for the nut itself, or the hole it needs.
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

/**
 * A washer
 * Can be used for the washer itself, or the hole it needs.
 * diameter can be one of 2, 2.5, 3, 4, 5, 6, or 8
 * Use a top greater than 0 for difference().
 */
module washer(diam, top=0) {
	//echo (str("Diam:", diam, "mm"));
	dims = getWasherDims(diam);
	od = dims[0];
	t = dims[1];

	length = 0;
	
	difference() {
		union() {
			if (top > 0) {
				translate([0, 0, length - 0.01]) {
					cylinder(h=t + 0.01, d=od, $fn=50); 
				}
			}
			translate([0, 0, length]) {
				cylinder(h=t, d=od, center=false, $fn=50);
			}
		}
		translate([0, 0, -2]) {
			cylinder(h=t + 4, d=diam, $fn=50);
		}
	}
}

// Tests
echo("For tests only");

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

if (false) { // Hex Nut test
	
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

if (false) { // Washer test
	cubeSize = 16;
	diam = 6;
	translate([20, 5, 0]) {
		difference() {
			cube(cubeSize);
			translate([cubeSize / 2, cubeSize / 2, cubeSize - getWasherDims(6)[1] + 0.05]) { // Try #translate ;)
				washer(diam, top=10); 
			}
		}
	}

	translate([20, - 5 - cubeSize, 0]) {
		difference() {
			cube(cubeSize);
			translate([cubeSize / 2, cubeSize / 2, cubeSize - getWasherDims(6)[1] + 0.05]) { // Try #translate ;)
				hull() { washer(diam, top=10); }
			}
		}
	}

	for (i=[3, 3.5, 3, 4, 5, 6, 8]) {
		translate([-15 * i, 0, 0]) {
			washer(i);
		}
	}
}

// Nut bolt washer
if (false) {
	diam = 6;
	screwLen = 30;
	
	translate([- screwLen / 2, 0, 0]) {
		rotate([0, 90, 0]) {
			color("cyan") {
				metalScrewHB(diam, screwLen);
			}
			translate([0, 0, 15]) {
				color("red") {
					washer(diam);
				}
			}
			translate([0, 0, 5]) {
				color("green") {
					hexNut(diam);
				}
			}
		}
	}
}

// Ball bearing test
if (true) {
	for (i=[5, 6]) {
		translate([-20 * (i - 5), 0, 0]) {
			ballBearing(i);
		}
	}
}
