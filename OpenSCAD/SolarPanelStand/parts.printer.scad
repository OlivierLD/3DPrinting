/**
 * To print all parts 
 * for the solar panel stand
 */
use <./mechanical.parts.scad>
use <./all.parts.scad>

// Options, dimensions
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

topBaseFeetInside = true; // Topo base only

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

_sizeAboveAxis = 100; // Tossion!
_sizeBelowAxis = 130; // Tossion!
_widthOutAll = 90;
_plateWidth = 60;
_betweenAxis = 60;
_bottomCylinderDiam = 35;

/**
 * Panel Bracket.
 * All dimensions in mm
 *
 * @param horizontalAxisDiam Number. Horizontal axis diameter. Also used to find ball bearings' dimensions.
 * @param sizeAboveAxis Number. Size out all above axis
 * @param sizeBelowAxis Number. Size out all below axis
 * @param widthOutAll Number. Bracket's width out all
 * @param thickness Number. Bracket's thickness
 * @param plateWidth Number. Bracket's width
 * @param betweenAxis Number. Length bewteen main axis and motor axis
 * @param bottomCylinderDiam Number. Bottom cylinder diameter, for the cylinder's flanks.
 * @param motorDepth Number. USed to display the motor if required.
 * @param withMotor Boolean, default false.
 * @param withCylinder Boolean, default false.
 *
 * TODO Other motor dimensions (currently defaulted to NEMA-17)
 */
module printBracket(horizontalAxisDiam,
									  sizeAboveAxis,
									  sizeBelowAxis,
									  widthOutAll,
									  thickness,
									  plateWidth,
									  betweenAxis, 
									  bottomCylinderDiam,
										motorDepth=39,
									  withMotor=false,
									  withCylinder=false) {
	panelBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 widthOutAll,
							 thickness,
							 plateWidth,
							 betweenAxis, 
							 bottomCylinderDiam,
							 motorDepth,
							 withMotor,
							 withCylinder);
}
/** 
 * Bottom base
 * All dimensions in millimeters.
 *
 * @param cylHeight Number. Cylinder height 
 * @param extDiam Number. Cylinder external diameter
 * @param torusDiam Number. Torus diameter, the one the balls roll in
 * @param intDiam Number. Cylinder internal diameter
 * @param ballsDiam Number. Diameter of the balls in the torus (the groove on top)
 * @param fixingFootSize Number. Height and length of the fixing foot
 * @param fixingFootWidth Number. Fixing foot width
 * @param screwDiam Number. Diameter of the screws for the fixing foot
 * @param minWallThickness Number. How far inside the cylinder the fixing foot goes
 * @param wormGearAxisDiam Number. Diameter of the HOLE the worm gear axis spins in
 * @param workGearOffset Number. Distance between the vertical axis and the worm gear axis
 * @param wormGearHeight Number. Heigth of the worm gear axis
 */
module printBase1(cylHeight, 
									extDiam, 
									torusDiam, 
									intDiam, 
									ballsDiam, 
									fixingFootSize, 
									fixingFootWidth, 
									screwDiam, 
									minWallThickness,
									wormGearAxisDiam,
									workGearOffset,
									wormGearHeight) {
	dims = getBBDims(verticalAxisDiam); // [id, od, t]
	boltDims = getHBScrewDims(verticalAxisDiam);
	bbSocketBaseThickness = 3; // Bottom ball bearing in its socket, facing down.
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
				wormGearAxis(wormGearAxisDiam, workGearOffset, wormGearHeight);	
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
			// Bottom ball bearing socket, facing down.
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
/**
 * Top base, the one upside down
 * All dimensions in millimeters.
 *
 * @param cylHeight Number. Cylinder height 
 * @param extDiam Number. Cylinder external diameter
 * @param torusDiam Number. Torus diameter, the one the balls roll in
 * @param intDiam Number. Cylinder internal diameter
 * @param ballsDiam Number. Diameter of the balls in the torus (the groove on top)
 * @param fixingFootSize Number. Height and length of the fixing foot
 * @param fixingFootWidth Number. Fixing foot width
 * @param screwDiam Number. Diameter of the screws for the fixing foot
 * @param minWallThickness Number. How far inside the cylinder the fixing foot goes
 * @param feetInside Boolean. default false
 */
module printBase2(cylHeight, 
								  extDiam, 
								  torusDiam, 
								  intDiam, 
								  ballsDiam, 
								  fixingFootSize, 
								  fixingFootWidth, 
								  screwDiam, 
								  minWallThickness,
									feetInside = false) {
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
							 fullIndex=false,
							 feetInside=feetInside);
		drillingPattern(extDiam, 
										fixingFootSize, 
										screwDiam, 
										minWallThickness, 
										feetInside=feetInside);
	}
}

/**
 * The stand holding the bracket, fixed on the top base, rotarting on the bottom one.
 * All dimensions in millimeters
 *
 * @param totalStandWidth Number. Width out all.
 * @param length Number. Length out all.
 * @param height Number. Height of the horizontal axis
 * @param topWidth Number. Width of the top, on which the flaps sit (the ones hnolding the main axis)
 * @param thickness Number. Wall tickness
 * @param horizontalAxisDiam Number. Horizontal axis diameter
 * @param flapScrewDiam Number. Diam of the screws fixing the main axis in place
 * @param extDiam Number. Used to find the fixig foot drilling.
 * @param fixingFootSize Number. Used to find the fixig foot drilling.
 * @param screwDiam Number. Used to find the fixig foot drilling.
 * @param minWallThickness Number. Used to find the fixig foot drilling.
 */
module printMainStand(totalStandWidth, 
											length, 
											height, 
											topWidth, 
											thickness, 
											horizontalAxisDiam, 
											flapScrewDiam,
											extDiam, 
											fixingFootSize, 
											screwDiam, 
											minWallThickness,
											topFeetInside=false) {
	difference() {
		mainStand(totalStandWidth, 
							length, 
							height, 
							topWidth, 
							thickness, 
							horizontalAxisDiam, 
							flapScrewDiam);
		translate([0, 0, 0]) {
			drillingPattern(extDiam, 
											fixingFootSize, 
											screwDiam, 
											minWallThickness, 
											100, 
											feetInside=topFeetInside);
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			axisDrillingPattern(length=100);
		}
	}
}

/**
 * The counterweight cylinder at the bottom of the panel bracket
 * All dimensions in millimeters
 *
 * @param widthOutAll Number. Bracket's width out all
 * @param thickness Number. Bracket's thickness
 * @param bottomCylinderDiam Number. External cylinder's diameter
 */
module printCylinder(widthOutAll, thickness, bottomCylinderDiam) {
	cylinderLength = widthOutAll - (2 * thickness) - (2 * thickness);
	cylinderThickness = 1;
	counterweightCylinder(cylinderLength, bottomCylinderDiam, cylinderThickness);	
}

/**
 * Horizontal ball bearing stand (used for the worm gear axis).
 * All dimensions in millimeters
 *
 * @param diam Number. Axis diameter.
 * @param height Number. Axis height
 * @param fixingFootSize Number. Used for the fixing feet
 * @param fixingFootWidth Number. Used for the fixing feet 
 * @param screwDiam Number. Used for the fixing feet
 * @param minWallThickness Number. Used for the fixing feet
 */
module printBallBearingStand(diam,
														 height,
														 fixingFootSize, 
														 fixingFootWidth, 
														 screwDiam, 
														 minWallThickness) {
	ballBearingStand(diam,
									 height,
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
/*
printBracket(_horizontalAxisDiam,
						 _sizeAboveAxis,
						 _sizeBelowAxis,
						 _widthOutAll,
						 _thickness,
						 _plateWidth,
						 _betweenAxis, // between main axis and motor axis
						 _bottomCylinderDiam,
						 withMotor=false,
						 withCylinder=false);
*/
/*
printBase1(cylHeight, 
					 extDiam, 
					 torusDiam, 
					 intDiam, 
					 ballsDiam, 
					 fixingFootSize, 
					 fixingFootWidth, 
					 screwDiam, 
					 minWallThickness,
					 wormGearAxisDiam,
					 extDiam / 3, 
					 cylHeight / 2);
*/
/*
printBase2(cylHeight2, 
					 extDiam, 
					 torusDiam, 
					 intDiam, 
					 ballsDiam, 
					 fixingFootSize, 
					 fixingFootWidth, 
					 screwDiam, 
					 minWallThickness,
					 feetInside = feetInside);
*/
/* 
printCylinder(_widthOutAll, _thickness, _bottomCylinderDiam);
*/
/*
printMainStand(_totalStandWidth, 
							 _length, 
							 _height, 
							 _topWidth, 
							 _thickness, 
							 _horizontalAxisDiam, 
							 _flapScrewDiam,
							 extDiam, 
							 fixingFootSize, 
							 screwDiam, 
							 minWallThickness,
							 topFeetInside=topBaseFeetInside);
*/

printBallBearingStand(6,
										  30,
										  fixingFootSize, 
										  fixingFootWidth, 
										  screwDiam, 
										  minWallThickness);

// customPrint();
