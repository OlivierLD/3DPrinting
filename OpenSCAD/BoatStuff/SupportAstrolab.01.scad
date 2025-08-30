/**
 * Support Perche Astrolab
 */

module horizontalInside () { 
  diam = 2.7;
  union() {
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=12, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, 3.0]) {
         cube([12, diam, 6], center=true);
       }
     }
  }
}

module horizontalOutside () { 
  diam = 3.7;
  cubeDepth = 1.5;
  union() {  
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=10, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, cubeDepth / 2]) {
         cube([10, diam, cubeDepth], center=true);
       }
     }
  }
}
 
module verticalInside () { 
  diam = 3.4;
  union() {
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=12, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, 3.0]) {
         cube([12, diam, 6], center=true);
       }
     }
  }
}

module verticalOutside () { 
  diam = 4.4;
  cubeDepth = 1.5;
  union() {  
     rotate([0, 90, 0]) {
       translate([0, 0, 0]) {
         cylinder(h=10, r=(diam / 2), center=true, $fn=100);
       }
     }
     rotate([90, 0, 0]) {
       translate([0, 0, cubeDepth / 2]) {
         cube([10, diam, cubeDepth], center=true);
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
    translate([0, -3.55, 0]) {
      difference() {
        verticalOutside();
        verticalInside();
      }
    }
  }
  
  rotate([90, 0, 0]) {
    translate([0, 0, -1.6]) {
      cylinder(h=0.5, r=(5 / 2), center=true, $fn=100);
    }
  }
}