/*
 * Buckle for wrist band
 */
 
 /**
 * size is a triplet [x, y, z]
 * radius is the radius of the rounded corner
 */
module roundedRect(size, radius) {
	linear_extrude(height=size.z, center=true, $fn=50) {
		offset(radius) {
			offset(-radius) {
				square([size.x, size.y], center=true);
			}
		}
	}
}

buckleWidth = 27.5; // in mm
buckleLen   = 20.0; // 16.0;
buckleThick = 6.0;

innerWidth = 21.0;
innerLen   = 8.0; // 6.0;

// Option 1, rough
module buckle01() {
  difference() {
    // Outer
    translate([0, 0, 0]) {
      rotate([0, 0, 0]) {
        roundedRect([buckleWidth, buckleLen, buckleThick], 3.0);
      }
    }
    // Inner
    translate([0, 0, 0]) {
      rotate([0, 0, 0]) {
        cube([innerWidth, innerLen, 10], center=true);
      }
    }
    
    // Top
    translate([0, 0, 5 + 1.5]) {
      rotate([0, 0, 0]) {
        cube([innerWidth, 30, 10], center=true);
      }
    }
    
    // bottom
    translate([0, 0, - 5 - 1.5]) {
      rotate([0, 0, 0]) {
        cube([innerWidth, 30, 10], center=true);
      }
    }
  }
  
}

// Option 2, smoother
module buckle02() {
  difference() {
    resize(newsize=[buckleWidth, buckleLen, buckleThick]) {
      sphere(r=10, $fn=100);
    }

    // Inner
    translate([0, 0, 0]) {
      rotate([0, 0, 0]) {
        cube([innerWidth, innerLen, 10], center=true);
      }
    }
    
    // Top
    translate([0, 0, 5 + 1.5]) {
      rotate([0, 0, 0]) {
        cube([innerWidth, 30, 10], center=true);
      }
    }
    
    // bottom
    translate([0, 0, - 5 - 1.5]) {
      rotate([0, 0, 0]) {
        cube([innerWidth, 30, 10], center=true);
      }
    }
  }
}



translate([0, 0, 0]) {
  rotate([0, 0, 0]) {
    // buckle01();
    buckle02();
  }
}
  
