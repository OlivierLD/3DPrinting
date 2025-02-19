/*
 *
 * Raspberry Pi 3B stand, with 3.5" TFT screen
 *              |
 *              + hey, NOT 4 !!
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_4b_4p0.pdf
 *
 * 3.5" TFT Screen:
 * https://learn.adafruit.com/adafruit-pitft-3-dot-5-touch-screen-for-raspberry-pi?view=all
 *
 * NOTE: See the bottom of the file for print options.
 * Look for "PRINT OPTIONS".
 */
 
 
// use <../HDMI.5.inches.stand.scad>
use <../Adafruit3.5in.scad>

// Warning!! Location depends on your machine!! 
// See https://www.chrisfinke.com/2015/01/27/3d-printed-lego-compatible-bricks/
use <../../../../LEGO.oliv/LEGO.scad> 
 
echo(version=version());

module roundedRect(size, radius) {  
  // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/2D_to_3D_Extrusion
	linear_extrude(height=size.z, center=true, $fn=100) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

// Raspberry Pi holes: diameter: 2.5mm
// 49mm x 58mm (between holes axis)
rPiWidth = 58;
rPiLength = 49;

/*
 * RPI Board dims:
 * w: 56mm
 * l: 85mm
 */
// RPi Base plate
// --------------
plateWidth = 56 + 3;
plateLength = 85 + 3;

plateThickNess = 3;
cornerRadius = 5;
xOffset = 0;
yOffset = -9;

// PlateTickness = Wall Thickness
mainPlateWidth  = plateWidth + (2 * plateThickNess);
mainPlateLength = plateLength + (2 * plateThickNess);

module drawRaspberryPi(withSocket=false) {
  union() {
//  difference() {
    rotate([0, 0, 90]) {
      color("green", 0.75) {
        import("../../../Raspberry_Pi_3_Reference_Design_Model_B_Rpi_Raspberrypi/files/Raspberry_Pi_3.STL");
      }
    }
    if (withSocket) {
      // Audio
      rotate([0, 90, 0]) {
        // Audio diam = 5.85
        translate([-6.5, 56.3, 0]) {
          #cylinder(d=7 /*5.85*/, h=20, $fn=50, center=true);
        }
      }
      // HDMI
      rotate([0, 90, 0]) {
        translate([-7.5, 34.7, 0]) {
          #cube(size=[10, 20, 12], center=true);
        }
      }
      // USB/Power
      rotate([0, 90, 0]) {
        translate([-5, 13.4, 3]) {
          #cube(size=[7, 12, 12], center=true);
        }
      }
      // SD Card
      rotate([0, 0, 90]) {
        translate([-0, 30, 1.6]) {
          #cube(size=[14, 16, 6], center=true);
        }
      }
      // Ethernet
      rotate([0, 0, 90]) {
        translate([ 90, 12, 10]) {
          #cube(size=[14, 17.5, 15.25], center=true);
        }
      }
      // USB, 1.
      rotate([0, 0, 90]) {
        translate([ 90, 30.5, 11.5]) {
          #cube(size=[14,   // depth  
                      16.0, // width
                      17],  // height
                      center=true);
        }
      }
      // USB, 2.
      rotate([0, 0, 90]) {
        translate([ 90, 49, 11.5]) {
          #cube(size=[14,   // depth  
                      16.0, // width
                      17],  // height
                      center=true);
        }
      }
    }
  }
}

module raspberryBStand(withRPi=true, drillHoles=true) {

  // roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);

  difference() {  
    // Base plate
    // color("blue") {
      roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
    //}
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
  }

  // Raspberry Pi pegs
  // -----------------
  // Base Pegs
  basePegDiam = 6;
  basePegBottomDiam = 10;
  basePegScrewDiam = 2;
  basePegHeight = 5;

  difference() {
    // Cones for the base
    color("orange") {
      union() {
        translate([ ((rPiLength/2) - xOffset), yOffset + (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((rPiLength/2) - xOffset), yOffset - (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((rPiLength/2) - xOffset) - rPiLength, yOffset + (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((rPiLength/2) - xOffset) - rPiLength, yOffset - (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
      }
    }
    topPegDiam = 2;
    topPegHeight = 7;
    color("red") {
      // Drill holes in the cones
      translate([ ((rPiLength/2) - xOffset), yOffset + (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((rPiLength/2) - xOffset), yOffset - (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((rPiLength/2) - xOffset) - rPiLength, yOffset + (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((rPiLength/2) - xOffset) - rPiLength, yOffset - (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
    }
  }
  if (withRPi) {
    translate([(1 * rPiLength / 2) + 4.9 /*1.6*/ - (xOffset / 1) , yOffset - (35.4), 3]) {
      drawRaspberryPi(withSocket=true);
    }
  }
}


screenPlateWidth = getScreenPlateWidth();
screenPlateLength = getScreenPlateLength();
screenPlateExtensionWidth = getPlateExtensionWidth();

module oneFeetBar() {
  barWidth = 10;
  barLength = mainPlateLength * 1.25;
  screwDiam = 4;
  difference() {
    union() {
      cube(size=[barWidth, barLength, plateThickNess], center= true);
      translate([0, barLength / 2, 0]) {
        cylinder(h=plateThickNess, d=barWidth, center=true, $fn=50);
      }
      translate([0, - barLength / 2, 0]) {
        cylinder(h=plateThickNess, d=barWidth, center=true, $fn=50);
      }
    }
    // Drill
    translate([0, barLength / 2, 0]) {
      cylinder(d=screwDiam, h=2 * plateThickNess, center=true, $fn=50);
    }
    translate([0, - barLength / 2, 0]) {
      cylinder(d=screwDiam, h=2 * plateThickNess, center=true, $fn=50);
    }
  }
}

module fixingFeet() {
  translate([0, 0, 0]) {
    difference() {
      union() {
        rotate([0, 0, 33]) {
          oneFeetBar();
        }
        rotate([0, 0, -33]) {
          oneFeetBar();
        }
      }
    }
  }
}

module basePlate(withFeet) {
  roundedRect([mainPlateWidth, mainPlateLength, plateThickNess], cornerRadius);
  if (withFeet) {
    fixingFeet();
  }
}

/*
 * show=true: show the raspberry
 * show=false: drill holes for sockets
 */
module tvBoxRPiB3(show=true, 
                  logo=true, 
                  showWall=true, 
                  solid=false,
                  withFeet=false) { 

  difference() {
    // Bottom
    union() {
      translate([0, 0, 0]) {
        union() {
          // Base
          basePlate(withFeet);
          // The wall
          if (showWall) { // Set to false to see inside the box.
            wallHeight = 20 + 5; // 5 = basePegHeight;
            translate([0, 0, (wallHeight / 2)]) { // 12.5 = (20 + 5) / 2
              difference() {
                roundedRect([mainPlateWidth, mainPlateLength, wallHeight], cornerRadius);
                if (!solid) {
                  translate([0, 0, 0.5]) { // 0.5 = (1 / 2) ===========================+
                    roundedRect([mainPlateWidth - 6, mainPlateLength - 6, wallHeight + 1], cornerRadius - plateThickNess);              
                  }
                }
              }
            }
            // Pegs for the screws of the screen
            pegHeight = 4;
            pegHoleLength = 5;
            d2 = 5;
            d1 = 1; // plateThickNess;
            rotate([0, 0, 0]) {
              // bottom right
              translate([- ((screenPlateWidth - screenPlateExtensionWidth) / 2) - 0.5, 
                         - (screenPlateLength / 2) - 0.8, 
                         wallHeight - (pegHeight / 2) ]) {
                difference() {
                  cylinder(d2=d2, d1=d1, h=pegHeight, center=true, $fn=50);
                  // hole
                  translate([0, 0, 1]) {
                    cylinder(d=1.5, h=pegHoleLength, center=true, $fn=50);
                  }
                }
              }
              // Top right
              translate([+ ((screenPlateWidth - screenPlateExtensionWidth) / 2) - 0.5, 
                         - (screenPlateLength / 2) - 0.8, 
                         wallHeight - (pegHeight / 2) ]) {
                difference() {
                  cylinder(d2=d2, d1=d1, h=pegHeight, center=true, $fn=50);
                  // hole
                  translate([0, 0, 1]) {
                    cylinder(d=1.5, h=pegHoleLength, center=true, $fn=50);
                  }
                }
              }
              // Top Left
              translate([+ ((screenPlateWidth - screenPlateExtensionWidth) / 2) - 0.5, 
                         + (screenPlateLength / 2) + 3.5, 
                         wallHeight - (pegHeight / 2) ]) {
                difference() {
                  cylinder(d2=d2, d1=d1, h=pegHeight, center=true, $fn=50);
                  // hole
                  translate([0, 0, 1]) {
                    cylinder(d=1.5, h=pegHoleLength, center=true, $fn=50);
                  }
                }
              }         
              // Bottom Left: None.
            }
            
            withLogo = logo;
            if (withLogo) {
              rotate([90, 0, -90]) {
                out = 32.7; // use more than 32.2 to see it
                translate([0, 10, out]) {
                  color("orange") {
                    text("Over cool stuff!", halign="center", size=6);
                  }
                }
              }
            }
          }
        }
      }
      // Draw the raspberry. Show, or drill.
      raspberryBStand(withRPi=show, drillHoles=false);
    }
    
    // TODO Vents at the bottom?
    
    if (!show) {
      // Drill the holes for the sockets
      translate([(1 * rPiLength / 2) + 4.9 /*1.6*/ - (xOffset / 1) , yOffset - (35.4), 3]) {
        drawRaspberryPi(withSocket=true);
      }
    }
  }
}

module legoPlate(withFeet=true) {
  basePlate(withFeet=withFeet);
  // Lego brick
  translate([0, 0, -10]) {
    rotate([0, 0, 90]) {
      block(width=6,  // In studs (top studs)
            length=8, // In studs (top studs)
            height=1, // In "standard block" height
            type="brick");
    }
  }
}

/* 
 * PRINT OPTIONS
 *---------------
 * Now, do it:
 * 
 * To print the bottom:
 *   - justBottom = true
 *   - justTop = false
 *   - showRaspberry = false
 *   - withLogo = false
 *   - withFeet true | false
 *
 * To print the top:
 *   - justBottom = false
 *   - justTop = true
 *   - showRaspberry = false
 *   - withScreen = false
 *
 * To print the lego plate:
 *   - legoPlateOnly = true
 *   - withFeet = true
 * To print a lego plate for a breadboard (half-size)
 *   - legoPlateOnly = true
 *   - withFeet = false
 *
 * To visualize:
 *   - justBottom = false
 *   - justTop = false
 *   - showRaspberry = true|false
 *   - withScreen = true|false
 *   - withLogo = true|false
 *   - withLegoPlate = true|false
 *
 * ... and check out the code. Point of Truth.
 * 
 */

justBasePlate = false;

justTop = false;
justBottom = justBasePlate || false;

withScreen = false; // true;
showBoxWalls = true && (!justBasePlate);
showRaspberry = false; // true;
withLogo = false;

extrudeForScreen = false;

withFeet = true;

withLegoPlate = false;
legoPlateOnly = false;

/* =========================== */

if (!justTop && !legoPlateOnly) {
  // Bottom
  tvBoxRPiB3(show=showRaspberry, 
             logo=withLogo, 
             showWall=showBoxWalls, 
             withFeet=withFeet); 

  // The screen
  if (withScreen) {
    translate([-0.4, 1.25, 25.9]) { // On top of the box
      rotate([0, 0, 180]) {
        drawScreen();
      }
    }
  }
}

if (withLegoPlate || legoPlateOnly) {
  translate([0, 0, -(plateThickNess + 0.1)]) {
    legoPlate(withFeet);
  }
}

// The top
if (!justBottom && !legoPlateOnly) {
  difference() {
    // The lid
    lidThickness = 15;
    rotate([0, 0, 0]) {
      translate([0, 0, 24.5]) { 
        roundedRect([mainPlateWidth + (2.5 * plateThickNess), 
                     mainPlateLength + (2.5 * plateThickNess), 
                     lidThickness], 
                    cornerRadius + plateThickNess);
        // Like the box exterior
        // #roundedRect([mainPlateWidth, mainPlateLength, plateThickNess], cornerRadius);
      }
    }
    union() { // Like above. To extrude it.
      // Bottom
      tvBoxRPiB3(show=false, solid=true); 

      // The screen
      // translate([-0.4, 1.25, 22.5]) { // When completely closed.
      translate([-0.4, 1.25, 25.9]) { // On top of the box
      // translate([0, 0, 36]) {
        rotate([0, 0, 180]) {
          drawScreen(extrudeTop=extrudeForScreen, extrudeBottom=true, screenDimFactor=1.075);
        }
        if (!extrudeForScreen) { // Drill holes
          translate([0, 0, 10]) {
            translate([0, -20, 0]) {
              cylinder(d=10, h=30, center=true, $fn=50);
            }
            translate([0, 0, 0]) {
              cylinder(d=10, h=30, center=true, $fn=50);
            }
            translate([0, 20, 0]) {
              cylinder(d=10, h=30, center=true, $fn=50);
            }
          }
        }
      }
      // The bottom box, higher... To remove unwanted grooves.
      // translate([0, 0, 4]) {
        // tvBoxRPiB3(show=false, solid=true); // Wow! Demanding!
      // }
      // Big extrusion under everything...
      translate([0, 0, 11.75]) {
        cube(size=[58.0, 150, 30], center=true);
      }
    }
  }
}
// That's it!
