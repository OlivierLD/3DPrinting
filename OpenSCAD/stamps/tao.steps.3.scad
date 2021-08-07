/*
 * Tao Steps Stamp
 */
 echo(version=version());

// logo = "steps.tao.black.small.png";
// logoy = 400; 
// logox = 607; 
logo = "footprint.small.png";
logoy = 200; 
logox = 200; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}


plateWidth = 25;
plateLength = 200;
plateThickNess = 3;
cornerRadius = 1;
imgStep = 18; // 31.5;
scale = 0.7;

molded = false; // Make a mold, or not

module printTheSteps(from, to) {
  for (i = [from : to]) {
    translate([0, (i * imgStep), /* 2 */ 3]) {
      scale([scale * (plateLength / 7) / logox, 
             scale * plateWidth / logoy, .02]) {
        //color("white") {
          rotate([0, 0, -0]) {
            surface(file=logo, invert=true, center=true);
          }
        //}
      }
    }
  }
}

//color("green") {
  difference() {  
    union() {
      if (molded) {
        difference() {
          // Base plate
          roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
          // The footprints  
          printTheSteps(-4, 4);
        }
        // The frame around
        translate([0, 0, (plateThickNess / 1)]) {
          difference() {
            roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
            roundedRect([plateWidth - 5, plateLength - 5, plateThickNess * 1.1], cornerRadius);
          }
        }
      } else {
        // Base plate
        roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
        // The footprints  
        printTheSteps(-5, 5);
      }
    }
  }
//}
  