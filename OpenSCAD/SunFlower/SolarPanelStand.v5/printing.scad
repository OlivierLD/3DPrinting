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

//	designOption = V5_BASE_BASE_ONLY;
//	designOption = V5_BASE_TOP_ONLY;
	designOption = V5_BASE_ALL_ELEMENTS;
	
	withGear = true; // Set to false for printing
	
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
     	          betweenVertAxis=betweenVertAxis);
} else {
	echo(str("Nothing to do yet..."));
}
