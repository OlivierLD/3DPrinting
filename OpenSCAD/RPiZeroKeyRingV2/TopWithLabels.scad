/**
 * Based on https://www.thingiverse.com/thing:2197417
 */
 


difference() {
  // The top
  translate([120, -442, 0]) {
    rotate([0, 0, 0]) {
      color("red", 0.75) {
        import("../../pi_Zero_keychain_case/files/pi_zero_top.stl");
      }
    }
  }
  // Drill for the led
  translate([28.0, 7.7, 3]) {
    rotate([0, 0, 0]) {
      cylinder(d=2, h=10, center=true, $fn=100);
    }
  }
  
  // Text
  rotate([180, 0, 0]) {
    translate([17.5, -16, 0]) {
      color("lime") {
          linear_extrude(height=8, center=true) {
            text("PWR", 3);
          }
        }
     }
  }
  
  rotate([180, 0, 0]) {
    translate([6, -16, 0]) {
      color("lime") {
          linear_extrude(height=8, center=true) {
            text("USB", 3);
          }
        }
     }
  }

  rotate([180, 0, 0]) {
    translate([-24.3, -16, 0]) {
      color("lime") {
          linear_extrude(height=8, center=true) {
            text("HDMI", 3);
          }
        }
     }
  }

}

// The Raspberry Pi Zero
if (true) {
  translate([-31.5, -15.2, 27]) {
    rotate([-90, 0, 0]) {
      import("../../raspberry-pi-zero-2.snapshot.9/RapberryPiZero.STL");
    }
  }
}
