/*
 * Chiffres pechants
 */
echo(version=version());

// Base plate
// ----------
plateWidth = 160;    // 50
plateLength = 80;   // 50
plateThickNess = 3;
cornerRadius = 10;

logo = "./images/seventeen.png"; // White on Black !!
imgRatio = 0.4;
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
			translate([20, 0, 5]) {
				scale([.9 * plateWidth / logox, .9 * plateWidth / logoy, .2]) {
					color("silver") {
						rotate([0, 0, 0]) {
              surface(file=logo, invert=true, center=true); // , convexity=5);
						}
					}
				}
			}
		}
    translate([0, 0, -3]) {
      roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
    }
	}
}
