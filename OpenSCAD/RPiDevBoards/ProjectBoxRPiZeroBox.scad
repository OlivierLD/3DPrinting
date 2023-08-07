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
  RPiZeroSmallPlate(withPlate=true, withRpi=withRPi, withSide=true);
}
