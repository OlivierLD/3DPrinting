/**
 * @author OlivierLD
 * 
 * Small one relay module stand
 */

standThickness = 6;
standWidth = 45;
standLength = 45;

slotThickNess = 1.7;
slotDepth = 3;

rotate([0, 0, 0]) {
	translate([0, 0, 0]) {
		difference() {
			cube(size=[standWidth, standLength, standThickness], center=true);
			translate([0, 0, (standThickness - slotDepth) / 2]) {
				cube(size=[standWidth, slotThickNess, slotDepth], center=true);
			}
		}
	}
}