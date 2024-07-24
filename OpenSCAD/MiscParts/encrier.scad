// Un encrier pour Ellie.
// Fabriqué en deux elements.

module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

MAIN_TUBE_HEIGHT = 50;
MAIN_TUBE_EXT_DIAM = 35;
MAIN_TUBE_INT_DIAM = 30;

module bottom() {
  union() {
    // Main cylinder
    difference() {
      // Outside
      rotate([0, 0, 0]) {
        translate([0, 0, 0]) {
          cylinder(h=MAIN_TUBE_HEIGHT, d=MAIN_TUBE_EXT_DIAM, center=true, $fn=100);
        }
      }
      // Inside
      rotate([0, 0, 0]) {
        translate([0, 0, 2.5]) {
          cylinder(h=MAIN_TUBE_HEIGHT, d=MAIN_TUBE_INT_DIAM, center=true, $fn=100);
        }
      }
    } 
    // Only one element in the union...
  }
}

module top() {
  
  TORUS_DIAM = 10;
  EXTERNAL_RING_DIAM = 49;
  INTERNAL_DIAM = 20;
  
  difference() {
    union() {
      // External ring
      rotate([0, 0, 0]) {
        translate([0, 0, 0]) {
          torus(EXTERNAL_RING_DIAM - (TORUS_DIAM / 2), TORUS_DIAM);
        }
      }
      // Internal ring
      rotate([0, 0, 0]) {
        translate([0, 0, 0]) {
          torus(INTERNAL_DIAM + TORUS_DIAM, TORUS_DIAM);
        }
      }
      // Disc between toruses
      difference() {
        // out
        rotate([0, 0, 0]) {
          translate([0, 0, 0]) {
            cylinder(h=TORUS_DIAM, d=(EXTERNAL_RING_DIAM - (TORUS_DIAM / 2)), center=true);
          }
        }
        // in
        rotate([0, 0, 0]) {
          translate([0, 0, 0]) {
            cylinder(h=TORUS_DIAM * 1.1, d=(INTERNAL_DIAM + (TORUS_DIAM / 1)), center=true, $fn=100);
          }
        }
      }
      // Join to the tube
      rotate([0, 0, 0]) {
        translate([0, 0, -8]) {
          difference() {
            cylinder(h=10, d=MAIN_TUBE_INT_DIAM, center=true, $fn=100);
            cylinder(h=10 + 5, d=(INTERNAL_DIAM * 1.1), center=true, $fn=100);
          }
        }
      }
    }
    // Top torus ? Optional.
    if (false) {
      rotate([0, 0, 0]) {
        translate([0, 0, 9]) {
          torus(INTERNAL_DIAM + (2* TORUS_DIAM), TORUS_DIAM);
        }
      }
    }

  }
}

// Main part ! Comment at will.

WITH_TOP = false;
WITH_BOTTOM = true;

STUCK = true;

if (WITH_BOTTOM) {
  bottom();
}
if (WITH_TOP) {
  translate([0, 0, (MAIN_TUBE_HEIGHT / 2) + (STUCK ? 5 : 14)]) {
    top();
  }
}