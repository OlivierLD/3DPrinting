use <../../mechanical.parts.scad>

// Will use metalScrewCyl to fix it.

screwDiam = 3.0;
headDiam = 6.0;
screwLength = 30;


difference() {

  // The base
  union() {

    // Main
    difference() {
      rotate([90, 90, 0]) {
        resize([20, 50, 12]) {
          cylinder(h=24, r=50, center=true, $fn=100);
        }
      }
      
      translate([0, 0, -5]) {
        rotate([0, 0, 0]) {
          cube([55, 20, 10], center=true);
        }
      }
    }

    // Cylinder on top
    difference() {
      // Main
      translate([0, 0, 0]) {
        rotate([0, 0, 0]) {
          cylinder(h=20, r=5, $fn=50);
        }
      }
      // The hole
      translate([0, 0, 15]) {
        rotate([0, 90, 90]) {
          cylinder(h=30, r=2.5, center=true, $fn=50);
        }
      }
      
    }
  }

  // The screws
  rotate([0, 0, 0]) {
    translate([-14, 0, -21]) {
      metalScrewCyl(screwDiam, headDiam, screwLength, top=10);
    }
  }
  rotate([0, 0, 0]) {
    translate([14, 0, -21]) {
      metalScrewCyl(screwDiam, headDiam, screwLength, top=10);
    }
  }
}
