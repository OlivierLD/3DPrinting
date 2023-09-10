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

/* 
 * A 4400 mAh 
 * 
 */
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


module RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=false, withSide=false, withTop=false) {
  // Base plate
  // ----------
  plateWidth = 40;
  plateLength = 80;
  plateThickNess = 3;
  cornerRadius = 10;
  sideThickness = 3;
  sideHeight = 20;

  topOffset = 1;

  if (withTop) {
    union() {
      translate([0, 0, sideHeight + topOffset]) {
        translate([0, 0, plateThickNess]) {
          roundedRect([plateWidth + (2 * sideThickness), plateLength + (2 * sideThickness), plateThickNess], (cornerRadius + sideThickness), $fn=100); 
        }
        difference() {
          roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius, $fn=100); 
          translate([0, 0, -1]) {
            roundedRect([plateWidth - (2 * sideThickness), plateLength - (2 * sideThickness), plateThickNess + 2], cornerRadius - sideThickness, $fn=100); 
          }
        }
      }
    }
  }
  
  if (withPlate) {
    union() {
      roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius, false, $fn=100);
      if (withSide) {
        difference() {
          // Outside - big block
          translate([0, 0, sideHeight / 2]) {
            roundedRect([plateWidth + (2 * sideThickness), 
                         plateLength + (2 * sideThickness), 
                         plateThickNess + sideHeight], cornerRadius + sideThickness, $fn=100);
          }
          // Inside
          translate([0, 0, plateThickNess + (sideHeight / 2)]) {
            roundedRect([plateWidth, 
                         plateLength, 
                         plateThickNess + sideHeight], cornerRadius, $fn=100);
          }
          // Opening for sockets
          translate([(plateWidth / 2), 15, 2.75 + basePegHeight]) {
            cube([10, 25, 8], center=true);
          }
          // Opening for the SD card
          union() {
            translate([-1, -(plateLength / 2), 2.5 + basePegHeight]) {
              cube([10, 25, 5], center=true);
            }
            rotate([90, 0, 0]) {
              translate([3.75, 2.5 + basePegHeight, (plateLength / 2)]) {
                cylinder(h=10, r=2.5, center=true, $fn=50);
              }
              translate([-5.75, 2.5 + basePegHeight, (plateLength / 2)]) {
                cylinder(h=10, r=2.5, center=true, $fn=50);
              }
            }
          }
          // Labels
          label = "USB      PWR";
          fontSize = 2.5; // in mm
				  translate([sideThickness + (plateWidth / 2), 5, 9 + basePegHeight]) { 
  					rotate([0, 90, 0]) {
	  					linear_extrude(height=1.5, center=true) {
		  					rotate([0, 0, 90]) {
			  					translate([0, -(fontSize / 2)]) {
				  					text(label, fontSize);
					  			}
					  		}
				  		}
			  		}
		  		}

          label_2 = "SD Card";
				  translate([-8, - (sideThickness + (plateLength / 2)), 9 + basePegHeight]) { 
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
  offset = 8;
  
  if (withPegs) {
    difference() {
      color("orange") {
        union() {
          translate([ ((plateWidth) - offset), (rPiWidth / 1) + offset, plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
          }
          translate([ ((plateWidth/1) - offset), -(0 * rPiWidth / 1) + offset, plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
          }
          translate([ ((plateWidth/1) - offset) - rPiLength, (rPiWidth / 1) + offset, plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
          }
          translate([ ((plateWidth/1) - offset) - rPiLength, -(0 * rPiWidth / 1) + offset, plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
          }
        }
      }
      topPegDiam = 2;
      topPegHeight = 7;
      // Drill
      color("red") {
        translate([ ((plateWidth/1) - offset), (rPiWidth / 1) + offset, plateThickNess]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
        translate([ ((plateWidth/1) - offset), -(0 * rPiWidth / 2) + offset, plateThickNess]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
        translate([ ((plateWidth/1) - offset) - rPiLength, (rPiWidth / 1) + offset, plateThickNess]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
        translate([ ((plateWidth/1) - offset) - rPiLength, -(0 * rPiWidth / 2) + offset, plateThickNess]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
      }
    }
  }
  slack = 1.05;
  // With a Raspberry Pi Zero. Dimensions 65 x 30 out-all.
  if (withRpi) {
    translate([(1 * plateWidth / 1) - (30.5) - (offset / 2) , 5 /*-32.5*/, 0 -14.5]) {
      rotate([90, 0, 90]) {
        color("green", 0.75) {
          import("../../raspberry-pi-zero-2.snapshot.9/RapberryPiZero.STL");
        }
      }
    }
  }
  // That's it!
}

if (true) {
  union() {
    // RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=true, withSide=true, withTop=true);
    RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=true, withSide=false, withTop=false);
    // RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
    translate([66, 46.5, 7.6]) {
      rotate([0, 0, 90]) {
        GPS();
      }
    }
    translate([55, 95, 15]) {
      rotate([0, 0, 90]) {
        PowerBank();
      }
    }
  }
} else {
  echo(">>> Nothing rendered, see the bottom of the code");
}

