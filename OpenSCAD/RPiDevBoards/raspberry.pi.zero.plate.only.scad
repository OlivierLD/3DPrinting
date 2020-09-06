/*
 * Raspberry Pi Zero dev board, support.
 * A Raspberry Pi Zero, only.
 * Can be used to build a plate that goes in a project box...
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
 *
 */
echo(version=version());

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

module RPiZeroSmallPlate(withPlate=true, withRpi=false) {
  // Base plate
  // ----------
  plateWidth = 40;
  plateLength = 80;
  plateThickNess = 3;
  cornerRadius = 10;

  if (withPlate) {
    roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
  }

  // Raspberry Pi holes: diameter: 2.5mm
  // 23mm x 58mm (between holes axis)
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
  difference() {
    color("orange") {
      union() {
        translate([ ((plateWidth/2) - offset), (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((plateWidth/2) - offset), -(rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((plateWidth/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
        translate([ ((plateWidth/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
          cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
        }
      }
    }
    topPegDiam = 2;
    topPegHeight = 7;
    // Drill
    color("red") {
      translate([ ((plateWidth/2) - offset), (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((plateWidth/2) - offset), -(rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((plateWidth/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
      translate([ ((plateWidth/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
        cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
      }
    }
  }

  slack = 1.05;
  // With a Raspberry Pi Zero. Dimensions 65 x 30 out all.
  if (withRpi) {
    translate([(1 * plateWidth / 2) - (30.5) - (offset / 2) , -32.5, 0 -14.5]) {
      rotate([90, 0, 90]) {
        color("green", 0.75) {
          import("../../raspberry-pi-zero-2.snapshot.9/RapberryPiZero.STL");
        }
      }
    }
  }
  // That's it!
}

if (false) {
  RPiZeroSmallPlate(withPlate=true, withRpi=true);
}

