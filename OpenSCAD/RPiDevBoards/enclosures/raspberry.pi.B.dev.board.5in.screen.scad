/*
 *
 * Raspberry Pi *B stand, with screen
 * Several screen options, see at the bottom of the file.
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_4b_4p0.pdf
 *
 *
 * TODO: Header labels?
 *
 * NOTE:  See the bottom of the file for print options.
 */
 
 
use <../HDMI.5.inches.stand.scad>
// use <./cameraStand.scad>
use <./cameraStand.v2.scad>
use <../uc595.scad>
 
echo(version=version());

// Note; Logo not used in this file.
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

module prism(l, w, h){
   polyhedron(points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}

module bottomFoot(footWidth, footHeight, baseWidth, topWidth, thirdFoot = false) {
  prismBase = (baseWidth - topWidth) / 2;
  
  union() {
    rotate([0, 0, 90]) {
      // right 
      translate([0, -(prismBase + ((0 * footWidth) / 2)), 0]) {
        rotate([0, 0, 0]) {
          prism(prismBase, footWidth, footHeight);
        }
      }
    }
    translate([-topWidth / 2, footWidth / 2, footHeight / 2]) {
      cube(size=[topWidth, footWidth, footHeight], center=true);
    }
    rotate([0, 0, -90]) {
      // left 
      translate([-footWidth, -(prismBase + (topWidth / 1)), 0]) {
        rotate([0, 0, 0]) {
          prism(prismBase, footWidth, footHeight);
        }
      }
    }
    if (thirdFoot) {
      rotate([0, 0, 0]) {
        // left 
        translate([-((baseWidth - footWidth) / 2), 
                   -(prismBase + (0 * topWidth / 1)), 
                   0]) {
          rotate([0, 0, 0]) {
            prism(prismBase, footWidth, footHeight);
          }
        }
      }
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
cornerRadius = 5;
offset = 7;

hingeBaseLength = 10;
hingeBaseThickness = 5;
hingeOffset = 10;
hingeAxisDiam = 3.3; // Screw 3mm


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

BASE_HINGES_AXIS_HEIGTH = 25;
screenHingesAxisHeight = 20;

module rpiEnclosure(screenAngle=0, 
                    bottomOnly=false, 
                    topOnly=false, 
                    holeForTheHook=true,
                    screenType=1,
                    baseHingesAxisHeight=BASE_HINGES_AXIS_HEIGTH,
                    withLabels=true,
                    withScreen=false,
                    rpiZRotation=0,
                    rpiTranslate=-20) {

  if (screenType == FIVE_INCHES_OPTION) {
    echo("Option FIVE_INCHES_OPTION");
  } else if (screenType == SEVEN_INCHES_OPTION) {
    echo("Option SEVEN_INCHES_OPTION");
  } else if (screenType == SEVEN_INCHES_OPTION_V2) {
    echo("Option SEVEN_INCHES_OPTION_V2");
  }    

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
            // Optional Rotation
            rotate([0, 0, rpiZRotation]) { 
              translate([0, rpiTranslate, 0]) {
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
            }
            // End optional rotation

            // Bottom Hinges. Axis height: 25mm (baseHingesAxisHeight)
            // Right, external one
            translate([(mainPlateWidth/2) - hingeBaseThickness - (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Right, internal one
            translate([(mainPlateWidth/2) - (3 * hingeBaseThickness) - (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Right foot
            prismBase = 10;
            footHeight = baseHingesAxisHeight - 5;
            footBaseLength = (2 * prismBase) + (3 * hingeBaseThickness);
            translate([(mainPlateWidth/2) - (hingeBaseThickness / 2) - (1 * hingeOffset), 
                       (mainPlateLength / 2) - hingeBaseLength, 
                       0]) {
              bottomFoot(hingeBaseLength, 
                         footHeight, 
                         (2 * prismBase) + (3 * hingeBaseThickness), 
                         (3 * hingeBaseThickness),
                         thirdFoot = true);
            }
            
            // Left, external one
            translate([- (mainPlateWidth/2) + hingeBaseThickness + (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Left, internal one
            translate([- (mainPlateWidth/2) + (3 * hingeBaseThickness) + (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), (baseHingesAxisHeight / 2) + (plateThickNess / 2)]) {
              rotate([0, 0, 90]) {
                hingeStand(baseHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
              }
            }
            // Left foot
            translate([-(mainPlateWidth/2) + (1 * footBaseLength / 2) + hingeOffset, 
                       (mainPlateLength / 2) - hingeBaseLength, 
                       0]) {
              bottomFoot(hingeBaseLength, 
                         footHeight, 
                         (2 * prismBase) + (3 * hingeBaseThickness), 
                         (3 * hingeBaseThickness),
                         thirdFoot = true);
            }
          }
          // Lid stand
          standDiam = 10;
          standHeight = baseHingesAxisHeight + screenHingesAxisHeight;
          if (screenType == SEVEN_INCHES_OPTION_V2) {
            translate([0, 
                       -(mainPlateLength/2) + (standDiam/2) - 10, 
                       0]) {
              translate([0, 10, 0]) {              
                cube(size=[(2 * standDiam), (2 * standDiam), plateThickNess], center=true);
              }
              translate([0, 0, 10]) {
                cylinder(h=20, d2=standDiam, d1=(2 * standDiam), center=true, $fn=100);
              }
              cylinder(d=(2 * standDiam), h=plateThickNess, center=true, $fn=50);
           }            
            
            translate([0, 
                       -(mainPlateLength/2) + (standDiam/2) - 10, 
                       (standHeight / 2) + (plateThickNess / 2) - (plateThickNess + 0)]) {
              rotate([0, 0, 90]) {
                cylinder(d=standDiam, h=standHeight, center=true, $fn=50);
              }
            }
          } else {
            translate([0, 
                       -(mainPlateLength/2) + (standDiam/2), 
                       (standHeight / 2) + (plateThickNess / 2) - (plateThickNess + 0)]) {
              rotate([0, 0, 90]) {
                cylinder(d=standDiam, h=standHeight, center=true, $fn=50);
              }
            }
          }
          // Hook
          if (!holeForTheHook) {
            cubeHeight = 6;
            cubeWidth  =  10;
            cubeThickness = 6;
            translate([- (mainPlateWidth / 2) + 10, -(mainPlateLength / 2) + 10, cubeHeight]) {
              rotate([0, 180, 0]) {
                difference() {
                  union() {
                    cube(size=[cubeThickness, cubeWidth, cubeHeight]);
                    translate([0, cubeWidth / 2, 0]) {
                      rotate([0, 90, 0]) {
                        cylinder(h=cubeThickness, d=cubeWidth, $fn=50, center=false);
                      }
                    }
                  }
                  // Hole
                  rotate([0, 90, 0]) {
                    translate([0, cubeWidth / 2, -cubeThickness / 2]) {
                      cylinder(h=2 * cubeThickness, d=4, $fn=50);
                    }
                  }
                }
              }
            }               
          }
        }
        
        // Drill holes (less material)
        translate([15, -20, 0]) {
          rotate([0, 0, 0]) {
            cylinder(d=30, h=plateThickNess * 1.1, center=true, $fn=100);
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
        if (screenType == SEVEN_INCHES_OPTION_V2) {
          translate([50, 15, 0]) {
            rotate([0, 0, 0]) {
              cylinder(d=20, h=plateThickNess * 1.1, center=true, $fn=100);
            }
          }
          translate([50, -15, 0]) {
            rotate([0, 0, 0]) {
              cylinder(d=20, h=plateThickNess * 1.1, center=true, $fn=100);
            }
          }
          translate([50, -45, 0]) {
            rotate([0, 0, 0]) {
              cylinder(d=20, h=plateThickNess * 1.1, center=true, $fn=100);
            }
          }
        }
        // Drill completed
        
        // Hole for the hook
        if (holeForTheHook) {
          translate([- (mainPlateWidth / 2) + 10, -(mainPlateLength / 2) + 10, 0]) {
            rotate([0, 0, 0]) {
              cylinder(d=3, h=plateThickNess * 1.1, center=true, $fn=100);
            }
          }
        }
        // Labels
        if (withLabels) {
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
                  // Top Right foot
                  prismBase = 10;
                  footHeight = 10;
                  footBaseLength = (2 * prismBase) + (1 * hingeBaseThickness);
                  translate([(mainPlateWidth/2) - (3 * hingeBaseThickness / 2) - (1 * hingeOffset), 
                             (mainPlateLength / 2) - (0 * hingeBaseLength), 
                             0]) {
                    rotate([180, 0, 0]) {           
                      bottomFoot(hingeBaseLength, 
                                 footHeight, 
                                 (2 * prismBase) + (1 * hingeBaseThickness), 
                                 (1 * hingeBaseThickness));
                    }
                  }
                  // Right one
                  translate([- (mainPlateWidth/2) + (2 * hingeBaseThickness) + (1 * hingeOffset), (mainPlateLength/2) - (hingeBaseLength/2), -((screenHingesAxisHeight / 2) - (plateThickNess / 2))]) {
                    rotate([0, rotAngle, 90]) {
                      hingeStand(screenHingesAxisHeight, baseLength=hingeBaseLength, baseThickness=hingeBaseThickness, axisDiam=hingeAxisDiam);
                    }
                  }
                  // Top Left foot
                  translate([-(mainPlateWidth/2) + (3 * hingeBaseThickness / 2) + hingeBaseThickness + (1 * hingeOffset), 
                             (mainPlateLength / 2) - (0 * hingeBaseLength), 
                             0]) {
                    rotate([180, 0, 0]) {           
                      bottomFoot(hingeBaseLength, 
                                 footHeight, 
                                 (2 * prismBase) + (1 * hingeBaseThickness), 
                                 (1 * hingeBaseThickness));
                    }
                  }
                  
                  rotate([0, rotAngle, 0]) {
                    translate([0, -12, 0]) {
                      HDMI5inchesStand(option=screenType,  // 1: 5", 2: 7", 3: 7" from UCTronics
                                       hollowCenter=false,
                                       cornerScrews=false);
                    }
                  }
                  
                  if (!holeForTheHook) { // Something nicer than just a hole
                    cubeHeight = 6;
                    cubeWidth  =  10;
                    cubeThickness = 6;
                    translate([- (mainPlateWidth / 2) + 5, -(mainPlateLength / 2) + 20, -cubeHeight]) {
                      difference() {
                        union() {
                          cube(size=[cubeThickness, cubeWidth, cubeHeight]);
                          translate([0, cubeWidth / 2, 0]) {
                            rotate([0, 90, 0]) {
                              cylinder(h=cubeThickness, d=cubeWidth, $fn=50, center=false);
                            }
                          }
                        }
                        // Hole
                        rotate([0, 90, 0]) {
                          translate([0, cubeWidth / 2, -cubeThickness / 2]) {
                            cylinder(h=2 * cubeThickness, d=4, $fn=50);
                          }
                        }
                      }
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
                    if (holeForTheHook) { // Hole?
                      cylinder(d=3, h=plateThickNess * 1.1, center=true, $fn=100);
                    }
                  }
                }
              }
            }
          }
          // With a screen ?
          if (withScreen && screenType == SEVEN_INCHES_OPTION_V2) {
            rotate([-(screenAngle + 180), 0, 0]) {
              translate([0, 12, 18.5]) {
                uc595();
              }
            }
          }
          
          // With camera stand? Only drawn for FIVE_INCHES_OPTION
          if (screenAngle != 0 && screenType == FIVE_INCHES_OPTION) {
            rotate([-(screenAngle - 90), 0, 0]) {
              translate([0, 0, mainPlateLength / 2]) {
                cameraStand(withCamera=true);
              }
            }
          }
        }
      }
    }
  }
}

// When closed: 0, opened: 100. No camera stand when 0.
OPENED = 100; // Fix camera stand position for all screen options.
CLOSED = 0;

screenAngle = OPENED; // Change at will
bottomOnly = false;
topOnly = false;
holeForTheHook = true; // false: Ok with 5"
withScreen = true;

// From HDMI.5.inches.stand.scad
FIVE_INCHES_OPTION = 1;
SEVEN_INCHES_OPTION = 2;
SEVEN_INCHES_OPTION_V2 = 3;

screenType = SEVEN_INCHES_OPTION_V2; 

rpiEnclosure(screenAngle=screenAngle, 
             bottomOnly=bottomOnly, 
             topOnly=topOnly, 
             holeForTheHook=holeForTheHook,
             screenType=screenType,
             baseHingesAxisHeight=BASE_HINGES_AXIS_HEIGTH + (screenType == SEVEN_INCHES_OPTION_V2 ? 5 : 0), // TODO Tweak the 5...
             withLabels=(screenType != SEVEN_INCHES_OPTION_V2),
             withScreen=withScreen,
             rpiZRotation=(screenType == SEVEN_INCHES_OPTION_V2 ? 90 : 0), // 90 for the SEVEN_INCHES_OPTION_V2
             rpiTranslate=(screenType == SEVEN_INCHES_OPTION_V2 ? -5 : -20)); 
// That's it!
