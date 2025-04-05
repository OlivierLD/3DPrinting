/**
 * Locker for porthole
 * @author Olivier Le Diouris
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
         [0, -(ONE_PLATE_WIDTH / 2), 0],                                  // 0
         [BETWEEN_AXIS, -(ONE_PLATE_WIDTH_02 / 2), 0],                    // 1
         [BETWEEN_AXIS, (ONE_PLATE_WIDTH_02 / 2), 0],                     // 2
         [0, (ONE_PLATE_WIDTH / 2), 0],                                   // 3
         [0, -(ONE_PLATE_WIDTH / 2), ONE_PLATE_THICKNESS],                // 4
         [BETWEEN_AXIS, -(ONE_PLATE_WIDTH_02 / 2), ONE_PLATE_THICKNESS],  // 5
         [BETWEEN_AXIS, (ONE_PLATE_WIDTH_02 / 2), ONE_PLATE_THICKNESS],   // 6
         [0, (ONE_PLATE_WIDTH / 2), ONE_PLATE_THICKNESS]                  // 7
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
       // echo("Managing i=", i);
       offset = -(ONE_PLATE_WIDTH / 2) + (ONE_PLATE_WIDTH / 7) * (i * 1);
       translate([-COIN_RADIUS + 1, offset, -9.5]) {
         rotate([90, 0, 0]) {
           cylinder(h=1.5,r=COIN_RADIUS, center=true, $fn=100);
         }
       }
     }
   }
}

module handle() {
   translate([0, 7.5, (TOTAL_THICKNESS / 2)]) {
     rotate([90, 0, -90]) {
       // cube([5, ONE_PLATE_WIDTH, 10], center=true);
       // Ascending part, a  polyhedron
       CubePoints = [
         [0, 0, 0],     // 0
         [25, 20, 0],   // 1
         [25, 10, 0],   // 2
         [20, 0, 0],    // 3
         [0, 0, 8],     // 4
         [25, 20, 8],   // 5
         [25, 10, 8],   // 6
         [20, 0, 8]     // 7
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

       // Handle itself
       translate([37.5, 15, 4.5]) {
         rotate([90, -2, 0]) {
           difference() {
              cube([26, 8, 10], center=true);
             
              // Notches on the handle
              rotate([0, 0, 0]) {
                for (i = [1 : 1: 4]) {
                  translate([(i * 3) - 6, 4, 0]) {
                    cylinder(h=15, r=0.75, center=true);
                  }
                }
              }
           }
         }
       }
     }
   }
}
 

 
// Execution 

WITH_BOTTOM = true;
WITH_HANDLE = true;

translate([0, 0, 0 /*TOTAL_THICKNESS / 2*/]) {
   union() {
      if (WITH_BOTTOM) {
        translate([0, 0, 0]) {
          color("blue") {
            locker();
          }
       }
     }
     if (WITH_HANDLE) {
       translate([0, 0, 0]) {
         color("red") {
           handle();
         }
       }
     }
   }
}

echo("Bye now!");
