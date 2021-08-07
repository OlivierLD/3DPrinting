/*
 * Tao Steps Stamp
 */
 echo(version=version());

logo1 = "images/footprint_left.png";
logo2 = "images/footprint_right.png";
logoy = 400; // 343; 
logox = 626; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}


// Base plate
// ----------
nbSteps = 3; // Must be odd
betweenSteps = 100;

plateWidth = 40;
plateLength = 10 + (betweenSteps * nbSteps) + 10;  // before - steps - after

echo (str(">>> Plate length:", plateLength, " mm"));

plateThickNess = 3;
cornerRadius = 0;
ratio = 0.6;

module oneStep() {
  translate([0, -25, 2]) {
    scale([ratio * ((plateLength / (2 * nbSteps)) / 1) / logox, 
           ratio * plateWidth / logoy, .02]) {
      color("red") {
        rotate([0, 0, -0]) {
          surface(file=logo1, invert=true, center=true);
        }
      }
    }
  }
  translate([0, 25, 2]) {
    scale([ratio * ((plateLength / (2 * nbSteps)) / 1) / logox, 
           ratio * plateWidth / logoy, .02]) {
      color("green") {
        rotate([0, 0, -0]) {
          surface(file=logo2, invert=true, center=true);
        }
      }
    }
  }
}

from = -(nbSteps - 1) / 2;
to   = (nbSteps - 1) / 2;
//color("green") {
difference() {  
	union() {
		difference() {
			roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
      for (i = [from:to]) {
        translate([0, (betweenSteps * i), 0]) {
          oneStep();
        }
      }
		}
		// The frame
		translate([0, 0, (plateThickNess / 1)]) {
			difference() {
				roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
				roundedRect([plateWidth - 5, plateLength - 5, plateThickNess * 1.1], cornerRadius);
			}
		}
	}
}
//}