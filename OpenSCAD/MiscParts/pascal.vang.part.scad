/*
 * Piece hale-bas
 */
 
 // ringDiam: diam at max thickness (middle).
 module torus(ringDiam, torusDiam) { 
	rotate_extrude(convexity = ringDiam, $fn = 100) {
		translate([ringDiam / 2, 0, 0]) {
			circle(r = torusDiam / 2, $fn = 100);
		}
	}
} 

module tube(extDiam, intDiam, height) {
  difference() {
    cylinder(h=height, r=(extDiam / 2), center=true, $fn=100);
    cylinder(h=height, r=(intDiam / 2), center=true, $fn=100);    
  }
}

/*
 * Diam ext: 52.5 mm
 * Diam int: 45.75 mm
 * Epaisseur cylindre 3.375 mm
 * Depassement tore: 2.5 mm
 * Hauteur (sans le tore) : 19 mm
 * Tore demi-diam : 6 mm
 */

tubeExtDiam = 52.5;
tubeIntDiam = 45.75;
tubeHeight = 19;
torusSemiDiam = 6.0;

difference() {
  union() {
    tube(tubeExtDiam, tubeIntDiam, tubeHeight);
    translate([0, 0, (tubeHeight / 2)]) {
      torus(tubeIntDiam /* - torusSemiDiam */, torusSemiDiam * 2);
    }
  }
  // Exterior, for the bottom of the torus
  translate([0, 0, (tubeHeight / 2) - torusSemiDiam - 3]) {  // -3 ?
    tube(tubeExtDiam + (torusSemiDiam * 2), tubeExtDiam, tubeHeight);
  }
  // Interior, final cleanup
  cylinder(h=tubeHeight * 2, r=(tubeIntDiam / 2), center=true, $fn=100);
}
  
