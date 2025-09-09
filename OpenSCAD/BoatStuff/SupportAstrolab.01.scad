/**
 * Support Perche Astrolab.
 * Pour La Reveuse.
 */

module horizontalInside () { 
  diam = 27;
  union() {
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=120, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, 30]) {
         cube([120, diam, 60], center=true);
       }
     }
  }
}

module horizontalOutside () { 
  diam = 37;
  cubeDepth = 15;
  union() {  
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=100, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, cubeDepth / 2]) {
         cube([100, diam, cubeDepth], center=true);
       }
     }
  }
}
 
module verticalInside () { 
  diam = 34;
  union() {
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=120, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, 30]) {
         cube([120, diam, 60], center=true);
       }
     }
  }
}

module verticalOutside () { 
  diam = 44;
  cubeDepth = 15;
  union() {  
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=100, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, cubeDepth / 2]) {
         cube([100, diam, cubeDepth], center=true);
       }
     }
  }
}

union() {

  difference() {
    horizontalOutside();
    horizontalInside();
  }

  rotate([0, 90, 180]) {
    translate([0, -35.5, 0]) {
      difference() {
        verticalOutside();
        verticalInside();
      }
    }
  }
  
  rotate([90, 0, 0]) {
    translate([0, 0, -16]) {
      cylinder(h=05, r=(50 / 2), center=true, $fn=200);
    }
  }
}