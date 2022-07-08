//
// A test
// A Pulley
//

module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

ringDiam = 30;
torusDiam = 10;
  
difference() {
  
  cylinder(h=torusDiam, r=(ringDiam / 2), center=true, $fn=100); // Pulley
  cylinder(h=12, r=2, center=true, $fn=100);  // Axis
  torus(ringDiam, torusDiam);                 // The groove
  
}

