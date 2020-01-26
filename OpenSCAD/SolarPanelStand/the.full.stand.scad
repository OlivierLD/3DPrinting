/**
 * @author OlivierLD
 *
 * The full stand... Using other scad files.
 *
 * Used to visualize the whole project, not for print.
 * Animation available in stuck mode.
 */
use <./all.parts.scad>

echo(version=version());
echo(">>>>>> For visualization only, not for print!");

baseAnimation = true; // Set to true to enable %$t based animations on the base's rotation.
tiltAnimation = true; // Set to true to enable %$t based animations on the bracket's tilt.

withBase = true;

// Two grooved cylinders, with 3 feet, and a crosshair.
// The bottom one has a place for a worm gear.
baseCylHeight = 50;
cylHeight2 = 35;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;

fixingFootSize = 20;
fixingFootWidth = 20;
screwDiam = 4;
screwLen = 30;
minWallThickness = 5;

workGearAxisDiam = 10;

// Main stand
_totalStandWidth = 160;
_length = 160;
_height = 150;
_topWidth = 35;
_thickness = 10;
_horizontalAxisDiam = 10; // 5;
_motorSide = 42.3;
_motorDepth = 39;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5; // vertical one
_screwDiam = 3;
_flapScrewDiam = 3;
_bbDiam = 16;

_sizeAboveAxis = 130;
_sizeBelowAxis = 130;
_widthOutAll = 90;
_plateWidth = 60;
_betweenAxis = 60;
_bottomCylinderDiam = 35;

stuck = true; // Components stuck together, or apart.
betweenParts = 20; // When apart 

// Base rotation
function timeToRot(t, stuck) =
	stuck ? (baseAnimation ? (t * 360) % 360 : 0) : 0;
	
// Bracket tilt
// t=0   =>  90
// t=0.5 => -90
function timeToTilt(t, stuck) =
	stuck ? (tiltAnimation ? lookup(t, [
		[ 0, 90 ],
		[ 0.125, 45 ],
		[ 0.25, 0],
		[ 0.375, -45 ],
		[ 0.5, -90],
		[ 0.625, -45 ],
		[ 0.75, 0],
		[ 0.875, 45 ],
		[ 1, 90 ]
	]) : 0) : 0;

// TODO Adjust height and everything.
wormGearHeight = _motorSide / 2; // baseCylHeight / 2;
workGearOffset = extDiam / 3;

difference() {
	currentHeight = 0;
	baseRotationAngle = timeToRot($t, stuck); // [0..360]
	bracketTiltAngle = timeToTilt($t, stuck); // [-90..90];
	union() {
		// Base, on the bootom plate
		if (withBase) {
			difference() {
				footedBase(baseCylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
				#wormGearAxis(workGearAxisDiam, workGearOffset, wormGearHeight);	
			}
			// inverted one on top, under the rotating stand
			translate([0, 0, (baseCylHeight + cylHeight2 + 1) + (stuck ? 0 : (1 * betweenParts))]) {
				rotate([180, 0, baseRotationAngle]) {
					footedBase(cylHeight2, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness, fullIndex=false);
				}
			}
			if (!stuck) {
				// Drilling pattern. Can be used with a difference() to drill holes in the top and bottom plates.
				color("grey", 0.6) {
					translate([0, 0, 50]) {
						drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, 200);
					}
				}
				// Axis drilling pattern. Same as above.
				color("green", 0.6) {
					translate([0, 0, 50]) {
						axisDrillingPattern(length=200);
					}
				}
			}
		}

		currentHeight = (withBase ? baseCylHeight + cylHeight2 + 1 + _thickness: 0);

		// Main stand and bracket
		translate([0, 0, (currentHeight + (0 * _thickness)) + (stuck ? 0 : (2 * betweenParts))]) {
			rotate([0, 0, baseRotationAngle]) {
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
				// The main axis / rod, with the big wheel gear
				wheelThickness = 10;
				bigWheelDiam = 100;
				smallWheelDiam = 30;
				_betweenAxis = (bigWheelDiam + smallWheelDiam) / 2;
				slack = 5; // Around the wheels, left and right.
				// echo("Tilt:", bracketTiltAngle);
				rotate([90, 0, 0]) {
					// Big wheel and its axis
					translate([_topWidth / 6, 
										 _height, 
										 (_totalStandWidth / 2) - (_thickness / 2) - (wheelThickness)]) {
						color("orange") {
							cylinder(d=bigWheelDiam,
											 h=wheelThickness,
											 $fn=50);
						}
					}
					// Main Axis
					translate([_topWidth / 6, _height, -(_totalStandWidth * 1.1 / 2)]) {
						color("grey", 0.8) {
							cylinder(d=_horizontalAxisDiam, h=(_totalStandWidth * 1.1));
						}
					}
				}
				_widthOutAll = ((_totalStandWidth - (2 * _thickness)) - slack) - wheelThickness;
				// Panel bracket
				translate([(_topWidth / 6),   // Back and forth
									 0,                 // Along the axis
									// Up & Down
									 + (_height + (0 * _thickness / 2))                      // Main stand height
									 - (((_sizeAboveAxis + _sizeBelowAxis) / 2) - _sizeAboveAxis) // Bracket // FIXME Pb on bracketTilt when above and below are different
									 + (stuck ? 0 : (3 * betweenParts))]) {        // stuck / apart
					
					rotate([bracketTiltAngle, 0, -90]) { // Bracket rotation (tilt angle) here.
						panelBracket(_horizontalAxisDiam,
												 _bbDiam,
												 _sizeAboveAxis,
												 _sizeBelowAxis,
												 _widthOutAll,
												 _thickness,
												 _plateWidth,
												 _betweenAxis, // between main axis and motor axis
												 _bottomCylinderDiam,
												 withMotor=true,
												 withCylinder=true);
						// Small wheel, attached to the motor axis
						rotate([0, 90, 0]) {
							translate([_betweenAxis, 0, (_widthOutAll / 2) + 3 /*slack*/]) {
								color("orange") {
									cylinder(d=smallWheelDiam,
													 h=wheelThickness,
													$fn=50);
								}
							}
						}
					}
				}
			}
		}
		// Worm gear motor
		if (withBase) {
			translate([workGearOffset, 150, (_motorSide / 2)]) {
				rotate([0, 0, 180]) {
					motor(withScrews=true);
				}
				// worm gear axis
				rotate([90, 0, 0]) {
					color("grey") {
						cylinder(d=_motorAxisDiam, h=300, $fn=50);
					}
				}
			}
		}
	}
	if (stuck) {
		// Drilling pattern
		translate([0, 0, withBase ? baseCylHeight + cylHeight2 : 0]) {
			rotate([0, 0, baseRotationAngle]) {
				drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, withBase ? 50 : 20);
			}
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			axisDrillingPattern(length=(withBase ? 200 : 20));
		}
	}
}

	

