/**
 * Locker for porthole
 *
 * First designed for Frolic.
 * TODO Manage orientation, left or right
 */
 
ONE_PLATE_THICKNESS = 5;
ONE_PLATE_WIDTH = 25;
ONE_PLATE_LENGTH_01 = 18;
ONE_PLATE_WIDTH_02 = 16;
BETWEEN_AXIS = 17;
BIG_AXIS_DIAM = 11;
BIG_AXIS_HEAD_THICKNESS = 5;

TOTAL_THICKNESS = 16; // Full bottom part
 
module oneHorizontalPlate () {
   union() {
     translate([0, 0, 0]) {
       cube([ONE_PLATE_LENGTH_01, ONE_PLATE_WIDTH, ONE_PLATE_THICKNESS], center=true);
     }
     translate([(ONE_PLATE_LENGTH_01 / 2), 0 , 0]) {
       cylinder(h=ONE_PLATE_THICKNESS, r=(ONE_PLATE_WIDTH / 2), center=true, $fn=100); 
     }
     translate([(ONE_PLATE_LENGTH_01 / 2) + BETWEEN_AXIS, 0 , 0]) {
       cylinder(h=ONE_PLATE_THICKNESS, r=(ONE_PLATE_WIDTH_02 / 2), center=true, $fn=100); 
     }
     translate([(ONE_PLATE_LENGTH_01 / 2) + 1, 0, -(ONE_PLATE_THICKNESS / 2)]) {
       CubePoints = [
         [0, -(ONE_PLATE_WIDTH / 2), 0],   // 0
         [BETWEEN_AXIS, -(ONE_PLATE_WIDTH_02 / 2), 0],  // 1
         [BETWEEN_AXIS, (ONE_PLATE_WIDTH_02 / 2), 0],  // 2
         [0, (ONE_PLATE_WIDTH / 2), 0],   // 3
         [0, -(ONE_PLATE_WIDTH / 2), ONE_PLATE_THICKNESS],   // 4
         [BETWEEN_AXIS, -(ONE_PLATE_WIDTH_02 / 2), ONE_PLATE_THICKNESS],  // 5
         [BETWEEN_AXIS, (ONE_PLATE_WIDTH_02 / 2), ONE_PLATE_THICKNESS],  // 6
         [0, (ONE_PLATE_WIDTH / 2), ONE_PLATE_THICKNESS]    // 7
       ];
       CubeFaces = [
         [0, 1, 2, 3],  // bottom
         [4, 5, 1, 0],  // front
         [7, 6, 5, 4],  // top
         [5, 6, 2, 1],  // right
         [6, 7, 3, 2],  // back
         [7, 4, 0, 3]   // left
       ]; 
       polyhedron( CubePoints, CubeFaces );
     }
   }
 }
 
 module handle() {
   translate([-5.5, 0, 12.5]) {
     rotate([0, 0, 0]) {
       cube([5, 25, 10], center=true);
     }
   }
 }
 
 module locker() {
   difference() {
     union() {
       translate([0, 0, ((TOTAL_THICKNESS - ONE_PLATE_THICKNESS) / 2)]) {
          oneHorizontalPlate();
       }
       translate([0, 0, -((TOTAL_THICKNESS - ONE_PLATE_THICKNESS) / 2)]) {
          oneHorizontalPlate();
       }
       // Around big axis
       translate([(ONE_PLATE_LENGTH_01 / 2), 0, 0]) {
         cylinder(h=TOTAL_THICKNESS, r=6, center=true, $fn=100);
       }
       // The back
       translate([0, 0, 0]) {
         cube([ONE_PLATE_LENGTH_01, ONE_PLATE_WIDTH, TOTAL_THICKNESS], center=true);
       }
       // TODO The handle
     }
     // Axis
     // 1 - Big one
     translate([(ONE_PLATE_LENGTH_01 / 2), 0, 0]) {
       cylinder(h=40, r=3.9, center=true, $fn=50);
     }
     // 1.1 - Axis Head
     translate([(ONE_PLATE_LENGTH_01 / 2), 0, -10.6 + BIG_AXIS_HEAD_THICKNESS]) {
       cylinder(h=BIG_AXIS_HEAD_THICKNESS, r=BIG_AXIS_DIAM / 2, center=true, $fn=50);
     }
     // 2 - Small one
     translate([(ONE_PLATE_LENGTH_01 / 2) + BETWEEN_AXIS, 0, 0]) {
       cylinder(h=40, r=2, center=true, $fn=50);
     }
     // 3 - Cut the back
     translate([-12.0, 0, 0]) {
       rotate([0, -30, 0]) {
          cube([15, 30, 40], center=true);
       }
     }
     // "Coin marks" at the back
     COIN_RADIUS = 20;
     for (i = [1:1:6]) { // [start: inc: end]
       echo("Managing i=", i);
       offset = -(ONE_PLATE_WIDTH / 2) + (ONE_PLATE_WIDTH / 7) * (i * 1);
       translate([-COIN_RADIUS + 1, offset, -9.5]) {
         rotate([90, 0, 0]) {
           cylinder(h=1.5,r=COIN_RADIUS, center=true, $fn=100);
         }
       }
     }
   }
 }
 
 // Execution 
 translate([0, 0, 0 /*TOTAL_THICKNESS / 2*/]) {
   union() {
     translate([0, 0, 0]) {
       locker();
     }
     translate([0, 0, 0]) {
       handle();
     }
   }
 }