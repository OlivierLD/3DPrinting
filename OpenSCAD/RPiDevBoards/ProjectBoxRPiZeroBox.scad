/*
 * Include a Raspberry plate into a project box.
 * This part is the plate that goes into the project box.
 *
 * Look for RPiZeroSmallPlate in the code below
 *
 * LEGO part relies on https://github.com/OlivierLD/LEGO.scad/tree/oliv.playgbround
 *
 * See in the script the parameters
 * - withRPi
 * - withBox
 * - withTop
 * - highBox
 * - withLegoBrick
 * - withLegoBasePlate
 *
 * To have an overview, use: 
 *  withRPi = true
 *  withBox = true
 *  withTop = true
 *  highBox = true or false
 *  withLegoBrick = true or false
 *  withLegoBasePlate = false
 * 
 * To print the box
 *  withRPi = false
 *  withBox = true
 *  withTop = false
 *  highBox = true or false
 *  withLegoBrick = true or false
 *  withLegoBasePlate = false
 *
 * To print the top
 *  withRPi = false
 *  withBox = false
 *  withTop = true
 *  highBox = false
 *  withLegoBrick = false
 *  withLegoBasePlate = false
 *
 * To print Lego base plate
 *  withRPi = false
 *  withBox = false
 *  withTop = false
 *  highBox = false
 *  withLegoBrick = false
 *  withLegoBasePlate = true
 *
 */
include <./raspberry.pi.zero.plate.only.scad>
// Warning!! Location depends on your machine!! 
use <../../../LEGO.oliv/LEGO.scad> 


withRPi = true;
withBox = true;
withTop = true;
highBox = true;
withLegoBrick = true;
withLegoBasePlate = false; // Exclusive, reset all the above.

// for the Lego brick
thickness = 3;
rpiPlateLenght = 68;
rpiPlateWidth = 35;


height = highBox ? 30 : 16; // 30;

union() { 
  if (!withLegoBasePlate) {
    // Box 
    if (withBox) {
      union() {
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
        // Lego brick under the plate
        if (withLegoBrick) {
          // color("red") {
            translate([0, 0, 0]) {
              union() {
                cube(size=[ rpiPlateWidth,
                            rpiPlateLenght,
                            thickness ], 
                     center=true);
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
    if (withTop) {
      RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
    }
  } else { // if (withLegoBasePlate) 
      TILE_TYPE = "tile"; 
      BLOCK_TYPE = "block"; // or just "block_type"
      BASE_PLATE = "baseplate";

      rotate([0, 0, 180]) {
        union() {
          //place(-4, -12) {
      			//uncenter(22, 6) {
              rotate([0, 0, 90]) {
                block(
                  type=BASE_PLATE,
                  width=22,
                  length=22,
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
