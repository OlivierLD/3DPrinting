/**
 * @author OlivierLD
 *
 * Printing with a set of parameters, 
 * included here.
 */
use <./mechanical.parts.scad> 
use <./all.parts.scad>
use <./parts.printer.scad>

// Options, dimensions, parameters

cylHeight = 50;
cylHeight2 = 20;
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;
verticalAxisDiam = 5;

fixingFootSize = 20;
fixingFootWidth = 20;
screwDiam = 4;
screwLen = 30;
minWallThickness = 5;

topBaseFeetInside = true; // For the top base only

wormGearAxisDiam = 10; // Tube diam.

_totalStandWidth = 130;
_length = 130; 
_height = 130;
_topWidth = 35;
_thickness = 10;
_horizontalAxisDiam = 6;
_motorSide = 42.3;
_motorDepth = 39;
_betweenScrews = 31;
_motorAxisDiam = 5;
_motorAxisLength = 24;
_mainAxisDiam = 5; // vertical one
_screwDiam = 3;
_flapScrewDiam = 3;

_sizeAboveAxis = 80; // Tossion! Needs to be bigger than _length / 2
_sizeBelowAxis = 120; // Tossion!
_widthOutAll = 90;
_plateWidth = 60;
_betweenAxis = 60;
_bottomCylinderDiam = 35;

// Execution

echo(">>> ------------------------------------------------------");
echo(">>> After adjusting the values,");
echo(">>> Choose the part to design at the bottom of the script.");
echo(">>> ------------------------------------------------------");
// Choose your own below, uncomment the desired one.
//----------------

printBracket(_horizontalAxisDiam,
						 _sizeAboveAxis,
						 _sizeBelowAxis,
						 _widthOutAll,
						 _thickness,
						 _plateWidth,
						 _betweenAxis, // between main axis and motor axis
						 _bottomCylinderDiam,
						 withMotor=false,
						 withCylinder=false);

/*
printBase1(cylHeight, 
					 extDiam, 
					 torusDiam, 
					 intDiam, 
					 ballsDiam, 
					 fixingFootSize, 
					 fixingFootWidth, 
					 screwDiam, 
					 minWallThickness,
					 verticalAxisDiam,
					 wormGearAxisDiam,
					 extDiam / 3, 
					 cylHeight / 2);
*/					 
/*
printBase2(cylHeight2, 
					 extDiam, 
					 torusDiam, 
					 intDiam, 
					 ballsDiam, 
					 fixingFootSize, 
					 fixingFootWidth, 
					 screwDiam, 
					 minWallThickness,
					 feetInside = topBaseFeetInside);
*/
/*
printCylinder(_widthOutAll, _thickness, _bottomCylinderDiam);
*/
/*
printMainStand(_totalStandWidth, 
							 _length, 
							 _height, 
							 _topWidth, 
							 _thickness, 
							 _horizontalAxisDiam, 
							 _flapScrewDiam,
							 extDiam, 
							 fixingFootSize, 
							 screwDiam, 
							 minWallThickness,
							 topFeetInside=topBaseFeetInside);
*/
/*
printBallBearingStand(5,
										  20,
										  fixingFootSize, 
										  fixingFootWidth, 
										  screwDiam, 
										  minWallThickness);
*/
// customPrint();
