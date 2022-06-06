/*
 * Bezier.
 * OpenSCAD, another mindset...
 *
 * To be used with a "use <./Bezier.scad>"
 */

function deltaX(from, to) = to[0] - from[0];
function deltaY(from, to) = to[1] - from[1];
function deltaZ(from, to) = to[2] - from[2];

/**
 * Calculate intermediate 3D point between 2 3D-points, at value t
 * @param from double triplet [x, y, z]
 * @param to   double triplet [x, y, z]
 * @param t double, [0..1]
 */
function calculate3D(from, to, t) = 
  [from[0] + (deltaX(from, to) * t), 
   from[1] + (deltaY(from, to) * t), 
   from[2] + (deltaZ(from, to) * t)];

/**
 * Calculate the bezier 3D-point for value t
 * @param ctrl Array of at least 2 double triplets [[x1, y1, z1], [x2, y2, z2], ... ]
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
        calculate3D(calculate3D(ctrl[0], ctrl[1], t), calculate3D(ctrl[1], ctrl[2], t ), t) 
    );

