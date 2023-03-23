/**
 * Belz house
 * Use # before difference object to see them (debug).
 * Dimensions in mm
 */

module prism(l, w, h) {
   polyhedron(points=[[0,0,0],      // 0
                      [l,0,0],      // 1
                      [l,w,0],      // 2
                      [0,w,0],      // 3
                      [0,w / 2,h],  // 4
                      [l,w / 2,h]], // 5
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
      color("gray") {
        prism(13000 + extra_roof, 5200, 2600);
      }
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
        color("gray") {
          prism(5700, 4500, 2200);
        }
      }
    }
  }
}

module velux() {
  color("silver") {
    cube(size=[1000, 1100, 100], center=false);
  }
}

module small_velux() {
  color("silver") {
    cube(size=[500, 900, 100], center=false);
  }
}

module deck() {
  color("silver") {
    cube(size=[9000, 4500, 30], center=false);
  }
}

module belzHouse() {
  difference() {
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
      // Velux(es)
      
      // Nord ouest Velux
      translate([4600, -2125, 3700]) {
        rotate([45, 0, 0]) {
          velux();
        }
      }

      // Sud ouest Velux
      translate([700, 1150, 4700]) {
        rotate([-45, 0, 0]) {
          velux();
        }
      }
      // Sud est Velux
      translate([-1700, 1150, 4700]) {
        rotate([-45, 0, 0]) {
          velux();
        }
      }

      // Pignon Sud ouest Velux
      translate([3750, 3300, 4700]) {
        rotate([-45, 0, 90]) {
          velux();
        }
      }
      // Pignon Sud est Velux
      translate([-3000, 3300, 3950]) {
        rotate([45, 0, 90]) {
          velux();
        }
      }

      // Sud ouest,  Small Velux
      translate([5650, 650, 5200]) {
        rotate([-45, 0, 0]) {
          small_velux();
        }
      }

      // Deck
      translate([-6500, 2250, 0]) {
        rotate([0, 0, 0]) {
          deck();
        }
      }

    }
    /* Windows and So. */
    // Roof, West
    translate([6500, -50, 3150]) {   
      cube(size=[500, 2400, 400], center=false);
    }
    // Roof, East
    translate([-7000, -50, 3150]) {  
      cube(size=[500, 2400, 400], center=false);
    }
    // Main West
    translate([400, 2100, 50]) { 
      color("silver") {
        cube(size=[1800, 500, 2000], center=false);
      }
    }
    // Main East
    translate([-2200, 2100, 50]) { 
      color("silver") {
        cube(size=[1800, 500, 2000], center=false);
      }
    }
    // Small window east of terrasse
    translate([-2450, 2250 + 380, 800 + 1250]) { 
      rotate([0, 90, 90]) {
        color("silver") {
          cube(size=[1250, 200, 400], center=false);
        }
      }
    }
    
    // East Window
    translate([-5500, 5200, 50]) { 
      color("silver") {
        cube(size=[2000, 500, 2000], center=false);
      }
    }
    // Garage door
    translate([3500, 5200, 50]) { 
      color("brown") {
        cube(size=[2000, 500, 2000], center=false);
      }
    }
    // Top Front Window,  west
    translate([6400, 5105, 3300]) { 
      rotate([0, 0, 90]) {
        color("silver") {
          prism(600, 3800, 1800);
        }
      }
    }
    // Top Front Window,  east
    translate([-2600, 5105, 3300]) { 
      rotate([0, 0, 90]) {
        color("silver") {
          prism(600, 3800, 1800);
        }
      }
    }
    // Pignon est, second floor window
    translate([-6400, -550, 3300]) { 
      rotate([0, 0, 90]) {
        color("silver") {
          cube(size=[600, 200, 1000], center=false);
        }
      }
    }
    // Pignon est, first floor window
    translate([-6400, 2300, 900]) { 
      rotate([0, 0, 90]) {
        color("silver") {
          cube(size=[900, 200, 1100], center=false);
        }
      }
    }
    // Back Window
    translate([-1050, -2300, 1100]) {
      rotate([0, 0, 0]) {
        color("silver") {
          cube(size=[1050, 200, 1000], center=false);
        }
      }
    }
    // Pignon ouest window
    translate([6600, -1600, 1100]) { 
      rotate([0, 0, 90]) {
        color("silver") {
          cube(size=[850, 200, 1100], center=false);
        }
      }
    }
  }
}

belzHouse();
