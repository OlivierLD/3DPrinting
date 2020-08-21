/*
 * First test for a stamp
 */
echo(version=version());

logo = "world.inv.png"; // res 200 x 197
logox = 200; 
logoy = 197; 

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

difference() {  
	union() {
		roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
		translate([0, 0, 3]) {
			scale([.9 * plateWidth / logox, .9 * plateWidth / logoy, .02]) {
				color("red") {
					rotate([0, 0, -90]) {
						surface(file=logo, invert=true, center=true);
					}
				}
			}
		}
	}
}
