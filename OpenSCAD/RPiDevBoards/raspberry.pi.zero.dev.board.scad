/*
 * 20-Jan-2020, MLK day, discovering OpenSCAD.
 * Note: This is a first experience with OpenSCAD. The structure of the code
 * could be improved, a lot! I know.
 *
 * Raspberry Pi Zero dev board, 
 * A Raspberry Pi Zero, next to a small breadboard.
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
 *
 * Features:
 * - Text
 * - Image
 * - etc
 *
 * TODO: Header labels?
 */
echo(version=version());

logo = "RPiLogo.png"; // res 240 x 300
logox = 200; 
logoy = 200; 

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

// Base plate
// ----------
plateWidth = 90;
plateLength = 90;
plateThickNess = 3;
cornerRadius = 10;

// roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);

text1="Oliv did it.";
text2="2020";
difference() {  
	union() {
		roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
		translate([25, 0, 2]) {
			scale([.2 * plateWidth / logox, .2 * plateWidth / logoy, .02]) {
				color("red") {
					rotate([0, 0, -90]) {
						surface(file=logo, invert=true, center=true);
					}
				}
			}
		}
	}
	// Corners screw holes
	translate([- ((plateWidth / 2) - (2 * cornerRadius / 3)), ((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
		cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
	}
	translate([+ ((plateWidth / 2) - (2 * cornerRadius / 3)), ((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
		cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
	}
	translate([- ((plateWidth / 2) - (2 * cornerRadius / 3)), -((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
		cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
	}
	translate([+ ((plateWidth / 2) - (2 * cornerRadius / 3)), -((plateLength / 2) - (2 * cornerRadius / 3)), 0]) {
		cylinder(h=plateThickNess * 2, d=4 /*cornerRadius/2*/, center=true, $fn=100);
	}
	rotate([0, 0, -90]) {
		translate([
		 -18, // left - right (Y)
		 -15, // Top - bottom (X)
		 1.5    // Up - down    (Z)
		]) {
			color("lime") {
				linear_extrude(height=plateThickNess - 1, center=true) {
					text(text1, 6);
				}
			}
		}
		translate([
		 -9,  // left - right (Y)
		 -25, // Top - bottom (X)
		 1.5    // Up - down    (Z)
		]) {
			color("lime") {
				linear_extrude(height=plateThickNess - 1, center=true) {
					text(text2, 6);
				}
			}
		}
	}
//	translate([25, 0, 3]) {
//		scale([.1 * plateWidth / logox, .1 * plateWidth / logoy, .02]) {
//			color("lime") {
//				rotate([0, 0, -90]) {
//					surface(file=logo, invert=true, center=true);
//				}
//			}
//		}
//	}
}

// Raspberry Pi holes: diameter: 2.5mm
// 23mm x 58mm (between holes axis)
rPiWidth = 58;
rPiLength = 23;

// Raspberry Pi pegs
// -----------------
// Base Pegs
basePegDiam = 6;
basePegBottomDiam = 10;
basePegScrewDiam = 2;
basePegHeight = 5;
offset = 7;
difference() {
	color("orange") {
		union() {
			translate([ ((plateLength/2) - offset), (rPiWidth / 2), plateThickNess]) {
				cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
			}
			translate([ ((plateLength/2) - offset), -(rPiWidth / 2), plateThickNess]) {
				cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
			}
			translate([ ((plateLength/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
				cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
			}
			translate([ ((plateLength/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
				cylinder(h=basePegHeight, d1=basePegBottomDiam, d2=basePegDiam, center=true, $fn=100);
			}
		}
	}
	topPegDiam = 2;
	topPegHeight = 7;
	color("red") {
		translate([ ((plateLength/2) - offset), (rPiWidth / 2), plateThickNess]) {
			cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
		}
		translate([ ((plateLength/2) - offset), -(rPiWidth / 2), plateThickNess]) {
			cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
		}
		translate([ ((plateLength/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
			cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
		}
		translate([ ((plateLength/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
			cylinder(h=topPegHeight, d=basePegScrewDiam, center=true, $fn=100);
		}
	}
}
// Small Breadboard: 35mm x 45.6mm
breadboardLength = 45.6;
breadboardWidth = 35;
borderHeight = 5;
borderThickness = 3;
// Same offset for the breadboard as for the raspberry

// Breadboard frame
// ----------------
slack = 1.05;
color("cyan") {
	// Outer width (close to the edge(), the bottom)
	translate([ -((plateLength/2) - offset + ((slack * borderThickness) / 2)), 
							0, 
							plateThickNess ]) {
		cube(size=[ borderThickness, 
								(breadboardLength + (2 * borderThickness)) * slack, 
								borderHeight], 
				 center=true);
	}
	// Inner width (close to the center, the top)
	translate([-((plateLength / 2) - offset - (slack * breadboardWidth) - borderThickness - (borderThickness / 2)), 
							0, 
							plateThickNess ]) {
		cube(size=[ borderThickness, 
								(breadboardLength + (2 * borderThickness)) * slack, 
								borderHeight], 
				 center=true);
	}
	// Left
	translate([ -((plateLength / 2) - offset - (slack * (breadboardWidth + borderThickness) / 2)), 
							((breadboardLength * slack) / 2) + ((slack * borderThickness) / 2), 
							plateThickNess ]) {
		cube(size=[ (breadboardWidth + (3 * borderThickness)) * slack, 
								borderThickness, 
								borderHeight], 
				 center=true);
	}
	// Right
	translate([ -((plateLength / 2) - offset - (slack * (breadboardWidth + borderThickness) / 2)), 
							-(((breadboardLength * slack) / 2) + ((slack * borderThickness) / 2)), 
							plateThickNess ]) {
		cube(size=[ (breadboardWidth + (3 * borderThickness)) * slack, 
								borderThickness, 
								borderHeight], 
				 center=true);
	}
}
// With a Raspberry Pi Zero. Dimensions 65 x 30 out all.
if (false) {
	translate([(1 * plateLength / 2) - (30) - (offset / 2) , -32.5, 0 -14.5]) {
		rotate([90, 0, 90]) {
			color("green", 0.75) {
				import("../../raspberry-pi-zero-2.snapshot.9/RapberryPiZero.STL");
			}
		}
	}
}
// That's it!
