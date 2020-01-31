/**
 * @author OlivierLD
 * 2020-Jan-28
 *
 * Printing with a set of parameters, 
 * included below.
 */
use <./mechanical.parts.scad> 
use <./all.parts.scad>
use <./parts.printer.scad>

// Options, dimensions, parameters
include <./param.set.04.scad>

// Execution

echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design below.");
echo(">>> ------------------------------------------------------");

PRINT_BRACKET = 1;
PRINT_BASE_1 = 2;
PRINT_BASE_2 = 3;
PRINT_MAIN_STAND = 4;
PRINT_COUNTERWEIGHT_CYLINDER = 5;
PRINT_BIG_WHEEL_STAND = 6;
PRINT_BALL_BEARING_STAND = 7;

// Choose your own here
option = PRINT_BALL_BEARING_STAND;

if (option == PRINT_BRACKET) {
	printBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 bracketWidthOutAll,
							 wallThickness,
							 bracketPlateWidth,
							 betweenAxis, // between main axis and motor axis
							 counterweightCylinderDiam,
							 withMotor=false,
							 withCylinder=false);
} else if (option == PRINT_BASE_1) {
	printBase1(bottomCylinderHeight, 
						 extDiam, 
						 torusDiam, 
						 intDiam, 
						 ballsDiam, 
						 fixingFootSize, 
						 fixingFootWidth, 
						 fixingFootScrewDiam, 
						 minFootWallThickness,
						 verticalAxisDiam,
						 wormGearAxisDiam * 2,
						 wormGearAxisRadiusOffset, 
						 wormGearAxisHeight);
} else if (option == PRINT_BASE_2) {
	printBase2(topCylinderHeight, 
						 extDiam, 
						 torusDiam, 
						 intDiam, 
						 ballsDiam, 
						 fixingFootSize, 
						 fixingFootWidth, 
						 fixingFootScrewDiam, 
						 minFootWallThickness,
						 feetInside = topBaseFeetInside);
} else if (option == PRINT_COUNTERWEIGHT_CYLINDER) {
	printCylinder(bracketWidthOutAll, wallThickness, counterweightCylinderDiam);
} else if (option == PRINT_MAIN_STAND) {
	printMainStand(standWidth, 
								 standLength, 
								 standHeight, 
								 standTopWidth, 
								 wallThickness, 
								 verticalAxisDiam,
								 horizontalAxisDiam, 
								 flapScrewDiam,
								 extDiam, 
								 fixingFootSize, 
								 fixingFootScrewDiam, 
								 minFootWallThickness,
								 topFeetInside=topBaseFeetInside,
								 wheelStandThickness=bigWheelStandThickness,
								 wheelStandDrillingPattern=actoBotics615238DrillingPattern);
} else if (option == PRINT_BALL_BEARING_STAND) {
	printBallBearingStand(wormGearAxisDiam,
												wormGearAxisHeight,
												fixingFootSize, 
												fixingFootWidth, 
												fixingFootScrewDiam, 
												minFootWallThickness);
} else if (option == PRINT_BIG_WHEEL_STAND) {
	printBigWheelStand(bigWheelStandDiam, 
										 horizontalAxisDiam, 
										 bigWheelStandThickness, 
										 actoBotics615238DrillingPattern);
}
// customPrint();
