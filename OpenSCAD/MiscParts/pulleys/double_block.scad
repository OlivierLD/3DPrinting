//
// A Block with its wheel.
// Becket: ringot (fr)
//
// See drawing options at the bottom of the code.
//

use <./wheels.scad>
use <./blocks.scad>

// Go !
ringDiam = 30;
torusDiam = 8;  // aka line diam
axisDiam = 6;
cheekThickness = 3;
cheekWidth = 20;

OPTION_FULL = 0;
OPTION_WHEEL_ONLY = 1;
OPTION_BLOCK_ONLY = 2;

option = OPTION_FULL;

union() {
  if (option != OPTION_BLOCK_ONLY) {
    translate([0, 0, ((torusDiam * 0.9375))]) {
      wheel(ringDiam, torusDiam, axisDiam);
    }
    translate([0, 0, -(torusDiam * 0.9375)]) {
      wheel(ringDiam, torusDiam, axisDiam);
    }
  }
  if (option != OPTION_WHEEL_ONLY) {
    doubleBlock(cheekThickness, cheekWidth, torusDiam * 1.5, (ringDiam / 2) + (torusDiam / 2), 6);
  }
}

