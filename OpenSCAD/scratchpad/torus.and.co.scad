//
// Torus (aka O-ring), etc
// 

color("red") {
	rotate_extrude(convexity = 10, $fn=10) { // $fn: torus' smoothing
        // Change x value below...
		translate([3, 0, 0]) { // Ring's diam
			circle(r = 0.75, $fn = 100); // Torus' diam
		}
	}
}

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

color("cyan") {
	translate([0, 0, 2.5]) {
		torus(10, 1);
	}
}

module baseCube(l, w, h) {
	cube(size=[l, w, h], center=true);
}

if (true) {
// Circular/toric groove on top of a cube
	translate([0, 0, -5]) {
		difference() {
			baseCube(12.5, 12.5, 5);
			translate([0, 0, 2.5]) {
				torus(10, 1);
			}
		}
	}
}

if (true) {
	// Circular/toric groove on top of a cylinder
	translate([0, 0, -12]) {
		difference() {
			cylinder(h=5, d=12.5, center=true, $fn=100);
			translate([0, 0, 2.6]) { // Higher than previously, some slack for ball bearings...
				torus(10, 1);
			}
			// Hole in the middle
			cylinder(h=5.1, d=7.5, center=true, $fn=100);
			// Some axis, not centered...
			rotate([0, 90, 0]) {
				translate([0, 2.5, 0]) {
					color("lime") {
						cylinder(h=100, d1=1, d2=1, center=true, $fn=100);
					}
				}
			}
		}
	}
}
