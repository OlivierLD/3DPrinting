/**
 * Mason jars
 */
 
// 800 ml
module masonJar() {
	union() {
	// Bottom
	cube(size=[93, 93, 140], center=true);
		translate([0, 0, (27.5 / 2) + (140 / 2)]) {
			rotate([0, 0, 0]) {
				cylinder(d=89.4, h=45, $fn=100, center=true);
			}
		}
	}
}
 
module masonJarSproutStand() {
	difference() {
		cube(size=[100, 110, 100], center=true);
		translate([0, 0, 140 / 2]) {
			rotate([0, 160, 0]) {
				masonJar();
			}
		}
		translate([0, 0, -10]) {
			translate([-5, 0, 0]) {
				cylinder(d=10, h=100, $fn=50, center=true);
			}
			translate([2, -22, 0]) {
				cylinder(d=10, h=100, $fn=50, center=true);
			}
			translate([2, 22, 0]) {
				cylinder(d=10, h=100, $fn=50, center=true);
			}
			translate([20, -37, 0]) {
				cylinder(d=10, h=100, $fn=50, center=true);
			}
			translate([20, 37, 0]) {
				cylinder(d=10, h=100, $fn=50, center=true);
			}
			translate([30, 0, 0]) {
				cylinder(d=40, h=100, $fn=50, center=true);
			}
		}
		translate([0, 0, -51]) {
			cube(size=[120, 100, 10], center=true);
		}
		translate([0, 0, 20]) {
			rotate([90, 0, 0]) {
				cylinder(d=40, h=150, $fn=100, center=true);
			}
		}
		translate([0, 0, 20]) {
			rotate([0, 90, 0]) {
				cylinder(d=40, h=150, $fn=100, center=true);
			}
		}
	}
}
 
// masonJar();
masonJarSproutStand();
