/**
 * The full stand... Using other scad files.
 *
 * Used to visualize the whole project, not for print.
 * Animation available in stuck mode.
 */
use <./all.parts.scad>

echo(version=version());
echo("\n>>> For visualization only, not for print\n");

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
_horizontalAxisDiam = 5;
_motorSide = 42.3;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5;
_screwDiam = 3;
_flapScrewDiam = 3;
_bbDiam = 16;

stuck = false; // Components stuck together, or apart.
betweenParts = 20; // When apart 

function timeToRot(t, stuck) =
	stuck ? (t * 360) % 360 : 0;

difference() {
	union() {
		// Base, on the bootom plate
		difference() {
			footedBase(baseCylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
			#wormGearAxis(workGearAxisDiam, extDiam / 3, baseCylHeight / 2);	// TODO Adjust height and everything.
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
									_motorAxisDiam, 
									_motorAxisLength, 
									_betweenScrews,
									_screwDiam,
									_flapScrewDiam,
									_bbDiam,
									false);
			}
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

