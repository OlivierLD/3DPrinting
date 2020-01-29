/**
 * @author OlivierLD
 *
 * The full stand... Using other scad files.
 *
 * Used to visualize the whole project, not for print.
 * Animation available in stuck mode.
 */
use <./mechanical.parts.scad>
use <./all.parts.scad>
use <./parts.printer.scad>

echo(version=version());
echo(">>>>>> For visualization only, not for print!");

stuck = true; // Components stuck together, or apart.
betweenParts = 20; // When apart 

baseAnimation = true; // Set to true to enable %$t based animations on the base's rotation.
tiltAnimation = true; // Set to true to enable %$t based animations on the bracket's tilt.

withBase = true;
topFeetInside = true;
withSolarPanel = true && stuck;

// Two grooved cylinders, with 3 feet, and a crosshair.
// The bottom one has a place for a worm gear.

// Change at will...
include <./full.stand.prm.02.scad>

solarPanelDimensions = [420, 280, 3]; // [width, length, thickness]

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
	]) : 0) : 90;

// TODO Adjust height and everything.
wormGearHeight = _motorSide / 2; // baseCylHeight / 2;
wormGearOffset = extDiam / 3;

difference() {
	currentHeight = 0;
	baseRotationAngle = timeToRot($t, stuck); // [0..360]
	bracketTiltAngle = timeToTilt($t, stuck); // [-90..90];
	union() {
		// Base, on the bottom plate
		if (withBase) {
			union() {
				printBase1(baseCylHeight, 
									 extDiam, 
									 torusDiam, 
									 intDiam, 
									 ballsDiam, 
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness, 
									 verticalAxisDiam,
									 wormGearAxisDiam, 
									 wormGearOffset, 
									 wormGearHeight);
			}
			// inverted one on top, under the rotating stand
			translate([0, 0, (baseCylHeight + cylHeight2 + 1) + (stuck ? 0 : (1 * betweenParts))]) {
				rotate([180, 0, baseRotationAngle]) {
					printBase2(cylHeight2, 
										 extDiam, 
										 torusDiam, 
										 intDiam, 
										 ballsDiam, 
										 fixingFootSize, 
										 fixingFootWidth, 
										 screwDiam, 
										 minWallThickness, 
										 feetInside=topFeetInside);
				}
			}
			if (!stuck) {
				// Drilling pattern. Can be used with a difference() to drill holes in the top and bottom plates.
				color("grey", 0.6) {
					translate([0, 0, 50]) {
						drillingPattern(extDiam, 
														fixingFootSize, 
														screwDiam, 
														minWallThickness, 
														200, 
														feetInside=topFeetInside);
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
				printMainStand(_totalStandWidth, 
											 _length, 
											 _height, 
											 _topWidth, 
											 _thickness, 
											 verticalAxisDiam,
											 _horizontalAxisDiam, 
											 _flapScrewDiam,
											 extDiam, 
											 fixingFootSize, 
											 screwDiam,
											 minWallThickness,
											 topFeetInside=topFeetInside);
				// The main axis / rod, with the big wheel gear
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
												 _sizeAboveAxis,
												 _sizeBelowAxis,
												 _widthOutAll,
												 _thickness,
												 _plateWidth,
												 _betweenAxis, // between main axis and motor axis
												 _bottomCylinderDiam,
												 withMotor=true,
												 withCylinder=true);
						// TODO Main axis ball bearings
						
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
						// Solar panel?
						if (withSolarPanel) {
							translate([-solarPanelDimensions[0] / 2, -solarPanelDimensions[1] / 2, _sizeAboveAxis + solarPanelDimensions[2]]) {
								color("black", 0.75) {
									cube(size=solarPanelDimensions);
								}
							}
						}
					}
				}
			}
		}
		// Worm gear motor
		if (withBase) {
			translate([wormGearOffset, 150, (_motorSide / 2)]) {
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
			// Ball bearings stands
			dims = getBBDims(_motorAxisDiam);
			// left
			translate([wormGearOffset, 100, 0]) { 
				rotate([0, 0, -90]) {
					ballBearingStand(_motorAxisDiam,
													 _motorSide / 2,
													 fixingFootSize, 
													 fixingFootWidth, 
													 screwDiam, 
													 minWallThickness);
					translate([(fixingFootWidth / 2) - (dims[2] * 0.9 / 2), 0, _motorSide / 2]) {
						rotate([0, 90, 0]) {
							ballBearing(_motorAxisDiam);
						}
					}
				}
			}
			// right
			translate([wormGearOffset, -100, 0]) { 
				rotate([0, 0, 90]) {
					ballBearingStand(_motorAxisDiam,
													 _motorSide / 2,
													 fixingFootSize, 
													 fixingFootWidth, 
													 screwDiam, 
													 minWallThickness);
					translate([(fixingFootWidth / 2) - (dims[2] * 0.9 / 2), 0, _motorSide / 2]) {
						rotate([0, 90, 0]) {
							ballBearing(_motorAxisDiam);
						}
					}
				}
			}
		}
	}
	if (stuck) {
		// Drilling pattern
		translate([0, 0, withBase ? baseCylHeight + cylHeight2 : 0]) {
			rotate([0, 0, baseRotationAngle]) {
				drillingPattern(extDiam, 
												fixingFootSize, 
												screwDiam, 
												minWallThickness, 
												withBase ? 50 : 20, 
												feetInside=topFeetInside);
			}
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			axisDrillingPattern(length=(withBase ? 200 : 20));
		}
	}
}

	

