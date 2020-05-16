/**
 * @author OlivierLD
 * 
 * A test, a stand for a Slide Switch
 * Here SPDT Slide Switch, or Small Switch (see mechanical.parts.scad)
 */
use <../mechanical.parts.scad>

SPDT = 1;
SMALL = 2;

OPTION = SMALL;

standThickness = (OPTION == SPDT ? 4 : 3);   // Important!

dims = (OPTION == SPDT ? getSpdtSlideDims() : getSmallSlideDims());

echo("Dimension: L:", dims[0], ", W:", dims[1], ", H:", dims[2]);

VISUALIZATION = true; // Set to true so see the switch in its socket.

difference() {
	union() {
		bootomSwitch = (OPTION == SPDT ? 3.2 : 2);
		caseBottom = (OPTION == SPDT ? 1.5 : 0.8);
		hollowWidthDiff = (OPTION == SPDT ? 2 : 1);
		hollowHeightDiff = (OPTION == SPDT ? 3 : 2);
		// Stand
		cube(size=[standThickness, 30, 20], center=true);
		// Bottom for the swicth
	  translate([-bootomSwitch, 0, 0]) {
			rotate([0, 0, 90]) {
				wallThickness = (OPTION == SPDT ? 3 : 1.5);
				difference() {
					translate([0, -caseBottom, 0]) {
						cube(size=[dims[0] + (2 * wallThickness), dims[1] + (0.8 * wallThickness), 1.5 * dims[2]], center=true);
					}
					translate([0, caseBottom, 0]) {
						cube(size=[dims[0] - hollowWidthDiff, dims[1] - 0, dims[2] - hollowHeightDiff], center=true);
					}
				}
			}
		}		
		if (VISUALIZATION) {
			translate([(- 1 * dims[2] / 2) + (1 * standThickness / 2) + 0.25, 0, 0]) {
				rotate([90, 0, 90]) {
					if (OPTION == SPDT) {
						spdtSlideSwitch();
					} else {
						smallSlideSwitch();
					}
				}
			}
		}
	}
	if (!VISUALIZATION) {
		translate([(- 1 * dims[2] / 2) + (1 * standThickness / 2) + 0.25, 0, 0]) {
			rotate([90, 0, 90]) {
				if (OPTION == SPDT) {
					#spdtSlideSwitch();
				} else {
					#smallSlideSwitch();
				}
			}
		}
	}
}
