/**
 * Parameters used for 
 * - printing.scad
 * - the.full.stand.scad
 */
bottomCylinderHeight = 50;
topCylinderHeight = 24;
// Warning: intDiam < torusDiam < extDiam
extDiam = 110;
torusDiam = 100;
intDiam = 90;
ballsDiam = 5;
verticalAxisDiam = 6;

fixingFootSize = 20;
fixingFootWidth = 20;
fixingFootScrewDiam = 4;
// screwLen = 30;
minFootWallThickness = 5;

topBaseFeetInside = true; // For the top base only

wormGearAxisDiam = 10; // Tube diam, not axis.
wormGearAxisRadiusOffset = extDiam / 3;
wormGearAxisHeight = bottomCylinderHeight / 2;

standWidth = 130;
standLength = 130; 
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
bigWheelDiam = 100;
smallWheelDiam = 12; // 30;
// -------------------------

sizeAboveAxis = 80; // Tossion! Needs to be bigger than standLength / 2
sizeBelowAxis = 120; // Tossion!
bracketWidthOutAll = 90; // Can be re-calculated
bracketPlateWidth = 60;
betweenAxis = 60;        // Between main and motor axis. May be re-calculated
counterweightCylinderDiam = 35;
