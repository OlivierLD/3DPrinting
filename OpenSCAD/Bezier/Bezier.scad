/*
 * Bezier.
 * OpenSCAD, another mindset...
 */

function deltaX(from, to) = to[0] - from[0];
function deltaY(from, to) = to[1] - from[1];
function deltaZ(from, to) = to[2] - from[2];

/**
 * Calculate intermediate between 2 points
 * @param from double triplet [x, y, z]
 * @param to   double triplet [x, y, z]
 * @param t double, [0..1]
 */
function calculate3D(from, to, t) = 
  [from[0] + (deltaX(from, to) * t), 
   from[1] + (deltaY(from, to) * t), 
   from[2] + (deltaZ(from, to) * t)];

/**
 * Calculate the bezier point for value t
 * @param ctrl Array of double triplets
 * @param t double [0..1]
 */
function recurse(ctrl, t) =
  (len(ctrl) > 3) ? 
    // len > 3
    recurse([ for (ptIdx = [ 0 : len(ctrl) - 2 ]) calculate3D(ctrl[ptIdx], ctrl[ptIdx + 1], t) ], t) : 
    ((len(ctrl) == 2) ? 
        // len = 2
        calculate3D(ctrl[0], ctrl[1], t) : 
        // len = 3
        calculate3D(calculate3D(ctrl[0], ctrl[1], t), calculate3D(ctrl[1], ctrl[2], t), t) );


// MAIN
    
// 4 Ctrl points
ctrlPoints = [[ -60, -20, 0],
              [   0,  40, 0],
              [  20, -40, 0],
              [ -50,  30, 0]];

t = 0.5;
pt = calculate3D(ctrlPoints[0], ctrlPoints[1], t);

echo("For t=", t, " => X:", pt[0], " Y:", pt[1], " Z:", pt[2]);
echo ("Sizeof ctrl points:", len(ctrlPoints));

/*
for (t = [0:0.01:1.001]) {
  pt = calculate3D(ctrlPoints[0], ctrlPoints[1], t);
  echo("For t=", t, " => X:", pt[0], " Y:", pt[1], " Z:", pt[2]);
}
*/

// newArray = [];
/*
newArray = [ for (i = [0: len(ctrlPoints) - 1]) ctrlPoints[i] ];
echo("NewArray:", newArray);
*/

// t = 0.1;
// ctrl = ctrlPoints;

/**
if (len(ctrl)  > 3) {
  inside = [ for (ptIdx = [ 0 : len(ctrl) - 2 ]) 
    calculate3D(ctrl[ptIdx], ctrl[ptIdx + 1], t) ];

  echo("Inside:", inside);
}
**/    
    
// An example:    
// for (t = [0:0.01:1.001]) {
for (t = [0:0.1:1]) {
  pt = recurse(ctrlPoints, t);
  // pt = recurse([[ -60, -20, 0], [ 0,  40, 0], [  20, -40, 0]], t);
  echo("For t=", t, " => X:", pt[0], " Y:", pt[1], " Z:", pt[2]);
}

    