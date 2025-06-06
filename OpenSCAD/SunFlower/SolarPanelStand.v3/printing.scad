/**
 * @author OlivierLD
 * Started 2020-Jan-28
 *
 * Printing with a set of parameters, 
 * included below.
 */
use <../../mechanical.parts.scad> 
use <../all.parts.scad>
use <../parts.printer.scad>

include <../printing.options.scad>
// Options, dimensions, parameters
include <./param.set.04.scad>

// Execution

echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design below.");
echo(">>> Set the 'option' variable value.");
echo(">>> ------------------------------------------------------");

NONE = -1;

CUSTOM_PRINT = 0;

PRINT_BRACKET = 1;             // Full bracket, in one piece (holding the solar panel)
PRINT_BASE_1 = 2;              // Bottom base
PRINT_BASE_2 = 3;              // Top base
PRINT_MAIN_STAND = 4;          // Full main stand, in one piece, the one holding the bracket
PRINT_COUNTERWEIGHT_CYLINDER = 5;
PRINT_BIG_WHEEL_STAND = 6;

PRINT_PANEL_PLATE = 8;         // On top of the bracket

PRINT_MAIN_STAND_BASE = 9;     // Base only
PRINT_MAIN_STAND_LEFT = 10;    // Left side only
PRINT_MAIN_STAND_RIGHT = 11;   // Right side only

PRINT_BRACKET_WITH_FEET = 12;  // Full bracket, with feet under the top
PRINT_BRACKET_TOP_ONLY = 13;   // Bracket top, with feet
PRINT_BRACKET_LEFT_ONLY = 14;  // Bracket left side
PRINT_BRACKET_RIGHT_ONLY = 15; // Bracket right side

MOTOR_BOX = 16;

BEVEL_GEAR_AND_BASE = 17;
BEVEL_GEAR_PINION = 18;

BASE1_AND_ALL_GEARS = 19; // for dev or visualization

FULL_STAND = 20;

// Choose your own here
// --------------------
// option = PRINT_BRACKET_WITH_FEET;
// option = PRINT_MAIN_STAND_BASE;
// option = PRINT_MAIN_STAND_LEFT;
// option = PRINT_MAIN_STAND_RIGHT;
// option = BASE1_AND_ALL_GEARS; 
option = FULL_STAND;

if (option == FULL_STAND) {

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
  
} else if (option == PRINT_BRACKET) {
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
} else if (option == BASE1_AND_ALL_GEARS) {
	printBase1(bottomCylinderHeight, 
						 extDiam, 
						 torusDiam, 
						 intDiam, 
						 ballsDiam, 
						 fixingFootSize, 
						 fixingFootWidth, 
						 fixingFootScrewDiam, 
						 minFootWallThickness,
						 verticalAxisDiam,,
						 withCylinder = true,
						 withMotor = true,
						 withBevelGear = true,
						 builtTogether = true,
						 withGear = true,
						 withPinion = true,
						 bevelGearScrewCircleRadius = bevelGearBaseScrewCircleRadius,
						 bevelGearScrewDiam = 4,
						 topCylHeight = topCylinderHeight);
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
						 verticalAxisDiam,,
						 withCylinder = true,
						 withMotor = false,
						 withBevelGear = false,
						 builtTogether = false,
						 withGear = false,
						 withPinion = true,
						 bevelGearScrewCircleRadius = bevelGearBaseScrewCircleRadius,
						 bevelGearScrewDiam = 4,
						 topCylHeight = topCylinderHeight);
} else if (option == BEVEL_GEAR_AND_BASE) {
	printBase1(bottomCylinderHeight, 
						 extDiam, 
						 torusDiam, 
						 intDiam, 
						 ballsDiam, 
						 fixingFootSize, 
						 fixingFootWidth, 
						 fixingFootScrewDiam, 
						 minFootWallThickness,
						 verticalAxisDiam,,
						 withCylinder = false,
						 withMotor = false,
						 withBevelGear = true,
						 builtTogether = false,
						 withGear = true,
						 withPinion = false,
						 bevelGearScrewCircleRadius = bevelGearBaseScrewCircleRadius,
						 bevelGearScrewDiam = 4,
						 topCylHeight = topCylinderHeight);
} else if (option == BEVEL_GEAR_PINION) {
	printBase1(bottomCylinderHeight, 
						 extDiam, 
						 torusDiam, 
						 intDiam, 
						 ballsDiam, 
						 fixingFootSize, 
						 fixingFootWidth, 
						 fixingFootScrewDiam, 
						 minFootWallThickness,
						 verticalAxisDiam,,
						 withCylinder = false,
						 withMotor = false,
						 withBevelGear = true,
						 builtTogether = false,
						 withGear = false,
						 withPinion = true,
						 bevelGearScrewCircleRadius = bevelGearBaseScrewCircleRadius,
						 bevelGearScrewDiam = 4,
						 topCylHeight = topCylinderHeight);
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
						 feetInside = topBaseFeetInside,
						 bevelGrearScrewCircleRadius = bevelGearBaseScrewCircleRadius);
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
} else if (option == PRINT_BIG_WHEEL_STAND) {
	printBigWheelStand(bigWheelStandDiam, 
										 horizontalAxisDiam, 
										 bigWheelStandThickness, 
										 actoBotics615238DrillingPattern);
} else if (option == PRINT_PANEL_PLATE) {
	panelStandPlate(wallThickness, bracketPlateWidth, bracketWidthOutAll);
} else if (option == MOTOR_BOX) {
	motorSocket(socketDepth = 25,
							wallThickness = 2);
} else if (option == CUSTOM_PRINT) {
	customPrint();
}
