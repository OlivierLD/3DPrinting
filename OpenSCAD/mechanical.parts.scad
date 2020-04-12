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


// Countersunk. [dk, k] dk: head diameter, k head thickness.
M3_CS = [6.72, 1.86];
M4_CS = [8.96, 2.48];
M5_CS = [11.20, 3.1];
M6_CS = [13.44, 3.72];
M8_CS = [17.92, 4.96];

// Hex Nuts and Bolts [h, f, g]. h: Head thickness, f: head spanner size (ex: M6, f: 10, g: 11.05)
// Use g for an hexa head in OpenSCAD
M2_HB = [1.525, 4, 4.32];
M25_HB = [1.825, 5, 5.45];
M3_HB = [2.125, 5.5, 6.01];
M4_HB = [2.925, 7, 7.66];
M5_HB = [3.65, 8, 8.79];
M6_HB = [4.15, 10, 11.05];
M8_HB = [5.45, 13, 14.38];

// Washer, [OD, thickness]
M3_W = [7, 0.55];
M35_W = [8, 0.55];
M4_W = [9, 0.9];
M5_W = [10, 1.1];
M6_W = [12, 1.8];
M8_W = [16, 1.8];

// Ball Bearings [ID, OD, Thickness]
// Warning: do check the data sheet of your ball bearing! Dimensions may vary!
BB_05 = [5, 16, 5];
BB_06 = [6, 19, 6];
BB_08 = [8, 22, 7];

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
		color("grey", 0.85) {
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
	s = dims[2]; // Was 1

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
	s = dims[2]; // Was 1

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

/**
 * https://www.aliexpress.com/item/1306340715.html
 * https://lovemyswitches.com/closeout-16mm-potentiometers-6-0mm-smooth-shaft-right-angle-pcb-mount/
 */
module B10K() {
	
	backCylinderDiam = 16.9;
	backCylinderHeight = 8.2;
	frontPlateThickness = 1.3; // Bakelite
	frontPlateCenterToBottom = 12;
	frontMetalPlateHeight = 11.2;
	frontMetalPlateThickness = 2.2;
	leftPegWidth = 2.8;
	leftPegHeight = 3.3;
	leftPegThickness = 1.2;
	
	screwedBaseDiam = 7.0; // 6.75;
	screwedBaseHeight = 7.4;
	tinyStuffHeight = 2.1;
	tinyStuffDiam = 5.1;
	knobDiam = 6.0;
	knobHeight = 6.1;
	
	rotate([0, 0, 0]) {
		translate([0, 0, 0]) {
			color("silver") {
				// Bottom, back cylinder
				cylinder(h=backCylinderHeight, d=backCylinderDiam, $fn=150);
			}
		}
		// Bakelite plate
		color("brown") {
			union() {
				translate([0, 0, backCylinderHeight]) {
					cylinder(h=frontPlateThickness, d=backCylinderDiam, $fn=50);
					translate([- (backCylinderDiam / 2), 0, 0]) {
						cube(size=[backCylinderDiam, frontPlateCenterToBottom, frontPlateThickness], center=false);
					}
				}
			}
		}
		// First front metal plate
		translate([0, 0, backCylinderHeight + frontPlateThickness]) {
			color("gray") {
				intersection() {
					cylinder(h=frontMetalPlateThickness, d=backCylinderDiam, $fn=50);
					translate([- (backCylinderDiam / 2), - (frontMetalPlateHeight / 2), 0]) {
						cube(size=[backCylinderDiam, frontMetalPlateHeight, frontMetalPlateThickness], center=false);
					}
				}
				// Add peg on the left
				translate([(backCylinderDiam / 2) - leftPegThickness, - (leftPegWidth / 2), 0]) {
					cube(size=[leftPegThickness, leftPegWidth, leftPegHeight + frontMetalPlateThickness], center=false);
				}
			}
		}
		// Screwed base
		translate([0, 0, backCylinderHeight + frontPlateThickness + frontMetalPlateThickness]) {
			cylinder(h=screwedBaseHeight, d=screwedBaseDiam, $fn=50);
		}
		// Tiny stuff
		color("silver") {
			translate([0, 0, backCylinderHeight + frontPlateThickness + frontMetalPlateThickness + screwedBaseHeight]) {
				cylinder(h=tinyStuffHeight, d=tinyStuffDiam, $fn=50);
			}		
		}
		// Knob
		color("gray") {
			translate([0, 0, backCylinderHeight + frontPlateThickness + frontMetalPlateThickness + screwedBaseHeight + tinyStuffHeight]) {
				difference() {
					cylinder(h=knobHeight, d=knobDiam, $fn=50);
					translate([-(knobDiam * 1.1 / 2), 0, 0]) {
						cube(size=[knobDiam * 1.1, 0.5, knobHeight * 1.1], center=false);
					}
				}
			}		
		}
	}
}


/*
 * https://www.parallax.com/sites/default/files/downloads/900-00005-Servo-Dimensions.pdf
 */
module servoParallax900_00005(drillPattern=false, drillDiam=2, drillLength=10) {
	boxHeight = 35.6;
	boxWidth = 20;
	boxLength = 40.5;
	topBevelsThickness = 3;
	mainAxisFromSideOffset = 10.4;
	
	/* Main box/container */
	// One side
	points = [
	  [0, 0],
	  [boxLength, 0],
	  [boxLength, boxHeight - topBevelsThickness],
	  [boxLength - 16, boxHeight],
	  [3, boxHeight],
	  [0, boxHeight - topBevelsThickness]
	];
	paths = [[0, 1, 2, 3, 4, 5]];
	
	if (!drillPattern) {
	
		translate([-mainAxisFromSideOffset, 0, 0]) {
			rotate ([90, 0, 0]) {
				linear_extrude(height=boxWidth, center=true) {
					polygon(points, paths, convexity=10);
				}
			}
		}
		
	}

	/* Box/container top */
	topPlateThickness = 3;
	topPlateLength = 36.5;
	points2 = [
	  [0, 0],
	  [2.5, topPlateThickness],
	  [topPlateLength - 1, topPlateThickness],
	  [topPlateLength, 0]
	];
	paths2 = [[0, 1, 2, 3]];
	topWidth = 18;
	betweenTops = 0.5;
	
	if (!drillPattern) {

		translate([(topPlateLength / 2) + mainAxisFromSideOffset - 2, 
							 -(topWidth / 2), 
							 0 + boxHeight + betweenTops - topPlateThickness]) {
			rotate([90, 0, 180]) {
				linear_extrude(height=topWidth, center=false) {
					polygon(points2, paths2, convexity=10);
				}
			}
		}
		
	}
	
	/* Screws plate */
	plateLength = 55.5;
	plateWidth = 18;
	plateThickness = 2.5;
	holeDiam = 4.5;
	betweenHoleW = 10;
	betweenHoleL = 50.5;
	plateHangOut = 7.5;
	plateBottomHeight = 26.6;
	
	translate([-(mainAxisFromSideOffset + plateHangOut), -(plateWidth / 2), plateBottomHeight]) {
		if (!drillPattern) {
			difference() {
				union() {
					cube(size=[plateLength, plateWidth, plateThickness]);
					/* extra, small fingers/stuff on top of the plate */
					width = 2.25;
					length = boxLength + (3 * 4);
					thickness = 1;
					translate([(width) + ((plateLength - length) / 2), 
											(plateWidth - width) / 2, 
											plateThickness]) {
						linear_extrude(height=thickness, center=false) {
							union() {
								square(size=[length - (2 * width), width]);
								translate([0, width / 2, 0]) {
									circle(d=width, $fn=50);
								}
								translate([length - (2 * width), width / 2, 0]) {
									circle(d=width, $fn=50);
								}
							}
						}
					}
				}
				// Bottom right
				drillHoleFactor = 0.95; // TODO Parameter?
				holeDiam = holeDiam * drillHoleFactor;
				translate([(plateLength - betweenHoleL) / 2, (plateWidth - betweenHoleW) / 2, -1]) {
					cylinder(d=holeDiam, h = 2*plateThickness, $fn=50);
				}
				// Bottom Left
				translate([(plateLength - betweenHoleL) / 2, plateWidth - ((plateWidth - betweenHoleW) / 2), -1]) {
					cylinder(d=holeDiam, h = 2*plateThickness, $fn=50);
				}
				// Top right
				translate([plateLength - ((plateLength - betweenHoleL) / 2), (plateWidth - betweenHoleW) / 2, -1]) {
					cylinder(d=holeDiam, h = 2*plateThickness, $fn=50);
				}
				// Top Left
				translate([plateLength - ((plateLength - betweenHoleL) / 2), plateWidth - ((plateWidth - betweenHoleW) / 2), -1]) {
					cylinder(d=holeDiam, h = 2*plateThickness, $fn=50);
				}
			}
		} else {
			/* Drill pattern only */
			// drillDiam, default 2
			translate([(plateLength - betweenHoleL) / 2, (plateWidth - betweenHoleW) / 2, -(drillLength / 2)]) {
				cylinder(d=drillDiam, h=drillLength, $fn=50);
			}
			// Bottom Left
			translate([(plateLength - betweenHoleL) / 2, plateWidth - ((plateWidth - betweenHoleW) / 2), -(drillLength / 2)]) {
				cylinder(d=drillDiam, h=drillLength, $fn=50);
			}
			// Top right
			translate([plateLength - ((plateLength - betweenHoleL) / 2), (plateWidth - betweenHoleW) / 2, -(drillLength / 2)]) {
				cylinder(d=drillDiam, h=drillLength, $fn=50);
			}
			// Top Left
			translate([plateLength - ((plateLength - betweenHoleL) / 2), plateWidth - ((plateWidth - betweenHoleW) / 2), -(drillLength / 2)]) {
				cylinder(d=drillDiam, h=drillLength, $fn=50);
			}
		}
	}
	
	if (!drillPattern) {

		/* Axis base */
		translate([0, 0, boxHeight + betweenTops]) {
			rotate([0, 0, 0]) {
				cylinder(d1=15, d2=10.5, h=1.5, $fn=50);
			}
		}
		
		/* Axis itself */
		axisLength = 41.1;
		axisDiam = 6;
		translate([0, 0, 0]) {
			rotate([0, 0, 0]) {
				color("silver") {
					cylinder(d=axisDiam, h=axisLength, $fn=50);
				}
			}
		}
		
		/* Wire socket */
		socketBaseThickness = 1.5;
		socketBaseLength = 6;
		socketBaseHeight = 4;
		
		// rubber socket base, like the wire socket
		rubberSocketLength = 6.5;
		rubberSocketEndWidth = 3.5;
		rubberSocketEndThickness = 2;
		
		rubberSocketPoints = [
			[0, 0, 0],
			[socketBaseHeight, 0, 0],
			[socketBaseHeight, socketBaseLength, 0],
			[0, socketBaseLength, 0],
			[(socketBaseHeight / 2) - (rubberSocketEndThickness / 2), (socketBaseLength / 2) - (rubberSocketEndWidth /2), rubberSocketLength],
			[(socketBaseHeight / 2) + (rubberSocketEndThickness / 2), (socketBaseLength / 2) - (rubberSocketEndWidth /2), rubberSocketLength],
			[(socketBaseHeight / 2) + (rubberSocketEndThickness / 2), (socketBaseLength / 2) + (rubberSocketEndWidth /2), rubberSocketLength],
			[(socketBaseHeight / 2) - (rubberSocketEndThickness / 2), (socketBaseLength / 2) + (rubberSocketEndWidth /2), rubberSocketLength]
		];
		rubberSocketFaces = [
			[0,1,2,3],  // bottom
			[4,5,1,0],  // front
			[7,6,5,4],  // top
			[5,6,2,1],  // right
			[6,7,3,2],  // back
			[7,4,0,3]   // left
		];
		
		translate([-mainAxisFromSideOffset - socketBaseThickness, -(socketBaseLength / 2), 0]) {
			rotate([90, 0, 90]) {
				union() {
					cube(size=[socketBaseLength, socketBaseHeight, socketBaseThickness]);
					rotate([0, 0, 90]) {
						rotate([0, 180, 0]) {
							translate([-socketBaseHeight, -socketBaseLength, -socketBaseThickness]) {
								polyhedron(rubberSocketPoints, rubberSocketFaces);
							}
						}
					}
				}
			}
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


if (false) { // Nut bolt washer
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
if (false) { // Ball bearing test
	for (i=[5, 6]) {
		translate([-20 * (i - 5), 0, 0]) {
			ballBearing(i);
		}
	}
}
if (false) { // B10K
	B10K();
}

if (true) {
	servoParallax900_00005(drillPattern=false);
}