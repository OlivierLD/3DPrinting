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
						 counterweightCylinderDiam,
						 withMotor=false,
						 withCylinder=false);
*/

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

/*
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
*/
/*
printCylinder(bracketWidthOutAll, wallThickness, counterweightCylinderDiam);
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
printBallBearingStand(wormGearAxisDiam,
										  wormGearAxisHeight,
										  fixingFootSize, 
										  fixingFootWidth, 
										  fixingFootScrewDiam, 
										  minFootWallThickness);
*/
// customPrint();
