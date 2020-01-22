/*
 * Getting started on the Solar Panel Stand.
 * Using linear_extrude (had problems with polyhedron)
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
	
	union() {
		polygon(points, paths, convexity=10);
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

module oneDrilledSide(base, height, top, thickness, holeDiam) {
	difference() {
		oneSolidSide(base, height, top, thickness);
		translate([0, height, 0]) {
			cylinder(h=thickness * 2, d=holeDiam, center=true, $fn=50);
		}
	}
}

module motor(motorSide, motorAxisDiam, motorAxisLength) {
	union() {
		cube(motorSide, center=true);
		rotate([90, 0, 0]) {
			translate([0, 0, -motorSide]) {
				color("white") {
					cylinder(h=motorAxisLength, d=motorAxisDiam, center=true, $fn=50);
				}
			}
		}
	}
}

// Let's draw it

totalStandWidth = 40;
length = 30;
height = 40;
topWidth = 10;
thickness = 2;
holeDiam = 3;
motorSide = 8;
motorAxisDiam = 1;
motorAxisLength = 10;

// left
translate([0, totalStandWidth / 2, 0]) {
	rotate([90, 0, 0]) {
		color("red") {
			oneDrilledSide(length, height, topWidth, thickness, holeDiam);
		}
	}
}
// right, with the motor socket
difference() {
	translate([0, -totalStandWidth / 2, 0]) {
		rotate([90, 0, 0]) {
			color("green") {
				oneDrilledSide(length, height, topWidth, thickness, holeDiam);
			}
		}
	}
	color("silver") {
		// Motor socket
		translate([0, -((totalStandWidth / 2) + (motorSide / 2)), height / 2]) {
			motor(motorSide, motorAxisDiam, motorAxisLength);
		}
	}
}
// base
translate([0, 0, -thickness / 2]) {
	color("yellow") {
		cube([length, totalStandWidth + thickness, thickness], center=true);
	}
}

