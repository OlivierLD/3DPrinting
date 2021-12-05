/**
 * @author OlivierLD
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 */
 
use <./Tri.914.scad>
use <./Outrigger.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

module FullTri(withBeams=true, withColor=true) {
  union() {
    translate([0, 0, 0]) {
      Tri914(withBeams=withBeams, withColor=withColor);
    }
    translate([0, -360, 0]) { // port
      rotate([-10, 0, 0]) {
        Outrigger(withBeams=withBeams, withColor=withColor);
      }
    }
    translate([0, 360, 0]) {  // starboard
      rotate([+10, 0, 0]) {
        Outrigger(withBeams=withBeams, withColor=withColor);
      }
    }
    // Cylindric amrs
    color("silver", 0.9) {
      translate([-150, 0, 65]) {
        rotate([90, 0, 0]) {
          cylinder(h=720, r=20, center=true);
        }
      }
      translate([150, 0, 65]) {
        rotate([90, 0, 0]) {
          cylinder(h=720, r=20, center=true);
        }
      }
    }
    // Mast
    color("silver", 0.9) {
      translate([-150, 0, 680]) {
        rotate([0, 0, 0]) {
          cylinder(h=1200, r=9, center=true);
        }
      }
    }
    // Boom
    color("silver", 0.9) {
      translate([100, 0, 120]) {
        rotate([0, 90, 0]) {
          cylinder(h=500, r=9, center=true);
        }
      }
    }
  }
}

FullTri(true, true);
