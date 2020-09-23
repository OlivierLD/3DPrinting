/**
 * Custom Camera Stand
 * See https://www.raspberrypi-spy.co.uk/wp-content/uploads/2013/05/Raspberry-Pi-Camera-Module-Diagram.png
 *
 * Interesting ones at https://all3dp.com/raspberry-pi-camera-cases-mounts/
 */
 
use <../../mechanical.parts.scad> 

// plateThickness = 3; 
baseScrewDiam = .25 * 25.4; // 6;
standThickness = 12;
standHeight = 20;
standWidth = 40;

cameraPlateWidth = 25;
cameraPlateHeight = 24;
cameraPlateThickness = 1;

betweenHorizHoles = 21;
cameraScrewHoleDiam = 2;
holesFromTopAndSides = 2;

screenPlateThickness = 3;
plateThickness = 2;
plateWidth = 30;
plateHeight = 25;
cableWidth = 20;
cableThickness = 3.5; // The hole for the cable

module prism(l, w, h) {
   polyhedron(points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}
 
 module cameraStand(withCamera=false, withBottom=true) {
   
   difference() {
     union() {
       if (withBottom) {
         // Stand and Slot 
         difference() {
           union() {
             cube(size=[standWidth, standThickness, standHeight], center=true);
             // cylinder(d=20, h=standHeight, center=true, $fn=100);
           }
           translate([0, 0, -6]) {
             cube(size=[standWidth + 10, screenPlateThickness, 12], center=true);
           }
         }
       }
       // Camera stand
       union() {
         // Bottom Plate
         difference() {
           translate([0, 0, (standHeight - plateThickness) / 2]) {
              cube(size=[plateWidth, plateHeight, plateThickness], center=true);
           }
           // Cable passage
//           translate([0, -(plateHeight - plateThickness) / 2, 0]) {
//             rotate([75, 0, 0]) {
//               cube(size=[cableWidth, plateHeight, cableThickness], center=true);
//             }
//           }
         }
         // Vertical plate
         rotate([90, 0, 0]) {
           translate([0, 
                      ((standHeight + plateHeight) / 2) - (plateThickness / 2),
                      plateThickness + (plateHeight - plateThickness) / 2]) {
             difference() {           
               // The plate
               cube(size=[plateWidth, plateHeight + plateThickness, plateThickness], center=true);
               // The hole
               cameraHoleWidth = 10;
               cameraHoleHeight = 10;
               holeFromBottom = 5;
               translate([0, -(plateHeight / 2) + (cameraHoleHeight / 2) + (plateThickness / 2) + holeFromBottom, 0]) {
                 cube(size=[cameraHoleWidth, cameraHoleHeight, 1.1 * plateThickness], center=true);
               }
             }
             // The feet for the screws
             feetDiam = 3.5;
             feetThickness = 2;
             drillHoleDiam = 5; // 2;
             // Top
             translate([(cameraPlateWidth / 2) - (holesFromTopAndSides / 2) - 1, 
                        (plateHeight / 2) - 1.5, 
                        -feetThickness]) {
               difference() {           
                 cylinder(h=2, d=feetDiam, center=true, $fn=40);
                 cylinder(h=drillHoleDiam, d=1, center=true, $fn=20);
               }
             }
             translate([-(cameraPlateWidth / 2) + (holesFromTopAndSides / 2) + 1, 
                        (plateHeight / 2) - 1.5, 
                        -feetThickness]) {
               difference() {           
                 cylinder(h=2, d=feetDiam, center=true, $fn=40);
                 cylinder(h=drillHoleDiam, d=1, center=true, $fn=20);
               }
             }
             // Bottom
             translate([(cameraPlateWidth / 2) - (holesFromTopAndSides / 2) - 1, 
                        - (plateHeight / 2) + 11.5, 
                        -feetThickness]) {
               difference() {           
                 cylinder(h=2, d=feetDiam, center=true, $fn=40);
                 cylinder(h=drillHoleDiam, d=1, center=true, $fn=20);
               }
             }
             translate([-(cameraPlateWidth / 2) + (holesFromTopAndSides / 2) + 1, 
                        - (plateHeight / 2) + 11.5, 
                        -feetThickness]) {
               difference() {           
                 cylinder(h=2, d=feetDiam, center=true, $fn=40);
                 cylinder(h=drillHoleDiam, d=1, center=true, $fn=20);
               }
             }
           }
         }
         // Sides corners
         footHeight = 10;
         footWidth = 15;
         footThickness = 2.5;
         // right 
         translate([-((plateWidth / 2) - footThickness), 2, footHeight]) {
           rotate([0, 0, 180]) {
             prism(footThickness, footWidth, footHeight);
           }
         }
         // left 
         translate([((plateWidth / 2) - (0 * footThickness)), 2, footHeight]) {
           rotate([0, 0, 180]) {
             prism(footThickness, footWidth, footHeight);
           }
         }
          
         // With Camera? 
         if (withCamera) {
           rotate([90, 0, 0]) {
             translate([0,     // left right 
                        22.5,  // Up down 
                        10]) { // Back and forth
               color("green") {
                 difference() {
                   cube([cameraPlateWidth, cameraPlateHeight, cameraPlateThickness], center=true);
                   // screw holes, top
                   translate([(cameraPlateWidth / 2) - (1 * holesFromTopAndSides), 
                               (cameraPlateHeight / 2) - (1 * holesFromTopAndSides), 
                               -3 / 2]) {
                     cylinder(d=cameraScrewHoleDiam, h=3, $fn=30);
                   }
                   translate([-(cameraPlateWidth / 2) + (1 * holesFromTopAndSides), 
                               (cameraPlateHeight / 2) - (1 * holesFromTopAndSides), 
                               -3 / 2]) {
                     cylinder(d=cameraScrewHoleDiam, h=3, $fn=30);
                   }
                   // screw holes, bottom
                   translate([(cameraPlateWidth / 2) - (1 * holesFromTopAndSides), 
                               -(cameraPlateHeight / 2) + (1 * holesFromTopAndSides) + 8, 
                               -3 / 2]) {
                     cylinder(d=cameraScrewHoleDiam, h=3, $fn=30);
                   }
                   translate([-(cameraPlateWidth / 2) + (1 * holesFromTopAndSides), 
                              -(cameraPlateHeight / 2) + (1 * holesFromTopAndSides) + 8, 
                               -3 / 2]) {
                     cylinder(d=cameraScrewHoleDiam, h=3, $fn=30);
                   }
                 }
               }
               // Lens
               color("black") {
                 cameraLensWidth = 8;
                 cameraLensHeight = 8;
                 cameraLensThickness = 5;
                 cameraLensFromBottom = 5.5;
                 translate([0, 
                            cameraLensFromBottom - ((cameraPlateHeight - cameraLensHeight) / 2), 
                            (cameraPlateThickness / 2) + (cameraLensThickness / 2)]) {
                   cube(size=[cameraLensWidth, cameraLensHeight, cameraLensThickness], center=true);
                 }
               }
               // Connector
               color("brown") {
                 connectorWidth = 20.8;
                 connectorHeight = 5.7;
                 connectorThickness = 2.5;
                 translate([0, 
                            - ((cameraPlateHeight - connectorHeight) / 2), 
                            - ((cameraPlateThickness / 2) + (connectorThickness / 2))]) {
                   cube(size=[connectorWidth, connectorHeight, connectorThickness], center=true);
                 }
               }
               // Cable on top of the lens
               color("yellow") {
                 thickness = 1.5;
                 width = 8;
                 height = 9;
                 translate([0, 
                            6,
                            thickness - (cameraPlateThickness / 2)]) {
                   cube(size=[width, height, thickness], center=true);             
                 }
               }
             }
           }
         }
       }
     }
     // Slot for the camera cable
     translate([0, -(plateHeight - plateThickness) / 2, 0]) {
       rotate([75, 0, 0]) {
         cube(size=[cableWidth, plateHeight, cableThickness], center=true);
       }
     }
     // Trim the back
     translate([0, (standThickness + 10) / 2, 10]) {
       cube(size=[plateWidth * 1.1, 10, 10], center=true);
     }
   }     
 }
 
 cameraStand(withCamera=true, withBottom=true);
 