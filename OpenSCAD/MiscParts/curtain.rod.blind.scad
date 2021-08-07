/*
 * A support for a curtain rod, on a blind
 */

module box(width=46, height=31, depth=50, ep=3) {
  rotate([0, 0, 0]) {
    difference() {
      translate([0, 0, 0]) {
         cube(size=[depth + (1 * ep), width + (2 * ep), height + (2 * ep)], center=true);
      }
      translate([ep, 0, 0]) {
         cube(size=[depth, width, height], center=true);
      }
    }
  }
}


module side(width=46, height=31, depth=50, ep=3, rodDiam=20, right=true) {
  rotate([0, 0, 0]) {
    translate([-(depth / 2), 0, 0]) {
      union() {
        cube(size=[ep, width + (2 * ep), height + (2 * ep)], center=true);
        translate([0, ((right ? 1 : -1) * width + ((right ? 1 : -1) * 2 * ep)) / 2, (height + (2 * ep)) / 2]) {
          rotate([right ? 0 : 180, 90, 0]) {
            difference() {
              cylinder(h=ep, d=2 * (height + (2 * ep)), $fn=100, center=true);
              // Hide the top
              translate([-(height + (2 * ep))/ 2, 0, 0]) {
                cube(size=[height + (2 * ep), 2 * (width + (0 * ep)), 2 * ep], center=true);
              }
              // Rod notch
              translate([0, 6 + (rodDiam / 2), 0]) {
                cylinder(d=rodDiam, h=3 * ep, $fn=100, center=true);
              }
            }
          }
        }
      }
    }
  }
}


RIGHT = true;

if (RIGHT) {
  union() {
    box();
    side(right=true);
  }
} else {
  union() {
    box();
    side(right=false);
  }
}