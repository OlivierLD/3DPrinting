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
      Outrigger(withBeams=withBeams, withColor=withColor);
    }
    translate([0, 360, 0]) {  // starboard
      Outrigger(withBeams=withBeams, withColor=withColor);
    }
  }
}

FullTri(true, true);
