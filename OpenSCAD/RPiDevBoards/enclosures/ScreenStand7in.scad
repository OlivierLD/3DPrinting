/**
 * Screen stand for the UCTronics UC-595
 */
use <../uc595.scad>  // This is the screen

betweenHorizontalScrews = 159.5;
betweenVerticalScrews = 108;
screwDiam = 3;

plateThickness = 5;

base = 50;
height = 110;

module prism(l, w, h){
   polyhedron(points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}


module oneSide() {
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
          cube(size=[10, plateThickness, 12.5], center=false);
        }
      }
      
      // Hollow
      rotate([0, 90, 0]) {
        translate([-25, 32, -plateThickness/2]) {
          cylinder(h=(2 * plateThickness), d = 26, $fn=100);
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
oneSideOnly = false;

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
    oneSide();
  }
}
if (fullView) {
  // Left
  translate([-(betweenHorizontalScrews / 2), 0, 0]) {
    oneSide();
  }
}

if (fullView || barOnly) {
  barBehind();
}
