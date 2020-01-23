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
				cylinder(h=50, d=5, center=true, $fn=50);
			}
		}
	}
}

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

module screws(extDiam, fixingFootSize, screwDiam, wallThickness, length=50) {
	// 0.2 is the drilling offset in the foot. See in grooved.cylinder.scad.
	radius = (extDiam / 2) + (fixingFootSize / 2) + (fixingFootSize * 0.2) - wallThickness; // + (screwDiam / 2);
	for (angle = [0, 120, 240]) {				
		rotate([0, 0, angle - 90]) {
			translate([0, radius]) {
				metalScrew(screwDiam, length);
			}
		}		
	}
}

module axisDrillingPattern(length=100, diam=5) {
	cylinder(h=length, d=diam, center=true, $fn=50);
}

module flatSide(base, height, top) {
	points = [ 
		[-base / 2, 0],
		[base / 2, 0],
		[top / 2, height],
		[-top / 2, height]
	];
	paths = [[0, 1, 2, 3]];
	
	hull() {
		polygon(points, paths, convexity=10);
		// Rounded top
		translate([0, height]) {
			circle(d=top, $fn=50);
		}
	}
}
 
module oneSolidSide(base, height, top, thickness) {  
	linear_extrude(height=thickness, center=true) {
		flatSide(base, height, top);
	}
}

module oneDrilledSide(base, height, top, thickness, holeDiam, bbDiam, left=true) {
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

module motor(motorSide, motorAxisDiam, motorAxisLength, betweenScrews, screwDiam) {
	union() {
		// Motor
		cube(motorSide, center=true);
		// Axis
		rotate([90, 0, 0]) {
			translate([0, 0, -motorAxisLength]) {
				color("white") {
					cylinder(h=motorAxisLength, d=motorAxisDiam, center=true, $fn=50);
				}
			}
		}
		// Screws. Assuming the motor face is square.
		rotate([90, 0, 0]) {
			for (i = [0:1]) {
				for (j = [0:1]) {
					translate([	-(betweenScrews / 2) + (i * betweenScrews), 
											-(betweenScrews / 2) + (j * betweenScrews), 
											-motorAxisLength]) {
						color("white") {
							cylinder(h=motorAxisLength, d=screwDiam, center=true, $fn=50);
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
								 motorAxisDiam, 
								 motorAxisLength, 
								 betweenScrews,
								 screwDiam,
								 bbDiam,
								 withMotor=false) {
	// left
	translate([0, totalStandWidth / 2, 0]) {
		rotate([90, 0, 0]) {
			color("red") {
				oneDrilledSide(length, height, topWidth, thickness, mainAxisDiam, bbDiam);
			}
		}
	}
	// right, with the motor socket
	difference() {
		translate([0, -totalStandWidth / 2, 0]) {
			rotate([90, 0, 0]) {
				color("green") {
					oneDrilledSide(length, height, topWidth, thickness, mainAxisDiam, bbDiam, false);
				}
			}
		}
		color("silver") {
			// Motor socket
			translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
				motor(motorSide, motorAxisDiam, motorAxisLength, betweenScrews, screwDiam);
			}
		}
	}
	if (withMotor) {
		translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
			motor(motorSide, motorAxisDiam, motorAxisLength, betweenScrews, screwDiam);
		}
	}		
	// base
	translate([0, 0, -thickness / 2]) {
		color("turquoise") {
			cube([length, totalStandWidth + thickness, thickness], center=true);
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

_totalStandWidth = 120;
_length = 120;
_height = 150;
_topWidth = 35;
_thickness = 5;
_horizontalAxisDiam = 5;
_motorSide = 42.3;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5;
_screwDiam = 3;
_bbDiam = 16;

FULL_BASE = 1;
FULL_BASE_WITH_WORK_GEAR = 2;
MAIN_STAND = 3;

option = MAIN_STAND;

if (option == FULL_BASE) {
  footedBase(cylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
} else if (option == FULL_BASE_WITH_WORK_GEAR) {
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
						_motorAxisDiam, 
						_motorAxisLength, 
						_betweenScrews,
						_screwDiam,
						_bbDiam,
						false);
} else {
	echo(str("Unknown option for now [", option, "]"));
}


