/*
 * Chain Links and chain plug
 * (pour l'écubier - hawsehole - de La Reveuse)
 */

/**
 * Draw a Torus
 *
 * @param ringDiam The ring diameter. Warning: Add the torus (2 * 1 / 2) diameter to get the final part diameter !
 * @param torusDiam The torus diameter
 */
module torus(ringDiam, torusDiam) {
 	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
}

// Top/Bottom part of a link
module top_bottom(width, diam) {
  difference() {
    torus(width - (diam / 2), diam);
    translate([10, 0, 0]) {
          cube(size=[(width + (diam / 2)) / 2,
                      width + (diam / 2),
                      diam],
               center=true);
     }
  }
}

module one_link(width, height, diam) {
  x = (height / 2) - (1 * width / 2);
  union() {
    // Top
    translate([-x, 0, 0]) {
      rotate([0, 0, 0]) {
        top_bottom(width, diam);
      }
    }
    translate([0, (width / 2) - (diam / 4), 0]) {
      rotate([0, 90, 0]) {
        cylinder(h=2 * x, r=diam/2, center=true, $fn = 100);
      }
    }
    translate([0, - ((width / 2) - (diam / 4)), 0]) {
      rotate([0, 90, 0]) {
        cylinder(h=2 * x, r=diam/2, center=true, $fn = 100);
      }
    }
    // Bottom
    translate([x, 0, 0]) {
      rotate([0, 180, 0]) {
        top_bottom(width, diam);
      }
    }
  }
}

module one_link_hull(width, height, diam) {
  hull() {
    one_link(width, height, diam);
  }
}

// a 3-link chain
module three_link_chain(width, height, diam, hull=false) {
  // top
  translate([(height - (1.5 * diam)), 0, 0]) {
    rotate([90, 0, 0]) {
      if (!hull) {
        one_link(width, height, diam);
      } else {
        one_link_hull(width, height, diam);
      }
    }
  }
  // center
  translate([0, 0, 0]) {
    rotate([0, 0, 0]) {
      if (!hull) {
        one_link(width, height, diam);
      } else {
        one_link_hull(width, height, diam);
      }
    }
  }
  // bottom
  translate([-(height - (1.5 * diam)), 0, 0]) {
    rotate([90, 0, 0]) {
      if (!hull) {
        one_link(width, height, diam);
      } else {
        one_link_hull(width, height, diam);
      }
    }
  }
}

// Common to the two parts (top and bottom). Just dimensions are different
module plugPart(width, length, height) {
  linear_extrude(height=height, center=true) {
    hull() {
      translate([-length / 8, 0, 0]) {
        circle(d=width, $fn=100);
      }
      translate([length / 8, 0, 0]) {
        circle(d=width, $fn=100);
      }
    }
  }
}

module plug() {
  difference() {
    union() {
      // Bottom
      translate([0, 0, - 20 / 2]) {
        plugPart(44, 58, 20);
      }
      // Top
      translate([0, 0, 10 / 2]) {
        plugPart(44 + 6, 58 + 6, 10);
      }
      // Top-Ring
      translate([35, 0, 8]) {
        rotate([90, 90, 0]) {
          union() {
            cylinder(h=20, r=8, center=true, $fn=100);
            translate([4, -4, 0]) {
              cube([8, 8, 20], center=true);
            }
          }
        }
      }
    }
    // Same translation/rotation as above, hole in the ring
    translate([35, 0, 8]) {
       rotate([90, 90, 0]) {
         cylinder(h=200, r=4, center=true, $fn=100);
       }
    }
  }
}

LINK_HEIGHT = 50;
LINK_WIDTH  = 35;
LINK_DIAM   = 10; // Increase this to get some slack...
