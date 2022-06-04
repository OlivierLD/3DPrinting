/**
 * @author OlivierLD
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 */
 
use <./Bezier.scad>
use <./BoatDesign.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

// All the boat definition in there
// include <./SmallBoat.550.prms.scad>
include <./tri.9.14.prms.scad>
// include <./outrigger.prms.scad>

module Tri914(withBeams=true, withColor=true) {
  BoatDesign(extVolume, rail, keel, withBeams, withColor);
}

Tri914();