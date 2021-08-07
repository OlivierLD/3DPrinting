/*
 * Leather embossing
 */
echo(version=version());

// Base plate
// ----------
plateWidth = 75;    // 50
plateLength = 50;   // 50
plateThickNess = 3;
cornerRadius = 0; // 10;

logo = "./images/onecamel.inv.2.png"; 
imgRatio = 1.2;
logox = 448 * imgRatio; 
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
		//difference() {
			roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
			translate([0, 0, 2.9]) {
				scale([.9 * plateWidth / logox, .9 * plateWidth / logoy, .02]) {
					//color("white") {
						rotate([0, 0, -90]) {
							surface(file=logo, invert=true, center=true);
						}
					//}
				}
			}
		//}
	}
}
