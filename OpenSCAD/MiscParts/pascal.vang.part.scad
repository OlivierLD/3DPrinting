/*
 * Piece hale-bas
 * Vang junction part
 */
 
// ringDiam: diam at max thickness (middle).
module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

module tube(extDiam, intDiam, height, offsetYInt=0.0) {
  difference() {
    cylinder(h=height, r=(extDiam / 2), center=true, $fn=100);
    translate([0, offsetYInt, 0]) {
      cylinder(h=height, r=(intDiam / 2), center=true, $fn=100);    
    }
  }
}

/*
 * Main dimensions
 * ==============
 * Diam ext: 52.5 mm
 * Diam int: 45.75 mm
 * Epaisseur cylindre 3.375 mm
 * Depassement tore: 2.5 mm
 * Hauteur (sans le tore) : 19 mm
 * Tore demi-diam : 6 mm
 */

tubeExtDiam = 52.25;
tubeIntDiam = 46.0; // 45.75;
tubeHeight = 19.0;
torusSemiDiam = 6.0;
offsetInteriorY = 0.0; // 1.25;

difference() {
  union() {
    tube(tubeExtDiam, tubeIntDiam, tubeHeight, offsetInteriorY);
    translate([0, 0, (tubeHeight / 2)]) {
      torus(tubeIntDiam /* - torusSemiDiam */, torusSemiDiam * 2);
    }
  }
  // Exterior, for the bottom of the torus
  translate([0, 0, (tubeHeight / 2) - torusSemiDiam - 3]) {  // -3 ?
    tube(tubeExtDiam + (torusSemiDiam * 2), tubeExtDiam, tubeHeight);
  }
  // Interior, final cleanup
  translate([0, offsetInteriorY, 0]) {
    cylinder(h=tubeHeight * 2, r=(tubeIntDiam / 2), center=true, $fn=100);
  }
}
  
