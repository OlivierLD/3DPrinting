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

cylHeight = 46;
cylHeight2 = 24;
// Warning: intDiam < torusDiam < extDiam
extDiam = 86;
torusDiam = 76;
intDiam = 66;
ballsDiam = 5;
verticalAxisDiam = 6;

fixingFootSize = 20;
fixingFootWidth = 20;
fixingFootScrewDiam = 4;
// screwLen = 30;
minFootWallThickness = 4;

topBaseFeetInside = true; // For the top base only

wormGearAxisDiam = 10; // Tube diam, not axis.
wormGearAxisRadiusOffset = 25.5;
wormGearAxisHeight = 30;

standWidth = 130;
standLength = 100; 
standHeight = 130;
standTopWidth = 35;
wallThickness = 10;
cylinderThickness = 1;
horizontalAxisDiam = 6;
motorSide = 42.3;
motorDepth = 39;
betweenMotorScrews = 31;
motorAxisDiam = 5;
motorAxisLength = 24;
motorfixingFootScrewDiam = 3;
flapScrewDiam = 3;

sizeAboveAxis = 80; // Tossion! Needs to be bigger than standLength / 2
sizeBelowAxis = 120; // Tossion!
bracketWidthOutAll = 90;
bracketPlateWidth = 60;
betweenAxis = 60;
bottomCylinderDiam = 35;

// Execution

echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design at the bottom of the script.");
echo(">>> ------------------------------------------------------");

// Choose your own below, uncomment the desired one.
//----------------
/*
printBracket(horizontalAxisDiam,
						 sizeAboveAxis,
						 sizeBelowAxis,
						 bracketWidthOutAll,
						 wallThickness,
						 bracketPlateWidth,
						 betweenAxis, // between main axis and motor axis
						 bottomCylinderDiam,
						 withMotor=false,
						 withCylinder=false);
*/

printBase1(cylHeight, 
					 extDiam, 
					 torusDiam, 
					 intDiam, 
					 ballsDiam, 
					 fixingFootSize, 
					 fixingFootWidth, 
					 fixingFootScrewDiam, 
					 minFootWallThickness,
					 verticalAxisDiam,
					 wormGearAxisDiam,
					 wormGearAxisRadiusOffset, 
					 wormGearAxisHeight);

/*
printBase2(cylHeight2, 
					 extDiam, 
					 torusDiam, 
					 intDiam, 
					 ballsDiam, 
					 fixingFootSize, 
					 fixingFootWidth, 
					 fixingFootScrewDiam, 
					 minFootWallThickness,
					 feetInside = topBaseFeetInside);
*/
/*
printCylinder(bracketWidthOutAll, wallThickness, bottomCylinderDiam);
*/
/*
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
							 topFeetInside=topBaseFeetInside);
*/
/*
printBallBearingStand(5,
										  20,
										  fixingFootSize, 
										  fixingFootWidth, 
										  screwDiam, 
										  minFootWallThickness);
*/
// customPrint();
