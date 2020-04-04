/**
 * Full stand for feedback from linear potentiometer
 *
 * @author OlivierLD
 */
 
use <../mechanical.parts.scad>
 
basePlateThickness = 10;
basePlateWH = 80;
mainAxisDiam = 10;
mainAxisHeight = 30;
mainAxisBottomPlateDiam = 20;
mainAxisBottomPlateThickness = 5;

knobDiam = 60; 
knobThickness = 30;
 
// Axis
module axis() {
	union() {
		cylinder(h=mainAxisHeight, d=mainAxisDiam, $fn=100);
		cylinder(h=mainAxisBottomPlateThickness, d=mainAxisBottomPlateDiam, $fn=100);
	}
}

notchHeight = 2;
notchLen = 5;
notchThickness = 1;

// Bottom Plate
module bottomPlate() {
	difference() {
		cube(size=[basePlateWH, basePlateWH, basePlateThickness], center=true);
		// Grooves (for graduation)
		for (angle = [0:10:359]) {
			rotate([0, 0, angle]) {
				translate([(notchLen / 2) + (knobDiam / 2), 0, (basePlateThickness / 2) - (notchHeight * 0.9)]) {
					rotate([0, 0, 90]) {
						cube(size=[1, notchLen, notchHeight]);
					}
				}
			}
		}
	}
}

topPlateWidth = 25;
topStandThickness = 6;
module topPlate() {
  bottomToFirstPlateTop = 8.2 + 1.3; // + 2.2;
  standThickness = topStandThickness;
	
	plateLength = (basePlateWH / 2) + 20;

	difference() {
		translate([0, 0, -(basePlateWH / 2) + 20 + 10]) {
			cube(size=[standThickness, topPlateWidth, plateLength], center=true);
		}
		translate([- (standThickness / 2) - bottomToFirstPlateTop, 0, 0]) {
			rotate([0, 90, 0]) {
				rotate([0, 0, -90]) {
					#B10K();
				}
			}
		}
	}
}

slack = 5;

module flatSide() {
	sideHeight = basePlateThickness + knobThickness + slack + topStandThickness;
	points = [
		[-(basePlateWH / 2), 0],
		[(basePlateWH / 2), 0],
	  [topPlateWidth / 2, sideHeight],
		[-(topPlateWidth / 2), sideHeight]
	];
	paths = [[0, 1, 2, 3]];
	
	difference() {
		polygon(points, paths, convexity=10);
		// TODO Drill holes
		translate([0, 10]) {
			circle(d=basePlateWH / 2, $fn=50);
		}
	}
}

module standSide() {
	linear_extrude(height=topStandThickness, center=true) {
		flatSide();
	}
}

module fullStand() {
	translate([0, 0, 0]) {
		bottomPlate();
	}
	translate([0, 0, basePlateThickness + knobThickness + slack]) {
		rotate([0, 90, 0]) {
			topPlate();
		}
	}
	translate([-(basePlateWH / 2) + (topStandThickness / 2), 0, -(topStandThickness / 2)]) {
		rotate([90, 0, 90]) {
			standSide();
		}
	}
}

module knob() {
	difference() {
		union() {
			nbFaces = 12;
			cylinder(d=knobDiam, h=knobThickness, $fn=nbFaces);
			// The Beak, pointer
			rotate([0, 0, (360 / nbFaces) / 2]) {
				translate([(knobDiam / 2) - 2, 0, 0]) {
					cylinder(10, 5 , 00, $fn=4);
				}
			}
		}
		// Top hole
		diam = 6; // From the pot axis
		translate([0, 0, knobThickness - 15]) {
			cylinder(d=diam, h=30, $fn=50);
		}
	}
}

// Tweak the following for printing
withBottomAxis = false;
withKnob = true;
withBase = true;

// Now talking

if (withBottomAxis) {
	axis();
}

if (!withBottomAxis) {
	difference() { 
		union() {
			if (withBase) {
				translate([0, 0, basePlateThickness / 2]) {
					fullStand();
				}
			}
			if (withKnob) {
				translate([0, 0, basePlateThickness]) {
					knob();
				}
			}
		}
		axis();
	}
}