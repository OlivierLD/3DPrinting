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
