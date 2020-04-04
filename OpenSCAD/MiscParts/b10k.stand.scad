/**
 * @author OlivierLD
 * 
 * A test, a stand for a B10K
 */
use <../mechanical.parts.scad>

bottomToFirstPlateTop = 8.2 + 1.3; // + 2.2;
standThickness = 6;

difference() {
	cube(size=[standThickness, 40, 40], center=true);
	translate([- (standThickness / 2) - bottomToFirstPlateTop, 0, 0]) {
		rotate([0, 90, 0]) {
			#B10K();
		}
	}
}
