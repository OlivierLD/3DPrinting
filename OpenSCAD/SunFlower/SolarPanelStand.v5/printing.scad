/**
 * @author OlivierLD
 * Started 2020-Jun-21
 *
 * V5. No Worm gear.
 * 2 Flat spur gears (16 and 76 teeth)
 *
 * Printing with a set of parameters, 
 * included below.
 */
use <../../mechanical.parts.scad> 
use <../all.parts.scad>
use <../parts.printer.scad>

include <../printing.options.scad>
// Options, dimensions, parameters
include <./param.set.01.scad>

// Execution

echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design below.");
echo(">>> Set the 'option' variable value.");
echo(">>> ------------------------------------------------------");

NONE = -1;

CUSTOM_PRINT = 0;
BASE_V5_PRINT = 1;

option = BASE_V5_PRINT; 

if (option == CUSTOM_PRINT) {
	customPrint();
} else if (option == BASE_V5_PRINT) {
	
  V5_BASE_BASE_ONLY = 1;
  V5_BASE_TOP_ONLY = 2;
  V5_BASE_ALL_ELEMENTS = 3;
  V5_BASE_UPPER_TOP_ONLY = 4;  
  V5_BRACKET_BASE_ONLY = 5;  

//  designOption = V5_BASE_BASE_ONLY;
//	designOption = V5_BASE_TOP_ONLY;
//  designOption = V5_BASE_UPPER_TOP_ONLY;
    designOption = V5_BASE_ALL_ELEMENTS;
//  designOption = V5_BRACKET_BASE_ONLY;
//  designOption = 0;
	
	withGear = false; // Set to false for printing
	
  echo(str("Between Axis (motor):", betweenVertAxis));
  
  difference() {
    union() {
      if (designOption != V5_BRACKET_BASE_ONLY) {
        printBase1_v5(bottomCylinderHeight,
                      bottomPlateLength,
                      bottomPlateWidth,
                      bottomPlateThickness,
                      extDiam, 
                      torusDiam, 
                      intDiam, 
                      ballsDiam,
                      option = designOption,
                      withGear = withGear,
                      betweenVertAxis = betweenVertAxis);
      }
      if (designOption == V5_BRACKET_BASE_ONLY || designOption == V5_BASE_ALL_ELEMENTS) {
        rotate([0, 0, 45]) {               
          translate([0, 0, 51]) {  // z=51: stuck
            printMainStand(standWidth, 
                           standLength, 
                           standHeight, 
                           0, // standTopWidth, 
                           wallThickness, 
                           verticalAxisDiam,
                           0, // horizontalAxisDiam, 
                           flapScrewDiam,
                           extDiam, 
                           fixingFootSize, 
                           fixingFootScrewDiam, 
                           // minFootWallThickness,
                           // topFeetInside=topBaseFeetInside,
                           // wheelStandThickness=bigWheelStandThickness,
                           // wheelStandDrillingPattern=actoBotics615238DrillingPattern,
                           fixingFeetOnBase=true,
                           gearBaseScrewCircleRadius=-1,
                           printOption=BASE_ONLY);
          }
        }
      }
    }
    // TODO drill screws ...
    for (angle = [0, 90, 180, 270]){
      rotate([0, 0, angle + 45]) {
        translate([30, 0, 0]) {
          cylinder(d=4, h=100, $fn=50);
        }
      }
    }
  }                      
} else {
	echo(str("Nothing to do yet..."));
}
