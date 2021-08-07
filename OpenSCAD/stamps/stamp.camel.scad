/*
 * Test for a stamp mold
 */
echo(version=version());

// Base plate
// ----------
plateWidth = 75;    // 50
plateLength = 50;   // 50
plateThickNess = 3;
cornerRadius = 10;

logo = "./images/onecamel.2.png"; 
imgRatio = 1.3;
logox = 450 * imgRatio; 
logoy = 450 * imgRatio; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

difference() {  
	union() {
		difference() {
			roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
			translate([0, 0, 2]) {
				scale([.9 * plateWidth / logox, .9 * plateWidth / logoy, .02]) {
					color("white") {
						rotate([0, 0, -90]) {
							surface(file=logo, invert=true, center=true);
						}
					}
				}
        // the groove around the picture
        difference() {
          roundedRect([plateWidth -  5, plateLength -  5, plateThickNess], cornerRadius);
          roundedRect([plateWidth - 10, plateLength - 10, plateThickNess * 1.1], cornerRadius);
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
