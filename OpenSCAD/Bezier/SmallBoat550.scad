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

// All the boat definition in there
// include <./SmallBoat.550.prms.scad>
include <./tri.9.14.scad>
// include <./outrigger.prms.scad>

function reverse(list) = 
  [for (i = [len(list) - 1 : -1 : 0]) list[i]];


module SmallBoat550(withBeams=true, withColor=true) {
  
  increment = 0.025;
  // railPoints
  railPoints = [ for (t = [0:increment:1]) recurse(rail, t) ];
  // keelPoints
  keelPoints = [ for (t = [0:increment:1]) recurse(keel, t) ];
    
  translate([- extVolume[0] / 2, 
             0, 
             0]) {
    for (idx = [0 : len(railPoints) - 2]) {
      // echo(str("idx:", idx));
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
      bezierPoints_1_port = [ for (t = [0:increment:1]) recurse(ctrlPointsPort_1, t) ];
      bezierPoints_2_port = [ for (t = [0:increment:1]) recurse(ctrlPointsPort_2, t) ];
      
      bezierPoints_1_stbd = [ for (t = [0:increment:1]) recurse(ctrlPointsStbd_1, t) ];
      bezierPoints_2_stbd = [ for (t = [0:increment:1]) recurse(ctrlPointsStbd_2, t) ];

      // Polyhedron here
      allPoints = concat(bezierPoints_1_port, 
                         reverse(bezierPoints_1_stbd), 
                         bezierPoints_2_port, 
                         reverse(bezierPoints_2_stbd));
      // echo("After:", len(allPoints), " points");
      faces = [ for (i = [0 : (2 * len(bezierPoints_1_port)) - 2])
          [ i, i+1, (2 * len(bezierPoints_1_port)) + i + 1, (2 * len(bezierPoints_1_port)) + i ]
        ];
      color(withColor ? "cyan" : "silver", 0.9) {
        hull() {      
          polyhedron(allPoints, faces, 1);
        }
      }
    }
    
    if (withBeams) {
      for (idx = [0 : len(railPoints) - 2]) {
        ctrlPointsBeam_1 = [
            [railPoints[idx][0], railPoints[idx][1], railPoints[idx][2]], // rail
            [railPoints[idx][0], 0, railPoints[idx][2] + (2 * railPoints[idx][1] * 0.15)], // center
            [railPoints[idx][0], -railPoints[idx][1], railPoints[idx][2]] // other rail
        ];
        ctrlPointsBeam_2 = [
            [railPoints[idx + 1][0], railPoints[idx + 1][1], railPoints[idx + 1][2]], // rail
            [railPoints[idx + 1][0], 0, railPoints[idx + 1][2] + (2 * railPoints[idx + 1][1] * 0.15)], // center
            [railPoints[idx + 1][0], -railPoints[idx + 1][1], railPoints[idx + 1][2]] // other rail
        ];
        bezierPointsBeam_1 = [ for (t = [0:increment:1]) recurse(ctrlPointsBeam_1, t) ];
        bezierPointsBeam_2 = [ for (t = [0:increment:1]) recurse(ctrlPointsBeam_2, t) ];
          
        allPoints = concat(bezierPointsBeam_1, bezierPointsBeam_2);
        faces = [ for (i = [0 : len(bezierPointsBeam_1) - 2 ]) 
                         [ i, 
                           i+1, 
                           i + (len(bezierPointsBeam_1)) + 1, 
                           i + (len(bezierPointsBeam_1))
                         ] 
        ];
        color(withColor ? "orange" : "silver", 0.9) {
          hull() {
            polyhedron(allPoints, faces, 1);
          }
        }
      }
    }
  }
}

SmallBoat550(withBeams=true, withColor=true);
