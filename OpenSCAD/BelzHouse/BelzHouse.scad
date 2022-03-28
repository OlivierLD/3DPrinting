/**
 * Belz house
 */

module prism(l, w, h) {
   polyhedron(points=[[0,0,0],   // 0
                      [l,0,0],   // 1
                      [l,w,0],   // 2
                      [0,w,0],   // 3
                      [0,w / 2,h],   // 4
                      [l,w / 2,h]],  // 5
              faces=[[0,1,2,3],         // bottom
                     [5,4,3,2],         // One face (top)
                     [0,4,5,1],         // Other face (top)
                     [0,3,4],           // One side
                     [5,2,1]]);         // Other side
}

extra_roof = 0; // 500;

module mainRoof() {
  union() {
    translate([-extra_roof / 2, 0, 0]) {
      prism(13000 + extra_roof, 5200, 2600);
    }
    translate([0, (5200 - 1000) / 2, 2100]) {
      chimney();
    }
    translate([13000 - 600, (5200 - 1000) / 2, 2100]) {
      chimney();
    }
  }
}

module chimney() {
  // color("red") {
  cube(size=[600, 1000, 1100], center=false);
  // }
}

module pignon() {
  union() {
    cube(size=[4000, 3100, 3300], center=false);
    translate([2000 + (4500 / 2), -(4500 / 2), 3300]) {
      rotate([0, 0, 90]) {
        prism(5700, 4500, 2200);
      }
    }
  }
}

module belzHouse() {
  union() {
    union() {
      translate([-13000 / 2, -4500 / 2, 0]) {
        cube(size=[13000, 4500, 3300], center=false); // Main part
      }
      translate([-13000 / 2, -5200 / 2, 3300]) {
        mainRoof();
      }
    }
    // Pignon Ouest
    translate([(13000 / 2) - 4000, (4500 / 2), 0]) {
      pignon();
    }
    // Pignon Est
    translate([( - 13000 / 2) + 00, (4500 / 2), 0]) {
      pignon();
    }
	}
}

belzHouse();
