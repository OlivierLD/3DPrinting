/*
 * Double pulley
 */

use <./pulley.scad>

module doublePulley(ringDiam, torusDiam, axisDiam) {
  union() {
    translate([0, 0, torusDiam / 2]) {
      pulley(ringDiam, torusDiam, axisDiam);
    }
    translate([0, 0, - torusDiam / 2]) {
      pulley(ringDiam, torusDiam, axisDiam);
    }
  }
}

ringDiam = 30;
torusDiam = 10;  // aka line diam
axisDiam = 6;

doublePulley(ringDiam, torusDiam, axisDiam);

