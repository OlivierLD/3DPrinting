/*
 * Cache-instrument SIMRAD
 */
 echo("Ça vient !");
 
 difference() {
   // Main block
   translate([0, 0, 0]) {
     rotate([0, 0, 0]) {
       w = 109;
       d = 109;
       h = 10;
       cube([w, d, h], center=true);
     }
   }
   
   // Lines in the corners
   translate([50, 50, 5]) {
     rotate([0, 0, -45]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   translate([50, -50, 5]) {
     rotate([0, 0, 45]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   translate([-50, 50, 5]) {
     rotate([0, 0, 45]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   translate([-50, -50, 5]) {
     rotate([0, 0, -45]) {
       cube([50, 0.5, 1], center=true);
     }
   }
   
 }