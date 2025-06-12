/*
 * Cache-instrument SIMRAD
 */
 echo("Ça vient !");

 w = 109;
 d = 109;
 h = 10;
 
 difference() {
   // Main block
   translate([0, 0, 0]) {
     rotate([0, 0, 0]) {
       cube([w, d, h], center=true);
     }
   }
   
   // Lines in the corners
   translate([47.5, 47.5, 5]) {
     rotate([0, 0, -40]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   translate([47.5, -47.5, 5]) {
     rotate([0, 0, 40]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   translate([-47.5, 47.5, 5]) {
     rotate([0, 0, 40]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   translate([-47.5, -47.5, 5]) {
     rotate([0, 0, -40]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   
   // Bottom vaccum
   translate([0, 0, -2]) {
     rotate([0, 0, 0]) {
       cube([w - 4, d - 4, h], center=true);
     }
   }
   
   // Top 
   // Main screen
   translate([0, 10, 3]) {
     rotate([0, 0, 0]) {
       cube([90, 60, h], center=true);
     }
   }
   translate([0, 10, 3]) {
     rotate([0, 0, 0]) {
       cube([75, 73, h], center=true);
     }
   }
   // Main Screen Corners
   // Top right
   translate([38, 39.5, 3]) {
     rotate([0, 0, 50]) {
       cube([10, 10, h], center=true);
     }
   }
   // Top left
   translate([-38, 39.5, 3]) {
     rotate([0, 0, -50]) {
       cube([10, 10, h], center=true);
     }
   }
   
   // Bittom right
   translate([38, -19.5, 3]) {
     rotate([0, 0, 40]) {
       cube([10, 10, h], center=true);
     }
   }
   // Bottom left
   translate([-38, -19.5, 3]) {
     rotate([0, 0, -40]) {
       cube([10, 10, h], center=true);
     }
   }
   
   // Bottom buttons
   // Left to right. 1
   translate([-37 + (15 / 2), -40, 3]) {
     rotate([0, 0, 0]) {
       cube([15, 8, h], center=true);
     }
   }
   // Left to right. 2
   translate([-18 + (15 / 2), -40, 3]) {
     rotate([0, 0, 0]) {
       cube([15, 8, h], center=true);
     }
   }
   // Left to right. 3
   translate([2 + (15 / 2), -40, 3]) {
     rotate([0, 0, 0]) {
       cube([15, 8, h], center=true);
     }
   }
   // Left to right. 4
   translate([22 + (15 / 2), -40, 3]) {
     rotate([0, 0, 0]) {
       cube([15, 8, h], center=true);
     }
   }
   
 }