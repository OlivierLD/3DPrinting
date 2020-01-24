/**
 * The full stand... Using other scad files.
 *
 * Used to visualize the whole project, not for print.
 * Animation available in stuck mode.
 */
use <./all.parts.scad>

echo(version=version());
echo(">>>>>> For visualization only, not for print!");

// Two grooved cylinders, with 3 feet, and a crosshair.
// The bottom one has a place for a worm gear.
baseCylHeight = 50;
cylHeight2 = 35;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;

fixingFootSize = 20;
fixingFootWidth = 30;
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

_sizeAboveAxis = 100;
_sizeBelowAxis = 130;
_widthOutAll = 90;
_plateWidth = 60;
_betweenAxis = 60;
_bottomCylinderDiam = 35;


stuck = true; // Components stuck together, or apart.
betweenParts = 20; // When apart 

function timeToRot(t, stuck) =
	stuck ? (t * 360) % 360 : 0;

// TODO Adjust height and everything.
wormGearHeight = _motorSide / 2; // baseCylHeight / 2;
workGearOffset = extDiam / 3;

difference() {
	union() {
		// Base, on the bootom plate
		difference() {
			footedBase(baseCylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
			#wormGearAxis(workGearAxisDiam, workGearOffset, wormGearHeight);	
		}
		// inverted one on top, under the rotating stand
		translate([0, 0, (baseCylHeight + cylHeight2 + 1) + (stuck ? 0 : (1 * betweenParts))]) {
			rotate([180, 0, timeToRot($t, stuck)]) {
				footedBase(cylHeight2, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
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
		// Main stand
		translate([0, 0, (baseCylHeight + cylHeight2 + 1 + _thickness) + (stuck ? 0 : (2 * betweenParts))]) {
			rotate([0, 0, timeToRot($t, stuck)]) {
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
				slack = 5;
				rotate([90, 0, 0]) {
					translate([0, _height, (_totalStandWidth / 2) - (_thickness / 2) - (wheelThickness)]) {
						color("orange") {
							cylinder(d=bigWheelDiam,
											 h=wheelThickness,
											$fn=50);
						}
					}
					translate([_topWidth / 6, _height, -(_totalStandWidth * 1.1 / 2)]) {
						color("grey", 0.8) {
							cylinder(d=_horizontalAxisDiam, h=(_totalStandWidth * 1.1));
						}
					}
				}
				_widthOutAll = ((_totalStandWidth - (2 * _thickness)) - slack) - wheelThickness;
				// Panel bracket
				rotate([0, 0, -90]) {
					translate([0, _topWidth / 6, (baseCylHeight + cylHeight2 + 1 + _thickness) + (_height - _thickness) - _sizeAboveAxis + (stuck ? 0 : (3 * betweenParts)) /*_sizeAboveAxis - (_thickness / 2)*/]) {
						
						rotate([0, 0, 0]) { // TODO Tweak for animation
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
							// Small wheel
							rotate([0, 90, 0]) {
								translate([(-smallWheelDiam / 2) + _betweenAxis, 0, (_widthOutAll / 2) + 3 /*slack*/]) {
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
		}
		// Worm gear motor
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
	if (stuck) {
		// Drilling pattern
		translate([0, 0, 0]) {
			%drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, 200);
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			%axisDrillingPattern(length=200);
		}
	}
}

	

