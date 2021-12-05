/**
 * @author OlivierLD
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 */
 
// use <./Bezier.scad>
// use <./BoatDesign.scad>
use <./Tri.914.scad>
use <./Outrigger.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

// All the boat definition in there
// include <./SmallBoat.550.prms.scad>
// include <./tri.9.14.scad>
// include <./outrigger.prms.scad>

module FullTri(withBeams=true, withColor=true) {
  union() {
    translate([0, 0, 0]) {
      Tri914(withBeams=withBeams, withColor=withColor);
    }
    translate([0, -360, 0]) {
      Outrigger(withBeams=withBeams, withColor=withColor);
    }
    translate([0, 360, 0]) {
      Outrigger(withBeams=withBeams, withColor=withColor);
    }
  }
}

FullTri(true, true);
