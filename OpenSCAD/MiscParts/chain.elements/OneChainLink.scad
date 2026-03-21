/*
 * Chain Link
 */
 
module torus(ringDiam, torusDiam) { 
 	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 


// Top/Bottom part
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

// a 3-link chain
module 3_link_chain(width, height, diam) {
  // top
  translate([(height - (1.5 * diam)), 0, 0]) {
    rotate([90, 0, 0]) {
      one_link(width, height, diam);
    }
  }
  // center
  translate([0, 0, 0]) {
    rotate([0, 0, 0]) {
      one_link(width, height, diam);
    }
  }
  // bottom
  translate([-(height - (1.5 * diam)), 0, 0]) {
    rotate([90, 0, 0]) {
      one_link(width, height, diam);
    }
  }
}

// Main starts here
LINK_HEIGHT = 50;
LINK_WIDTH  = 35;
LINK_DIAM   = 10;

rotate([0, 90, 0]) {
  3_link_chain(LINK_WIDTH, LINK_HEIGHT, LINK_DIAM);
}
