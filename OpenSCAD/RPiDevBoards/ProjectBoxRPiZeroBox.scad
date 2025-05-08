/*
 * Include a Raspberry plate into a project box.
 * This part is the plate that goes into the project box.
 *
 * Look for RPiZeroSmallPlate in the code below
 *
 * LEGO part relies on https://github.com/OlivierLD/LEGO.scad/tree/oliv.playgbround
 *
 * Many oiptions available...
 * See in the script the parameters:
 * - withRPi
 * - withBox
 * - withTop
 * - highBox
 * - withLegoBrick
 * - brickOnly
 * - withLegoBasePlate
 *
 * To have an overview, use: 
 *  withRPi = true
 *  withBox = true
 *  withTop = true
 *  highBox = true or false
 *  withLegoBrick = true or false
 *  brickOnly = false
 *  withLegoBasePlate = false
 *  withBracket = true | false (optional)
 * 
 * To print the box, use:
 *  withRPi = false
 *  withBox = true
 *  withTop = false
 *  highBox = true or false
 *  withLegoBrick = true or false
 *  brickOnly = false
 *  withLegoBasePlate = false
 *  withBracket = false
 *  
 * To separate the lego brick from the box:
 *   Box only:
 *      withLegoBrick = false
 *      brickOnly = false
 *   Brick only:
 *      withLegoBrick = true
 *      brickOnly = true
 *
 * To print the top, use:
 *  withRPi = false
 *  withBox = false
 *  withTop = true
 *  highBox = false
 *  withLegoBrick = false
 *  brickOnly = false
 *  withLegoBasePlate = false
 *  withBracket = false
 *
 * To print Lego base plate, use:
 *  withRPi = false
 *  withBox = false
 *  withTop = false
 *  highBox = false
 *  withLegoBrick = false
 *  brickOnly = false
 *  withLegoBasePlate = true
 *  withBracket = false
 * 
 * To print the - optional - bracket(s), use:
 *  withRPi = false
 *  withBox = false
 *  withTop = false
 *  highBox = false
 *  withLegoBrick = false
 *  brickOnly = false
 *  withLegoBasePlate = false
 *  withBracket = true 
 *
 */
include <./raspberry.pi.zero.plate.only.scad>
// Warning!! Location depends on your machine!! 
use <../../../LEGO.oliv/LEGO.scad> 


withRPi = true;
withBox = true;
withTop = true;
highBox = false;
withLegoBrick = false; // true;
brickOnly = false;
withLegoBasePlate = false; // Was Exclusive, reset all the above.
withBracket = true; // true;

module bracket() {
  difference() {
    // Main
    translate([0, 0, -10]) {
      rotate([0, 0, 0]) {
        cube([50, 10, 35], center=true);
      }
    }
    // The hook
    translate([5, 0, -14]) {
      rotate([0, 0, 0]) {
        cube([50, 12, 20], center=true);
      }
    }
    // The box
    translate([0, 0, 8.5]) {
      rotate([0, 0, 0]) {
        cube([46.0, 12, 20], center=true);
      }
    }
  }
}

module bracket_v2() {
  difference() {
    // Main
    translate([0, 0, -3]) {
      rotate([0, 0, 0]) {
        cube([50, 10, 48], center=true);
      }
    }
    // The hook
    translate([5, 0, -14]) {
      rotate([0, 0, 0]) {
        cube([50, 12, 20], center=true);
      }
    }
    // The box
    translate([0, 0, 8.5]) {
      rotate([0, 0, 0]) {
        cube([46.0, 12, 18], center=true);
      }
    }
    // The top
    translate([0, 0, 20]) {
      rotate([0, 0, 0]) {
        cube([40, 12, 10], center=true);
      }
    }
  }
}

module bracket_v3() {
  difference() {
    // Main
    translate([0, 0, -3]) {
      rotate([0, 0, 0]) {
        cube([50, 10, 48], center=true);
      }
    }
    // The hook
    translate([5, 0, -14]) {
      rotate([0, 0, 0]) {
        cube([50, 12, 20], center=true);
      }
    }
    // The box
    translate([0, 0, 8.5]) {
      rotate([0, 0, 0]) {
        cube([46.0, 12, 18], center=true);
      }
    }
    // The top
    translate([5, 0, 15.5]) {
      rotate([0, 0, 0]) {
        cube([50, 12, 25], center=true);
      }
    }
  }
}

// for the Lego brick
thickness = 3;
rpiPlateLenght = 68;
rpiPlateWidth = 35;

// For the base plate. In studs.
// Raspberry Pi Zero, L = 6, others, L = 10;
nbSpotW = 14; // 22
nbSpotL =  6; //  10; // 22

height = highBox ? 30 : 16; // 30;

union() { 
  if (true || !withLegoBasePlate) {
    // Box 
    if (withBox || brickOnly) {
      union() {
       if (!brickOnly) {
          difference() {
            RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=withRPi, withSide=true, withTop=false, boxHeight=height);
            if (highBox) {
              // Optional: opening for the wiring, on high box
              holeDiam = 8; // mm
              translate([20, 0, 22.5]) {
                rotate([0, 90, 0]) {
                  cylinder(h=30, d=holeDiam, center=true, $fn=100);
                }
              }
            }
          }
        }
        // Lego brick under the plate
        if (withLegoBrick) {
          // color("red") {
            translate([0, 0, 0]) {
              union() {
                difference() {
                  cube(size=[ rpiPlateWidth,
                              rpiPlateLenght,
                              thickness ], 
                       center=true);
                  // Holes for the screws
                  rotate([0, 0, 0]) {
                    translate([(rpiPlateWidth / 2) - 5, -((rpiPlateLenght / 2) - 5), 0]) {
                      cylinder(h= 30, d=2, center=true, $fn=50);
                    }
                  }
                  rotate([0, 0, 0]) {
                    translate([-((rpiPlateWidth / 2) - 5), -((rpiPlateLenght / 2) - 5), 0]) {
                      cylinder(h= 30, d=2, center=true, $fn=50);
                    }
                  }
                  rotate([0, 0, 0]) {
                    translate([-((rpiPlateWidth / 2) - 5), ((rpiPlateLenght / 2) - 5), 0]) {
                      cylinder(h= 30, d=2, center=true, $fn=50);
                    }
                  }
                  rotate([0, 0, 0]) {
                    translate([((rpiPlateWidth / 2) - 5), ((rpiPlateLenght / 2) - 5), 0]) {
                      import("/Users/olivierlediouris/3DPrinting/Sextant - 5350353/files/Sextant.stl");
                      cylinder(h= 30, d=2, center=true, $fn=50);
                    }
                  }
                }
                // cube(size= [12, 94, thickness], center = true);
                // Lego brick
                translate([0, 0, -10]) {
                  rotate([0, 0, 90]) {
                    block(width=2,  // In studs (top studs)
                          length=6, // In studs (top studs)
                          height=1, // In "standard block" height
                          type="brick");
                  }
                }
              }
            }
          // }
        }
      }
    }
    // Top 
    if (withTop && !brickOnly) {
      RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
    }
    if (withBracket) {
      // bracket();
      bracket_v2();
      // bracket_v3();
    }
  } // else { // 
  
  if (withLegoBasePlate) {
      TILE_TYPE = "tile"; 
      BLOCK_TYPE = "block"; // or just "block_type"
      BASE_PLATE = "baseplate";

      translate([0, 0, -20]) {
        rotate([0, 0, 180]) {
          union() {
            //place(-4, -12) {
              //uncenter(22, 6) {
                rotate([0, 0, 90]) {
                  block(
                    type=BASE_PLATE,
                    width=nbSpotW,  // Nb studs
                    length=nbSpotL, // Nb studs
                    roadway_width=0,
                    roadway_length=0,
                    roadway_x=0);
                }
              //}
            //}
          }
        }
      }
   }
}
