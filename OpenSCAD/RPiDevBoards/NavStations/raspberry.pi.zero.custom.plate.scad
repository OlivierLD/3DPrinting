/*
 * To be called (included) from other modules ?
 * Raspberry Pi Zero dev board, support.
 * A Raspberry Pi Zero.
 * GPS dongle (see GPS module)
 * Power Bank (see PowerBank module)
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
 *
 * TODO: Consider different orientations for the power bank
 *
 * Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/
 *
 */
 
include <./GPSDongle.scad>
include <./PowerBank4400.scad>
include <./EInkBonnet213.scad>
 
echo(version=version());

module roundedRect(size, radius, center=true) {  
	linear_extrude(height=size.z, center=center) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = center);
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

module RPiZeroPlate(withPlate=true, 
                    withPegs=true, 
                    withRpi=false, 
                    withSide=false, 
                    withTop=false,
                    withScreenHole=true,
                    sideNotch=false) {
  // Base plate
  // ----------
  usbSocketSlack = 33;
  plateWidth = 105 + usbSocketSlack;
  plateLength = 120;
  plateThickNess = 3;
  cornerRadius = 10;
  sideThickness = 3;
  sideHeight = 25;

  topOffset = 20; //1;
  offset = 8;

  if (withTop) {
    difference() {
      union() {
        translate([-sideThickness, -sideThickness, sideHeight + topOffset]) {
          translate([0, 0, plateThickNess]) {
            roundedRect([plateWidth + (2 * sideThickness), plateLength + (2 * sideThickness), plateThickNess], (cornerRadius + sideThickness), false, $fn=100); 
          }
          translate([sideThickness, sideThickness, 0]) {
            difference() {
              roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius, false, $fn=100); 
              translate([sideThickness, sideThickness, -1]) {
                roundedRect([plateWidth - (2 * sideThickness), plateLength - (2 * sideThickness), plateThickNess + 2], cornerRadius - sideThickness, false, $fn=100); 
              }
            }
          }
        }
      }
      if (withScreenHole) { // Hole for the screen.
        screenWidth = rPiWidth + 3;
        screenLength = rPiLength + 5;
        rotate([0, 0, 90]) {
          translate([4.0 + sideThickness, -screenLength - sideThickness -4.5, sideHeight + topOffset]) {
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
          if (sideNotch) {
            // Opening for the external GPS cable
            translate([50, 0, 22]) {
              rotate([0, 90, 0]) {
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
          import("../../../raspberry-pi-zero-2.snapshot.9/RapberryPiZero.STL");
        }
      }
    }
  }
  // That's it!
}

module main() {
  withAccessories = true; // RasPi, GPS, PowerBank, eink bonnet
    
  // Invert booleans below for top only  
  withPlate = true;
  withPegs = true;
  withSide = true;
  withTop = true;
  withScreenHole = true; // Set to false if no eink bonnet
  withSideNotch = true;
  
  // withPlate = false;
  // withPegs = false;
  // withSide = false;
  // withTop = true;

/*
  withAccessories = false;
  withPlate = true;
  withPegs = true;
  withSide = true;
  withTop = false;
  withScreenHole = true;
  withSideNotch = true;
*/
  union() {
    // RPiZeroPlate(withPlate=true, withPegs=true, withRpi=true, withSide=true, withTop=true);
    RPiZeroPlate(withPlate=withPlate, 
                 withPegs=withPegs, 
                 withRpi=withAccessories, 
                 withSide=withSide, 
                 withTop=withTop,
                 withScreenHole=withScreenHole,
                 sideNotch=withSideNotch);
    // RPiZeroPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
    
    if (withAccessories) {
      // Accessories
      translate([66, 46.5, 7.6]) {
        rotate([0, 0, 90]) {
          GPSDongle();
        }
      }
      translate([52.5, 95, 15]) {
        rotate([0, 0, 90]) {
          PowerBank4400();
        }
      }
      
      translate([21, 36, 11.5]) {
        rotate([0, 0, 0]) {
          einkBonner213();
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

