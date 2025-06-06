/**
 * Parameters used for 
 * - printing.scad
 * - the.full.stand.scad
 */
bottomCylinderHeight = 46;
topCylinderHeight = 24;
// Warning: intDiam < torusDiam < extDiam
extDiam = 86;
torusDiam = 76;
intDiam = 66;
ballsDiam = 6;
verticalAxisDiam = 5;

fixingFootSize = 20;
fixingFootWidth = 20;
fixingFootScrewDiam = 4;
// screwLen = 30;
minFootWallThickness = 4;

topBaseFeetInside = true; // For the top base only

wormGearAxisDiam = 5; // Tube  will be twice this diam.
wormGearAxisRadiusOffset = 15;
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
motorFixingFootScrewDiam = 3; // Might be unsed
flapScrewDiam = 3;

// -- See what this becomes... 
wheelThickness = 10;
bigWheelDiam = 103;
smallWheelDiam = 13; 

bigWheelStandDiam = 80;
bigWheelStandThickness = 10;
// -------------------------

sizeAboveAxis = 70;   // Needs to be bigger than standLength / 2
sizeBelowAxis = 120; 
bracketWidthOutAll = 80; // Can be re-calculated
bracketPlateWidth = 60;
// Must be equal to (bigWheelDiam + smallWheelDiam) / 2
betweenAxis = 58;        // Between main and motor axis. May be re-calculated
counterweightCylinderDiam = 35;

defaultCylinderPlateThickness = 1.5;

// Wheel stand drilling pattern
//-----------------------------
// For a real one, ActoBotics #615238:
bigWheelStandDrillingDiam = 3;
// Each tuple [radius, angle]
fourHoles = [[ 45.7188023, 17.14134429], [35.19371654, 22.51171482], [28.08199751, 28.67456738], [19.04712535, 45.02701357]];
// Each tuple [angle, radius, diam]
actoBotics615238DrillingPattern = [
	[0 - fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[0 - fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[0 - fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[0 - fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[0 + fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[0 + fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[0 + fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[0 + fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[90 - fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[90 - fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[90 - fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[90 - fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[90 + fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[90 + fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[90 + fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[90 + fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[180 - fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[180 - fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[180 - fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[180 - fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[180 + fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[180 + fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[180 + fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[180 + fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[270 - fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[270 - fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[270 - fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[270 - fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam],

	[270 + fourHoles[0][1], fourHoles[0][0], bigWheelStandDrillingDiam],
	[270 + fourHoles[1][1], fourHoles[1][0], bigWheelStandDrillingDiam],
	[270 + fourHoles[2][1], fourHoles[2][0], bigWheelStandDrillingDiam],
	[270 + fourHoles[3][1], fourHoles[3][0], bigWheelStandDrillingDiam]
];


