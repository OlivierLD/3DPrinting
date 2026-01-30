//
// Just the wheel
// See dimensions below...
//

// Default values
RING_DIAM = 30;
TORUS_DIAM = 8;
AXIS_DIAM = 6;

module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

module wheel(ringDiam, torusDiam, axisDiam, wheelThickness) {  
  // wheelThickness = 25; // 1.375 * torusDiam; // for torus=8 => thickness=12
  difference() {
    cylinder(h=wheelThickness, r=(ringDiam / 2), center=true, $fn=100); // The wheel of the Pulley
    cylinder(h=(wheelThickness * 1.2), r=(axisDiam / 2), center=true, $fn=100);  // Axis
    torus(ringDiam, torusDiam);                 // The groove
  }
}

// Go !
/*
ringDiam =  RING_DIAM;  // 30;
torusDiam = TORUS_DIAM; //  8;  // aka line diam
axisDiam =  AXIS_DIAM;  //  6;
wheelThickness = 1.375 * torusDiam; // for torus=8 => thickness=12
*/
WHEEL_TICKNESS = 25; // Used to override

ringDiam =  75;   // RING_DIAM;  // 30;
torusDiam = 18;   // TORUS_DIAM; //  8;  // aka line diam
axisDiam =  12.5; // AXIS_DIAM;  //  6;
wheelThickness = WHEEL_TICKNESS;

// For tests
union() {
    wheel(ringDiam, torusDiam, axisDiam, wheelThickness);
}

