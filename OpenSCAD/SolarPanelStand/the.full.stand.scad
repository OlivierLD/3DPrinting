/**
 * @author OlivierLD
 *
 * The full stand... Using other scad files.
 * See "include" statement below.
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
withSolarPanel = true && stuck;

// Change at will...
include <./param.set.03.scad>

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

difference() {
	currentHeight = 0;
	baseRotationAngle = timeToRot($t, stuck); // [0..360]
	bracketTiltAngle = timeToTilt($t, stuck); // [-90..90];
	union() {
		// Base, on the bottom plate
		if (withBase) {
			union() { // TODO remove this
				printBase1(bottomCylinderHeight, 
									 extDiam, 
									 torusDiam, 
									 intDiam, 
									 ballsDiam, 
									 fixingFootSize, 
									 fixingFootWidth, 
									 fixingFootScrewDiam, 
									 minFootWallThickness, 
									 verticalAxisDiam,
									 wormGearAxisDiam, 
									 wormGearAxisRadiusOffset, 
									 wormGearAxisHeight);
			}
			// inverted one on top, under the rotating stand
			translate([0, 0, (bottomCylinderHeight + topCylinderHeight + 1) + (stuck ? 0 : (1 * betweenParts))]) {
				rotate([180, 0, baseRotationAngle]) {
					printBase2(topCylinderHeight, 
										 extDiam, 
										 torusDiam, 
										 intDiam, 
										 ballsDiam, 
										 fixingFootSize, 
										 fixingFootWidth, 
										 fixingFootScrewDiam, 
										 minFootWallThickness, 
										 feetInside=topBaseFeetInside);
				}
			}
			if (!stuck) {
				// Drilling pattern. Can be used with a difference() to drill holes in the top and bottom plates.
				color("grey", 0.6) {
					translate([0, 0, 50]) {
						drillingPattern(extDiam, 
														fixingFootSize, 
														fixingFootScrewDiam, 
														minFootWallThickness, 
														200, 
														feetInside=topBaseFeetInside);
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

		currentHeight = (withBase ? bottomCylinderHeight + topCylinderHeight + 1 + wallThickness: 0);

		// Main stand and bracket
		translate([0, 0, (currentHeight + (0 * wallThickness)) + (stuck ? 0 : (2 * betweenParts))]) {
			rotate([0, 0, baseRotationAngle]) {
				printMainStand(standWidth, 
											 standLength, 
											 standHeight, 
											 standTopWidth, 
											 wallThickness, 
											 verticalAxisDiam,
											 horizontalAxisDiam, 
											 flapScrewDiam,
											 extDiam, 
											 fixingFootSize, 
											 fixingFootScrewDiam,
											 minFootWallThickness,
											 topFeetInside=topBaseFeetInside);
				// The main axis / rod, with the big wheel gear
				// betweenAxis = (bigWheelDiam + smallWheelDiam) / 2;
				slack = 5; // Around the wheels, left and right.
				// echo("Tilt:", bracketTiltAngle);
				rotate([90, 0, 0]) {
					// Big wheel and its axis
					translate([standTopWidth / 6, 
										 standHeight, 
										 (standWidth / 2) - (wallThickness / 2) - (wheelThickness)]) {
						color("orange") {
							cylinder(d=bigWheelDiam,
											 h=wheelThickness,
											 $fn=50);
						}
					}
					// Main Axis
					translate([standTopWidth / 6, standHeight, -(standWidth * 1.1 / 2)]) {
						color("grey", 0.8) {
							cylinder(d=horizontalAxisDiam, h=(standWidth * 1.1));
						}
					}
				}
				bracketWidthOutAll = ((standWidth - (2 * wallThickness)) - slack) - wheelThickness;
				bracketHeightOutAll = sizeAboveAxis + sizeBelowAxis;
				// Temp, force tilt.
				bracketTiltAngle = -45;
				deltaH = ((bracketHeightOutAll / 2) - sizeAboveAxis);
				// Panel bracket. See sinus and cosinus on the translate.
				translate([(standTopWidth / 6) + (sin(bracketTiltAngle) * deltaH), // Back and forth
									 0,                                                      // Along the axis
									// Up & Down
									 + (standHeight + (0 * wallThickness / 2))               // Main stand height
									// Pb on bracketTilt when above and below are different
						  		 - (cos(bracketTiltAngle) * deltaH)                      // Bracket 
									 + (stuck ? 0 : (3 * betweenParts))]) {                  // stuck / apart
					
					rotate([bracketTiltAngle, 0, -90]) { // Bracket rotation (tilt angle) here.
						printBracket(horizontalAxisDiam,
												 sizeAboveAxis,
												 sizeBelowAxis,
												 bracketWidthOutAll,
												 wallThickness,
												 bracketPlateWidth,
												 betweenAxis, // between main axis and motor axis
												 counterweightCylinderDiam,
												 withMotor=true,
												 withCylinder=true);
						// TODO Main axis ball bearings
						
						// Small wheel, attached to the motor axis
						rotate([0, 90, 0]) {
							translate([betweenAxis - ((sizeBelowAxis - sizeAboveAxis) / 2), 
							           0, 
							           (bracketWidthOutAll / 2) + 3 /*slack*/]) {
								color("orange") {
									cylinder(d=smallWheelDiam,
													 h=wheelThickness,
													 $fn=50);
								}
							}
						}
						// Solar panel?
						if (withSolarPanel) {
							translate([-solarPanelDimensions[0] / 2, 
												 -solarPanelDimensions[1] / 2, 
												 (bracketHeightOutAll / 2) - (solarPanelDimensions[2] / 2)]) {
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
			axisLength = 300;
			motorBaseSide = 50;
			
			translate([wormGearAxisRadiusOffset, (axisLength / 2) + 30, wormGearAxisHeight /*(motorSide / 2)*/ ]) {
				translate([-(motorBaseSide / 2), -(motorBaseSide / 2), -wormGearAxisHeight]) {
					// A base for the motor
					color("brown") {
						cube(size=[motorBaseSide, motorBaseSide, (wormGearAxisHeight - (motorSide / 2))]);
					}
				}
				rotate([0, 0, 180]) {
					motor(withScrews=true);
				}
				// worm gear axis and coupler
				rotate([90, 0, 0]) {
					color("grey", 0.75) {
						cylinder(d=motorAxisDiam, h=axisLength, $fn=50);
					}
					// Coupler
					translate([0, 0, 20 + (25 / 2)]) {
						color("blue", 0.85) {
							cylinder(d=19, h=25); // 5-5 coupler
						}
					}
				}
			}
			// Ball bearings stands
			dims = getBBDims(motorAxisDiam);
			// left
			translate([wormGearAxisRadiusOffset, 100, 0]) { 
				rotate([0, 0, -90]) {
					ballBearingStand(motorAxisDiam,
													 wormGearAxisHeight, // motorSide / 2,
													 fixingFootSize, 
													 fixingFootWidth, 
													 fixingFootScrewDiam, 
													 minFootWallThickness);
					translate([(fixingFootWidth / 2) - (dims[2] * 0.9 / 2), 0, motorSide / 2]) {
						rotate([0, 90, 0]) {
							ballBearing(motorAxisDiam);
						}
					}
				}
			}
			// right
			translate([wormGearAxisRadiusOffset, -100, 0]) { 
				rotate([0, 0, 90]) {
					ballBearingStand(motorAxisDiam,
													 wormGearAxisHeight, // motorSide / 2,
													 fixingFootSize, 
													 fixingFootWidth, 
													 fixingFootScrewDiam, 
													 minFootWallThickness);
					translate([(fixingFootWidth / 2) - (dims[2] * 0.9 / 2), 0, motorSide / 2]) {
						rotate([0, 90, 0]) {
							ballBearing(motorAxisDiam);
						}
					}
				}
			}
		}
	}
	if (stuck) {
		// Drilling pattern
		translate([0, 0, withBase ? bottomCylinderHeight + topCylinderHeight : 0]) {
			rotate([0, 0, baseRotationAngle]) {
				drillingPattern(extDiam, 
												fixingFootSize, 
												fixingFootScrewDiam, 
												minFootWallThickness, 
												withBase ? 50 : 20, 
												feetInside=topBaseFeetInside);
			}
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 0]) {
			axisDrillingPattern(length=(withBase ? 200 : 20));
		}
	}
}
