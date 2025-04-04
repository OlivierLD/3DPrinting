/*
 * Double pulley
 */

use <./wheels.scad>

module doubleWheel(ringDiam, torusDiam, axisDiam) {
  union() {
    translate([0, 0, torusDiam / 2]) {
      wheel(ringDiam, torusDiam, axisDiam);
    }
    translate([0, 0, - torusDiam / 2]) {
      wheel(ringDiam, torusDiam, axisDiam);
    }
  }
}

ringDiam = 30;
torusDiam = 8;  // aka line diam
axisDiam = 6;

doubleWheel(ringDiam, torusDiam, axisDiam);

