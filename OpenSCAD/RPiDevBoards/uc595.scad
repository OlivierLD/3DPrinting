/*
 * UCTronics UC-595, https://www.uctronics.com/display/uctronics-7-inch-touch-screen-for-raspberry-pi-1024-600-capacitive-hdmi-lcd-touchscreen-monitor-portable-display-for-pi-4-b-3-b-windows-10-8-7-free-driver.html
 */
 module uc595() {
   
   // in mm
   screenWidth = 165;
   screenLength = 100;
   screenTickness = 6;
   
   lcdWidth = 155;
   lcdHeight = 86;
   
   plateWidth = 165;
   plateLength = 100;
   plateThickness = 1.5;
   
   sidePlateWidth = 5.5;
   sidePlateFullLength = 115;
   sidePlateBetweenHoleAxis = 108;
   sidePlateHolesDiam = 3;
   
   union() {
     color("black") {
       cube(size=[screenWidth, screenLength, screenTickness], center=true);
     }
     color("gray") {
       cube(size=[lcdWidth, lcdHeight, screenTickness], center=true);
     }
   }
   translate([0, 0, -3]) {
     color("green") {
       union() {
         // Side plate 1
         translate([((plateWidth - sidePlateWidth)/ 2), 0, 0]) {
           difference() {
             union() {
               translate([0, (sidePlateBetweenHoleAxis / 2), 0]) {
                 cylinder(h=plateThickness, d=sidePlateWidth, center=true, $fn=50);
               }
               cube(size=[sidePlateWidth, sidePlateBetweenHoleAxis, plateThickness], center=true);
               translate([0, - (sidePlateBetweenHoleAxis / 2), 0]) {
                 cylinder(h=plateThickness, d=sidePlateWidth, center=true, $fn=50);
               }
             }
             translate([0, (sidePlateBetweenHoleAxis / 2), 0]) {
               cylinder(h=2 * plateThickness, d=sidePlateHolesDiam, center=true, $fn=50);
             }
             translate([0, -(sidePlateBetweenHoleAxis / 2), 0]) {
               cylinder(h=2 * plateThickness, d=sidePlateHolesDiam, center=true, $fn=50);
             }
           }
         }
         // Main plate
         cube(size=[plateWidth, plateLength, plateThickness], center=true);
         // Side plate 2
         translate([-((plateWidth - sidePlateWidth)/ 2), 0, 0]) {
           difference() {
             union() {
               translate([0, (sidePlateBetweenHoleAxis / 2), 0]) {
                 cylinder(h=plateThickness, d=sidePlateWidth, center=true, $fn=50);
               }
               cube(size=[sidePlateWidth, sidePlateBetweenHoleAxis, plateThickness], center=true);
               translate([0, - (sidePlateBetweenHoleAxis / 2), 0]) {
                 cylinder(h=plateThickness, d=sidePlateWidth, center=true, $fn=50);
               }
             }
             translate([0, (sidePlateBetweenHoleAxis / 2), 0]) {
               cylinder(h=2 * plateThickness, d=sidePlateHolesDiam, center=true, $fn=50);
             }
             translate([0, -(sidePlateBetweenHoleAxis / 2), 0]) {
               cylinder(h=2 * plateThickness, d=sidePlateHolesDiam, center=true, $fn=50);
             }
           }
         }           
       }
     }
   }
}
 
uc595();
 