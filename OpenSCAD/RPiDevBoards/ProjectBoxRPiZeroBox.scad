/*
 * Include a Raspberry plate into a project box.
 * This part is the plate that goes into the project box.
 *
 * Look for RPiZeroSmallPlate in the code below
 *
 * See in the script the parameters
 * - withRPi
 */
include <./raspberry.pi.zero.plate.only.scad>

withRPi = true;
withBox = true;
withTop = true;

height = 30;

union() { 
  // Box 
  if (withBox) {
    difference() {
      RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=withRPi, withSide=true, withTop=false, boxHeight=height);
      // Optional: opening for the wiring
      holeDiam = 8; // mm
      translate([20, 0, 22.5]) {
        rotate([0, 90, 0]) {
          cylinder(h=30, d=holeDiam, center=true, $fn=100);
        }
      }
    }
  }
  // Top 
  if (withTop) {
    RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
  }
}
