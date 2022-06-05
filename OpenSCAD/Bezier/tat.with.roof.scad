/**
 * @author OlivierLD
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 */
 
use <./roof.tat.scad>
use <./tat.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

module FullTeteAToto(withBeams=true, withColor=true) {
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
    color("silver", 0.9) {
      translate([-150, 0, 0]) {
        rotate([0, 0, 0]) {
          cylinder(h=700, r=6, center=false);
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
    } */
  }
}

FullTeteAToto(true, true);
