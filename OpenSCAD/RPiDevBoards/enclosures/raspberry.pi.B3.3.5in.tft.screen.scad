/*
 *
 * Raspberry Pi 3B stand, with 3.5" TFT screen
 *              |
 *              + hey, NOT 4 !!
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_4b_4p0.pdf
 *
 * NOTE:  See the bottom of the file for print options.
 */
 
 
use <../HDMI.5.inches.stand.scad>
 
echo(version=version());

module roundedRect(size, radius) {  
  // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/2D_to_3D_Extrusion
	linear_extrude(height=size.z, center=true, $fn=50) {
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
        translate([-5.95, 56.3, 0]) {
          #cylinder(d=7 /*5.85*/, h=20, $fn=50, center=true);
        }
      }
      // HDMI
      rotate([0, 90, 0]) {
        translate([-6, 34.7, 0]) {
          #cube(size=[8, 16, 12], center=true);
        }
      }
      // USB/Power
      rotate([0, 90, 0]) {
        translate([-4, 13.4, 3]) {
          #cube(size=[4, 10, 12], center=true);
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
          #cube(size=[14, 17, 15], center=true);
        }
      }
      // USB, 1.
      rotate([0, 0, 90]) {
        translate([ 90, 30.5, 11.5]) {
          #cube(size=[14,   // depth  
                      15.5, // width
                      16],  // height
                      center=true);
        }
      }
      // USB, 2.
      rotate([0, 0, 90]) {
        translate([ 90, 49, 11.5]) {
          #cube(size=[14,   // depth  
                      15.5, // width
                      16],  // height
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

/*
 * show=true: show the raspberry
 * show=false: drill holes for sockets
 */
module tvBoxRPiB3(show=true) { 

  difference() {
    // Bottom
    union() {
      translate([0, 0, 0]) {
        union() {
          // Base
          roundedRect([mainPlateWidth, mainPlateLength, plateThickNess], cornerRadius);
          // The wall
          wallHeight = 20 + 5; // 5 = basePegHeight;
          translate([0, 0, (wallHeight / 2)]) { // 12.5 = (20 + 5) / 2
            difference() {
              roundedRect([mainPlateWidth, mainPlateLength, wallHeight], cornerRadius);
              translate([0, 0, 0.5]) { // 0.5 = (1 / 2) ===========================+
                roundedRect([mainPlateWidth - 6, mainPlateLength - 6, wallHeight + 1], cornerRadius - plateThickNess);              
              }
            }
          }
        }
      }
      // Draw the raspberry. Show, or drill.
      raspberryBStand(withRPi=show, drillHoles=false);
    }
    
    if (!show) {
      // Drill the holes for the sockets
      translate([(1 * rPiLength / 2) + 4.9 /*1.6*/ - (xOffset / 1) , yOffset - (35.4), 3]) {
        drawRaspberryPi(withSocket=true);
      }
    }
  }
}

/* 
 * Do it!
 */

// Bottom
tvBoxRPiB3(show=false); 

// That's it!
