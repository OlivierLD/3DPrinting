/**
 * @author OlivierLD
 * Started 2020-Jan-28
 *
 * Printing with a set of parameters, 
 * included below.
 */
use <./mechanical.parts.scad> 
use <./all.parts.scad>
use <./parts.printer.scad>

include <./printing.options.scad>
// Options, dimensions, parameters
include <./param.set.04.scad>

// Execution

echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design below.");
echo(">>> ------------------------------------------------------");

PRINT_BRACKET = 1;             // Full bracket, in one piece
PRINT_BASE_1 = 2;
PRINT_BASE_2 = 3;
PRINT_MAIN_STAND = 4;          // Full main stand, in one piece
PRINT_COUNTERWEIGHT_CYLINDER = 5;
PRINT_BIG_WHEEL_STAND = 6;
PRINT_BALL_BEARING_STAND = 7;
PRINT_PANEL_PLATE = 8;         // On top of the bracket

PRINT_MAIN_STAND_BASE = 9;     // Base only
PRINT_MAIN_STAND_LEFT = 10;    // Left side only
PRINT_MAIN_STAND_RIGHT = 11;   // Right side only

PRINT_BRACKET_WITH_FEET = 12;  // Full bracket, with feet under the top
PRINT_BRACKET_TOP_ONLY = 13;   // Bracket top, with feet
PRINT_BRACKET_LEFT_ONLY = 14;  // Bracket left side
PRINT_BRACKET_RIGHT_ONLY = 15; // Bracket right side

// Choose your own here
option = PRINT_BRACKET_WITH_FEET; 

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
} else if (option == PRINT_BRACKET_WITH_FEET) {	
	printBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 bracketWidthOutAll,
							 wallThickness,
							 bracketPlateWidth,
							 betweenAxis,
							 counterweightCylinderDiam,
							 withMotor=false,
							 withCylinder=false,
							 withFixingFeet=true);
} else if (option == PRINT_BRACKET_TOP_ONLY) {	
	printBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 bracketWidthOutAll,
							 wallThickness,
							 bracketPlateWidth,
							 betweenAxis,
							 counterweightCylinderDiam,
							 withMotor=false,
							 withCylinder=false,
							 withFixingFeet=true,
							 printOption=TOP_BRACKET_ONLY);
} else if (option == PRINT_BRACKET_LEFT_ONLY) {	
	printBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 bracketWidthOutAll,
							 wallThickness,
							 bracketPlateWidth,
							 betweenAxis,
							 counterweightCylinderDiam,
							 withMotor=false,
							 withCylinder=false,
							 withFixingFeet=true,
							 printOption=LEFT_BRACKET_ONLY);
} else if (option == PRINT_BRACKET_RIGHT_ONLY) {	
	printBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 bracketWidthOutAll,
							 wallThickness,
							 bracketPlateWidth,
							 betweenAxis,
							 counterweightCylinderDiam,
							 withMotor=false,
							 withCylinder=false,
							 withFixingFeet=true,
							 printOption=RIGHT_BRACKET_ONLY);
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
								 wheelStandDrillingPattern=actoBotics615238DrillingPattern,
								 fixingFeetOnBase=false);
} else if (option == PRINT_MAIN_STAND_BASE) {
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
								 wheelStandDrillingPattern=actoBotics615238DrillingPattern,
								 fixingFeetOnBase=true,
	               printOption=BASE_ONLY);
} else if (option == PRINT_MAIN_STAND_LEFT) {
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
								 wheelStandDrillingPattern=actoBotics615238DrillingPattern,
								 fixingFeetOnBase=true,
	               printOption=LEFT_ONLY);
} else if (option == PRINT_MAIN_STAND_RIGHT) {
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
								 wheelStandDrillingPattern=actoBotics615238DrillingPattern,
								 fixingFeetOnBase=true,
	               printOption=RIGHT_ONLY);
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
} else if (option == PRINT_PANEL_PLATE) {
	panelStandPlate(wallThickness, bracketPlateWidth, bracketWidthOutAll);
}
// customPrint();
