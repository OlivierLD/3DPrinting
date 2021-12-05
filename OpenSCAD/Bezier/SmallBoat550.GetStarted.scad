/**
 * @author OlivierLD
 *
 * Small boat, with Bezier curves.
 * This is the OpenSCAD version of its Java conterpart.
 * 
 * Step 1: Just the rails and the keel.
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 */
 
use <./Bezier.scad>

echo(version=version());
echo(">>>>>> For visualization only, not for print!");

extVolume = [550, 300, 159];

// Basic Ctrl Points
rail = [
  [   0.000000,    0.000000, 75.000000 ],
  [   0.000000,   21.428571, 75.0 ],
  [  69.642857,   86.785714, 47.500000 ],
  [ 305.357143, 156.428571,  45.357143 ],
  [ 550.000000,  65.0,       56.000000 ]
];
keel = [
  [   5.000000, 0.000000,  -2.000000 ],
  [ 300.0,      0.000000, -45.0 ],
  [ 550.000000, 0.000000,  10.000000 ]
];


module SmallBoat550() {
  
  increment = 0.01;
  // railPoints
  railPoints = [ for (t = [0:increment:1]) concat(recurse(rail, t)) ];
  // keelPoints
  keelPoints = [ for (t = [0:increment:1]) concat(recurse(keel, t)) ];
  // otherRail
  otherRailPoints = [ for (i = [0 : len(railPoints) - 1]) concat([railPoints[i][0], -railPoints[i][1], railPoints[i][2]]) ];  
    
  allPoints = concat(railPoints, keelPoints, otherRailPoints);
  echo(
    "Len rail:", len(railPoints),
    "Len keel:", len(keelPoints),
    "Total:", len(allPoints)
  );
  
  faces = [for (idx = [0 : len(railPoints) - 2])
    concat(
      [idx, idx + 1, // rail
       len(railPoints) + idx + 1, len(railPoints) + idx ] // keel
    ) ]; 
  otherFaces = [for (idx = [0 : len(otherRailPoints) - 2])
    concat(
      [(2 * len(keelPoints)) + idx, (2 * len(keelPoints)) + idx + 1, // rail
       len(railPoints) + idx + 1, len(otherRailPoints) + idx ] // keel
    ) ]; 
  
  translate([- extVolume[0] / 2, 
             0, 
             0]) {
    // cube(size=extVolume);
    polyhedron( allPoints, concat(faces, otherFaces) );           
  }
}

SmallBoat550();