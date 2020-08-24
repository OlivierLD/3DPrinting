/*
 * 20-Jan-2020, MLK day, discovering OpenSCAD.
 * Note: This is a first experience with OpenSCAD. The structure of the code
 * could be improved, a lot! I know.
 *
 * Raspberry Pi *B stand 
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_4b_4p0.pdf
 *
 * Features:
 * - Text
 * - Image
 * - etc
 *
 * TODO: Header labels?
 *
 * See the bottom of the file for print options.
 */
 
 
use <../HDMI.5.inches.stand.scad>
 
echo(version=version());

logo = "../RPiLogo.png"; // res 240 x 300
logox = 200; 
logoy = 200; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

module hingeStand(axisHeight, baseLength=10, baseThickness=5, axisDiam=4) {
  difference() {
    union() {
      translate([0, 0, axisHeight / 2]) {
        rotate([90, 0, 0]) {
          cylinder(h=baseThickness, d=baseLength, center=true, $fn=50);
        }
      }
      translate([0, 0, 0]) {
        cube(size=[baseLength, baseThickness, axisHeight], center=true);
      }
    }
    translate([0, 0, axisHeight / 2]) {
      rotate([90, 0, 0]) {
        cylinder(h=baseThickness * 1.1, d=axisDiam, center=true, $fn=50);
      }
    }
  }
}

// RPi Base plate
// --------------
plateWidth = 90;
plateLength = 90;
plateThickNess = 3;
cornerRadius = 10;
offset = 7;

hingeBaseLength = 10;
hingeBaseThickness = 5;
hingeOffset = 10;
hingeAxisDiam = 4;


module raspberryBStandOnly(drillHoles=true) {

  // roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);

  text1="Oliv did it.";
  text2="2020";
  difference() {  
    roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
    // Corners screw holes
    if (drillHoles) {
      translate([- ((plateWidth / 2) - (2 * cornerRadius / 3)), ((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
        cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
      }
      translate([+ ((plateWidth / 2) - (2 * cornerRadius / 3)), ((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
        cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
      }
      translate([- ((plateWidth / 2) - (2 * cornerRadius / 3)), -((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
        cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
      }
      translate([+ ((plateWidth / 2) - (2 * cornerRadius / 3)), -((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
        cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
      }
    }
    if (false) {
      rotate([0, 0, -90]) {
        translate([
         -18, // left - right (Y)
         -15, // Top - bottom (X)
         1.5    // Up - down    (Z)
        ]) {
          color("lime") {
            linear_extrude(height=plateThickNess - 1, center=true) {
              text(text1, 6);
            }
          }
        }
        translate([
         -9,  // left - right (Y)
         -25, // Top - bottom (X)
         1.5    // Up - down    (Z)
        ]) {
          color("lime") {
            linear_extrude(height=plateThickNess - 1, center=true) {
              text(text2, 6);
            }
          }
        }
      }
      // Logo
      translate([25, 0, 3]) {
        scale([.1 * plateWidth / logox, .1 * plateWidth / logoy, .02]) {
          color("lime") {
            rotate([0, 0, -90]) {
              surface(file=logo, invert=true, center=true);
            }
          }
        }
      }
    }
  }

  // Raspberry Pi holes: diameter: 2.5mm
  // 23mm x 58mm (between holes axis)
  rPiWidth = 58;
  rPiLength = 49;

  // Raspberry Pi pegs
  // -----------------
  // Base Pegs
  basePegDiam = 6;
  basePegBottomDiam = 10;
  basePegScrewDiam = 2;
  basePegHeight = 5;

  difference() {
    color("orange") {
      union() {
        translate([ ((plateLength/2) - offset), (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((plateLength/2) - offset), -(rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((plateLength/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((plateLength/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
      }
    }
    topPegDiam = 2;
    topPegHeight = 7;
    color("red") {
      translate([ ((plateLength/2) - offset), (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((plateLength/2) - offset), -(rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((plateLength/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((plateLength/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
    }
  }
}

mainPlateWidth  = 140;
mainPlateLength = 130;

baseHingesAxisHeight = 25;
screenHingesAxisHeight = 20;

module rpiEnclosure(screenAngle=0, bottomOnly=false, topOnly=false) {

  union() {
    // RPi Stand
    if (!topOnly) {
      difference() {
        union() {
          // Bottom
          union() {
            translate([0, 0, 0]) {
              roundedRect([mainPlateWidth, mainPlateLength, plateThickNess], cornerRadius);
            }
            translate([0, -20, 0]) {
              raspberryBStandOnly(false);
              // With a Raspberry Pi 4B. 
              if (!bottomOnly) {
                translate([(1 * plateLength / 2) + 1.6 - (offset / 2) , -(35.4), 3]) {
                  rotate([0, 0, 90]) {
                    color("green", 0.75) {
                      import("../../../Raspberry_Pi_3_Reference_Design_Model_B_Rpi_Raspberrypi/files/Raspberry_Pi_3.STL");
                    }
                  }
                }
              }
            }
            // Hinges. Axis height: 25mm (baseHingesAxisHeight)
            // Left, external one
            translate([(mainPlateWidth/2) - hingeBaseThickness - (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Left, internal one
            translate([(mainPlateWidth/2) - (3 * hingeBaseThickness) - (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Right, external one
            translate([- (mainPlateWidth/2) + hingeBaseThickness + (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Right, internal one
            translate([- (mainPlateWidth/2) + (3 * hingeBaseThickness) + (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
          }
          // Lid stand
          standDiam = 10;
          standHeight = baseHingesAxisHeight + screenHingesAxisHeight;
          translate([0, 
                     -(mainPlateLength/2) + (standDiam/2), 
                     (standHeight / 2) + (plateThickNess / 2) - (plateThickNess + 0)]) {
            rotate([0, 0, 90]) {
              cylinder(d=standDiam, h=standHeight, center=true, $fn=50);
            }
          }
        }
        
        // Drill holes (less material)
        translate([15, -20, 0]) {
          rotate([0, 0, 0]) {
            cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
          }
        }
        translate([15, 30, 0]) {
          rotate([0, 0, 0]) {
            cylinder(d=30, h=plateThickNess * 1.1, center=true, $fn=100);
          }
        }
        translate([-40, 20, 0]) {
          rotate([0, 0, 0]) {
            cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
          }
        }
        translate([-40, -30, 0]) {
          rotate([0, 0, 0]) {
            cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
          }
        }
        // Hole for the hook
        translate([- (mainPlateWidth / 2) + 10, -(mainPlateLength / 2) + 10, 0]) {
          rotate([0, 0, 0]) {
            cylinder(d=3, h=plateThickNess * 1.1, center=true, $fn=100);
          }
        }
        // Labels
        translate([
         55,  // left - right (X)
         -55, // Top - bottom (Y)
         1.5  // Up - down    (Z)
        ]) {
          rotate([0, 0, 90]) {
            color("lime") {
              linear_extrude(height=plateThickNess - 1, center=true) {
                text("power HDMI audio", 6);
              }
            }
          }
        }
        translate([
         7.5,  // left - right (X)
         -62, // Top - bottom (Y)
         1.5  // Up - down    (Z)
        ]) {
          rotate([0, 0, 0]) {
            color("lime") {
              linear_extrude(height=plateThickNess - 1, center=true) {
                text("SD", 6);
              }
            }
          }
        }
      }
    }
    
    // Hinge Axis
    if (!bottomOnly && !topOnly) {
      translate([0, (mainPlateLength / 2) - (hingeBaseLength / 2), baseHingesAxisHeight + (plateThickNess / 2)]) {
        rotate([0, 90, 0]) {
          #cylinder(d=hingeAxisDiam, h=mainPlateWidth, center=true, $fn=50);
        }
      }
    }
    
    
    // Screen stand
    if (!bottomOnly) {
      rotAngle = 180; // topOnly ? 0 : 180;
      
      betweenLids = baseHingesAxisHeight + screenHingesAxisHeight - plateThickNess;
      
      zOffset = baseHingesAxisHeight - (plateThickNess / 2) + ((mainPlateLength/2) * sin(screenAngle)) + ((screenHingesAxisHeight + (1 * plateThickNess / 2)) * cos(screenAngle))
                + (screenAngle == 0 ? 0 : -1); 
      yOffset = ((mainPlateWidth/2) * sin(screenAngle)) - (screenHingesAxisHeight * sin(screenAngle))
                + (screenAngle == 0 ? 0 : 39.5);
      
      translate([0, yOffset, zOffset]) {
        union() {
          rotate([-screenAngle, 0, 0]) {
            translate([0, 0, 0]) {
              difference() {
                union() {
                  translate([0, 0, 0]) {
                    roundedRect([mainPlateWidth, mainPlateLength, plateThickNess], cornerRadius);
                  }
                  // Hinges
                  // Left one
                  translate([(mainPlateWidth/2) - (2 * hingeBaseThickness) - (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), -((screenHingesAxisHeight / 2) - (plateThickNess / 2))]) {
                    rotate([0, rotAngle, 90]) {
                      hingeStand(screenHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
                    }
                  }
                  // Right one
                  translate([- (mainPlateWidth/2) + (2 * hingeBaseThickness) + (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), -((screenHingesAxisHeight / 2) - (plateThickNess / 2))]) {
                    rotate([0, rotAngle, 90]) {
                      hingeStand(screenHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
                    }
                  }
                  
                  rotate([0, rotAngle, 0]) {
                    translate([0, -12, 0]) {
                      HDMI5inchesStand(option=1); // 1: 5", 2: 7"
                    }
                  }
                }
                // Drill holes, less material
                translate([25, -25, 0]) {
                  rotate([0, 0, 0]) {
                    cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
                  }
                }
                translate([-25, -25, 0]) {
                  rotate([0, 0, 0]) {
                    cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
                  }
                }
                translate([25, 25, 0]) {
                  rotate([0, 0, 0]) {
                    cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
                  }
                }
                translate([-25, 25, 0]) {
                  rotate([0, 0, 0]) {
                    cylinder(d=40, h=plateThickNess * 1.1, center=true, $fn=100);
                  }
                }
                // Hole for the hook
                translate([- (mainPlateWidth / 2) + 5, -(mainPlateLength / 2) + 20, 0]) {
                  rotate([0, 0, 0]) {
                    cylinder(d=3, h=plateThickNess * 1.1, center=true, $fn=100);
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

screenAngle = 100; // 100; // When closed: 0
bottomOnly = false;
topOnly = false;

rpiEnclosure(screenAngle=screenAngle, bottomOnly=bottomOnly, topOnly=topOnly);
// That's it!
