/*
 * With a GPS and a Power Bank
 *
 * To be called (included) from other modules ?
 * Raspberry Pi Zero dev board, support.
 * A Raspberry Pi Zero, only.
 * Can be used to build a plate that goes in a project box...
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
 *
 * TODO: Consider different orientations for the power bank
 *
 */
echo(version=version());

module roundedRect(size, radius, center=true) {  
	linear_extrude(height=size.z, center=center) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = center);
		}
	}
}

/* GPS/GLONASS U-blox7 */
module GPS() {
  union() {
    translate([0, 0, 0]) {
      rotate([0, 0, 0]) {
        color("white") {
          cube(size=[25, 31, 9], center=true);
        }
      }
    }
    translate([0, -31 / 2, 0]) {
      rotate([0, 0, 0]) {
        color("white") {
          cylinder(h=9, d1=25, d2=25, center=true, $fn=100);
        }
      }
    }
    // USB Socket
    translate([0, 22, 0]) {
      rotate([0, 0, 0]) {
        color("silver") {
          cube(size=[12, 14, 4.5], center=true);
        }
      }
    }
    // Text
    rotate([0, 0, -90]) {
      translate([6, -1, 4.1]) {
         color("black") {
           text("GPS/GLONASS", halign="center", size=3.5);
         }
       }
     }
  }
}

/* A 4400 mAh power bank */
module PowerBank() {
  union() {
    color("white") {
      roundedRect([41, 98, 22], 5, $fn=100); 
    }
        // Text
    rotate([0, 0, 0]) {
      translate([0, -40, 11]) {
         color("black") {
           text("4400 mAh", halign="center", size=3.5);
         }
       }
     }

  }
}

// Raspberry Pi holes: diameter: 2.5mm
// RasPi Zero: 23mm x 58mm (between holes axis)
rPiWidth = 58;
rPiLength = 23;

// Raspberry Pi pegs
// -----------------
// Base Pegs
basePegDiam = 6;
basePegBottomDiam = 10;
basePegScrewDiam = 2;
basePegHeight = 5;

module pegs() {
  difference() {
    color("orange") {
      union() {
        translate([ 0, rPiWidth, 0]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([0, 0, 0]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([- rPiLength, rPiWidth, 0]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ - rPiLength, 0, 0]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
      }
    }
    topPegDiam = 2;
    topPegHeight = 7;
    // Drill
    color("red") {
      translate([ 0, rPiWidth, 0]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ 0, 0, 0]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ - rPiLength, rPiWidth, 0]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ - rPiLength, 0, 0]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
    }
  }
}

module RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=false, withSide=false, withTop=false) {
  // Base plate
  // ----------
  usbSocketSlack = 30;
  plateWidth = 105 + usbSocketSlack;
  plateLength = 120;
  plateThickNess = 3;
  cornerRadius = 10;
  sideThickness = 3;
  sideHeight = 25;

  topOffset = 1;
  offset = 8;

  if (withTop) {
    difference() {
      union() {
        translate([-sideThickness, -sideThickness, sideHeight + topOffset]) {
          translate([0, 0, plateThickNess]) {
            roundedRect([plateWidth + (2 * sideThickness), plateLength + (2 * sideThickness), plateThickNess], (cornerRadius + sideThickness), false, $fn=100); 
          }
          difference() {
            roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius, false, $fn=100); 
            translate([0, 0, -1]) {
              roundedRect([plateWidth - (2 * sideThickness), plateLength - (2 * sideThickness), plateThickNess + 2], cornerRadius - sideThickness, false, $fn=100); 
            }
          }
        }
      }
      if (true) { // Hole for the screen. TODO: an option
        screenWidth = rPiWidth + 3;
        screenLength = rPiLength + 5;
        rotate([0, 0, 90]) {
          translate([5.0 + sideThickness, -screenLength - sideThickness -4.5, 25]) {
            roundedRect([screenWidth, screenLength, 10], 3, false, $fn=100);
          }
        }
      }
    }
  }
  
  if (withPlate) {
    union() {
      roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius, false, $fn=100);
      // Bulkhead
      translate([plateWidth / 2, rPiWidth + (1.8 * offset), 10 + plateThickNess]) {
        rotate([0, 0, 0]) {
          cube(size=[plateWidth, plateThickNess, 20], center=true);
        }
      }
      
      if (withSide) {
        difference() {
          // Outside - big block
          translate([-sideThickness, -sideThickness, 0]) {
            roundedRect([plateWidth + (2 * sideThickness), 
                         plateLength + (2 * sideThickness), 
                         plateThickNess + sideHeight], cornerRadius + sideThickness, false, $fn=100);
          }
          // Inside
          translate([0 * sideThickness, 0 * sideThickness, plateThickNess]) {
            roundedRect([plateWidth, 
                         plateLength, 
                         plateThickNess + sideHeight], cornerRadius, false, $fn=100);
          }

          // Opening for the SD card
          translate([19, 0, 0]) {
            union() {
              translate([0, 0, 2.5 + basePegHeight]) {
                cube([10, 25, 5], center=true);
              }
              rotate([90, 0, 0]) {
                translate([4.75, plateThickNess + basePegHeight - 0.5, 0]) {
                  cylinder(h=10, r=2.5, center=true, $fn=50);
                }
                translate([-5.10, plateThickNess + basePegHeight - 0.5, 0]) {
                  cylinder(h=10, r=2.5, center=true, $fn=50);
                }
              }
            }
            // Labels
            fontSize = 2.5; // in mm
            label_2 = "SD Card";
            translate([-8, -sideThickness, 9 + basePegHeight]) { 
              rotate([0, 90, -90]) {
                linear_extrude(height=1.5, center=true) {
                  rotate([0, 0, 90]) {
                    translate([0, -(fontSize / 2)]) {
                      text(label_2, fontSize);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  if (withPegs) {
    translate([ (basePegDiam / 2) + (rPiWidth / 2), (basePegDiam / 2) + 5, plateThickNess]) {
      rotate([0, 0, 0]) {
        pegs();
      }
    }
  }

  // With a Raspberry Pi Zero. Dimensions 65 x 30 out-all.
  if (withRpi) {
    translate([9.5 - (offset / 2) , 4.5,  -14.5]) {
      rotate([90, 0, 90]) {
        color("green", 0.75) {
          import("../../raspberry-pi-zero-2.snapshot.9/RapberryPiZero.STL");
        }
      }
    }
  }
  
  // That's it!
}

module main() {
  withAccessories = true; // RasPi, GPS, PowerBank
    
  // Invert booleans below for top only  
  withPlate = true;
  withPegs = true;
  withSide = true;
  withTop = false;
  
  union() {
    // RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=true, withSide=true, withTop=true);
    RPiZeroSmallPlate(withPlate=withPlate, 
                      withPegs=withPegs, 
                      withRpi=withAccessories, 
                      withSide=withSide, 
                      withTop=withTop);
    // RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
    
    if (withAccessories) {
      // Accessories
      translate([66, 46.5, 7.6]) {
        rotate([0, 0, 90]) {
          GPS();
        }
      }
      translate([52.5, 95, 15]) {
        rotate([0, 0, 90]) {
          PowerBank();
        }
      }
    }
  }
}

// Main part
if (true) {
  main();
} else {
  echo ("-----------------------------------------------");
  echo(">>> Nothing rendered, see the bottom of the code");
  echo ("-----------------------------------------------");
}

