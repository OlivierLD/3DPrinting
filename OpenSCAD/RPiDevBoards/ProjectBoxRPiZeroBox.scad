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

difference() { 
  // Box only
  RPiZeroSmallPlate(withPlate=true, withPegs=true, withRpi=withRPi, withSide=true, withTop=false);
  // Top only
  // RPiZeroSmallPlate(withPlate=false, withPegs=false, withRpi=false, withSide=false, withTop=true);
}
