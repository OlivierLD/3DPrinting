/*
 * Getting started on the Solar Panel Stand.
 * Using linear_extrude (had problems with polyhedron)
 * 
 * The idea is to have all dimensions as parameters.
 *
 * Closer to the truth:
 * - NEMA-17 motor specs: http://www.mosaic-industries.com/embedded-systems/microcontroller-projects/stepper-motors/specifications
 *
 * TODO:
 * - Ball bearing sockets for all axis
 */
echo(version=version());
 
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

module buildMainStand(totalStandWidth, 
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

// Let's draw it
// All measurments in mm
_totalStandWidth = 100;
_length = 100;
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

difference() {
	buildMainStand(
		_totalStandWidth, 
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
	  false); // Set this to false for printing.
	// Drill axis
	cylinder(h=3 * _thickness, d=_mainAxisDiam, center=true, $fn=50);
}

