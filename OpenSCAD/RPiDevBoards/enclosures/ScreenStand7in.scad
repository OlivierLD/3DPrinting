/**
 * Screen stand for the UCTronics UC-595
 */
use <../uc595.scad>  // This is the screen

betweenHorizontalScrews = 159.5;
betweenVerticalScrews = 108;
screwDiam = 3;

plateThickness = 7; // 8 Max. 5 Min. Adjust at will.

base = 50;
height = 110;

/*
 
z 
^  
|       4           5
|       .           .
|      /|          /|
|     / |         / |
|    /  |        /  |
| 0 .---. 3   1 .---. 2    
+---------> y
  

+---------> x
| 0 .---. 1   
|   |   |
v   |   |
y 3 .---. 2  4 .---. 5
  
*/
module prism(l, w, h){
   polyhedron(points=[[0,0,0], // Point 0
                      [l,0,0], // Point 1
                      [l,w,0], // Point 2
                      [0,w,0], // Point 3
                      [0,w,h], // Point 4 
                      [l,w,h]],// Point 5
              faces=[[0,1,2,3],  // Base
                     [5,4,3,2],  // Vertical Face
                     [0,4,5,1],  // Slope
                     [0,3,4],    // One side
                     [5,2,1]]);  // The other side
}


module oneSide(left=false) {
  translate([- (plateThickness / 2), 0, 0]) { // Center
    difference() {
      union() {
        rotate([-atan(base / height), 0, 0]) {
          translate([0, 0, 87]) {
            cube(size=[plateThickness, 15, 35], center=false);
          }
        }
        prism(plateThickness, 50, 110);
      }
      // holes for the screws
      firstBottomOffset = -11;
      rotate([-atan(base / height) - 90, 0, 0]) {
        translate([plateThickness / 2, firstBottomOffset, -5]) {
          cylinder(h=10, d=1.5, $fn=50);
        }
        translate([plateThickness / 2, firstBottomOffset - betweenVerticalScrews, -5]) {
          cylinder(h=10, d=1.5, $fn=50);
        }
      }
      // Hook
      rotate([0, 0, 0]) {
        translate([-plateThickness/2, // left-right
                    40,  // back and forth
                    45]) { // Up and down
          cube(size=[14, plateThickness, 12.5], center=false);
        }
      }
      
      // Hollow
      rotate([0, 90, 0]) {
        translate([-22, 30, -plateThickness/2]) {
          cylinder(h=(2 * plateThickness), d = 26, $fn=100);
        }
      }
      if (left) {
        // Space for the sockets, another difference
        rotate([-atan(base / height) + 90, 0, 0]) {
                    
          translate([plateThickness / 2, 99 + 11.5, -1.99]) {
            cube(size=[plateThickness * 2, 8, 4], center=true);
          }

          translate([plateThickness / 2, 99 - 26, -2.99]) {
            cube(size=[plateThickness * 2, 40, 6], center=true);
          }
        }
      }
    }
  }
}

module barBehind() {
  barHeight = 10;
  barThickness = plateThickness;
  barLength = betweenHorizontalScrews + plateThickness + 10;
  
  translate([0, (barThickness/ 2) + 40, 45]) {
    difference() {
      cube(size=[barLength, barThickness, barHeight], center=true);
      translate([(betweenHorizontalScrews / 2), 0, -5]) {
        cube(size=[plateThickness, 20, 10], center= true);
      }
      translate([-(betweenHorizontalScrews / 2), 0, -5]) {
        cube(size=[plateThickness, 20, 10], center= true);
      }
    }
  }
}

screenAngle = 180 - atan(height / base); // 110;
echo("Screen Angle = ", str(screenAngle));

// Drawing options, change at will
withScreen = true;
fullView = true;

barOnly = false;
// Setting this up (those two) smartly is your responsibility.
// You might see some wierd stuff if you do some wierd things. Blame it on you!
oneSideOnly = false;
leftSideOnly = false;

/**
 * To print:
 *   setup screwDiam (default 3)
 *   setup plateThickness (default 7) 
 * 
 * Use withScreen = false;
 *
 * Full View: 
 *    fullView = true;
 *    barOnly = false;
 *    oneSideOnly = false;
 *    leftSideOnly = false;
 *
 * Right side: 
 *    fullView = false;
 *    barOnly = false;
 *    oneSideOnly = true;
 *    leftSideOnly = false;
 *
 * Left side: 
 *    fullView = false;
 *    barOnly = false;
 *    oneSideOnly = true;
 *    leftSideOnly = true;
 *
 * Behind bar: 
 *    fullView = false;
 *    barOnly = true;
 *    oneSideOnly = false;
 *    leftSideOnly = false;
 *
 */

// With a screen ?
if (withScreen) {
  rotate([-(screenAngle + 180), 0, 0]) {
    translate([0, 65, 3.8]) {
      uc595();
    }
  }
}

if (fullView || oneSideOnly) {
  // Right
  translate([(betweenHorizontalScrews / 2), 0, 0]) {
    color("cyan") {
      oneSide(leftSideOnly);
    }
  }
}
if (fullView) {
  // Left
  translate([-(betweenHorizontalScrews / 2), 0, 0]) {
    color("red") {
      oneSide(true);
    }
  }
}

if (fullView || barOnly) {
  color("blue") {
    barBehind();
  }
}
