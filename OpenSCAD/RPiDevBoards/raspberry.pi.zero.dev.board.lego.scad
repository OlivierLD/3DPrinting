/*
 * Raspberry Pi Zero dev board, 
 * A Raspberry Pi Zero, next to a small breadboard.
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
 *
 * LEGO part by https://github.com/cfinke/LEGO.scad
 *
 */
 
// Warning!! Location depends on your machine!! 
use <../../../LEGO.oliv/LEGO.scad> 
 
 
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

module legoStand() {
	TILE_TYPE = "tile"; 

	tapeWidth = 2;         // In studs
	tapeThickness = 1 / 3; // In "standard block" height
	tapeType = TILE_TYPE;

	outerWidth = 10; // 12;  // In studs
	outerLength = 10; // 11; // In studs

	// Studs to mm ?
	function studsToMm(studs) =
		((8 * studs) + 0);

	// Could also use place and uncenter (LOGO specific)
	outerWidthMm = studsToMm(outerWidth);
	outerLengthMm = studsToMm(outerLength);
	tapeWidthMm = studsToMm(tapeWidth);

	rotate([0, 0, 180]) {
		union() {

			color( "green" ) {
				
				translate([0, -((outerWidthMm / 2) - (tapeWidthMm / 2)), 0]) {
					rotate([0, 0, 0]) {
						block(width=tapeWidth,
									length=outerLength,
									height=tapeThickness,
									type=tapeType);
					}
				}
			
				translate([0, ((outerWidthMm / 2) - (tapeWidthMm / 2)), 0]) {
					rotate([0, 0, 0]) {
						block(width=tapeWidth,
									length=outerLength,
									height=tapeThickness,
									type=tapeType);
					}
				}
/*
				translate([-((outerLengthMm / 2) - (tapeWidthMm / 2)), 0, 0]) {
					rotate([0, 0, 90]) {
						block(width=tapeWidth,
									length=outerWidth,
									height=tapeThickness,
									type=tapeType);
					}
				}

				translate([((outerLengthMm / 2) - (tapeWidthMm / 2)), 0, 0]) {
					rotate([0, 0, 90]) {
						block(width=tapeWidth,
									length=outerWidth,
									height=tapeThickness,
									type=tapeType);
					}
				}
*/
			}
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

withCornerScrewHoles = false;

difference() {  
	roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
	// Corners screw holes
	if (withCornerScrewHoles) {
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
	translate([25, 0, 3]) {
		scale([.1 * plateWidth / logox, .1 * plateWidth / logoy, .02]) {
			color("lime") {
				rotate([0, 0, -90]) {
					surface(file=logo, invert=true, center=true);
				}
			}
		}
	}
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

// With Lego stand
if (true) {
	translate([0, 0, -4]) {
		legoStand();
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
