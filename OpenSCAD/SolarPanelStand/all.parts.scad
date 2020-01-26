/**
 * @author OlivierLD
 *
 * The full stand... Using other scad files.
 *
 * To set the required option, see the option variable at the bottom of the script.
 */
use <./mechanical.parts.scad>
use <./grooved.cylinder.scad>

echo(version=version());

module ballBearingStand(diam,
												axisHeight,
												fixingFootSize, 
												fixingFootWidth, 
												screwDiam, 
												minWallThickness) {
  bbDims = getBBDims(diam); // [ID, OD, Thickness]		
	bottomToAxis = max(axisHeight, fixingFootSize);									
  difference() {														
		union() {												
			translate([0, (fixingFootSize / 2) + (bbDims[1] / 2), fixingFootSize / 2]) {
				fixingFoot(fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
			}
			rotate([0, 0, 180]) {
				translate([0, (fixingFootSize / 2) + (bbDims[1] / 2), fixingFootSize / 2]) {
					fixingFoot(fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
				}
			}
			translate([0, 0, bottomToAxis / 2]) {
				cube(size=[fixingFootWidth, bbDims[1] * 1.1, bottomToAxis], center=true);
			}
			translate([0, 0, bottomToAxis]) {
				rotate([0, 90, 0]) {
					cylinder(h=fixingFootWidth, d=(bbDims[1] * 1.1), $fn=50, center=true);
				}
			}
		}
		// The socket itself
		rotate([0, 90, 0]) {
			translate([-bottomToAxis, 0, (fixingFootWidth / 2) - (bbDims[2] * .9 / 2)]) {
				cylinder(h=bbDims[2], d=(bbDims[1]), $fn=50, center=true);		
			}
		}
		// Drill
		rotate([0, 90, 0]) {
			translate([-bottomToAxis, 0, 0]) {
				cylinder(h=fixingFootWidth * 1.1, d=diam * 1.1, $fn=50, center=true);		
			}
		}
	}										
}

// Horizontal axis for the worm gear
module wormGearAxis(axisThickness, centerOffset, axisHeight, cylLen=150) {
	rotate([90, 0, 0]) {
		translate([centerOffset, axisHeight]) {
			cylinder(h=cylLen, d=axisThickness, center=true, $fn=50);
		}
	}
}

CARD_POINTS = ["N", "W", "S", "E"]; // yes, counter-clockwise

// Grooved cylinder with feet
module footedBase(cylHeight, 
									extDiam, 
									torusDiam, 
									intDiam, 
									ballsDiam, 
									fixingFootSize, 
									fixingFootWidth, 
									screwDiam, 
									minWallThickness,
									withIndex=true,
									fullIndex=true) {
	difference() {
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
					cylinder(h=50, d=5, center=true, $fn=50);
				}
			}
		}
		// Engraving on cylinder?
		if (withIndex) {
			bigIndexHeight   = 8;
			smallIndexHeight = 5;
			if (fullIndex) {
				offset = 3;
				for (angle = [0:5:359]) {
					// echo("Angle: ", angle);
					indexHeight = (angle % 45 == 0) ? bigIndexHeight : smallIndexHeight;
					rotate([0, 0, angle]) {
						translate([(extDiam / 2) - 0.5, 
											 0, 
											 cylHeight - offset - (indexHeight / 2)]) {
							color("cyan") {
								cube(size=[1, 1, indexHeight], center=true);
							}
						}
						if (angle % 90 == 0) {
							fontSize = 6;
							str = CARD_POINTS[angle / 90];
							// echo("For ", angle, " => ", str);
							translate([(extDiam / 2) - 0.5, 
											 0, 
											 cylHeight - indexHeight - fontSize - 1]) {
								rotate([90, 0, 90]) {
									color("red") {
										linear_extrude(1.5, center=true, convexity=4) {
											text(str, valign="center", halign="center", size=fontSize);
										}
									} 
								}
							}
						}
					}
				}
			} else { // Just one
				indexHeight = bigIndexHeight;
				rotate([0, 0, 0]) {
					translate([(extDiam / 2) + 3,  // TODO Fix all that...
										 0, 
										 cylHeight - (indexHeight / 2) - 1]) {
						color("cyan") {
							cube(size=[12, 1, indexHeight], center=true);
						}
					}
				}
			}
		}
	}
}

// For the bases with feet
module drillingPattern(extDiam, fixingFootSize, screwDiam, wallThickness, length=100) {
	// 0.2 is the drilling offset in the foot. See in grooved.cylinder.scad.
	radius = (extDiam / 2) + (fixingFootSize / 2) + (fixingFootSize * 0.2) - wallThickness; // + (screwDiam / 2);
	for (angle = [0, 120, 240]) {				
		rotate([0, 0, angle - 90]) {
			translate([0, radius]) {
				cylinder(h=length, d=screwDiam, center=true, $fn=50);
			}
		}		
	}
}

// Same as above, with screws
module screws(extDiam, fixingFootSize, screwDiam, wallThickness, length=50) {
	// 0.2 is the drilling offset in the foot. See in grooved.cylinder.scad.
	radius = (extDiam / 2) + (fixingFootSize / 2) + (fixingFootSize * 0.2) - wallThickness; // + (screwDiam / 2);
	for (angle = [0, 120, 240]) {				
		rotate([0, 0, angle - 90]) {
			translate([0, radius]) {
				metalScrewCS(screwDiam, length);
			}
		}		
	}
}

module axisDrillingPattern(length=100, diam=5) {
	cylinder(h=length, d=diam, center=true, $fn=50);
}

FLAP_THICKNESS = 5;
OVERLAP = 5;
SLOT_WIDTH = 1;

module flatSide(base, height, top, holeDiam=5) {
	points = [ 
		[-base / 2, 0],
		[base / 2, 0],
		[top / 2, height],
		[-top / 2, height]
	];
	paths = [[0, 1, 2, 3]];
	
	overlap = OVERLAP;
	flapThickness = FLAP_THICKNESS;
	slotWidth = SLOT_WIDTH;
	
	difference() {
		union() {
			polygon(points, paths, convexity=10);
			// Rounded top
			translate([(top / 6), height]) {
				circle(d=2 * top / 3, $fn=50);
			}
			translate([-(top / 3) + (overlap / 2), height + (flapThickness / 2) + slotWidth]) {
				square(size=[overlap + (top / 3), flapThickness], center=true);
			}
		}
		translate([-(top / 6), height + (slotWidth / 2)]) {
			square(size=[2 * (top / 3), slotWidth], center=true);
		}
		translate([(top / 6), height]) {
			circle(d=holeDiam, $fn=50);
		}
		// Nut socket
		translate([(- top / 3), height - (3 * flapThickness / 2)]) {
			square(size=[flapThickness * 1.5, // TODO That one depends on the screw diameter
			             flapThickness], 
						 center=true);
		}
	}
}
 
module oneSolidSide(base, height, top, thickness, holeDiam=5) {  
	linear_extrude(height=thickness, center=true) {
		flatSide(base, height, top, holeDiam);
	}
}

module oneDrilledSide(base, height, top, thickness, holeDiam, flapScrewDiam, bbDiam=16, left=true) {
	if (true) { // New version
		screwLength = FLAP_THICKNESS * 3;
		difference() {
			oneSolidSide(base, height, top, thickness, holeDiam);
			// Flap Screw
			rotate([90, 0, 0]) {
				translate([-(top / 3), 
									 0, 
									 -(height + (FLAP_THICKNESS) + SLOT_WIDTH - screwLength + 0.1) ]) {
					rotate([180, 0, 0]) {				
						// Use this for countersunk head
						metalScrewCS(flapScrewDiam, screwLength);
						// Use this for hexagonal head
						// cylinder(d=flapScrewDiam, h=screwLength, $fn=50);
					}
				}
			}
		}
	} else {
		difference() {
			oneSolidSide(base, height, top, thickness);
			// The top axis
			translate([0, height, 0]) {
				cylinder(h=thickness * 2, d=holeDiam, center=true, $fn=50);
			}
			// Ball bearing socket
			translate([0, height, (left ? 1 : -1) * (0.5 * thickness / 3)]) {
				cylinder(h=thickness, d=bbDiam, center=true, $fn=50);
			}
		}
	}
}

/**
 * For pre-viewing only, not to print.
 * Can be used with a difference() for a motor socket.
 * Datasheet at http://www.mosaic-industries.com/embedded-systems/microcontroller-projects/stepper-motors/specifications
 * Defvault values for NEMA-17
 */
module motor(motorSide=42.32, 
						 motorDepth=39, 
						 motorAxisDiam=5, 
						 axisStageThickness=2,
						 axisStageDiam=22,
						 motorAxisLength=24, 
						 betweenScrews=31, 
						 screwDiam=3, 
						 withScrews=false, 
						 screwLen=10,
						 wallThickness=0,
						 label="NEMA-17") {
	
	axisHangingFromBox = 	motorAxisLength + axisStageThickness;				 
	union() {
		// Motor
		difference() {
			cube(size=[motorSide, motorDepth, motorSide], center=true);
			translate([-motorSide / 2, 0, 0]) {
				rotate([90, 0, -90]) {
					color("green") {
						linear_extrude(1.5, center=true, convexity=4) {
							resize([motorDepth * 0.75, 0], auto=true) {
								text(label, valign = "center", halign = "center");
							}
						}
					}
				}
			}
		}
		
		// Axis stage and axis
		offset = 5; // Stuck inside (usefull when difference()...)
		rotate([90, 0, 0]) {
			// Axis stage
			translate([0, 0, -(motorDepth / 2) - axisStageThickness]) {
				color("orange") {
					cylinder(h=axisStageThickness + 1, d=axisStageDiam, $fn=100); // + 1 is an offset, for difference()...
				}
			}
			// Axis
			translate([0, 0, -((axisHangingFromBox / 2) + (motorDepth / 2) - offset)]) {
				color("white") {
					cylinder(h=axisHangingFromBox + (offset * 2), d=motorAxisDiam, center=true, $fn=50);
				}
			}
		}
		// Screws. Assuming the motor face is square.
		rotate([90, 0, 0]) {
			for (i = [0:1]) {
				for (j = [0:1]) {
					color("grey") {
						if (!withScrews) {
							translate([	-(betweenScrews / 2) + (i * betweenScrews), 
												-(betweenScrews / 2) + (j * betweenScrews), 
												-(motorAxisLength)]) {
								cylinder(h=motorAxisLength * 2.1, d=screwDiam, center=true, $fn=50);
							}
						} else {
							headThickness = getHBScrewDims(screwDiam)[0];
							translate([	-(betweenScrews / 2) + (i * betweenScrews), 
												-(betweenScrews / 2) + (j * betweenScrews), 
												-((motorDepth / 2) - screwLen + wallThickness)]) {
								rotate([180, 0, 0]) {					
									metalScrewHB(screwDiam, screwLen);
								}
							}
						}
					}
				}
			}
		}
	}
}

module mainStand(totalStandWidth, 
								 length, 
								 height, 
								 topWidth, 
								 thickness, 
								 mainAxisDiam, 
								 motorSide, 
								 motorDepth,
								 motorAxisDiam, 
								 motorAxisLength, 
								 betweenScrews,
								 screwDiam,
								 flapScrewDiam,
								 bbDiam,
								 withMotor=false) {
	// left
	translate([0, totalStandWidth / 2, 0]) {
		rotate([90, 0, 0]) {
			color("red") {
				oneDrilledSide(length, height, topWidth, thickness, mainAxisDiam, flapScrewDiam);
			}
		}
	}
	// right /*, with the motor socket */
	difference() {
		translate([0, -totalStandWidth / 2, 0]) {
			rotate([90, 0, 0]) {
				color("green") {
					oneDrilledSide(length, height, topWidth, thickness, mainAxisDiam, flapScrewDiam);
				}
			}
		}
		if (false) {
			color("silver") {
				// Motor socket
				translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
					motor(motorSide, 39, motorAxisDiam, motorAxisLength, betweenScrews, screwDiam);
				}
			}
		}
	}
	if (withMotor) {
		translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
			motor(motorSide, 39, motorAxisDiam, motorAxisLength, betweenScrews, screwDiam);
		}
	}		
	// base
	translate([0, 0, -thickness / 2]) {
		color("turquoise") {
			cube([length, totalStandWidth + thickness, thickness], center=true);
		}
	}
}

module oneBracketSide(mainAxisDiam,
										  bbDiam=16, // Ball Bearing diam
										  sizeAboveAxis,
											sizeBelowAxis,
											thickness=10,
											plateWidth,
											bottomCylinderDiam) {
	heightOutAll = sizeAboveAxis + sizeBelowAxis;													
  difference() {												
		cube([thickness, plateWidth, (heightOutAll)], center=true);
		rotate([90, 0, 90]) {
			translate([0, (heightOutAll / 2) - sizeAboveAxis, 0]) {
				cylinder(h=thickness * 1.1, d=bbDiam, center=true, $fn=true);
			}
		}
		// drill for the cylinder threaded rod
		rotate([90, 0, 90]) {
			translate([0, (- (heightOutAll/2) + (bottomCylinderDiam / 2)), 0]) {
				cylinder(h=thickness * 3, d=4, center=true, $fn=true); // TODO 4: prm
			}
		}
	}
}

module counterweightCylinder(length, extDiam, thickness) {
	difference() {
		cylinder(d=extDiam, h=length, $fn=100, center=true);
		cylinder(d=extDiam - thickness, h=length * 1.1, $fn=100, center=true);
	}
}

module panelBracket(mainAxisDiam,
										bbDiam=16, // Ball Bearing diam
										sizeAboveAxis,
										sizeBelowAxis,
										widthOutAll,
										thickness=10,
										plateWidth,
										betweenAxis, // between main axis and motor axis
										bottomCylinderDiam,
										motorDepth=39,
										withMotor=false,
										withCylinder=false) {

  heightOutAll = sizeAboveAxis + sizeBelowAxis;
	cylinderThickness = 1;
  // right
	translate([(widthOutAll / 2) - (thickness / 2), 0, 0]) {
		color("green") {
			difference() {
				oneBracketSide(mainAxisDiam,
											 bbDiam,
											 sizeAboveAxis,
											 sizeBelowAxis,
											 thickness,
											 plateWidth,
											 bottomCylinderDiam);
				// Motor socket here
				rotate([0, 0, -90]) {
					translate([0, -motorDepth / 2, (heightOutAll / 2) - sizeAboveAxis - betweenAxis]) {
						motor(withScrews=false, wallThickness=thickness / 2); // TODO Tweak thickness
					}
				}
			}
		}
		if (withMotor) {
			rotate([0, 0, -90]) {
				translate([0, -motorDepth / 2, (heightOutAll / 2) - sizeAboveAxis - betweenAxis]) {
					motor(withScrews=true, wallThickness=thickness / 2); // TODO Tweak thickness
				}
			}
		}
	}

  // left
	translate([- ((widthOutAll / 2) - (thickness / 2)), 0, 0]) {
		// No need to flip it if the ball bearing goes throught the full stuff
		color("red") {
			oneBracketSide(mainAxisDiam,
										 bbDiam,
										 sizeAboveAxis,
										 sizeBelowAxis,
										 thickness,
										 plateWidth,
										 bottomCylinderDiam);
		}
	}
	
	// top
	translate([0, 0, (heightOutAll / 2) - (thickness / 2)]) {
		difference() {
			color("cyan") {
				cube(size=[widthOutAll, plateWidth, thickness], center=true);
			}
			color("green") {
				// Write on it
				translate([0, 0, (thickness / 2)]) {
					linear_extrude(1.5, center=true, convexity = 4) {
						resize([widthOutAll * 0.75, 0], auto=true) {
							text("Panel stuck here", valign="center", halign="center");
						}
					}
				}
			}
		}
	}
	
	// bottom cylinder 
	plateThickness = 1.5;
	// Plugs on each side
	difference() {
		union() {
			// right plug
			translate([(widthOutAll / 2) - thickness, 0, -(heightOutAll / 2) + (bottomCylinderDiam / 2)]) {
				rotate([0, 90, 0]) {
					color("orange") {
						cylinder(h=plateThickness, d=bottomCylinderDiam, center=true);
						cylinder(h=4, d=bottomCylinderDiam - (2 * cylinderThickness), center=true); 
					}
				}
			}
			// left plug
			translate([ - (widthOutAll / 2) + thickness, 0, -(heightOutAll / 2) + (bottomCylinderDiam / 2)]) {
				rotate([0, -90, 0]) {
					color("orange") {
						cylinder(h=plateThickness, d=bottomCylinderDiam, center=true);
						cylinder(h=4, d=bottomCylinderDiam - (2 * cylinderThickness), center=true);
					}
				}
			}
		}
		// Drill cylinder's axis holes
		translate([0, 0, -(heightOutAll / 2) + (bottomCylinderDiam / 2)]) {
			rotate([0, 90, 0]) {
				color("grey") {
					cylinder(h=(widthOutAll * 1.1), d=4, $fn=100, center=true); // 4: axis diam
				}
			}
		}
	}
	// The cylinder itself
	if (withCylinder) {
		// bottom axis (cylinder)
		translate([0, 0, -(heightOutAll / 2) + (bottomCylinderDiam / 2)]) {
			rotate([0, 90, 0]) {
				color("grey") {
					cylinder(h=(widthOutAll * 1.1), d=4, $fn=100, center=true); // 4: axis diam
				}
			}
		}
	
		translate([0, 0, -(heightOutAll / 2) + (bottomCylinderDiam / 2)]) {
			rotate([0, 90, 0]) {
				color("yellow") {
					cylinderLength = widthOutAll - (2 * thickness) - (2 * plateThickness);
					counterweightCylinder(cylinderLength, bottomCylinderDiam, cylinderThickness);
				}
			}
		}
	}
}

// Options
cylHeight = 50;
cylHeight2 = 35;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;
verticalAxisDiam = 5;

fixingFootSize = 20;
fixingFootWidth = 20;
screwDiam = 4;
screwLen = 30;
minWallThickness = 5;

workGearAxisDiam = 10;

_totalStandWidth = 160;
_length = 160;
_height = 150;
_topWidth = 35;
_thickness = 10;
_horizontalAxisDiam = 10;
_motorSide = 42.3;
_motorDepth = 39;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5; // vertical one
_screwDiam = 3;
_flapScrewDiam = 3;
_bbDiam = 16;

_sizeAboveAxis = 100; // Tossion!
_sizeBelowAxis = 130; // Tossion!
_widthOutAll = 90;
_plateWidth = 60;
_betweenAxis = 60;
_bottomCylinderDiam = 35;

NONE = -1;

FULL_BASE = 1;
FULL_BASE_WITH_WORM_GEAR = 2;
MAIN_STAND = 3;
FLAT_SIDE = 4;
ONE_DRILLED_SIDE = 5;
MOTOR = 6;
MOTOR_SOCKET = 7;
ONE_BRACKET_SIDE = 8;
FULL_BRACKET = 9;
BALL_BEARING_STAND = 10;

option = NONE;

if (option == FULL_BASE) {
  footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
} else if (option == FULL_BASE_WITH_WORM_GEAR) {
	union() {
		difference() {
			footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
			#wormGearAxis(workGearAxisDiam, extDiam / 3, cylHeight / 2);	
		}
		if (false) { // Drilling patterns or screws.
			color("grey", 0.6) {
				drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness);
			}
		} else {
			color("grey", 0.6) {
				translate([0, 0, -10]) {
					screws(extDiam, fixingFootSize, screwDiam, minWallThickness, 30);
				}
			}
		}
		color("green", 0.6) {
			axisDrillingPattern();
		}
	}
} else if (option == MAIN_STAND) {
	mainStand(_totalStandWidth, 
						_length, 
						_height, 
						_topWidth, 
						_thickness, 
						_horizontalAxisDiam, 
						_motorSide, 
						_motorDepth,
						_motorAxisDiam, 
						_motorAxisLength, 
						_betweenScrews,
						_screwDiam,
						_flapScrewDiam,
						_bbDiam,
						false);
} else if (option == FLAT_SIDE) {
	flatSide(_length, _height, _topWidth);
} else if (option == ONE_DRILLED_SIDE) {
	oneDrilledSide(_length, _height, _topWidth, _thickness, _horizontalAxisDiam, _flapScrewDiam);
} else if (option == MOTOR) {
	motor(withScrews=true, wallThickness=3);
} else if (option == MOTOR_SOCKET) {
		/* Default vaklues for motor:
				motorSide=42.32, 
				motorDepth=39, 
				motorAxisDiam=5, 
				motorAxisLength=24, 
				betweenScrews=31, 
				screwDiam=3, 
				withScrews=false, 
				screwLen=10,
				wallThickness=0		 
		*/
	
	translate([0, 0, 60]) {
			motor(withScrews=true, wallThickness=3);
	}
	
	translate([30, 0, 0]) {
		cubeThickness = 20;
		motorDepth = 39;
		wallThickness = 3;
		union() {
			#cube(size=[50, cubeThickness, 50], center=true);
			translate([0, - ((motorDepth / 2) - (cubeThickness / 2) + wallThickness), 0]) {
				motor(withScrews=true, wallThickness=wallThickness);
			}
		}
	}
	translate([-30, 0, 0]) {
		cubeThickness = 20;
		motorDepth = 39;
		wallThickness = 3;
		difference() {
			cube(size=[50, cubeThickness, 50], center=true);
			translate([0, - ((motorDepth / 2) - (cubeThickness / 2) + wallThickness), 0]) {
				motor(withScrews=false, wallThickness=wallThickness);
			}
		}
	}
} else if (option == ONE_BRACKET_SIDE) {
	oneBracketSide(_horizontalAxisDiam,
								 _bbDiam,
								 _sizeAboveAxis,
								 _sizeBelowAxis,
								 _thickness,
								 _plateWidth,
								 _bottomCylinderDiam);
} else if (option == FULL_BRACKET) {
	translate([-_widthOutAll, 0, 0]) {
		panelBracket(_horizontalAxisDiam,
								_bbDiam,
								_sizeAboveAxis,
								_sizeBelowAxis,
								_widthOutAll,
								_thickness,
								_plateWidth,
								_betweenAxis, // between main axis and motor axis
								_bottomCylinderDiam,
								withMotor=false,
								withCylinder=false);
	}
	cylinderLength = _widthOutAll - (2 * _thickness) - (2 * _thickness);
	cylinderThickness = 1;
	color("yellow") {
		counterweightCylinder(cylinderLength, _bottomCylinderDiam, cylinderThickness);
	}
	
	translate([_widthOutAll, 0, 0]) {
		panelBracket(_horizontalAxisDiam,
								_bbDiam,
								_sizeAboveAxis,
								_sizeBelowAxis,
								_widthOutAll,
								_thickness,
								_plateWidth,
								_betweenAxis, // between main axis and motor axis
								_bottomCylinderDiam,
								withMotor=true,
								withCylinder=true);
	}
} else if (option == BALL_BEARING_STAND) {
	echo("FootSize", fixingFootSize, " width", fixingFootWidth);
	ballBearingStand(6,
									 30,
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness);
} else {
	if (option != NONE) {
		echo(str("Unknown option for now [", option, "]"));
	}
}

// ----------------------------------------
// Modules for printing
module printBracket() {
	panelBracket(_horizontalAxisDiam,
							 _bbDiam,
							 _sizeAboveAxis,
							 _sizeBelowAxis,
							 _widthOutAll,
							 _thickness,
							 _plateWidth,
							 _betweenAxis, // between main axis and motor axis
							 _bottomCylinderDiam,
							 withMotor=false,
							 withCylinder=false);
}
module printBase1() {
	union() {
		difference() {
			footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
			wormGearAxis(workGearAxisDiam, extDiam / 3, cylHeight / 2);	
		}
		// Bottom ball bearing socket.
		dims = getBBDims(verticalAxisDiam); // [id, od, t]
		bbSocketBaseThickness = 3;
		socketWallThickness = 3;
		difference() {
			translate([0, 0, 0]) {
				rotate([0, 0, 0]) {
					cylinder(d=dims[1] + socketWallThickness, h=(dims[2] * 0.9) + bbSocketBaseThickness, $fn=50);
				}
			}
			translate([0, 0, bbSocketBaseThickness]) {
				rotate([0, 0, 0]) {
					cylinder(d=dims[1], h=dims[2], $fn=50);
				}
			}
			translate([0, 0, -1]) { // Drill
				rotate([0, 0, 0]) {
					cylinder(d=dims[0], h=dims[2] * 2, $fn=50);
				}
			}
		}
	}
}
module printBase2() {
  footedBase(cylHeight2, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness, fullIndex=false);
}
module printMainStand() {
	difference() {
		mainStand(_totalStandWidth, 
							_length, 
							_height, 
							_topWidth, 
							_thickness, 
							_horizontalAxisDiam, 
							_motorSide, 
							_motorDepth,
							_motorAxisDiam, 
							_motorAxisLength, 
							_betweenScrews,
							_screwDiam,
							_flapScrewDiam,
							_bbDiam,
							false);
		translate([0, 0, 0]) {
			drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, 100);
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			axisDrillingPattern(length=100);
		}
	}
}
module printCylinder() {
	cylinderLength = _widthOutAll - (2 * _thickness) - (2 * _thickness);
	cylinderThickness = 1;
	counterweightCylinder(cylinderLength, _bottomCylinderDiam, cylinderThickness);	
}
module printBallBearingStand() {
	ballBearingStand(6,
									 30,
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness);
}
module customPrint() { // You choose!
	footedBase(40, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
}
echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design at the bottom of the script.");
echo(">>> ------------------------------------------------------");
// Choose your own below, uncomment the desired one.
//----------------
// printBracket();
// printBase1();
// printBase2();
// printCylinder();
// printMainStand();
printBallBearingStand();
// customPrint();
