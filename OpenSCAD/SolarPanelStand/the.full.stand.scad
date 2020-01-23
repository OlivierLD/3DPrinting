/**
 * The full stand... Using other scad files.
 *
 * Used to visualize the whole project, not for print.
 */
use <./all.parts.scad>

echo(version=version());
echo("\n>>> For visualization only, not for print\n");

// A grooved cylinder, with 3 feet, and a crosshair.

baseCylHeight = 50;
cylHeight2 = 35;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;

fixingFootSize = 30;
fixingFootWidth = 30;
screwDiam = 5;
screwLen = 30;
minWallThickness = 5;

workGearAxisDiam = 10;

// Main stand
_totalStandWidth = 160;
_length = 160;
_height = 150;
_topWidth = 35;
_thickness = 5;
_horizontalAxisDiam = 5;
_motorSide = 42.3;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5;
_screwDiam = 3;
_bbDiam = 16;

stuck = false; // Components stuck together, or apart.
betweenParts = 20;

difference() {
	union() {
		// Base, on the bootom plate
		difference() {
			footedBase(baseCylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
			#wormGearAxis(workGearAxisDiam, extDiam / 3, baseCylHeight / 2);	// TODO Adjust height and everything.
		}
		// inverted one, under the rotating stand
		translate([0, 0, (baseCylHeight + cylHeight2 + 1) + (stuck ? 0 : (1 * betweenParts))]) {
			rotate([180, 0, 0]) {
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
			mainStand(_totalStandWidth, 
								_length, 
								_height, 
								_topWidth, 
								_thickness, 
								_horizontalAxisDiam, 
								_motorSide, 
								_motorAxisDiam, 
								_motorAxisLength, 
								_betweenScrews,
								_screwDiam,
								_bbDiam,
								true);
		}
	}
	if (stuck) {
		// Drilling pattern
		translate([0, 0, 50]) {
			drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, 200);
		}
		// Axis drilling pattern. Same as above.
		translate([0, 0, 50]) {
			axisDrillingPattern(length=200);
		}
	}
}

