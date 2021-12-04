/**
 * @author OlivierLD
 *
 * Small boat, with Bezier curves.
 * This is the OpenSCAD version of its Java conterpart.
 * 
 * Step 2: Bezier frames derived from rails and keel.
 *
 * OpenSCAD Manual at https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
 * Some usefull functions at https://github.com/openscad/scad-utils/blob/master/lists.scad
 */
 
use <./Bezier.scad>

echo(version=version());
// echo(">>>>>> For visualization only, not for print!");

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

function reverse(list) = 
  [for (i = [len(list) - 1 : -1 : 0]) list[i]];

module SmallBoat550() {
  
  increment = 0.025;
  // railPoints
  railPoints = [ for (t = [0:increment:1]) concat(recurse(rail, t)) ];
  // keelPoints
  keelPoints = [ for (t = [0:increment:1]) concat(recurse(keel, t)) ];
    

  translate([- extVolume[0] / 2, 
             0, 
             0]) {
    color("silver", 0.95) {       
      for (idx = [0 : len(railPoints) - 2]) {
        // echo("idx:", idx);
        ctrlPointsPort_1 = [ 
          [railPoints[idx][0], railPoints[idx][1], railPoints[idx][2]], // rail
          [railPoints[idx][0], railPoints[idx][1], keelPoints[idx][2]], // under the rail, at the keel level
          [keelPoints[idx][0], keelPoints[idx][1], keelPoints[idx][2]]  // keel
        ];
        ctrlPointsPort_2 = [
          [railPoints[idx + 1][0], railPoints[idx + 1][1], railPoints[idx + 1][2]], 
          [railPoints[idx + 1][0], railPoints[idx + 1][1], keelPoints[idx + 1][2]], 
          [keelPoints[idx + 1][0], keelPoints[idx + 1][1], keelPoints[idx + 1][2]]
        ];
        ctrlPointsStbd_1 = [
          [railPoints[idx][0], -railPoints[idx][1], railPoints[idx][2]], 
          [railPoints[idx][0], -railPoints[idx][1], keelPoints[idx][2]], 
          [keelPoints[idx][0],  keelPoints[idx][1], keelPoints[idx][2]]
        ];
        ctrlPointsStbd_2 = [
          [railPoints[idx + 1][0], -railPoints[idx + 1][1], railPoints[idx + 1][2]], 
          [railPoints[idx + 1][0], -railPoints[idx + 1][1], keelPoints[idx + 1][2]], 
          [keelPoints[idx + 1][0],  keelPoints[idx + 1][1], keelPoints[idx + 1][2]]
        ];
        
        // echo("ctrlPointsPort_1:", ctrlPointsPort_1);
        bezierPoints_1_port = [ for (t = [0:increment:1]) concat(recurse(ctrlPointsPort_1, t)) ];
        bezierPoints_2_port = [ for (t = [0:increment:1]) concat(recurse(ctrlPointsPort_2, t)) ];
        
        bezierPoints_1_stbd = [ for (t = [0:increment:1]) concat(recurse(ctrlPointsStbd_1, t)) ];
        bezierPoints_2_stbd = [ for (t = [0:increment:1]) concat(recurse(ctrlPointsStbd_2, t)) ];

        // Polyhedron here
        allPoints = concat(bezierPoints_1_port, 
                           reverse(bezierPoints_1_stbd), 
                           bezierPoints_2_port, 
                           reverse(bezierPoints_2_stbd));
        // echo("After:", len(allPoints), " points");
        faces = [ for (i = [0 : (2 * len(bezierPoints_1_port)) - 2])
          concat(
            [ i, i+1, (2 * len(bezierPoints_1_port)) + i + 1, (2 * len(bezierPoints_1_port)) + i ]
          ) ];
        hull() {      
          polyhedron(allPoints, faces, 1);
        }
      }
    }
  }
}

SmallBoat550();