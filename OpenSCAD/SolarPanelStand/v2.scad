/*
 * Getting started on the Solar Panel Stand.
 * Using linear_extrude (had problems with polyhedron)
 * 
 * The idea is to have all dimensions as parameters.
 *
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

module oneDrilledSide(base, height, top, thickness, holeDiam, left=true) {
	difference() {
		oneSolidSide(base, height, top, thickness);
		// The top axis
		translate([0, height, 0]) {
			cylinder(h=thickness * 2, d=holeDiam, center=true, $fn=50);
		}
		// Ball bearing socket
		translate([0, height, (left ? 1 : -1) * thickness / 2]) {
			cylinder(h=thickness, d=holeDiam * 2, center=true, $fn=50); // TODO replace holeDiam * 2: socket diameter
		}
	}
}

module motor(motorSide, motorAxisDiam, motorAxisLength, betweenScrews) {
	union() {
		// Motor
		cube(motorSide, center=true);
		// Axis
		rotate([90, 0, 0]) {
			translate([0, 0, -motorSide]) {
				color("white") {
					cylinder(h=motorAxisLength, d=motorAxisDiam, center=true, $fn=50);
				}
			}
		}
		// Screws
		rotate([90, 0, 0]) {
			for (i = [0:1]) {
				for (j = [0:1]) {
					translate([-(betweenScrews / 2) + (i * betweenScrews), -(betweenScrews / 2) + (j * betweenScrews), -motorSide]) {
						color("white") {
							cylinder(h=motorAxisLength, d=0.5, center=true, $fn=50); // TODO replace 0.5 with screw diameter
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
											withMotor=false) {
	// left
	translate([0, totalStandWidth / 2, 0]) {
		rotate([90, 0, 0]) {
			color("red") {
				oneDrilledSide(length, height, topWidth, thickness, mainAxisDiam);
			}
		}
	}
	// right, with the motor socket
	difference() {
		translate([0, -totalStandWidth / 2, 0]) {
			rotate([90, 0, 0]) {
				color("green") {
					oneDrilledSide(length, height, topWidth, thickness, mainAxisDiam, false);
				}
			}
		}
		color("silver") {
			// Motor socket
			translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
				motor(motorSide, motorAxisDiam, motorAxisLength, betweenScrews);
			}
		}
	}
	if (withMotor) {
		translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
			motor(motorSide, motorAxisDiam, motorAxisLength, betweenScrews);
		}
	}		
	// base
	translate([0, 0, -thickness / 2]) {
		color("yellow") {
			cube([length, totalStandWidth + thickness, thickness], center=true);
		}
	}
}

// Let's draw it

_totalStandWidth = 40;
_length = 30;
_height = 40;
_topWidth = 10;
_thickness = 2;
_horizontalAxisDiam = 3;
_motorSide = 8;
_betweenScrews = 6;
_motorAxisDiam = 1;
_motorAxisLength = 10;
_mainAxisDiam = 5;

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
	  false); // Set this to false for printing.
	// Drill axis
	cylinder(h=3 * _thickness, d=_mainAxisDiam, center=true, $fn=50);
}

