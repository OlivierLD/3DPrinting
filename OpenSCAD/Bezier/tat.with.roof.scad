/**
 * @author OlivierLD
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 *
 * 550m sailboat (named "Tête à Toto"). Hull, roof, cockpit, and other options.
 * Options:
 *   - Appendix (rudder(s) and centerboard)
 *     - One or two rudders
 *   - Mast
 *   - Stand Only
 */
 
use <./roof.tat.scad>
use <./tat.scad>

use <./centerBoard.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

WITH_APPENDIX = true;    // Rudder(s) and centerboard
WITH_TWO_RUDDERS = true; // Set to false for one rudder.
WITH_MAST = true;
STAND_ONLY = false;

module rudder(width = 25.0, wlRatio = 6.0, thickness = 3.0) {
    headHeight = 60;
    union() {
        // The blade
        rotate([90, 0, 0]) {
            centerBoard(width = width, wlRatio = wlRatio, thickness = thickness);
        }
        // The head
        translate([-width / 2, -thickness, 0]) {
            cube(size=[width, thickness * 2, headHeight], center=false);
        }
        // the tiller
        translate([-(100 - (width / 2)), 0, headHeight + 3]) {
            rotate([0, 92, 0]) {
                cylinder($fn=30, 100, 2.5, 2.5, center=false);
            }
        }
    }
}

module FullTeteAToto(withBeams=true, withColor=true) {
    
  difference() {  
      union() {
        translate([0, 0, 0]) {
          TeteAToto(withBeams=withBeams, withColor=withColor);
        }
        translate([-100, 0, 105]) { // roof
          rotate([180, 0, 0]) {
            RoofTeteAToto(withBeams=false, withColor=withColor);
          }
        }
        // Mast
        if (WITH_MAST) {
           color("silver", 0.9) {
              translate([-150, 0, 0]) {
                rotate([0, 0, 0]) {
                  cylinder(h=700, r1=8, r2=3, center=false);
                }
              }
           }
        }
        // Boom
        /* 
        color("silver", 0.9) {
          translate([100, 43, 120]) {
            rotate([0, 90, 10]) {
              cylinder(h=500, r=9, center=true);
            }
          }
        }  */
        if (WITH_APPENDIX && !STAND_ONLY) {
          // Center board
          translate([0, 0, 0]) {
              rotate([90, 0, 0]) {
                  centerBoard(width = 37.0, wlRatio = 6.0, thickness = 5.0);
              }
          }
          // Rudder(s)
          translate([290, 0, 12]) {
              if (!WITH_TWO_RUDDERS) {
                  rudder(width = 25.0, wlRatio = 6.0, thickness = 3.0);
              } else {
                  // Port
                  translate([0, -40, 0]) {
                      rotate([-12, 0, 0]) {
                          rudder(width = 25.0, wlRatio = 6.0, thickness = 3.0);
                      }
                  }    
                  // Starboard
                  translate([0, 40, 0]) {
                      rotate([12, 0, 0]) {
                          rudder(width = 25.0, wlRatio = 6.0, thickness = 3.0);
                      }
                  }    
              }
           }
        }
      }
      // Cockpit
      cockpitLen = 200;
      cockpitWidth = 75;
      cockpitDepth = 50;
      translate([0, - cockpitWidth / 2, 20]) {
          cube([cockpitLen, cockpitWidth, cockpitDepth], false);
      }
  }
}


if (STAND_ONLY) {
  difference() {
    union() {
      translate([-100, 0, -20]) {
        cube([20, 180, 50], center=true);
      }
      translate([100, 0, -20]) {
        cube([20, 180, 50], center=true);
      }
      translate([0, -75, -40]) {
        cube([200, 30, 10], center=true);
      }
      translate([0, 75, -40]) {
        cube([200, 30, 10], center=true);
      }
    }
    #FullTeteAToto(true, true);
  }
} else {
  FullTeteAToto(true, true);
}
