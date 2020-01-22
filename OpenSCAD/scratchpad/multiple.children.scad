// Usage example for difference of multiple children:
$fn=90;

difference(){
    cylinder(r=5,h=20,center=true);
    rotate([00,140,-45]) {
			color("LightBlue") {
				cylinder(r=2,h=25,center=true);
			}
		}
    rotate([00,40,-50]) {
			cylinder(r=2,h=30,center=true);
		}
    translate([0,0,-10]){
			rotate([00,40,-50]) {
				cylinder(r=1.4,h=30,center=true);
			}
		}
}
   
// second instance with added union
translate([10,10,0]) {
	difference() {
		union() {        // combine 1st and 2nd children
			cylinder(r=5,h=20,center=true);
			translate([0, 0, 0]) {
				rotate([00,140,-45]) {
					color("LightBlue") {
						cylinder(r=2,h=25,center=true);
					}
				}
			}
		}
		rotate([00,40,-50]) {
			cylinder(r=2,h=30,center=true);
		}
		translate([0,0,-10]){
			rotate([00,40,-50])   {
				cylinder(r=1.4,h=30,center=true);
			}
		}
	}
}