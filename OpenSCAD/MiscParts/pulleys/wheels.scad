//
// Just the wheel
//


module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

module wheel(ringDiam, torusDiam, axisDiam) {  
  difference() {
    cylinder(h=1.1 * torusDiam, r=(ringDiam / 2), center=true, $fn=100); // Thw wheel of the Pulley
    cylinder(h=12, r=(axisDiam / 2), center=true, $fn=100);  // Axis
    torus(ringDiam, torusDiam);                 // The groove
  }
}

// Go !
ringDiam = 30;
torusDiam = 10;  // aka line diam
axisDiam = 6;

// For tests

union() {
    wheel(ringDiam, torusDiam, axisDiam);
}

