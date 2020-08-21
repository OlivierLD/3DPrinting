/*
 * Test for a stamp mold
 *
 * This one is not a mold, it is the stamp itself.
 */
echo(version=version());

logo = "resist.png"; // res 354 x 355
logox = 354; 
logoy = 355; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

// Base plate
// ----------
plateWidth = 50;
plateLength = 50;
plateThickNess = 3;
cornerRadius = 10;

union() {
  // The plate
  translate([0, 0, 2 * plateThickNess]) {
    color("green") {
      roundedRect([plateWidth * 1.05, plateLength * 1.05, plateThickNess * 2], cornerRadius);
    }
  }
  // The "mold"
  difference() {  
    union() {
      difference() {
        //roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
        translate([0, 0, 1]) {
          scale([.9 * plateWidth / logox, .9 * plateWidth / logoy, -.02]) {
            color("white") {
              rotate([0, 0, -90]) {
                surface(file=logo, invert=true, center=true);
              }
            }
          }
          // the groove around the picture
          /*
          difference() {
            roundedRect([plateWidth -  5, plateLength -  5, plateThickNess], cornerRadius);
            roundedRect([plateWidth - 10, plateLength - 10, plateThickNess * 1.1], cornerRadius);
          }
          */
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
}
