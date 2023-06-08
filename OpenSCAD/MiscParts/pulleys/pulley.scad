//
// A test
// A Block with its wheel.
// Becket: ringot (fr)
//
// See drawing options at the bottom of the code.
//


module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

module wheel(ringDiam, torusDiam, axisDiam) {  
  difference() {
    cylinder(h=1.1 * torusDiam, r=(ringDiam / 2), center=true, $fn=100); // Thw wheel of the Pulley
    cylinder(h=12, r=(axisDiam / 2), center=true, $fn=100);  // Axis
    torus(ringDiam, torusDiam);                 // The groove
  }
}

module oneCheek(thickness, width, axisToBottomLen, axisDiam) {
  union() {
    translate([0, 0, 0]) {
      cylinder(h=thickness, r=(width / 2), center=true, $fn=100);
    }
    translate([0, axisToBottomLen / 2, 0]) {
      cube(size=[width, axisToBottomLen, thickness], center=true);
    }
  }
}

module block(sideThickness,       // Cheek's thickness
             sideWidth,           // Cheek's width
             internalThickness,   // Between the cheeks
             wheelPlusRopeDiam,   // Wheel + rope
             axisDiam) {          // axis diam
  totalThickness = internalThickness + (2 * sideThickness);
  difference() {
    union() {
      translate([0, 0, (cheekThickness / 2) + (internalThickness / 2)]) {
        oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
      }
      translate([0, 0, -((cheekThickness / 2) + (internalThickness / 2))]) {
        oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
      }
      // The junction between the cheeks
      difference() {
        union() {
          translate([0, 1.2 * wheelPlusRopeDiam, 0]) {
            cube(size=[sideWidth, 0.5 * wheelPlusRopeDiam, internalThickness + (2 * sideThickness)], center=true);
          }
          translate([0, 1.45 * wheelPlusRopeDiam, 0]) {
            cylinder(h=totalThickness, r=(sideWidth / 2), center=true, $fn=100);
          }
        }
        // Trim of each side of the axis
        translate([0, 2 * wheelPlusRopeDiam, 1.4 * ((sideWidth / 2) + (cheekThickness / 2))]) {
          rotate([0, 90, 0]) {
            cylinder(h=sideWidth, r=(1.5 * totalThickness / 2), center=true, $fn=100);
          }
        }
        translate([0, 2 * wheelPlusRopeDiam, - 1.4 * (((sideWidth / 2) + (cheekThickness / 2)))]) {
          rotate([0, 90, 0]) {
            cylinder(h=sideWidth, r=(1.5 * totalThickness / 2), center=true, $fn=100);
          }
        }
        // Block top axis
        translate([0, 1.65 * wheelPlusRopeDiam, 0]) {
          rotate([0, 0, 0]) {
            cylinder(h=totalThickness * 2, r=axisDiam / 2, center=true, $fn=100);
          }
        }
      }
    }
    // The axis
    cylinder(h=(2 * (sideThickness + internalThickness)), r=(axisDiam / 2), center=true, $fn=100);  // Axis
  }
}

// Go !
ringDiam = 30;
torusDiam = 10;  // aka line diam
axisDiam = 6;
cheekThickness = 3;
cheekWidth = 20;

OPTION_FULL = 0;
OPTION_WHEEL_ONLY = 1;
OPTION_BLOCK_ONLY = 2;

option = OPTION_BLOCK_ONLY;

union() {
  if (option != OPTION_BLOCK_ONLY) {
    wheel(ringDiam, torusDiam, axisDiam);
  }
  if (option != OPTION_WHEEL_ONLY) {
    block(cheekThickness, cheekWidth, torusDiam * 1.2, (ringDiam / 2) + (torusDiam / 2), 6);
  }
}

