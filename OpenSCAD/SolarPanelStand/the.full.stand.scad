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


union() {
	// Base, on the bootom plate
	difference() {
		footedBase(baseCylHeight, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);	
		#wormGearAxis(workGearAxisDiam, extDiam / 3, baseCylHeight / 2);	// TODO Adjust height and everything.
	}
	// inverted one, under the rotating stand
	translate([0, 0, 100]) {
		rotate([180, 0, 0]) {
			footedBase(cylHeight2, extDiam, torusDiam, intDiam, ballsDiam, fixingFootSize, fixingFootWidth, screwDiam, minWallThickness);
		}
	}
	// Drilling pattern
	color("grey", 0.75) {
		translate([0, 0, 50]) {
			drillingPattern(extDiam, fixingFootSize, screwDiam, minWallThickness, 200);
		}
	}
}

