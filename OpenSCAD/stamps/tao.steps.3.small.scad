/*
 * Tao Steps Stamp
 */
 echo(version=version());

logo = "steps.tao.black.small.png";
logoy = 400; 
logox = 607; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}


// Base plate
// ----------
plateWidth = 25;
plateLength = 40;
plateThickNess = 3;
cornerRadius = 1;
imgStep = 31.5;
//color("green") {
difference() {  
	union() {
		difference() {
			roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
			translate([0, 0, 2]) {
				scale([.6 * (plateLength / 1) / logox, 
               .6 * plateWidth / logoy, .02]) {
					color("white") {
						rotate([0, 0, -0]) {
							surface(file=logo, invert=true, center=true);
						}
					}
				}
        // the groove around the picture
        //difference() {
        //  roundedRect([plateWidth -  5, plateLength -  5, plateThickNess], cornerRadius);
        //  roundedRect([plateWidth - 10, plateLength - 10, plateThickNess * 1.1], cornerRadius);
        //}
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