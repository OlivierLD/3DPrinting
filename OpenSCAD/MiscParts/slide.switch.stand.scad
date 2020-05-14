/**
 * @author OlivierLD
 * 
 * A test, a stand for a Slide Switch
 * Here SPDT Slide Switch
 */
use <../mechanical.parts.scad>

standThickness = 4;

dims = getSpdtSlideDims();

echo("Dimension: L:", dims[0], ", W:", dims[1], ", H:", dims[2]);

VISUALIZATION = false; // Set to true so see the switch in its socket.

difference() {
	union() {
		// Stand
		cube(size=[standThickness, 30, 20], center=true);
		// Bottom for the swicth
	  translate([-3.4, 0, 0]) {
			rotate([0, 0, 90]) {
				wallThickness = 3;
				difference() {
					translate([0, -1.5, 0]) {
						cube(size=[dims[0] + wallThickness, dims[1] + (0.8 * wallThickness), dims[2]], center=true);
					}
					translate([0, 1.5, 0]) {
						cube(size=[dims[0] - 3.0, dims[1] - 0, dims[2] - 3], center=true);
					}
				}
			}
		}		
		if (VISUALIZATION) {
			translate([(- 1 * dims[2] / 2) + (1 * standThickness / 2) + 0.25, 0, 0]) {
				rotate([90, 0, 90]) {
					spdtSlideSwitch();
				}
			}
		}
	}
	if (!VISUALIZATION) {
		translate([(- 1 * dims[2] / 2) + (1 * standThickness / 2) + 0.25, 0, 0]) {
			rotate([90, 0, 90]) {
				#spdtSlideSwitch();
			}
		}
	}
}
