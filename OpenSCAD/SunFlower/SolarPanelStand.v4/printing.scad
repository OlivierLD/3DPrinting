/**
 * @author OlivierLD
 * Started 2020-Jun-14
 *
 * V4. The worm gear is all inside the base cylinder.
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

PRINT_BRACKET = 1;             // Full bracket, in one piece (holding the solar panel)
PRINT_BASE_1 = 2;              // Bottom base
PRINT_BASE_2 = 3;              // Top base
PRINT_MAIN_STAND = 4;          // Full main stand, in one piece, holding the bracket
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

SPUR_GEAR_BASE = 17;

BASE1_AND_ALL_GEARS = 18; // for dev or visualization

// Choose your own here
inDev = false; // Set to true to show the worm gear
option = BASE1_AND_ALL_GEARS;  // PRINT_BASE_1; 

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
} else if (option == BASE1_AND_ALL_GEARS) {
	printBase1_v2(bottomCylinderHeight, 
	              topCylinderHeight,
							  extDiam, 
							  torusDiam, 
							  intDiam, 
							  ballsDiam, 
							  fixingFootSize, 
							  fixingFootWidth, 
							  fixingFootScrewDiam, 
							  minFootWallThickness,
								screwDiam = 4,
	              motorSide=motorSide,
							  withGearsAndCoupler=true,
							  forBasePrinting=false,
							  forConePrinting=false); 
} else if (option == PRINT_BASE_1) {
	printBase1_v2(bottomCylinderHeight, 
	              topCylinderHeight,
							  extDiam, 
							  torusDiam, 
							  intDiam, 
							  ballsDiam, 
							  fixingFootSize, 
							  fixingFootWidth, 
							  fixingFootScrewDiam, 
							  minFootWallThickness,
								screwDiam = 4,
	              motorSide=motorSide,
							  withGearsAndCoupler=inDev, // Set to true to visualize the worm gear
							  forBasePrinting=true,
							  forConePrinting=false); 
} else if (option == SPUR_GEAR_BASE) {
	printBase1_v2(bottomCylinderHeight, 
	              topCylinderHeight,
							  extDiam, 
							  torusDiam, 
							  intDiam, 
							  ballsDiam, 
							  fixingFootSize, 
							  fixingFootWidth, 
							  fixingFootScrewDiam, 
							  minFootWallThickness,
								screwDiam = 4,
	              motorSide=motorSide,
							  withGearsAndCoupler=false,
							  forBasePrinting=false,
							  forConePrinting=true); 
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
