/**
 * Parameters used for 
 * - printing.scad
 */
ballsDiam = 6.35; // 1/4" -> Make the wall 20mm thick.
// Warning: intDiam < torusDiam < extDiam
intDiam   = 100; // Minimum for 16 + 76 teeth
torusDiam = 110;
extDiam   = 120;

verticalAxisDiam = 5;

// Between vertical axis and motor axis
betweenVertAxis = 36.5; // 37.5; // Might need adjustments...

bottomCylinderHeight = 20;

bottomPlateLength = 130;  // x
bottomPlateWidth = 150;   // y
bottomPlateThickness = 5; // z

motorSide = 42.5; // .3;
motorDepth = 39;
betweenMotorScrews = 31;
motorAxisDiam = 5;
motorAxisLength = 24;
motorFixingFootScrewDiam = 3; // Might be unsed
flapScrewDiam = 3;

standWidth = 130;
standLength = 100; 
standHeight = 130;
wallThickness = 10;

fixingFootSize = 20;
fixingFootWidth = 20;
fixingFootScrewDiam = 4;

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


