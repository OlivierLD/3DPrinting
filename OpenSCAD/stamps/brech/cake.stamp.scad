/*
 * Cake embossing
 * A Stamp on the cake. ELLIE, EVA, FEFE, BABA.
 * Uncomment at will. Works with images.
 */
echo(version=version());

// Base plate
// ----------
plateWidth = 30;    // 50
plateLength = 50;   // 50
plateThickNess = 3;
cornerRadius = 5; // 0; // 10;

logo = "../images/brech/ellie.flip.png"; 
// logo = "../images/brech/eva.flip.png"; 
// logo = "../images/brech/fefe.flip.png"; 
// logo = "../images/brech/baba.flip.png"; 

imgRatio = 1.0;
logox = 448 * imgRatio; 
logoy = 450 * imgRatio; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) { 
      offset(-radius) {
        square([size.x, size.y], center = true);
      }
		}
	}
}

difference() {  
	union() {
		//difference() {
			roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
			translate([0, 0, 3.5]) {
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
