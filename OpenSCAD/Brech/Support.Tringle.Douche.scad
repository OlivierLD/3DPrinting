/*
 * Support Tringle Douche Brech
 */
 DIAMETER = 25.0;
 THICKNESS = 8;
 FULL_LENGTH = 80;
 
 WALL_ANGLE = 45.0;
 SCREW_DIAM = 4.1;
 
 module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

module groovedCylinder(cylinderIntDiam, torusDiam) {
	difference() {
		cylinder(h=torusDiam, d=cylinderIntDiam + torusDiam, center=true, $fn=100);
		translate([0, 0, -(torusDiam / 2)]) { // Higher than previously, some slack for ball bearings...
			torus(cylinderIntDiam + (2 * torusDiam / 1), 2 * torusDiam);
		}
		// Hole in the middle
		cylinder(h=torusDiam * 1.1, d=cylinderIntDiam, center=true, $fn=100);
	}
}

module supportTringle() {
  union() {
    difference() {
      rotate([0, 90, 0]) {
        translate([0, 0, 0]) {
          cylinder(h=FULL_LENGTH, d=DIAMETER + THICKNESS, $fn=100, center=true);
        }
      }
      rotate([0, 90, 0]) {
        translate([0, 0, 0]) {
          cylinder(h=FULL_LENGTH + 10, d=DIAMETER, $fn=100, center=true);
        }
      }
      rotate([0, 0, 0]) {
        translate([0, 0, (DIAMETER + THICKNESS) / 4]) {
          cube(size = [FULL_LENGTH + 10, (DIAMETER + THICKNESS), (DIAMETER + THICKNESS) / 2], center=true);
        }
      }
    }
    // One side
    rotate([0, 0, 0]) {
      translate([-18, (DIAMETER + (THICKNESS / 2)) / 2, 5]) {
        cube(size=[10, THICKNESS / 2, 10], center=true);
      }
    }
    // Other side
    rotate([0, 0, 0]) {
      translate([-18, -(DIAMETER + (THICKNESS / 2)) / 2, 5]) {
        cube(size=[10, THICKNESS / 2, 10], center=true);
      }
    }
  }
}
 
module wallPlaque(withHoles = true) {
   
   difference() {
     rotate([0, WALL_ANGLE, 0]) {
       translate([0, 0, 0]) {
         cube(size=[THICKNESS, 2 * DIAMETER, 3 * DIAMETER], center=true);
       }
     }
     if (withHoles) {
       rotate([0, -WALL_ANGLE, 0]) {
         translate([-25, 0, 0]) {
           cylinder(h=(THICKNESS * 2), d=SCREW_DIAM, $fn=50, center=true);
         }
       }
       rotate([0, -WALL_ANGLE, 0]) {
         translate([25, 18, 0]) {
           cylinder(h=(THICKNESS * 2), d=SCREW_DIAM, $fn=50, center=true);
         }
       }
       rotate([0, -WALL_ANGLE, 0]) {
         translate([25, -18, 0]) {
           cylinder(h=(THICKNESS * 2), d=SCREW_DIAM, $fn=50, center=true);
         }
       }
     }
   }
}
 
 // Execution

difference() {
  union() {
    rotate([0, 0, 0]) {
      translate([0, 0, 0]) {
         supportTringle();
      }
    }
    /* Warning: This is not a circle... */
    if (true) {
      translate([-23.0, 0, -5]) {
        rotate([0, -45, 0]) {
          groovedCylinder(DIAMETER + (2 * THICKNESS), THICKNESS);
        }
      }
    }
    rotate([0, 0, 0]) {
      translate([-((FULL_LENGTH / 2) - THICKNESS) * 0.9, 0, 0]) {
         wallPlaque();
      }
    }
  }
  rotate([0, 0, 0]) {
    translate([-((FULL_LENGTH / 2) - THICKNESS) * 0.9, 0, 11.315]) {
       wallPlaque(false);
    }
  }
}
 