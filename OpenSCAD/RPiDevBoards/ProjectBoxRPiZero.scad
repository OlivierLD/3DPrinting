/*
 * Include a Raspberry pate into a project box.
 * This part is the plate that goes into the project box,
 * or on top of a lego plate (included here)
 *
 * Look for RPiZeroSmallPlate in the code below
 *
 * See in the script the parameters
 * - withRPi
 * - withFeet
 * - withLegoPlate
 * - legoPlateOnly
 */
include <./raspberry.pi.zero.plate.only.scad>

// Warning!! Location depends on your machine!! 
use <../../../LEGO.oliv/LEGO.scad> 


projectPlateLength = 95; 
projectPlateWidth = 15; 
thickness = 3;

projectPlateHoleDiam = 4;
betweenHole = 80.5;
projectPlateAxisOffset = 10;

rpiPlateLenght = 68;
rpiPlateWidth = 35;
raspiLower = 5 + (thickness / 2);

withRPi = false;
withFeet = true;
withLegoPlate = true;
legoPlateOnly = false;

difference() {
  union() {
    if (!legoPlateOnly) {
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
          RPiZeroSmallPlate(withPlate=false, withRpi=withRPi, withSide=false);
          cube(size=[ rpiPlateWidth,
                      rpiPlateLenght,
                      thickness ], 
               center=true);
        }
      }
    }
    // Lego brick under the plate
    if (withLegoPlate) {
      color("red") {
        translate([0, 0, -(10 + thickness)]) {
          union() {
            cube(size=[ rpiPlateWidth,
                        rpiPlateLenght,
                        thickness ], 
                 center=true);
            cube(size= [12, 94, thickness], 
                 center = true);
            // Lego brick
            translate([0, 0, -10]) {
              rotate([0, 0, 90]) {
                block(width=2,  // In studs (top studs)
                      length=6, // In studs (top studs)
                      height=1, // In "standard block" height
                      type="brick");
              }
            }
          }
        }
      }
    }
  }  
  // Screw holes
  screwBaseDiam = 8.75;
  translate([0, (betweenHole / 2), - thickness]) {
    union() {
      // Countersink on top
      rotate([0, 180, 0]) {
        translate([0, 0, -7.5]) {
          cylinder(h=15, r1=10, r2=0, center=true);
        }
      }
      translate([0, 0, -12]) {
        cylinder(d=projectPlateHoleDiam, h=5 * thickness, $fn=50);
      }
      translate([0, 0, -(thickness + 0.5)]) {
        cylinder(d=screwBaseDiam, h=10, $fn=50, center=true);
      }
    }
  }
  translate([0, -(betweenHole / 2), - thickness]) {
    union() {
      // Countersink on top
      rotate([0, 180, 0]) {
        translate([0, 0, -7.5]) {
          cylinder(h=15, r1=10, r2=0, center=true);
        }
      }
      translate([0, 0, -12]) {
        cylinder(d=projectPlateHoleDiam, h=5 * thickness, $fn=50);
      }
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

// With feet
if (withFeet && !legoPlateOnly) {
  screwBaseDiam = 12;
  translate([0, (betweenHole / 2), - thickness]) {
    difference() {
      translate([0, 0, -(thickness + 0.5)]) {
        cylinder(d=screwBaseDiam, h=10, $fn=50, center=true);
      }
      translate([0, 0, -10]) {
        cylinder(d=projectPlateHoleDiam, h=20, $fn=50);
      }
    }
  }
  translate([0, -(betweenHole / 2), - thickness]) {
    difference() {
      translate([0, 0, -(thickness + 0.5)]) {
        cylinder(d=screwBaseDiam, h=10, $fn=50, center=true);
      }
      translate([0, 0, -10]) {
        cylinder(d=projectPlateHoleDiam, h=20, $fn=50);
      }
    }
  }
}