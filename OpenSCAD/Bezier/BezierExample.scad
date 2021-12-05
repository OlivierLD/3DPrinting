/**
 * Bezier at work, example
 */
 
use <./Bezier.scad>

// MAIN, as an example.
    
// 4 Ctrl points
ctrlPoints = [[ -60, -20, 0],
              [   0,  40, 0],
              [  20, -40, 0],
              [ -50,  30, 0]];

t = 0.5;
pt = calculate3D(ctrlPoints[0], ctrlPoints[1], t);

echo(str("For t=", t, " => X:", pt[0], " Y:", pt[1], " Z:", pt[2]));
echo (str("Sizeof ctrl points array : ", len(ctrlPoints)));

/*
for (t = [0:0.01:1.001]) {
  pt = calculate3D(ctrlPoints[0], ctrlPoints[1], t);
  echo(str("For t=", t, " => X:", pt[0], " Y:", pt[1], " Z:", pt[2]));
}
*/

/*
// Clone array
newArray = [ for (i = [0: len(ctrlPoints) - 1]) ctrlPoints[i] ];
echo(str("NewArray: ", newArray));
*/

// An example:    
// for (t = [0:0.01:1.001]) {
for (t = [0:0.1:1]) {
  pt = recurse(ctrlPoints, t);
  // pt = recurse([[ -60, -20, 0], [ 0,  40, 0], [  20, -40, 0]], t);
  echo(str("For t=", t, " => X:", pt[0], " Y:", pt[1], " Z:", pt[2]));
}


