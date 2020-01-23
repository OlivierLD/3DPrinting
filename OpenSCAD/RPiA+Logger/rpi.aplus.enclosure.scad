/*
 * Raspberry Pi A+ Enclosure.
 * Check https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_3aplus_case.pdf
 * and https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_3aplus.pdf
 */
use <../oliv.utils.scad>;

echo(version=version());

outerWidth = 75;
outerLength = 65;
outerHeight = 30;
outerRadius = 6;
boxThickness = 2;

basePegDiam = 6;
basePegHeight = 3;
basePegInnerDiam = 2.5;

module box() {
	difference() {
		roundedRect([ outerWidth,
									outerLength,
									outerHeight ],
								outerRadius, $fn=100);

		translate([0, 0, boxThickness]) {
			roundedRect([ outerWidth - boxThickness,
										outerLength - boxThickness,
										outerHeight - boxThickness ],
									outerRadius - boxThickness, $fn=100);
		}
	}
}

// Pegs
widthBetweenPegs = 42.73;
lengthBetweenPegs = 49.31;

module pegs() {
	color("green") {
		translate([ lengthBetweenPegs / 2,
						    widthBetweenPegs / 2,
						    - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
		}
		translate([ lengthBetweenPegs / 2,
						    - widthBetweenPegs / 2,
						    - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
		}
		translate([ - lengthBetweenPegs / 2,
						    widthBetweenPegs / 2,
						    - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
		}
		translate([ - lengthBetweenPegs / 2,
						    - widthBetweenPegs / 2,
						    - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
		}
	}
}         

module drillPegs() {
	color("red") {
		translate([ lengthBetweenPegs / 2,
								widthBetweenPegs / 2,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight * 10, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
		translate([ lengthBetweenPegs / 2,
								- widthBetweenPegs / 2,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight * 10, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
		translate([ - lengthBetweenPegs / 2,
								widthBetweenPegs / 2,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight * 10, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
		translate([ - lengthBetweenPegs / 2,
								- widthBetweenPegs / 2,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight * 10, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
	}
}  

module boxPegsAndScrews() {
	difference() {
		union() {
			box();
			pegs();
		}
		drillPegs();
	}
}

module drillUSB() {
	// TODO 
}

if (true) {
	// Holes
	difference() {
		boxPegsAndScrews();
		rotate([0, 90, 0]) {
			cylinder(h=100, d1=10, d2=10, center=true, $fn=100);
		}
	}
} else {
	// Bar
	boxPegsAndScrews();
	rotate([0, 90, 0]) {
		color("cyan") {
			cylinder(h=100, d1=10, d2=10, center=true, $fn=100);
		}
	}
}
