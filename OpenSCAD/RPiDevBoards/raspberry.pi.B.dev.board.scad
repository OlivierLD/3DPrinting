/*
 * 20-Jan-2020, MLK day, discovering OpenSCAD.
 * Note: This is a first experience with OpenSCAD. The structure of the code
 * could be improved, a lot! I know.
 *
 * Raspberry Pi 4B stand 
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
 */
echo(version=version());

logo = "RPiLogo.png"; // res 240 x 300
logox = 200; 
logoy = 200; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

module raspberryBStandOnly(drillHoles=true) {
  // Base plate
  // ----------
  plateWidth = 90;
  plateLength = 90;
  plateThickNess = 3;
  cornerRadius = 10;

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

  offset = 7;
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

translate([0, 0, 0]) {
  raspberryBStandOnly();
}

// With a Raspberry Pi 4B. 
if (false) {
	translate([(1 * plateLength / 2) + 1.6 - (offset / 2) , -(35.4), 3]) {
		rotate([0, 0, 90]) {
			color("green", 0.75) {
				import("../../Raspberry_Pi_3_Reference_Design_Model_B_Rpi_Raspberrypi/files/Raspberry_Pi_3.STL");
			}
		}
	}
}
// That's it!
