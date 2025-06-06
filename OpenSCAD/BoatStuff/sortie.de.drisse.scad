/*
 * Sortie de drisse
 *
 * Dimensions L: 115mm, l: 23mm, h: 10.4mm
 */
 
 module shape01(length, width, thickness) {
   blockLength = length - width;
   union() {
     // Main block
     rotate([0, 0, 0]) {
       translate([0, 0, 0]) {
         cube([width, blockLength, thickness], center=true);
       }
     }
     // Top, round
     rotate([0, 0, 0]) {
       translate([0, -(blockLength / 2), 0]) {
         cylinder(h=thickness, r=(width / 2), center=true, $fn=100);
       }
     }
     // Bottom, round
     rotate([0, 0, 0]) {
       translate([0, (blockLength / 2), 0]) {
         cylinder(h=thickness, r=(width / 2), center=true, $fn=100);
       }
     }
   }
}

difference() {
  union() {
    shape01(115, 23, 10.4);
    rotate([0, 0, 0]) {
      translate([0, -40, -6.0]) {
        shape01(50, 18.0, 2.0);
      }
    }
  }
  rotate([0, 0, 0]) {
    translate([0, 0, 4]) {
      shape01(108, 14, 5);
    }
  }
  // The slopes
  // Up
  rotate([2, 0, 0]) {
    translate([0, -29.6, 10.25]) {
      cube([25, 60, 10], center=true);
    }
  }
  // Down
  rotate([-4, 0, 0]) {
    translate([0, 29.6, 10.25]) {
      cube([25, 60, 10], center=true);
    }
  }
  
  // The hole through it
  rotate([0, 0, 0]) {
    translate([0, -18, 0]) {
      shape01(72, 14, 15);
    }
  }
  
  // The rope going down
  translate([0, 0, -1.5]) {
    rotate([-77, 0, 0]) {
      cylinder(h=100, r=6.5, center=true, $fn=100);
    }
  }
  
  // The rope coming up
  translate([0, -20, -1.5]) {
    rotate([-73.2, 0, 0]) {
      cylinder(h=100, r=6.5, center=true, $fn=100);
    }
  }
  // Bottom difference
  translate([0, 50, -6]) {
    rotate([0, 0, 0]) {
      cube([40, 30, 10], center=true);
    }
  }
  
  // Bottom difference
  translate([0, 0, -4]) {
    rotate([0, 0, 0]) {
      difference() {
        shape01(120, 25, 2.0);
        shape01(108, 18, 2.0);
      }
    }
  }

  // The pop (screw) at the bottom
  translate([0, 48, 0]) {
    rotate([0, 0, 0]) {
      cylinder(h=30, r=2.5, center=true, $fn=100);
    }
  }
}

