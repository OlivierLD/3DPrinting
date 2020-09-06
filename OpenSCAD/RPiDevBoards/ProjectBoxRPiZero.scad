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
        cube(size=[ projectPlateWidth,
                    (projectPlateLength / 2) - (rpiPlateLenght / 2),
                    thickness ], 
             center=true);
        rotate([90, 0, 0]) {  
          translate([0, -raspiLower / 2, 6]) {
            cube(size=[projectPlateWidth, (raspiLower + thickness), thickness], center=true);
          }
        }
    }
    
    translate([0, 
               - ((projectPlateLength / 2) - ((projectPlateLength - rpiPlateLenght) / 4)), 
               0]) {
        cube(size=[ projectPlateWidth,
                    (projectPlateLength / 2) - (rpiPlateLenght / 2),
                    thickness ], 
             center=true);
        rotate([90, 0, 0]) {  
          translate([0, -raspiLower / 2, -6]) {
            cube(size=[projectPlateWidth, (raspiLower + thickness), thickness], center=true);
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
  translate([0, (betweenHole / 2), - thickness]) {
    cylinder(d=projectPlateHoleDiam, h=2 * thickness, $fn=50);
  }
  translate([0, -(betweenHole / 2), - thickness]) {
    cylinder(d=projectPlateHoleDiam, h=2 * thickness, $fn=50);
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
