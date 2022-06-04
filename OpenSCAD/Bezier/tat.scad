/**
 * @author OlivierLD
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 * Points/parameters generation, see https://github.com/OlivierLD/raspberry-coffee/blob/master/Project-Trunk/BoatDesign
 */
 
use <./Bezier.scad>
use <./BoatDesign.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

// All the boat definition in there
include <./tat.prms.scad>

module TeteAToto(withBeams=true, withColor=true) {
  BoatDesign(extVolume, rail, keel, withBeams, withColor);
}

TeteAToto(true, true);
