/*
 * Embout Barre de Fleche Thibault
 * 
 * Diametre inox: 6mm
 * Longueur interieure: 47mm
 * Longueur exterieure: 57mm (minimum)
 * Largeur interieure: 12.62mm
 * Largeur exterieure: 18mm (mini)
 *
 * Hauteur partie superieure: 18mm
 * Hauteur partie interieure: 20mm
 *
 * Diametre trou de fixation: 3mm
 * Position trou de fixation: H: -10mm
 *                            L:  10mm
 */
 
 module bottomPart() {
   
   width = 12.62;
   length = 47;
   height = 20;
   
   hull() { // was union
     rotate([0, 0, 0]) {
       translate([0, 0, 0]) {
         cube([5.5, length, height], center=true);
       }
     }
     rotate([0, 0, 0]) {
       translate([0, 0, 0]) {
         cube([width, 22.5, height], center=true);
       }
     }
     // Corners
     rotate([0, 0, 0]) {
       translate([5.5 / 2, (length / 2) - 1.5, 0]) {
         cylinder(h=height, r=1.5, center=true, $fn=50);
       }
     }
     rotate([0, 0, 0]) {
       translate([5.5 / 2, -((length / 2) - 1.5), 0]) {
         cylinder(h=height, r=1.5, center=true, $fn=50);
       }
     }
     rotate([0, 0, 0]) {
       translate([-5.5 / 2, (length / 2) - 1.5, 0]) {
         cylinder(h=height, r=1.5, center=true, $fn=50);
       }
     }
     rotate([0, 0, 0]) {
       translate([-5.5 / 2, -((length / 2) - 1.5), 0]) {
         cylinder(h=height, r=1.5, center=true, $fn=50);
       }
     }
     // Joining narrow and wide parts
     // - Right
     rotate([0, 0, -10.5]) {
       translate([5.75, -15.55, 0]) {
         cube([5, 11.5, height], center=true);
       }
     }
     rotate([0, 0, 10.5]) {
       translate([-5.75, -15.55, 0]) {
         cube([5, 11.5, height], center=true);
       }
     }
     // - Left
     rotate([0, 0, 10.5]) {
       translate([5.75, 15.55, 0]) {
         cube([5, 11.5, height], center=true);
       }
     }
     rotate([0, 0, -10.5]) {
       translate([-5.75, 15.55, 0]) {
         cube([5, 11.5, height], center=true);
       }
     }
   }
 }
 
 module topPart() {
   
   fullLength = 57;
   height = 18;
   
   difference() {
     hull() { // was union
     
       // Main thing
       rotate([0, 0, 0]) {
         translate([0, 0, 0]) {
           cube([5, fullLength, height], center=true); 
         }
       }
       // Thickest part
       rotate([0, 0, 0]) {
         translate([0, 0, 0]) {
           cube([20, 30, height], center=true); 
         }
       }
       // Corners
       rotate([0, 0, 0]) {
         translate([-5.5 / 2, -((fullLength / 2) - 2.5), 0]) {
           cylinder(h=18, r=2.5, center=true, $fn=50);
         }
       }
       rotate([0, 0, 0]) {
         translate([5.5 / 2, -((fullLength / 2) - 2.5), 0]) {
           cylinder(h=18, r=2.5, center=true, $fn=50);
         }
       }
       rotate([0, 0, 0]) {
         translate([-5.5 / 2, ((fullLength / 2) - 2.5), 0]) {
           cylinder(h=18, r=2.5, center=true, $fn=50);
         }
       }
       rotate([0, 0, 0]) {
         translate([5.5 / 2, ((fullLength / 2) - 2.5), 0]) {
           cylinder(h=18, r=2.5, center=true, $fn=50);
         }
       }
       // Joining narrow and wide parts
       // - One side
       rotate([0, 0, -22]) {
         translate([11.35, -16.7, 0]) {
           cube([7, 13, height], center=true);
         }
       }
       rotate([0, 0, 22]) {
         translate([11.35, 16.7, 0]) {
           cube([7, 13, height], center=true);
         }
       }
       // - Other side
       rotate([0, 0, 22]) {
         translate([-11.35, -16.7, 0]) {
           cube([7, 13, height], center=true);
         }
       }
       rotate([0, 0, -22]) {
         translate([-11.35, 16.7, 0]) {
           cube([7, 13, height], center=true);
         }
       }
       
     }
     // Cable hole
     rotate([0, 90, 0]){ 
       translate([0, -8.2, 0]) {
         cylinder(h=30, r=5.5, center=true, $fn=100);
       }
     }
     // Top hole, for the stanless steel part
     rotate([0, 0, 0]){ 
       translate([0, -7.2, 7.5]) {
         cube([30, 9, 16], center=true);
       }
     }
   }
 }
 
 // Now we're talking.
 
 difference() {
   union() {
     // Bottom
     rotate([0, 0, 0]) {
       translate([0, 0, -20 / 2]) {
         bottomPart();
       }
     }
     // Top
     rotate([0, 0, 0]) {
       translate([0, 0, 18 / 2]) {
         topPart();
       }
     }
   }
   
   // The axis
   rotate([0, 0, 0]) {
     translate([0, 0, 0]) {
       cylinder(h=50, r=3.05, center=true, $fn=50);
     }
   }
   // Front of the axis
   rotate([0, 0, 0]) {
     translate([0, -4, 22]) {
       cube([6.1, 8, 30], center=true);
     }
   }
   // Tip of the hook
   if (false) {  // V1
     translate([0, -12, 17]) {
       rotate([-70, 0, 0]) {
         cylinder(h=10, r=3, center=true, $fn=50);
       }
     }
   } else {
     rotate([0, 0, 0]) {
       translate([0, -14.5, 17]) {
         cylinder(h=20, r=3.05, center=true, $fn=50);
       }
     }
     // Free the back
     rotate([0, 0, 0]) {
       translate([0, -10.5, 22]) {
         cube([6.1, 8, 30], center=true);
       }
     }
   }
   
   // Front carenage
   translate([0, -25, 20]) {
     rotate([35, 0, 0]) {
       cube([30, 30, 10], center=true);
     }
   }
   // Back carenage
   translate([0, 15, 20]) {
     rotate([-25, 0, 0]) {
       cube([30, 50, 10], center=true);
     }
   }
   
   // The hole for the screw in the spreader
   if (true) {
     translate([-5, -14, -10]) {
       rotate([0, 90, 0]) {
         cylinder(h=10, r=1.5, center=true, $fn=30);
       }
     }
   }

 }