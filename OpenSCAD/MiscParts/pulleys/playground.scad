//
// Double, flat, becket.
//
// See drawing options at the bottom of the code.
//

use <./wheels.scad>
use <./blocks.scad>

// Go !
ringDiam1 = 30;   // wheel diameter
ringDiam2 = 50;   // wheel diameter
torusDiam = 8;  // aka line diameter
axisDiam = 6;
cheekThickness = 3;
cheekWidth = 20;

axisToBottomLen = 110;
internalThickness = torusDiam * 1.5;
totalThickness = internalThickness + (2 * cheekThickness);

topOffset = 50;

WITH_WHEELS = false;

difference() {
  union() {
    if (WITH_WHEELS) {
      // small wheel
      translate([0, -(ringDiam1 / 2) - (torusDiam / 4), 0]) {
        rotate([0, 0, 0]) {
          wheel(ringDiam1, torusDiam, axisDiam);
        }
      }
      // big wheel
      translate([0, ringDiam2 / 2, 0]) {
        rotate([0, 0, 0]) {
          wheel(ringDiam2, torusDiam, axisDiam);
        }
      }
    }
    // becket axis
    translate([0, -(ringDiam1 / 2) -(torusDiam / 4) - 25, 0]) {
      rotate([0, 0, 0]) {
        cylinder(h=(internalThickness * 1.1), r=4, center=true, $fn=100);
      }
    }

    // Cheek One
    translate([0, -45, (internalThickness + cheekThickness) / 2]) {
      rotate([0, 0, 0]) {
        oneCheek(cheekThickness, cheekWidth, axisToBottomLen, axisDiam);
      }
    }
    // Cheek Two
    translate([0, -45, -(internalThickness + cheekThickness) / 2]) {
      rotate([0, 0, 0]) {
        oneCheek(cheekThickness, cheekWidth, axisToBottomLen, axisDiam);
      }
    }

    // The junction across the cheeks
    rotate([0, 0, 0]) {
      difference() {
        union() {
          translate([0, 1.3 * (topOffset), 0]) {
            cube(size=[cheekWidth, 0.5 * (30), (1 * internalThickness) + (2 * cheekThickness)], center=true);
          }
          translate([0, 1.45 * (topOffset), 0]) {
            cylinder(h=totalThickness * 1.0, r=(cheekWidth / 2), center=true, $fn=100);
          }
        }

        // Trim of each side of the axis
        translate([0, 1.6 * (topOffset), 1.55 * ((cheekWidth / 2) + (cheekThickness / 2))]) {
          rotate([0, 90, 0]) {
            cylinder(h=cheekWidth + 10, r=(1.5 * totalThickness / 2), center=true, $fn=100);
          }
        }
        translate([0, 1.6 * (topOffset), - 1.55 * (((cheekWidth / 2) + (cheekThickness / 2)))]) {
          rotate([0, 90, 0]) {
            cylinder(h=cheekWidth + 10, r=(1.5 * totalThickness / 2), center=true, $fn=100);
          }
        }
      }
    }
  }


  // AXIS

  // Block top axis
  translate([0, 1.5 * (topOffset), 0]) {
    rotate([0, 0, 0]) {
      cylinder(h=totalThickness * 2, r=axisDiam / 2, center=true, $fn=100);
    }
  }
  // The axis of the wheels
  translate([0, ringDiam2 / 2, 0]) {
    cylinder(h=(3 * (cheekThickness + internalThickness)), r=(axisDiam / 2), center=true, $fn=100);  // Axis
  }
  translate([0, - (ringDiam1 / 2) - (torusDiam / 4), 0]) {
    cylinder(h=(3 * (cheekThickness + internalThickness)), r=(axisDiam / 2), center=true, $fn=100);  // Axis
  }
}