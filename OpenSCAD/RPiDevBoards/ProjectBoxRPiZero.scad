/*
 * Include a Raspberry pate into a project box.
 * This part is the plate that goes into the project box.
 */
include <./raspberry.pi.zero.plate.only.scad>

projectPlateLength = 95; 
projectPlateWidth = 15; 
thickness = 3;

projectPlateHoleDiam = 4;
betweenHole = 80.5;
projectPlateAxisOffset = 10;

rpiPlateLenght = 68;
rpiPlateWidth = 35;
raspiLower = 5 + (thickness / 2);

difference() {
  union() {
    translate([0, 
               (projectPlateLength / 2) - ((projectPlateLength - rpiPlateLenght) / 4), 
               0]) {
        // Horizontal side  
        difference() {         
          cube(size=[ projectPlateWidth,
                      (projectPlateLength / 2) - (rpiPlateLenght / 2),
                      thickness ], 
               center=true);
          difference() {
            cube(size=[ projectPlateWidth * 2,
                        (projectPlateLength / 2) - (rpiPlateLenght / 2),
                        thickness * 2 ], 
                 center=true);
            translate([0, 0, 0]) {
              cylinder(h=(2 * thickness), d=((projectPlateLength - rpiPlateLenght) / 2), $fn=50, center=true); 
            }
          }
        }
        // vertical (16 degrees)        
        rotate([74, 0, 0]) {  
          translate([0, -(thickness / 2) - (raspiLower / 2), 6]) {
            cube(size=[projectPlateWidth, (raspiLower + thickness), thickness], center=true);
          }
        }
    }
    
    translate([0, 
               - ((projectPlateLength / 2) - ((projectPlateLength - rpiPlateLenght) / 4)), 
               0]) {
        difference() {         
          union() {         
            // Horizontal side       
            difference() {  
              cube(size=[ projectPlateWidth,
                          (projectPlateLength / 2) - (rpiPlateLenght / 2),
                          thickness ], 
                   center=true);
              difference() {
                cube(size=[ projectPlateWidth * 2,
                            (projectPlateLength / 2) - (rpiPlateLenght / 2),
                            thickness * 2 ], 
                     center=true);
                translate([0, 0, 0]) {
                  cylinder(h=(2 * thickness), d=((projectPlateLength - rpiPlateLenght) / 2), $fn=50, center=true); 
                }
              }
            }
            // vertical (16 degrees)        
            rotate([106, 0, 0]) {  
              translate([0, -(thickness / 2) - (raspiLower / 2), -6]) {
                cube(size=[projectPlateWidth, (raspiLower + thickness), thickness], center=true);
              }
            }
          }
          // Space for SD card
          translate([-9, 9, 0]) {
            cube(size=[10, 10, 10], center=true);
          }
        }
    }
    translate([- projectPlateAxisOffset, 0, 0]) {
      translate([0, 0, -raspiLower]) {
        RPiZeroSmallPlate(withPlate=false, withRpi=true);
        cube(size=[ rpiPlateWidth,
                    rpiPlateLenght,
                    thickness ], 
             center=true);
      }
    }
  }  
  // Screw holes
  screwBaseDiam = 8.75;
  translate([0, (betweenHole / 2), - thickness]) {
    union() {
      cylinder(d=projectPlateHoleDiam, h=2 * thickness, $fn=50);
      translate([0, 0, -(thickness + 0.5)]) {
        cylinder(d=screwBaseDiam, h=10, $fn=50, center=true);
      }
    }
  }
  translate([0, -(betweenHole / 2), - thickness]) {
    union() {
      cylinder(d=projectPlateHoleDiam, h=2 * thickness, $fn=50);
      translate([0, 0, -(thickness + 0.5)]) {
        cylinder(d=screwBaseDiam, h=10, $fn=50, center=true);
      }
    }
  }
  // Corners
//  cornerInsetRadius = 15;
//  translate([(projectPlateWidth / 2), (projectPlateLength / 2), -thickness]) {
//    cylinder(d=(2 * cornerInsetRadius), h=2 * thickness, $fn=50);
//  }
//  translate([-(projectPlateWidth / 2), (projectPlateLength / 2), -thickness]) {
//    cylinder(d=(2 * cornerInsetRadius), h=2 * thickness, $fn=50);
//  }
//  translate([(projectPlateWidth / 2), -(projectPlateLength / 2), -thickness]) {
//    cylinder(d=(2 * cornerInsetRadius), h=2 * thickness, $fn=50);
//  }
//  translate([-(projectPlateWidth / 2), -(projectPlateLength / 2), -thickness]) {
//    cylinder(d=(2 * cornerInsetRadius), h=2 * thickness, $fn=50);
//  }
}
