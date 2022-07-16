//
// Cuisine à Belz
// A test.
// Measures in mm.
//

wall_color = [1.0, 0.647, 0, 0.85]; // "yellow";
furniture_color = "cyan";
counter_top_color = "white";

sinkLength = 780; // 750;
sinkWidth = 435; // 500;
sinkDepth = 415; // 180;

module sink() {
  difference() {
    translate([0, 0, sinkDepth / 2]) {
      color("gray") {
        cube(size=[sinkLength, sinkWidth, sinkDepth], center=true);
      }
    }
    translate([(sinkLength / 4), 0, (sinkDepth / 2) + 100]) {
      color("silver") {
        cube(size=[(sinkLength / 2) - 100, sinkWidth - 100, sinkDepth - 10], center=true);
      }
    }
    translate([-(sinkLength / 4), 0, (sinkDepth / 2) + 100]) {
      color("silver") {
        cube(size=[(sinkLength / 2) - 100, sinkWidth - 100, sinkDepth - 10], center=true);
      }
    }
  }
}

// West wall
x1 = 2320 + 721.2; // 2600;
y1 = 2500;
translate([x1 / 2, 0, y1 / 2]) {
  rotate([90, 0, 0]) {
    color(wall_color) {
      square(size = [x1, y1], center = true);
    }
  }
}
// Door frame
x2 = 300;
y2 = 2500;
translate([x1, -x2 / 2, y2 / 2]) {
  rotate([90, 0, 90]) {
    color(wall_color) {
      square(size = [x2, y2], center = true);
    }
  }
}
x2_1 = 700;
y2_1 = 2500;
translate([x1 + (x2_1 / 2), -x2, y2_1 / 2]) {
  rotate([90, 0, 0]) {
    color(wall_color) {
      square(size = [x2_1, y2_1], center = true);
    }
  }
}


// North wall
x3 = 2155 + 721.2; // 2450;
y3 = 2500;

// x4 = (721.2 + 2155); // 2400;
// y4 = 2500;

translate([0, x3 / 2, y3 / 2]) {
  rotate([90, 0, 90]) {
    color(wall_color) {
      square(size = [x3, y3], center = true);
    }
  }
}
// Bevel
xb = 1020; // 850;
yb = 2500;
translate([360, 360, yb / 2]) {
  rotate([90, 0, -45]) {
    color(wall_color) {
      square(size = [xb, yb], center = true);
    }
  }
}
// North wall extension
x4 = ((0 * 721.2) + 2155); // 2400;
y4 = 2500;
wh = 900;
ww = 1210;
difference() {
  translate([0, x3 + (1 * x4 / 2), y4 / 2]) {
    rotate([90, 0, 90]) {
      color(wall_color) {
        square(size = [x4, y4], center = true);
      }
    }
  }
  // Window
  translate([0, y3 + (ww / 2), 1230 + (wh / 2)]) {
    rotate([0, 0, 0]) {
      %cube(size=[150, ww, wh], center=true);
    }
  }
}

// Heater
heaterLength = 1220;
heaterHeight = 600;
heaterThickness = 80;
translate([heaterThickness, (2600 + (721.2 / 2)) + (heaterLength / 2), (heaterHeight / 2) + 200]) {
  rotate([0, 0, 0]) {
    color("grey") {
      cube(size=[heaterThickness, heaterLength, heaterHeight], center=true);
    }
  }
}


// Floor
floorLength = x3 + x4 + x2;
floorWidth = x1 + x2_1;
translate([floorWidth / 2, (floorLength / 2) - x2, 0]) {
  rotate([0, 0, 0]) {
    color("silver") {
      square(size = [floorWidth, floorLength], center = true);
    }
  }
}

counterTopWidth = 620;

// fridge
fridgeHeight = 2010;
fridgeWidth = 600;
fridgeDepth = counterTopWidth;
translate([x1 - (fridgeWidth / 2), fridgeDepth/ 2, fridgeHeight / 2]) {
  rotate([0, 0, 0]) {
    color(furniture_color) {
      cube(size=[fridgeWidth, fridgeDepth, fridgeHeight], center=true);
    }
  }
}

// closet, right of the fridge (colonne electromenager)
fridgeRightHeight = 2010;
fridgeRightWidth = 300;
fridgeRightDepth = counterTopWidth;
translate([x1 - (fridgeWidth) - (fridgeRightWidth / 2), fridgeRightDepth/ 2, fridgeRightHeight / 2]) {
  rotate([0, 0, 0]) {
    color(furniture_color) {
      // cube(size=[fridgeRightWidth, fridgeRightDepth, fridgeRightHeight], center=true);
      
      difference() {
        cube(size=[fridgeRightWidth, fridgeRightDepth, fridgeRightHeight], center=true);
        translate([10, -(fridgeRightWidth / 1), 0]) {
           cube(size=[fridgeRightWidth, (fridgeRightWidth / 1) + 1000, fridgeRightHeight - 40], center=true);
        }
      }
    }
  }
}

// Counter top 
countertopHeight = (720 + 150);
counterTopThickness = 20;
//
//difference() {
  union() {
    // West part
    translate([(x1 - (fridgeWidth + fridgeRightWidth)) / 2 , counterTopWidth / 2, countertopHeight]) {
      rotate([0, 0, 0]) {
        color(counter_top_color) {
          cube(size=[x1 - (fridgeWidth + fridgeRightWidth), counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
    // North part
    translate([counterTopWidth / 2, (x3 + 0) / 2, countertopHeight]) {
      rotate([0, 0, 90]) {
        color(counter_top_color) {
          cube(size=[x3, counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
    // Bevel part
    rotate([0, 0, -45]) {
      translate([0, (xb + counterTopWidth)/ 2, countertopHeight]) {
        color(counter_top_color) {
          cube(size=[xb, counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
  }
  // sink
  rotate([0, 0, -45]) {

    translate([0, 850, countertopHeight - (sinkDepth / 1.1)]) {
      color("silver") {
        sink();
      }
    }
  }

//} // End difference
// End counter top

// Under the counter top
// West
deltaLength = 620 * 0.707 / 2;  
blockLength = x1 - 721.2 - (fridgeWidth + fridgeRightWidth) - deltaLength - 40;
echo(str(">> BlockLength West:", str(blockLength), " mm"));
translate([((blockLength + (1 * deltaLength)) / 1) + 180, 
           (counterTopWidth / 2) + 0, 
           (countertopHeight / 2) + 0]) {
  rotate([0, 0, 0]) {
    color(furniture_color) {
      cube(size=[blockLength, counterTopWidth, countertopHeight], center=true);
    }
  }
}
// North
theFullNorth = false;
if (theFullNorth) {
  translate([counterTopWidth / 2, 
             (x3/* ? */) / 2, 
             (countertopHeight / 2) + 0]) {
    rotate([0, 0, 90]) {
      color(furniture_color) {
        cube(size=[(x3), counterTopWidth, countertopHeight], center=true);
      }
    }
  }
}
// Just the necessary block
blockLength_2 = x3 - 721.2 - deltaLength - 40;
echo(str(">> BlockLength North:", str(blockLength_2), " mm"));
translate([counterTopWidth / 2, 
           (blockLength_2 + 30) / 1, 
           (countertopHeight / 2) + 0]) {
  rotate([0, 0, 90]) {
    color(furniture_color) {
      cube(size=[(blockLength_2), counterTopWidth, countertopHeight], center=true);
    }
  }
}

// Bevel 
theFullBevelThing = false;
if (theFullBevelThing) {
  rotate([0, 0, -45]) {
    translate([0, (xb + counterTopWidth)/ 2, (countertopHeight / 2) + 0]) {
      color(furniture_color) {
        cube(size=[xb, counterTopWidth, countertopHeight], center=true);
      }
    }
  }
}

// Width of the bevel block
blockLength_3 = xb/ 2;
echo(str(">> BlockLength Bevel:", str(blockLength_3), " mm"));
rotate([0, 0, -45]) {
  translate([0, (xb + counterTopWidth)/ 2, (countertopHeight / 2) + 0]) {
    color(furniture_color) {
      cube(size=[blockLength_3, counterTopWidth, countertopHeight], center=true);
    }
  }
}


// Right side (oven, micro-wave)
/*
rightStuffHeight = 1510;
rightStuffWidth = 600;
rightStuffDepth = counterTopWidth;
translate([(2 + rightStuffDepth) / 2, x3 - (rightStuffWidth / 2), rightStuffHeight / 2]) {
  rotate([0, 0, 0]) {
    color(furniture_color) {
      cube(size=[rightStuffWidth, rightStuffDepth, rightStuffHeight], center=true);
    }
  }
}
*/

stoveWidth = 600;
stoveDepth = 510;
stoveThickness = 20;

// La hotte
union() {
  hDepth = 500;
  hWidth = 900;
  hHeight = 30;
  // Bottom
  translate([hDepth / 2, (721.2 + 1010) - (0 * hHeight / 2), (650 + 870) + (hHeight / 2)]) {
    rotate([0, 0, 0]) {
      color("gray") {
        cube(size=[hDepth, hWidth, hHeight], center=true);
      }
    }
  }
  // Pyramid
  translate([(50), 
             (721.2 + 1010) - 5, 
             650 + 870 + hHeight + (200/2)]) {
    rotate([0, 0, 45]) {
      color("gray") {
        // Pyramid ? That one is not right.
          cylinder(h=200, r1=620, r2=80, $fn=4, center=true);
      }
    }
  }
  // Chimney
  translate([0, (721.2 + 1010 - 110), 650 + 870]) {
    rotate([0, 0, 0]) {
      color("gray") {
        cube([220, 165, 980]);
      }
    }
  }
}

// Closet, west wall
closetWidth = 1100; 
closetDepth = 500;
closetHeight = 720;
closetBottomHeight = 1300;
translate([(1900) - (closetHeight / 2), closetDepth / 2, closetBottomHeight + (closetHeight / 2)]) {
  rotate([0, 0, 90]) {
    color(furniture_color) {
      difference() {
        cube(size=[closetDepth, closetWidth, closetHeight], center=true);
        translate([10, -(closetWidth / 3), 0]) {
           cube(size=[closetDepth, (closetWidth / 3) - 40, closetHeight - 40], center=true);
        }
        translate([10, (0 * closetWidth / 3), 0]) {
           cube(size=[closetDepth, (closetWidth / 3) - 40, closetHeight - 40], center=true);
        }
        translate([10, (closetWidth / 3), 0]) {
           cube(size=[closetDepth, (closetWidth / 3) - 40, closetHeight - 40], center=true);
        }
      }
    }
  }
}

// Closets, north wall
// Right
closetWidth_2 = 300;
closetDepth_2 = 500;
closetHeight_2 = 500;
closetBottomHeight_2 = 1520;

withRight = false; // Impact below

if (withRight) {
  translate([(closetDepth_2 /2), 2340, closetBottomHeight_2 + (closetHeight_2 / 2)]) {
    rotate([0, 0, 0]) {
      color(furniture_color) {
        difference() {
          cube(size=[closetDepth_2, closetWidth_2, closetHeight_2], center=true);
          translate([20, 0, 10]) {
            cube(size=[closetDepth_2 - 0, closetWidth_2 - 40, closetHeight_2 - 40], center=true);
          }
        }
      }
    }
  }
}

// Left
closetWidth_3 = 500;
closetDepth_3 = 500;
closetHeight_3 = 500;
translate([(closetDepth_3 /2), 1020, 1520 + (closetHeight_3 / 2)]) {
  rotate([0, 0, 0]) {
    color(furniture_color) {
      difference() {
        cube(size=[closetDepth_3, closetWidth_3, closetHeight_3], center=true);
        translate([20, 0, 10]) {
          cube(size=[closetDepth_3 - 0, closetWidth_3 - 40, closetHeight_3 - 40], center=true);
        }
      }
    }
  }
}


// Stove, 51 x 60
translate([(stoveDepth / 2) + 50, 721.2 + 1010 + (0 * stoveWidth / 2), countertopHeight + stoveThickness]) {
  rotate([0, 0, 0]) {
    // The whole thing
    union() {
      color("gray") {
        cube(size=[stoveDepth, stoveWidth, stoveThickness], center = true);
      }
    }
    // Burners
    translate([130, -180, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    translate([-130, -180, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    translate([130, 90, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    translate([-130, 90, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    // Knobs
    translate([-150, 250, 10]) {
      color("white") {
        cylinder(h=20, r=10, center=true);
      }
    }
    translate([-100, 250, 10]) {
      color("white") {
        cylinder(h=20, r=10, center=true);
      }
    }
    translate([-50, 250, 10]) {
      color("white") {
        cylinder(h=20, r=10, center=true);
      }
    }
    translate([0, 250, 10]) {
      color("white") {
        cylinder(h=20, r=10, center=true);
      }
    }
    // Done
  }
}

// The guy, standing in the kitchen...
showTheGuy = false;
if (showTheGuy) {
  translate([1200, 1500, 0]) {
    rotate([90, 0, -40]) {
      color("orange") {
        scale([1.25, 1.25, 1.25]) {
          #import("/Users/olivierlediouris/3DPrinting/walid90/3d-human-model/3DHumanModel.STL");
          // import("../../Raspberry_Pi_A+_board/A+_Board.stl");
        }
      }
    }
  }
}