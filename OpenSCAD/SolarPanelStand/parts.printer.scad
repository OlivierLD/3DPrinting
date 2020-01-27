/**
 * To print all parts 
 * for the solar panel stand
 */
use <./mechanical.parts.scad>
use <./all.parts.scad>

// Options
cylHeight = 50;
cylHeight2 = 35;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;
verticalAxisDiam = 5;

fixingFootSize = 20;
fixingFootWidth = 20;
screwDiam = 4;
screwLen = 30;
minWallThickness = 5;

wormGearAxisDiam = 10; // Tube diam.

_totalStandWidth = 160;
_length = 160;
_height = 150;
_topWidth = 35;
_thickness = 10;
_horizontalAxisDiam = 6;
_motorSide = 42.3;
_motorDepth = 39;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5; // vertical one
_screwDiam = 3;
_flapScrewDiam = 3;
_bbDiam = 16;

_sizeAboveAxis = 100; // Tossion!
_sizeBelowAxis = 130; // Tossion!
_widthOutAll = 90;
_plateWidth = 60;
_betweenAxis = 60;
_bottomCylinderDiam = 35;

module printBracket() {
	panelBracket(_horizontalAxisDiam,
							 _bbDiam,
							 _sizeAboveAxis,
							 _sizeBelowAxis,
							 _widthOutAll,
							 _thickness,
							 _plateWidth,
							 _betweenAxis, // between main axis and motor axis
							 _bottomCylinderDiam,
							 withMotor=false,
							 withCylinder=false);
}
module printBase1() {
	dims = getBBDims(verticalAxisDiam); // [id, od, t]
	boltDims = getHBScrewDims(verticalAxisDiam);
	bbSocketBaseThickness = 3; // Bottom ball bearing
	socketWallThickness = 3;
	
	socketTotalHeight = (dims[2] * 1.1) + (boltDims[0]) + bbSocketBaseThickness;
			
	difference() {
		union() {
			difference() {
				footedBase(cylHeight, 
									 extDiam, 
									 torusDiam, 
									 intDiam, 
									 ballsDiam, 
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness, 
									 crosshairThickness=socketTotalHeight);	
				wormGearAxis(wormGearAxisDiam, extDiam / 3, cylHeight / 2);	
				// hole at the back, to access the screw on the axis
				translate([-torusDiam / 2, 0, cylHeight / 3]) {
					rotate([0, 90, 0]) {
						holeDepth = (extDiam - intDiam) * 1.1;
						linear_extrude(height=holeDepth, center=true) {		
							resize([cylHeight / 3, (cylHeight / 3) * 2]) {
								circle(d=cylHeight / 3);
							}
						}
					}
				}
			}
			// Bottom ball bearing socket.
			rotate([180, 0, 0]) {
				translate([0, 0, -socketTotalHeight]) {
					difference() {
						translate([0, 0, 0]) {
							rotate([0, 0, 0]) {
								cylinder(d=dims[1] + socketWallThickness, h=socketTotalHeight, $fn=50);
							}
						}
						translate([0, 0, bbSocketBaseThickness]) {
							rotate([0, 0, 0]) {
								cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
							}
						}
						translate([0, 0, -1]) { // Drill
							rotate([0, 0, 0]) {
								cylinder(d=dims[0], h=dims[2] * 5, $fn=50);
							}
						}
					}
				}
			}
		}
		// Drill everything from bottom
		translate([0, 0, -bbSocketBaseThickness]) {
			rotate([0, 0, 0]) {
				cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
			}
		}
	}

}
module printBase2() {
	footedBase(cylHeight2, 
						 extDiam, 
						 torusDiam, 
						 intDiam, 
						 ballsDiam, 
						 fixingFootSize, 
						 fixingFootWidth, 
						 screwDiam, 
						 minWallThickness, 
						 fullIndex=false);
}
module printMainStand() {
	difference() {
		mainStand(_totalStandWidth, 
							_length, 
							_height, 
							_topWidth, 
							_thickness, 
							_horizontalAxisDiam, 
							_motorSide, 
							_motorDepth,
							_motorAxisDiam, 
							_motorAxisLength, 
							_betweenScrews,
							_screwDiam,
							_flapScrewDiam,
							_bbDiam,
							false);
		translate([0, 0, 0]) {
			drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, 100);
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			axisDrillingPattern(length=100);
		}
	}
}
module printCylinder() {
	cylinderLength = _widthOutAll - (2 * _thickness) - (2 * _thickness);
	cylinderThickness = 1;
	counterweightCylinder(cylinderLength, _bottomCylinderDiam, cylinderThickness);	
}
module printBallBearingStand() {
	ballBearingStand(6,
									 30,
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness);
}
module customPrint() { // You choose!
	footedBase(40, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
}
echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design at the bottom of the script.");
echo(">>> ------------------------------------------------------");
// Choose your own below, uncomment the desired one.
//----------------
printBracket();
// printBase1();
// printBase2();
// printCylinder();
// printMainStand();
// printBallBearingStand();
// customPrint();
