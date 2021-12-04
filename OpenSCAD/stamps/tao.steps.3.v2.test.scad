/*
 * Tao Steps Stamp. Two feet, side by side.
 */
 echo(version=version());

logo1 = "images/footprint_left.png";
logo2 = "images/footprint_right.png";
logoy = 450; // 343; 
logox = 550; // 626; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}


// Base plate
// ----------
plateWidth = 60; // 80;
plateLength = 60; // 80;
plateThickNess = 3;
cornerRadius = 0;
ratio = 0.5;

module oneStep() {
  translate([-10, 0, 2]) {
    scale([ratio * ((plateLength / 1) / 1) / logox, 
           ratio * plateWidth / logoy, .02]) {
      color("red") { // Port
        rotate([0, 0, -0]) {
          surface(file=logo1, invert=true, center=true);
        }
      }
    }
  }
  translate([10, 0, 2]) {
    scale([ratio * ((plateLength / 1) / 1) / logox, 
           ratio * plateWidth / logoy, .02]) {
      color("green") { // Starboard
        rotate([0, 0, -0]) {
          surface(file=logo2, invert=true, center=true);
        }
      }
    }
  }
}

//color("blue") {
difference() {  
	union() {
		difference() {
			roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
      oneStep();
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