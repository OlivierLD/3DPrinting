//
// Cuisine à Belz
//

sinkLength = 75;
sinkWidth = 50;
sinkDepth = 18;

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
x1 = 260;
y1 = 250;
translate([x1 / 2, 0, y1 / 2]) {
  rotate([90, 0, 0]) {
    color("yellow") {
      square(size = [x1, y1], center = true);
    }
  }
}
// Door frame
x2 = 30;
y2 = 250;
translate([x1, -x2 / 2, y2 / 2]) {
  rotate([90, 0, 90]) {
    color("yellow") {
      square(size = [x2, y2], center = true);
    }
  }
}
x2_1 = 70;
y2_1 = 250;
translate([x1 + (x2_1 / 2), -x2, y2_1 / 2]) {
  rotate([90, 0, 0]) {
    color("yellow") {
      square(size = [x2_1, y2_1], center = true);
    }
  }
}


// North wall
x3 = 245;
y3 = 250;
translate([0, x3 / 2, y3 / 2]) {
  rotate([90, 0, 90]) {
    color("yellow") {
      square(size = [x3, y3], center = true);
    }
  }
}
// Bevel
xb = 85;
yb = 250;
translate([30, 30, yb / 2]) {
  rotate([90, 0, -45]) {
    color("yellow") {
      square(size = [xb, yb], center = true);
    }
  }
}
// North wall extension
x4 = 240;
y4 = 250;
wh = 126.3;
ww = 100;
difference() {
  translate([0, x3 + (x4/ 2), y4 / 2]) {
    rotate([90, 0, 90]) {
      color("yellow") {
        square(size = [x4, y4], center = true);
      }
    }
  }
  // Window
  translate([0, y3 + (ww / 2), 120 + (wh / 2)]) {
    rotate([0, 0, 0]) {
      cube(size=[5, ww, wh], center=true);
    }
  }
}

// Heater
heaterLength = 122;
heaterHeight = 60;
heaterThickness = 8;
translate([heaterThickness, x3 + (heaterLength / 2) + 45, (heaterHeight / 2) + 20]) {
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
countertopHeight = (72 + 15);
counterTopWidth = 62;
counterTopThickness = 2;
//
//difference() {
  union() {
    // West part
    translate([(x1 + 60) / 2, counterTopWidth / 2, countertopHeight]) {
      rotate([0, 0, 0]) {
        color("white") {
          cube(size=[x1 - 60, counterTopWidth, counterTopThickness], center=true);
        }
      }
    }
    // North part
    translate([counterTopWidth / 2, (x3 + 60) / 2, countertopHeight]) {
      rotate([0, 0, 90]) {
        color("white") {
          cube(size=[x3 - 60 + 50, counterTopWidth, counterTopThickness], center=true);
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

    translate([0, 75, countertopHeight - (sinkDepth / 1.1)]) {
      color("silver") {
        sink();
      }
    }
  }

//} // End difference
// End counter top

// Under the counter top
// West
translate([(x1 + 60) / 2, counterTopWidth / 2, countertopHeight / 2]) {
  rotate([0, 0, 0]) {
    color("blue") {
      cube(size=[x1 - 60, counterTopWidth, countertopHeight], center=true);
    }
  }
}
// North
translate([counterTopWidth / 2, (x3 + 50 + 60) / 2, countertopHeight / 2]) {
  rotate([0, 0, 90]) {
    color("blue") {
      cube(size=[x3 - 60, counterTopWidth, countertopHeight], center=true);
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
fridgeHeight = 201;
fridgeWidth = 60;
fridgeDepth = counterTopWidth;
translate([x1 - (counterTopWidth / 2), fridgeDepth/ 2, fridgeHeight / 2]) {
  rotate([0, 0, 0]) {
    color("blue") {
      cube(size=[fridgeWidth, fridgeDepth, fridgeHeight], center=true);
    }
  }
}
// Right side (oven, micro-wave)
rightStuffHeight = 151;
rightStuffWidth = 60;
rightStuffDepth = counterTopWidth;
/*translate([(2 + rightStuffDepth) / 2, x3 - (rightStuffWidth / 2), rightStuffHeight / 2]) {
  rotate([0, 0, 0]) {
    color("blue") {
      cube(size=[rightStuffWidth, rightStuffDepth, rightStuffHeight], center=true);
    }
  }
}*/

// La hotte
hDepth = 40;
hWidth = 80;
hHeight = 36;
translate([hDepth / 2, (60 + 30 + 100) - (hHeight / 2), 180 + (hHeight / 2)]) {
  rotate([0, 0, 0]) {
    color("gray") {
      cube(size=[hDepth, hWidth, hHeight], center=true);
    }
  }
}

// Closet, west wall
closetWidth = 100; // + 30 + 30 ?
closetDepth = 50;
closetHeight = 72;
translate([(60 + 100) - (closetHeight / 2), closetDepth / 2, 130 + (closetHeight / 2)]) {
  rotate([0, 0, 90]) {
    color("blue") {
      cube(size=[closetDepth, closetWidth, closetHeight], center=true);
    }
  }
}

// Stove, 60 x 80
stoveWidth = 80;
stoveDepth = 60;
stoveThickness = 2;
translate([(stoveDepth / 2), 40 + 60 + 30 + (stoveWidth / 2), countertopHeight + stoveThickness]) {
  rotate([0, 0, 0]) {
    union() {
      color("gray") {
        cube(size=[stoveDepth, stoveWidth, stoveThickness], center = true);
      }
    }
    translate([15, -20, 2]) {
      color("black") {
        cylinder(h=1, r=10, center=true);
      }
    }
    translate([-15, -20, 2]) {
      color("black") {
        cylinder(h=1, r=10, center=true);
      }
    }
    translate([15, 20, 2]) {
      color("black") {
        cylinder(h=1, r=10, center=true);
      }
    }
    translate([-15, 20, 2]) {
      color("black") {
        cylinder(h=1, r=10, center=true);
      }
    }
  }
}

