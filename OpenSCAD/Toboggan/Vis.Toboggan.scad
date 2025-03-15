//
// Une vis pour le toboggan a Brec'h
//
tube_diam = 22;
tube_length = 26;
head_diam = 36;
head_thickness = 3;

union() {
  // Cylinder with screw
  difference() {
    translate([0, 0, tube_length / 2]) {
      cylinder(h=tube_length, d=tube_diam, center=true, $fn=100);
    }
    translate([0, 0, 67.5]) {
      rotate([180, 0, 0]) {
        color("silver") {
          // Original screw diam = 8.
          // Needed diam = 18.
          // 18 / 8 = 2.25
          scale([2.25, 2.25, 2.25]) {
            import("/Users/olivierlediouris/3DPrinting/NUT.JOB/NUT JOB _ Nut, Bolt, Washer and Threaded Rod Factory - 193647/files/bolt_25x8.stl");
            // import("../../Raspberry_Pi_A+_board/A+_Board.stl");
          }
        }
      }
    }
  }
  // Head
  difference() {
    // Top
    translate([0, 0, -head_thickness / 2]) {
      cylinder(h=head_thickness, d=head_diam, center=true, $fn=100);
    }
    // Grove
    translate([0, 0, -26.5]) {
      rotate([90, 0, 0]) {
        cylinder(h=3, d=50, center=true, $fn=100);
      }
    }

  }
}

// Bolt
showTheBolt = false;
if (showTheBolt) {
  translate([0, 0, 0]) {
    rotate([180, 0, 0]) {
      color("silver") {
        scale([2.25, 2.25, 2.25]) {
          import("/Users/olivierlediouris/3DPrinting/NUT.JOB/NUT JOB _ Nut, Bolt, Washer and Threaded Rod Factory - 193647/files/bolt_25x8.stl");
          // import("../../Raspberry_Pi_A+_board/A+_Board.stl");
        }
      }
    }
  }
}