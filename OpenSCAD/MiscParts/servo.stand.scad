/**
 * @author OlivierLD
 * 
 * A test, a stand for a servoParallax900_00005()
 */
use <../mechanical.parts.scad>

servoXOffset = 29.1; // From the servo's specs.
servoZOffset = 10;
standThickness = 6;

deeper = 1;

difference() {
	cube(size=[standThickness, 50, 70], center=true);
	translate([- (standThickness / 2) - (servoXOffset) + deeper, 0, servoZOffset]) {
		rotate([0, 90, 0]) {
			servoParallax900_00005();
			servoParallax900_00005(drillPattern=true, drillDiam=2.5);
		}
	}
}
