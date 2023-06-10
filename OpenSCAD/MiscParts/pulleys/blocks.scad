//
// Just the block, no wheel.
// Becket: ringot (fr)
//

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

module becketBlock(sideThickness,       // Cheek's thickness
                   sideWidth,           // Cheek's width
                   internalThickness,   // Between the cheeks
                   wheelPlusRopeDiam,   // Wheel + rope
                   axisDiam) {          // axis diam
  union() {
    translate([0, 0, 0]) {
      rotate([0, 0, 0]) {
        block(sideThickness,
              sideWidth,    
              internalThickness,
              wheelPlusRopeDiam,
              axisDiam);
      }
    }    
    translate([0, 0, 0]) {
      rotate([0, 0, 180]) {
        block(sideThickness,
              sideWidth,    
              internalThickness,
              wheelPlusRopeDiam,
              axisDiam);
      }
    }    
  }
}

module doubleBlock(sideThickness,       // Cheek's thickness
                   sideWidth,           // Cheek's width
                   internalThickness,   // Between the cheeks
                   wheelPlusRopeDiam,   // Wheel + rope
                   axisDiam) {          // axis diam
  totalThickness = internalThickness + (2 * sideThickness);
  difference() {
    union() {
      translate([0, 0, 0]) {
        oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
      }
      translate([0, 0, +((cheekThickness / 1) + (internalThickness / 1))]) {
        oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
      }
      translate([0, 0, -((cheekThickness / 1) + (internalThickness / 1))]) {
        oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
      }
      // The junction across the cheeks
      difference() {
        union() {
          translate([0, 1.2 * wheelPlusRopeDiam, 0]) {
            cube(size=[sideWidth, 0.5 * wheelPlusRopeDiam, (2 * internalThickness) + (3 * sideThickness)], center=true);
          }
          translate([0, 1.45 * wheelPlusRopeDiam, 0]) {
            cylinder(h=totalThickness, r=(sideWidth / 2), center=true, $fn=100);
          }
        }
        // Trim of each side of the axis
        translate([0, 2 * wheelPlusRopeDiam, 1.4 * ((sideWidth / 2) + (cheekThickness / 2))]) {
          rotate([0, 90, 0]) {
            cylinder(h=sideWidth + 10, r=(1.5 * totalThickness / 2), center=true, $fn=100);
          }
        }
        translate([0, 2 * wheelPlusRopeDiam, - 1.4 * (((sideWidth / 2) + (cheekThickness / 2)))]) {
          rotate([0, 90, 0]) {
            cylinder(h=sideWidth + 10, r=(1.5 * totalThickness / 2), center=true, $fn=100);
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
    cylinder(h=(3 * (sideThickness + internalThickness)), r=(axisDiam / 2), center=true, $fn=100);  // Axis
  }
}

module doubleWithBecket(sideThickness,       // Cheek's thickness
                        sideWidth,           // Cheek's width
                        internalThickness,   // Between the cheeks
                        wheelPlusRopeDiam,   // Wheel + rope
                        axisDiam) {          // axis diam
  totalThickness = internalThickness + (2 * sideThickness);
  difference() {
    union() {
      union() {
        translate([0, 0, +((1 * cheekThickness / 2) + (internalThickness / 2))]) {
          // oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
          becketBlock(sideThickness,       // Cheek's thickness
                     sideWidth,           // Cheek's width
                     internalThickness,   // Between the cheeks
                     wheelPlusRopeDiam,   // Wheel + rope
                     axisDiam);
        }
        // translate([0, 0, +((cheekThickness / 2) + (internalThickness / 1))]) {
        //   oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
        // }
        translate([0, 0, -((cheekThickness / 1) + (internalThickness / 1))]) {
          oneCheek(sideThickness, sideWidth, wheelPlusRopeDiam, axisDiam);
        }
      }
      // The junction across the cheeks
      difference() {
        union() {
          translate([0, 1.2 * wheelPlusRopeDiam, 0]) {
            cube(size=[sideWidth, 0.5 * wheelPlusRopeDiam, (2 * internalThickness) + (3 * sideThickness)], center=true);
          }
          translate([0, 1.45 * wheelPlusRopeDiam, 0]) {
            cylinder(h=totalThickness * 1.25, r=(sideWidth / 2), center=true, $fn=100);
          }
        }
      }
    }
    // Trim of each side of the axis
    translate([0, 2 * wheelPlusRopeDiam, 1.4 * ((sideWidth / 2) + (cheekThickness / 2))]) {
      rotate([0, 90, 0]) {
        cylinder(h=sideWidth + 10, r=(1.5 * totalThickness / 2), center=true, $fn=100);
      }
    }
    translate([0, 2 * wheelPlusRopeDiam, - 1.4 * (((sideWidth / 2) + (cheekThickness / 2)))]) {
      rotate([0, 90, 0]) {
        cylinder(h=sideWidth + 10, r=(1.5 * totalThickness / 2), center=true, $fn=100);
      }
    }
    // Block top axis
    translate([0, 1.65 * wheelPlusRopeDiam, 0]) {
      rotate([0, 0, 0]) {
        cylinder(h=totalThickness * 2, r=axisDiam / 2, center=true, $fn=100);
      }
    }
    // The axis of the wheels
    cylinder(h=(3 * (sideThickness + internalThickness)), r=(axisDiam / 2), center=true, $fn=100);  // Axis
  }
}

// For tests
ringDiam = 30;
torusDiam = 8;  // aka line diam
axisDiam = 6;
cheekThickness = 3;
cheekWidth = 20;
internalThickness = torusDiam * 1.5;

// block(cheekThickness, cheekWidth, internalThickness, (ringDiam / 2) + (torusDiam / 2), 6);
// becketBlock(cheekThickness, cheekWidth, internalThickness, (ringDiam / 2) + (torusDiam / 2), 6);
// doubleBlock(cheekThickness, cheekWidth, internalThickness, (ringDiam / 2) + (torusDiam / 2), 6);
doubleWithBecket(cheekThickness, cheekWidth, internalThickness, (ringDiam / 2) + (torusDiam / 2), 6);

