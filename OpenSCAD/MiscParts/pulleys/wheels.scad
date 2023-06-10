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
  wheelThickness = 1.375 * torusDiam; // for torus=8, thickness=12
  difference() {
    cylinder(h=wheelThickness, r=(ringDiam / 2), center=true, $fn=100); // Thw wheel of the Pulley
    cylinder(h=(wheelThickness * 1.2), r=(axisDiam / 2), center=true, $fn=100);  // Axis
    torus(ringDiam, torusDiam);                 // The groove
  }
}

// Go !
ringDiam = 30;
torusDiam = 8;  // aka line diam
axisDiam = 6;

// For tests

union() {
    wheel(ringDiam, torusDiam, axisDiam);
}

