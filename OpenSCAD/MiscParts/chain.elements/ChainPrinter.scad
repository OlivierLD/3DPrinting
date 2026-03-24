// To print elements coded in ChainPlug.scad
// Variables LINK_WIDTH, LINK_HEIGHT, LINK_DIAM are defined in the included file.
//

include <./ChainPlug.scad>

LEFT_SIDE  = 0;
RIGHT_SIDE = 1;

/*******************************************
 * Main starts here                        *
 * Just set FOR_PRINT, and SIDE_TO_PRINT   *
 * Bonus: See the FOR_DEMO as well         *
 *******************************************/

FOR_PRINT = true; // Set to false to see the full part
SIDE_TO_PRINT = LEFT_SIDE; // RIGHT_SIDE; // Ignored if FOR_PRINT is false.

// Aha ! Now we're talking !
difference() {
  plug();

  if (FOR_PRINT) {
    // Cut half the plug
    translate([0, SIDE_TO_PRINT == LEFT_SIDE ? 25 : -25, 0]) {
      rotate([0, 0, 0]) {
        cube(size=[200, 50, 50], center=true);
      }
    }
  }
  // Empty/clear the chain path
  translate([0, 0, -5]) {
    rotate([0, 90, 0]) {
      // hull() {
        three_link_chain(LINK_WIDTH, LINK_HEIGHT, LINK_DIAM, true);
      //}
    }
  }
}

FOR_DEMO = true;
// The code below will display the other part, for demo.
// To be skipped when printing. Set FOR_DEMO to false.
if (FOR_DEMO && FOR_PRINT) { // Print both parts
  translate([0, 1, 0]) {
    SIDE_TO_PRINT = RIGHT_SIDE;

    difference() {
      plug();

      if (FOR_PRINT) {
        // Cut half the plug
        translate([0, SIDE_TO_PRINT == LEFT_SIDE ? 25 : -25, 0]) {
          rotate([0, 0, 0]) {
            cube(size=[200, 50, 50], center=true);
          }
        }
      }
      // Empty/clear the chain path
      translate([0, 0, -5]) {
        rotate([0, 90, 0]) {
          // hull() {
            %three_link_chain(LINK_WIDTH, LINK_HEIGHT, LINK_DIAM, true);
          //}
        }
      }
    }
    // bonus
    if (true) {
      translate([0, 0, -5]) {
        rotate([0, 90, 0]) {
          color("gray") {
          // hull() {
            three_link_chain(LINK_WIDTH, LINK_HEIGHT, LINK_DIAM, false);
          //}
          }
        }
      }
    }
  }
}