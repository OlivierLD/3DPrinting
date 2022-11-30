/**
 * @author OlivierLD
 *
 * Screws, bolts, nuts, washer, ball bearings, etc...
 * To be used as placeholders.
 *
 * Also some PCB and other components (servos, pots, etc).
 *
 * Screws specs: 
 * - metric countersunk: https://us.misumi-ec.com/vona2/detail/221005020316/
 * - metric hex bolts: http://stsindustrial.com/a2-hex-cap-screw-technical-data/
 * - metric washers: https://www.mutualscrew.com/department/metric-flat-washers-din-125-11622.cfm
 *
 * Includes at the bottom many tests and showcases.
 *
 * OpenSCAD doc at https://www.openscad.org/documentation.html
 */

inch_to_mm = 25.4;

/**
 * size is a triplet [x, y, z]
 * radius is the radius of the rounded corner
 */
module roundedRect(size, radius) {
	linear_extrude(height=size.z, center=true) {
		offset(radius) {
			offset(-radius) {
				square([size.x, size.y], center=true);
			}
		}
	}
}

// Countersink. [dk, k] dk: head diameter, k head thickness.
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

M_1_4_HB = [4.62, 11, 12.6];

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
BB_025_IN = [(1 / 4) * inch_to_mm, (5 / 8) * inch_to_mm, 0.196 * inch_to_mm]; 

function getBBDims(diam) =  // Ball bearings dims
  (diam == 5) ? BB_05 :
  (diam == 6) ? BB_06 :
  (diam == 8) ? BB_08 :
  (diam == 0.25) ? BB_025_IN :
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
  // 1/4"
  (diam == (0.25 * inch_to_mm)) ? M_1_4_HB :
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
module B10K(small=false) {
	
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
			color("green") {
				cylinder(h=screwedBaseHeight, d=screwedBaseDiam, $fn=50);
			}
		}
		// Tiny stuff (small or not)
		if (!small) {
			color("orange") {
				translate([0, 0, backCylinderHeight + frontPlateThickness + frontMetalPlateThickness + screwedBaseHeight]) {
					cylinder(h=tinyStuffHeight, d=tinyStuffDiam, $fn=50);
				}		
			}
		}
		// Knob
		color("gray") {
			translate([0, 0, backCylinderHeight + frontPlateThickness + frontMetalPlateThickness + screwedBaseHeight + (small ? 0 : tinyStuffHeight)]) {
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



/*
 * http://adafruit.com/product/390
 * https://learn.adafruit.com/usb-dc-and-solar-lipoly-charger/using-the-charger?view=all#schematic-and-fabrication-print-7-2
 */
mcpUsbSolarThickness =  1.7;
mcpUsbSolarWidth     = (1.6 * inch_to_mm);
mcpUsbSolarLen       = 33.15;
//
function getMcpUsbSolarDims() =  // [x, y, z]
	[mcpUsbSolarWidth, mcpUsbSolarLen, mcpUsbSolarThickness];

module MCP73871_USB_Solar(bigHangout=false, withStand=false, standOnly=false, standHeight=4) {
	
	name = "MCP73871 USB Solar";
	
	dims = getMcpUsbSolarDims();
	
	width_inch = dims[0] / inch_to_mm;
	// height_inch = 1.305;
	corner_radius = 0.1; // inches
	
	width_mm = dims[0];
	height_mm = dims[1];
	
	boardThickness = dims[2]; // mm
	
	leftTo5Vcenter = 1.18; // inches
	leftToUSB = 0.68;      // inches
	
	cornerRadius = 0.1;    // Inches
	topFromHoles = 0.2;    // inches
	bottomFromHoles = 0.1; // inches
	
	holeDiam = 2.5; // mm
	
	_5VSocketWidth  = 9.5;  // mm
	_5VSocketHeight = 11.2; // mm
	_5VSocketDepth = 13.64; // mm
	_5VSockerHangout = 2.5; // mm
	
	usbWidth = 8.3; // mm
	usbHeight = 5.4; // mm
	usbDepth = 9.3; // mm
	usbHangout = 1; // mm
	
	fontSize = 2.5;
	
	difference() {
		union() {
			if (!standOnly) {
				difference() {
					roundedRect(size=[height_mm, width_mm, boardThickness], radius=(corner_radius * inch_to_mm));
					translate([0, 3, 0.5]) {
						linear_extrude(height=1.5, center=true) {
							rotate([0, 0, 90]) {
									translate([-(width_mm / 2), -(fontSize / 2)]) {
										text(name, fontSize);
								}
							}
						}
					}
				}
				// 5V power supply
				translate([((_5VSocketDepth - height_mm) / 2) - _5VSockerHangout, 
									 ((width_inch / 2) - (width_inch - leftTo5Vcenter)) * inch_to_mm, 
									 (_5VSocketHeight + boardThickness) / 2]) {
					cube(size=[(bigHangout ? 2 : 1) * _5VSocketDepth, _5VSocketWidth, _5VSocketHeight], center=true);
				}
				// USB socket
				translate([((usbDepth - height_mm) / 2) - usbHangout, 
									 ((width_inch / 2) - (width_inch - leftToUSB)) * inch_to_mm, 
									 (usbHeight + boardThickness) / 2]) {
					cube(size=[(bigHangout ? 2 : 1) * usbDepth, usbWidth, usbHeight], center=true);
				}
			}
			if (withStand || standOnly) { // 4 feet, cones
				color("green") {
					difference() {
						union() {
							translate([0, 0, -(standHeight + (boardThickness / 2))]) {
								translate([(height_mm / 2) - (bottomFromHoles * inch_to_mm), (width_mm / 2) - (cornerRadius * inch_to_mm), 0]) {
									cylinder(r1=(2*holeDiam), r2=(holeDiam), h=standHeight, $fn=50);
								}
								translate([(height_mm / 2) - (bottomFromHoles * inch_to_mm), - (width_mm / 2) + (cornerRadius * inch_to_mm) , 0]) {
									cylinder(r1=(2*holeDiam), r2=(holeDiam), h=standHeight, $fn=50);
								}
								translate([- (height_mm / 2) + (topFromHoles * inch_to_mm), (width_mm / 2) - (cornerRadius * inch_to_mm), 0]) {
									cylinder(r1=(2*holeDiam), r2=(holeDiam), h=standHeight, $fn=50);
								}
								translate([- (height_mm / 2) + (topFromHoles * inch_to_mm), - (width_mm / 2) + (cornerRadius * inch_to_mm) , 0]) {
									cylinder(r1=(2*holeDiam), r2=(holeDiam), h=standHeight, $fn=50);
								}
							}
						}
						// Drill screw holes
						translate([0, 0, -(standHeight + (boardThickness / 2))]) {
							translate([(height_mm / 2) - (bottomFromHoles * inch_to_mm), (width_mm / 2) - (cornerRadius * inch_to_mm), 0]) {
								#cylinder(d=(holeDiam / 2), h=standHeight, $fn=50);
							}
							translate([(height_mm / 2) - (bottomFromHoles * inch_to_mm), - (width_mm / 2) + (cornerRadius * inch_to_mm) , 0]) {
								#cylinder(d=(holeDiam / 2), h=standHeight, $fn=50);
							}
							translate([- (height_mm / 2) + (topFromHoles * inch_to_mm), (width_mm / 2) - (cornerRadius * inch_to_mm), 0]) {
								#cylinder(d=(holeDiam / 2), h=standHeight, $fn=50);
							}
							translate([- (height_mm / 2) + (topFromHoles * inch_to_mm), - (width_mm / 2) + (cornerRadius * inch_to_mm) , 0]) {
								#cylinder(d=(holeDiam / 2), h=standHeight, $fn=50);
							}
						}
					}
				}
			}
		}
		if (!standOnly) {
			translate([0, 0, -(boardThickness)]) {
				rotate([0, 0, 0]) {
					translate([(height_mm / 2) - (bottomFromHoles * inch_to_mm), (width_mm / 2) - (cornerRadius * inch_to_mm), 0]) {
						cylinder(d=holeDiam, h=2*boardThickness, $fn=50);
					}
					translate([(height_mm / 2) - (bottomFromHoles * inch_to_mm), - (width_mm / 2) + (cornerRadius * inch_to_mm) , 0]) {
						cylinder(d=holeDiam, h=2*boardThickness, $fn=50);
					}
					translate([- (height_mm / 2) + (topFromHoles * inch_to_mm), (width_mm / 2) - (cornerRadius * inch_to_mm), 0]) {
						cylinder(d=holeDiam, h=2*boardThickness, $fn=50);
					}
					translate([- (height_mm / 2) + (topFromHoles * inch_to_mm), - (width_mm / 2) + (cornerRadius * inch_to_mm) , 0]) {
						cylinder(d=holeDiam, h=2*boardThickness, $fn=50);
					}
				}
			}
		}
	}
}

/*
 * https://learn.adafruit.com/adafruit-powerboost-1000c-load-share-usb-charge-boost/downloads
 */
pb1000cThickness =  1.7;
pb1000cWidth     = 36.2;
pb1000cLen       = 22.86;
//
function getPowerBooster1000cDims() =  // [x, y, z]
	[pb1000cWidth, pb1000cLen, pb1000cThickness];

module AdafruitPowerboost1000C(withSwitch=false, withStand=false, standOnly=false, standHeight=4) {
	name = "PB 1000C";
	
	dims = getPowerBooster1000cDims();
	
	boardThickness = dims[2]; // 1.7; // mm
	boardWidth     = dims[0]; // 36.2;
	boardHeight    = dims[1]; // 22.86;
	
	betweenScrews = 17.65;
	holeDiam = 2.5; // mm
	cornerRadius = 3; // mm
	
	usbSocketDepth = 18; // 14;   // mm
	usbSocketWidth = 14.5; // mm
	usbSocketHeight = 8;   // mm
	usbHangout = 8;        // mm
	
	// in mm. There is some slack
	switchWidth = 12.5; 
	switchThickness = 5;
	switchDepth = 6;
	topFromUSBSide = 10;
	
	fontSize = 2;
	
	difference() {
		union() {
			if (!standOnly) {
				difference() {
					roundedRect(size=[boardHeight, boardWidth, boardThickness], radius=cornerRadius);
					translate([5.5, 2, 0.5]) {
						linear_extrude(height=1.5, center=true) {
							rotate([0, 0, 60]) {
									translate([-(boardWidth / 2), -(fontSize / 2)]) {
										text(name, fontSize);
								}
							}
						}
					}
				}
				// USB
				translate([0, ((boardWidth - usbSocketDepth) / 2) + usbHangout, (boardThickness + usbSocketHeight) / 2]) {
					rotate([0, 0, 90]) {
						cube(size=[usbSocketDepth, usbSocketWidth, usbSocketHeight], center=true);
					}
				}
				// Side Switch
				if (withSwitch) {
					translate([((boardHeight + switchDepth) / 2), 
					           ((boardWidth - switchWidth) / 2) - (topFromUSBSide), // X pos
					           (boardThickness + switchThickness) / 2]) {
						rotate([0, 0, 90]) {
							cube(size=[switchWidth, switchDepth, switchThickness], center=true);
						}
					}
				}
			}
			if (withStand || standOnly) { // 2 feet, 1 stand, conic
				color("green") {
					difference() {
						union() {
							translate([0, 0, -(standHeight + 0.25)]) {
								translate([(betweenScrews) / 2, - (boardWidth / 2) + cornerRadius, 0]) {
									cylinder(r1=holeDiam * 2, r2=holeDiam, h=2*boardThickness, $fn=50);
								}
								translate([- (betweenScrews) / 2, - (boardWidth / 2) + cornerRadius, 0]) {
									cylinder(r1=holeDiam * 2, r2=holeDiam, h=2*boardThickness, $fn=50);
								}
								// Add one right in the middle
								translate([0, 0, 0]) {
									cylinder(r1=holeDiam * 2, r2=holeDiam, h=2*boardThickness, $fn=50);
								}
							}
						}
						// Drill screw holes in 2 feet
						translate([0, 0, -(standHeight)]) {
								translate([(betweenScrews) / 2, - (boardWidth / 2) + cornerRadius, 0]) {
									cylinder(d=holeDiam/2, h=2*boardThickness, $fn=50);
								}
								translate([- (betweenScrews) / 2, - (boardWidth / 2) + cornerRadius, 0]) {
									cylinder(d=holeDiam/2, h=2*boardThickness, $fn=50);
								}
						}
					}
				}
			}
		}
		// Screw holes
		if (!standOnly) {
			translate([0, 0, -(boardThickness)]) {
				rotate([0, 0, 0]) {
					translate([(betweenScrews) / 2, - (boardWidth / 2) + cornerRadius, 0]) {
						cylinder(d=holeDiam, h=2*boardThickness, $fn=50);
					}
					translate([- (betweenScrews) / 2, - (boardWidth / 2) + cornerRadius, 0]) {
						cylinder(d=holeDiam, h=2*boardThickness, $fn=50);
					}
				}
			}
		}
	}
}

// LiPo cells, 1, 2 or 3 cells (2200 mAh, 4400 mAh, 6600 mAh)
onePkCellDiam = 17.44;
onePkCellLength = 69.3;
//
function getPkCellDims() =  // [diam, len]
	[onePkCellDiam, onePkCellLength];

module PkCell(cellNum=1) {
	dims = getPkCellDims();
	oneDiam = dims[0];
	oneLength =dims[1];
	
	rotate([0, 90, 0]) {
		hull() {
			cylinder(d=oneDiam, h=oneLength, $fn=50, center=true);
			if (cellNum > 1) {
				translate([0, -oneDiam, 0]) {
					cylinder(d=oneDiam, h=oneLength, $fn=50, center=true);
				}
			}
			if (cellNum > 2) {
				translate([0, oneDiam, 0]) {
					cylinder(d=oneDiam, h=oneLength, $fn=50, center=true);
				}
			}
		}
	}
}	

/**
 * Adafruit http://adafru.it/805
 */
// l=12 x w=4.2 x h=6
spdtSlideL = 12;
spdtSlideW =  4.2;
spdtSlideH =  6;
//
function getSpdtSlideDims() =  // [x, y, z]
	[spdtSlideL, spdtSlideW, spdtSlideH];

module spdtSlideSwitch() {

	recessLength = 6.0;

	dims = getSpdtSlideDims();
	union() {
		// Main box
		rotate([0, 0, 0]) {
			translate([0, 0, 0]) {
				union() {
					color("silver") {
						difference() {
							cube(size=[dims[0], dims[1], dims[2]], center=true);
							// recess
							translate([0, 0, (dims[2] / 2) - (0.25 / 2) + 0.001]) { 
								cube(size=[recessLength, 2.1, 0.25], center=true);
							}
						}
					}
					// switch
					color("black") {
						translate([(recessLength / 2) - (2.1 / 2), 0, (recessLength / 2) - (0.25 / 2) + 0.001]) { 
							cube(size=[2.1, 2.1, 2.1], center=true);
						}
					}
					// pins
					pinLen = 5.8;
					pinSide = 0.5;
					for (i = [-3, 0, 3]) {
						translate([i, 0, -((dims[2] / 2) + (pinLen / 2) - 0.001)]) {
							color("grey") {
								cube([pinSide, pinSide, pinLen], center=true);
							}
						}
					}
				}
			}
		}
	}
}

// l=8.74 x w=4.0 x h=3.65
smallSlideL = 8.74;
smallSlideW =  4.0;
smallSlideH =  3.65;
//
function getSmallSlideDims() =  // [x, y, z]
	[smallSlideL, smallSlideW, smallSlideH];

module smallSlideSwitch() {
	
	recessLength = 3.5;
	
	dims = getSmallSlideDims();
	union() {
		// Main box
		rotate([0, 0, 0]) {
			translate([0, 0, 0]) {
				union() {
					color("silver") {
						difference() {
							cube(size=[dims[0], dims[1], dims[2]], center=true);
							// recess
							translate([0, 0, (dims[2] / 2) - (0.25 / 2) + 0.001]) { 
								cube(size=[recessLength, 1.68, 0.25], center=true);
							}
						}
					}
					// switch
					color("black") {
						translate([(recessLength / 2) - (1.68 / 2), 0, (recessLength / 2) - (0.25 / 2) + 0.001]) { 
							cube(size=[1.68, 1.68, 1.68], center=true);
						}
					}
					// pins
					pinLen = 5.8;
					pinSide = 0.5;
					for (i = [-3, 0, 3]) {
						translate([i, 0, -((dims[2] / 2) + (pinLen / 2) - 0.001)]) {
							color("grey") {
								cube([pinSide, pinSide, pinLen], center=true);
							}
						}
					}
				}
			}
		}
	}
}

/**
 * Actobotics 615464, 27 Tooth Work Spur Gear
 * https://www.servocity.com/27-1-worm-gear-set-6mm-to-1-4-bore-worm-hub-mount-worm-gear
 */
spurGearOD = inch_to_mm * 1.176;
spurGearID = inch_to_mm * 0.850;
spurGearThickness = inch_to_mm * 0.30;
spurGearBottomThickness = inch_to_mm * 0.125;
spurGearMainAxisDiam = inch_to_mm * 0.315;
spurGearScrewDiam = inch_to_mm * 0.140;
spurGearScrewFromCenter = inch_to_mm * 0.575 / 2;

function getSpurGearThickness() =
  spurGearThickness;

function getSpurGearOD() =
  spurGearOD;
	
function getSpurGearScrewDiam() = 
  spurGearScrewDiam;

module actobotics615464(justDrillHoles=false, holeDepth=20, holeDiam=spurGearScrewDiam) {
  
	if (!justDrillHoles) {
		difference() {
			// Main gear
			translate([0, 0, 0]) {
				rotate([0, 0, 0]) {
					cylinder(d=spurGearOD, h=spurGearThickness, $fn=27);
				}
			}
			// Recess
			translate([0, 0, spurGearBottomThickness]) {
				rotate([0, 0, 0]) {
					cylinder(d=spurGearID, h=spurGearThickness, $fn=100);
				}
			}
			// Main axis
			translate([0, 0, -1]) {
				rotate([0, 0, 0]) {
					cylinder(d=spurGearMainAxisDiam, h=spurGearThickness, $fn=50);
				}
			}

			// Screw holes
			for (i=[0, 90, 180, 270]) {
				rotate([0, 0, i]) {
					translate([spurGearScrewFromCenter, 0, -1]) {
						cylinder(d=holeDiam, h=spurGearThickness, $fn=50);
					}
				}
			}
		}	
	} else {
		echo(str("Drilling at ", holeDiam, "mm"));
		for (i=[0, 90, 180, 270]) {
			rotate([0, 0, i]) {
				translate([spurGearScrewFromCenter, 0, - holeDepth]) {
					cylinder(d=holeDiam, h=(spurGearBottomThickness + holeDepth), $fn=50);
				}
			}
		}
	}
}

/**
 * Actobotics 615462
 * 1/4" D-Bore Worm Gear
 */
module actobotics615462(axisOnly=false, axisLength=100) {
	totalLength = inch_to_mm * 1.15;
	extDiam = inch_to_mm * 0.5;
	
	// Axis
	axisDiam1 = 6;
	axisDiam2 = inch_to_mm * 0.25;

	gearThickness = getSpurGearThickness();
	
	if (!axisOnly) {
		difference() {
			// Worm Gear
			translate([0, totalLength / 2, gearThickness / 2]) {
				rotate([90, 0, 0]) {
					cylinder(d=extDiam, h=totalLength, $fn=100);
				}
			}
			// Axis
			// 6mm, left
			translate([0, 0, gearThickness / 2]) {
				rotate([90, 0, 0]) {
					cylinder(d=axisDiam1, h=axisLength / 2, $fn=100);
				}
			}
			// 1/4", right	
			translate([0, axisLength / 2, gearThickness / 2]) {
				rotate([90, 0, 0]) {
					cylinder(d=axisDiam2, h=axisLength / 2, $fn=100);
				}
			}
		}
	}
	if (axisOnly) {
		// 6mm, left
		translate([0, 0, gearThickness / 2]) {
			rotate([90, 0, 0]) {
				cylinder(d=axisDiam1, h=axisLength / 2, $fn=100);
			}
		}
		// 1/4", right	
		translate([0, axisLength / 2, gearThickness / 2]) {
			rotate([90, 0, 0]) {
				cylinder(d=axisDiam2, h=axisLength / 2, $fn=100);
			}
		}
	}
}

module pinion32P16T() {
	baseDiam = 12;
	pinionDiam = 14.2;
	screwDiam = 4;
	screwLen = 4;
	axisDiam = 5; // Axis 5mm
	difference() {
		union() {
			rotate([0, 0, 0]) {
				translate([0, 0, 0]) {
					// Base
					cylinder(d=baseDiam, h=14, $fn=16, center=false);
				}
				translate([0, 0, 0]) {
					// Top
					cylinder(d=pinionDiam, h=7.5, $fn=16, center=false);
				}
			}
			rotate([0, 90, 0]) {
				translate([-10.5, 0, ((baseDiam - screwLen) / 2)]) {
					// Screw
					color("black") {
						cylinder(d=screwDiam, h=screwLen, $fn=20, center=false);
					}
				}
			}
		}
		rotate([0, 0, 0]) {
			translate([0, 0, -0.5]) {
				cylinder(d=axisDiam, h=15, $fn=50);
			}
		}
	}
}

/**
 * ActoBotics 615222
 * 32 pitch, 76 teeth, 1.00" bore.
 */
module actoBotics615222(stand = false,
                        gear = true,
                        standThickness = 10,
                        redrillHoles = false,
                        drillLength = -1,
                        redrillDiam = -1) {
	od = 2.437 * inch_to_mm;
	thickness = (1 / 4) * inch_to_mm;
	boreDiam = 1 * inch_to_mm;
	innerRecessDiam = 55.8;
	innerThicknsess = (1 / 8) * inch_to_mm;
	screwCircleDiam = 1.5 * inch_to_mm;
	screwDiam = 0.140 * inch_to_mm;
	nbScrews = 16;
	
	if (gear) {
        // Ony the gear
		difference() {
			translate([0, 0, 0]) {
                color("silver") {
                    cylinder(d=od, h=thickness, $fn=76);
                }
			}
			// Inner milling
			translate([0, 0, innerThicknsess]) {
				cylinder(d=innerRecessDiam, h=thickness, $fn=100);
			}
			// Bore
			translate([0, 0, -0.5]) {
				cylinder(d=boreDiam, h=thickness, $fn=100);
			}
			// Screws
			for (i = [0 : 15]) { // 16 screws
				angle = i * (360 / 16);
				rotate([0, 0, angle]) {
					translate([-(screwCircleDiam / 2), 0, -0.5]) {
						cylinder(d=screwDiam, h=thickness, $fn=20);
					}
				}
			}
		}
	}
  if (stand) { // Only the stand
		difference() {
			translate([0, 0, 0]) {
				cylinder(d=od * 0.8, h=standThickness, $fn=200);
			}			
			// Screws
			for (i = [0 : 15]) { // 16 screws
				angle = i * (360 / 16);
				rotate([0, 0, angle]) {
					translate([-(screwCircleDiam / 2), 0, -0.5]) {
						cylinder(d=screwDiam, h=standThickness * 1.1, $fn=20);
					}
				}
			}
		}
	}
  if (redrillHoles) {
        holeLength = drillLength == -1 ? standThickness * 1.1: drillLength;
        drillDiam = redrillDiam == -1 ? screwDiam : redrillDiam;
        for (i = [0 : 15]) { // 16 screws
            angle = i * (360 / 16);
            rotate([0, 0, angle]) {
                translate([-(screwCircleDiam / 2), 0, -0.5]) {
                    cylinder(d=drillDiam, h=holeLength, $fn=20);
                }
            }
        }
    }
}

/*
 * Tests
 */
echo("For tests and dev only");
echo("------------------------------");
echo("Contains the following modules:");
echo("- roundedRect");
echo("- ballBearing");
echo("- metalScrewCS");
echo("- metalScrewHB");
echo("- hexNut");
echo("- washer");
echo("- B10K (linear potentiometer)");
echo("- servoParallax900_00005");
echo("- MCP73871_USB_Solar");
echo("- AdafruitPowerboost1000C");
echo("- PkCell (batteries)");
echo("- spdtSlideSwitch");
echo("- smallSlideSwitch");
echo("- actobotics615464");
echo("- pinion32P16T");
echo("- actoBotics615222");
echo("------------------------------");
echo("When appropriate, components dimensions are externalized, and accessible through functions, from other modules");
echo("------------------------------");

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
if (false) { // B10K test
	translate([-10, 0, 0]) {
		B10K(small=false);
	}
	translate([10, 0, 0]) {
		B10K(small=true);	
	}
}

if (false) { // servoParallax900_00005 test
	servoParallax900_00005(drillPattern=false);
}

if (false) { // MCP73871_USB_Solar test
	MCP73871_USB_Solar(bigHangout=false, withStand=true, standOnly=false);
}

if (false) { // AdafruitPowerboost1000C test
	AdafruitPowerboost1000C(withSwitch=true, withStand=true, standOnly=false);
}

if (false) { // PkCell test
	PkCell(3);
}

if (false) { // spdtSlideSwitch test
	spdtSlideSwitch();
}

if (false) { // smallSlideSwitch test
	smallSlideSwitch();
}

if (false) { // Small SLide Switch test	
	translate([0, -5, 0]) {
	  spdtSlideSwitch();
	}
	translate([0, 5, 0]) {
		smallSlideSwitch();
	}
}
if (false) { // actobotics615464 + actobotics615462 test
	difference() {
		actobotics615464(); // The gear
		#actobotics615464(justDrillHoles=true, // Drilling
											holeDepth=20,
											holeDiam=3); // spurGearScrewDiam); 
	}
	BETWEEN_AXIS = 19; // mm
	translate([BETWEEN_AXIS, 0, 0]) { // Worm gear
		actobotics615462();
		%actobotics615462(axisOnly=true);
	}
}
if (false) {
	pinion32P16T();
}	

if (false) {
	actoBotics615222();
}

if (true) {
	// Just a wheel stand, for print test
	difference() {
		// Wheel stand
		actoBotics615222(stand=true,
                     gear=true,
                     redrillHoles=false,
                     standThickness=10);
		// With an axis, drilled
		translate([0, 0, -2]) {
			cylinder(d=5, h=20, $fn=50);
		}
    // Redrill screw holes
    actoBotics615222(stand=false,
             gear=false,
             redrillHoles=true,
             drillLength=40 /*,
             redrillDiam = 6 */);

	}
}

if (false) {
	// A wheel
	actoBotics615222();       
	translate([37.5, 0, 0]) {
		// A pinion
	  pinion32P16T();
	}
	translate([0, 0, -15]) {
		difference() {
			// Wheel stand
			actoBotics615222(stand=true,
											 standThickness=10);
			// With an axis, drilled
			translate([0, 0, -2]) {
				cylinder(d=5, h=20, $fn=50);
			}
		}
	}
}