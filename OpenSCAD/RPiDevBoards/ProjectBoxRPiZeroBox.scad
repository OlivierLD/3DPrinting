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

union() { 
  // Box 
  if (withBox) {
    RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=withRPi, withSide=true, withTop=false);
  }
  // Top 
  if (withTop) {
    RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
  }
}
