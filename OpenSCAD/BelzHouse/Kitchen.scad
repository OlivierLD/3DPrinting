//
// Cuisine à Belz
// A test.
// Measures in mm.
//

sinkLength = 750;
sinkWidth = 500;
sinkDepth = 180;

module sink() {
  difference() {
    translate([0, 0, sinkDepth / 2]) {
      color("gray") {
        cube(size=[sinkLength, sinkWidth, sinkDepth], center=true);
      }
    }
    translate([0, 0, (sinkDepth - 2) / 2]) {
      color("gray") {
        cube(size=[sinkLength - 2, sinkWidth - 2, sinkDepth - 2], center=true);
      }
    }
  }
}

// West wall
x1 = 2600;
y1 = 2500;
translate([x1 / 2, 0, y1 / 2]) {
  rotate([90, 0, 0]) {
    color("yellow") {
      square(size = [x1, y1], center = true);
    }
  }
}
// Door frame
x2 = 300;
y2 = 2500;
translate([x1, -x2 / 2, y2 / 2]) {
  rotate([90, 0, 90]) {
    color("yellow") {
      square(size = [x2, y2], center = true);
    }
  }
}
x2_1 = 700;
y2_1 = 2500;
translate([x1 + (x2_1 / 2), -x2, y2_1 / 2]) {
  rotate([90, 0, 0]) {
    color("yellow") {
      square(size = [x2_1, y2_1], center = true);
    }
  }
}


// North wall
x3 = 2450;
y3 = 2500;
translate([0, x3 / 2, y3 / 2]) {
  rotate([90, 0, 90]) {
    color("yellow") {
      square(size = [x3, y3], center = true);
    }
  }
}
// Bevel
xb = 850;
yb = 2500;
translate([300, 300, yb / 2]) {
  rotate([90, 0, -45]) {
    color("yellow") {
      square(size = [xb, yb], center = true);
    }
  }
}
// North wall extension
x4 = 2400;
y4 = 2500;
wh = 1263;
ww = 1000;
difference() {
  translate([0, x3 + (x4/ 2), y4 / 2]) {
    rotate([90, 0, 90]) {
      color("yellow") {
        square(size = [x4, y4], center = true);
      }
    }
  }
  // Window
  translate([0, y3 + (ww / 2), 1200 + (wh / 2)]) {
    rotate([0, 0, 0]) {
      cube(size=[50, ww, wh], center=true);
    }
  }
}

// Heater
heaterLength = 1220;
heaterHeight = 600;
heaterThickness = 80;
translate([heaterThickness, x3 + (heaterLength / 2) + 450, (heaterHeight / 2) + 200]) {
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

// Counter top 
countertopHeight = (720 + 150);
counterTopWidth = 620;
counterTopThickness = 20;
//
//difference() {
  union() {
    // West part
    translate([(x1 + 600) / 2, counterTopWidth / 2, countertopHeight]) {
      rotate([0, 0, 0]) {
        color("white") {
          cube(size=[x1 - 600, counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
    // North part
    translate([counterTopWidth / 2, (x3 + 600) / 2, countertopHeight]) {
      rotate([0, 0, 90]) {
        color("white") {
          cube(size=[x3 - 600 + 500, counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
    // Bevel part
    rotate([0, 0, -45]) {
      translate([0, (xb + counterTopWidth)/ 2, countertopHeight]) {
        color("white") {
          cube(size=[xb, counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
  }
  // sink
  rotate([0, 0, -45]) {

    translate([0, 750, countertopHeight - (sinkDepth / 1.1)]) {
      color("silver") {
        sink();
      }
    }
  }

//} // End difference
// End counter top

// Under the counter top
// West
translate([(x1 + 600) / 2, counterTopWidth / 2, countertopHeight / 2]) {
  rotate([0, 0, 0]) {
    color("blue") {
      cube(size=[x1 - 600, counterTopWidth, countertopHeight], center=true);
    }
  }
}
// North
translate([counterTopWidth / 2, (x3 + 500 + 600) / 2, countertopHeight / 2]) {
  rotate([0, 0, 90]) {
    color("blue") {
      cube(size=[x3 - 600, counterTopWidth, countertopHeight], center=true);
    }
  }
}
// Bevel 
rotate([0, 0, -45]) {
  translate([0, (xb + counterTopWidth)/ 2, countertopHeight / 2]) {
    color("blue") {
      cube(size=[xb, counterTopWidth, countertopHeight], center=true);
    }
  }
}

// fridge
fridgeHeight = 2010;
fridgeWidth = 600;
fridgeDepth = counterTopWidth;
translate([x1 - (counterTopWidth / 2), fridgeDepth/ 2, fridgeHeight / 2]) {
  rotate([0, 0, 0]) {
    color("blue") {
      cube(size=[fridgeWidth, fridgeDepth, fridgeHeight], center=true);
    }
  }
}
// Right side (oven, micro-wave)
rightStuffHeight = 1510;
rightStuffWidth = 600;
rightStuffDepth = counterTopWidth;
/*translate([(2 + rightStuffDepth) / 2, x3 - (rightStuffWidth / 2), rightStuffHeight / 2]) {
  rotate([0, 0, 0]) {
    color("blue") {
      cube(size=[rightStuffWidth, rightStuffDepth, rightStuffHeight], center=true);
    }
  }
}*/

// La hotte
hDepth = 400;
hWidth = 800;
hHeight = 360;
translate([hDepth / 2, (600 + 300 + 1000) - (hHeight / 2), 1800 + (hHeight / 2)]) {
  rotate([0, 0, 0]) {
    color("gray") {
      cube(size=[hDepth, hWidth, hHeight], center=true);
    }
  }
}

// Closet, west wall
closetWidth = 1000; // + 30 + 30 ?
closetDepth = 500;
closetHeight = 720;
translate([(600 + 1000) - (closetHeight / 2), closetDepth / 2, 1300 + (closetHeight / 2)]) {
  rotate([0, 0, 90]) {
    color("blue") {
      cube(size=[closetDepth, closetWidth, closetHeight], center=true);
    }
  }
}

// Stove, 60 x 80
stoveWidth = 800;
stoveDepth = 600;
stoveThickness = 20;
translate([(stoveDepth / 2), 400 + 600 + 300 + (stoveWidth / 2), countertopHeight + stoveThickness]) {
  rotate([0, 0, 0]) {
    union() {
      color("gray") {
        cube(size=[stoveDepth, stoveWidth, stoveThickness], center = true);
      }
    }
    translate([150, -200, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    translate([-150, -200, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    translate([150, 200, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
    translate([-150, 200, 20]) {
      color("black") {
        cylinder(h=10, r=100, center=true);
      }
    }
  }
}

translate([1000, 1200, 0]) {
  rotate([90, 0, -40]) {
    color("orange") {
      scale([1.25, 1.25,1.25]) {
        import("/Users/olivierlediouris/3DPrinting/walid90/3d-human-model/3DHumanModel.STL");
        // import("../../Raspberry_Pi_A+_board/A+_Board.stl");
      }
    }
  }
}
