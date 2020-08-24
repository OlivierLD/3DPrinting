/*
 * Stand for a 5" or 7" HDMI screen, from Adafruit
 * https://www.adafruit.com/product/2260
 *
 * Specs at https://learn.adafruit.com/adafruit-5-800x480-tft-hdmi-monitor-touchscreen-backpack/downloads	
 */
echo(version=version());

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

FIVE_INCHES_OPTION = 1;
SEVEN_INCHES_OPTION = 2;

module HDMI5inchesStand(option=SEVEN_INCHES_OPTION) {
  // Screen dimension, between screws
  INCHES_FIVE_INCH_SCREEN_WIDTH = 4.44;
  INCHES_FIVE_INCH_SCREEN_HEIGHT = 3.3;

  INCHES_SEVEN_INCH_SCREEN_WIDTH = 6.19;
  INCHES_SEVEN_INCH_SCREEN_HEIGHT = 4.26;

  INCHES_TO_MM = 25.4;


  screenWidth = (option == FIVE_INCHES_OPTION ? INCHES_FIVE_INCH_SCREEN_WIDTH : INCHES_SEVEN_INCH_SCREEN_WIDTH) * INCHES_TO_MM;
  screenHeight = (option == FIVE_INCHES_OPTION ? INCHES_FIVE_INCH_SCREEN_HEIGHT : INCHES_SEVEN_INCH_SCREEN_HEIGHT) * INCHES_TO_MM;

  echo("Screen dims in mm:", screenWidth, " x ", screenHeight);

  // Base plate
  // ----------
  plateThickNess = 3;
  cornerRadius = 10;
  plateWidth = screenWidth + (2 * cornerRadius);
  plateLength = screenHeight + (2 * cornerRadius);

  difference() {  
    difference() {
      roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
      roundedRect([plateWidth - 25, plateLength - 25, plateThickNess * 1.1], cornerRadius * 0.75);
    }
    // Corners screw holes
    translate([- ((plateWidth / 2) - (2 * cornerRadius / 1)), ((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
      cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
    }
    translate([+ ((plateWidth / 2) - (2 * cornerRadius / 1)), ((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
      cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
    }
    translate([- ((plateWidth / 2) - (2 * cornerRadius / 1)), -((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
      cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
    }
    translate([+ ((plateWidth / 2) - (2 * cornerRadius / 1)), -((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
      cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
    }
  }

  // holes diameter: 2.5mm
  // Raspberry Pi pegs
  // -----------------
  // Base Pegs
  basePegDiam = 6;
  basePegScrewDiam = 2;
  basePegHeight = 10;

  difference() {
    color("orange") {
      union() {
        translate([ (screenWidth / 2), (screenHeight / 2), (basePegHeight/ 2)]) {
          cylinder(h=basePegHeight, d1=2*basePegDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ (screenWidth / 2), -(screenHeight / 2), (basePegHeight/ 2)]) {
          cylinder(h=basePegHeight, d1=2*basePegDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ -(screenWidth / 2), (screenHeight / 2), (basePegHeight/ 2)]) {
          cylinder(h=basePegHeight, d1=2*basePegDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ -(screenWidth / 2), -(screenHeight / 2), (basePegHeight/ 2)]) {
          cylinder(h=basePegHeight, d1=2*basePegDiam, d2=basePegDiam, center=true, $fn=100);
        }
      }
    }
    topPegDiam = 2;
    topPegHeight = 12;
    color("red") {
      union() {
        translate([ (screenWidth / 2), (screenHeight / 2), (topPegHeight / 2)]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
        translate([ (screenWidth / 2), -(screenHeight / 2), (topPegHeight / 2)]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
        translate([ -(screenWidth / 2), (screenHeight / 2), (topPegHeight / 2)]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
        translate([ -(screenWidth / 2), -(screenHeight / 2), (topPegHeight / 2)]) {
          cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
        }
      }
    }
  }
}
// That's it!

HDMI5inchesStand(option=FIVE_INCHES_OPTION);

