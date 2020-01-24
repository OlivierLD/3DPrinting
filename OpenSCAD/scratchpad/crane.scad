/**
 * From https://www.instructables.com/id/Animating-with-OpenSCAD/
 * Start animation, 20 FPS, 360 steps.
 */
//Variable describing the cranes
//The height of the crane units are whatever could be feet
crane_h = 200;
//Distance from center to the base from each crane
crane_r = 160;
//Size of the base of the crane
crane_b = 10;

//Degrees of tilt
crane_tilt = 15;

//Cable radius.  Big enough to see. 2 foot is ridiculous
cable_r = 2;

//Radius of the effector. Once again big enough to see
eff_r = 10;

//Height of the rod
rod_l = 220;
//Radius of rod. Once again big enough to see
rod_r = 4;

/*
* This array represents x,y,z locations that the crane
* moves to.  Note that the array is doubly indexed.  So that creates
* an array of vectors. Which are themselves an array of three
*/
loc = [
    [0,0,10],
    [50,50,10],
    [-50,50,50],
    [-50,-50,10],
    [40,-40,30],
    [40,40,10],
    [50,0,40],
    [0,0,10]
      ];


/*
* This is the secret sauce.  The lookup function does interpolations
* between entries.  A lookup table has a series of keys and values.
* The keys must be monotonic. That is they all increase in value from
* one to the next or they all decrease in value.  Then when a key is
* passed that is in between two key values.  The lookup function
* interpolates between the two.
*
* The key values are given values from 0 to 1 by dividing by the 
* len of the array of vectors.  This makes the keys represent
* possible values of $t.  The values are points in the loc array.
*
* The lookup table can have variables as values.  So we effectively
* have three lookup tables. See below for example with constants.
*
* 
*/
function xyz(t,i) = 
    lookup(t, [
    [0/len(loc),loc[0][i]],
    [1/len(loc),loc[1][i]],
    [2/len(loc),loc[2][i]],
    [3/len(loc),loc[3][i]],
    [4/len(loc),loc[4][i]],
    [5/len(loc),loc[5][i]],
    [6/len(loc),loc[6][i]],
    [7/len(loc),loc[7][i]],

]);

/*
* This is the actual way I wrote this function.  I rewrote it in the
* above way because I thought it might be clearer what is happening
*/
//function xyz(t,i) = 
//  lookup(len(loc)*t, [
//  [0,loc[0][i]],
//  [1,loc[1][i]],
//  [2,loc[2][i]],
//  [3,loc[3][i]],
//  [4,loc[4][i]],
//  [5,loc[5][i]],
//  [6,loc[6][i]],
//  [7,loc[7][i]],
//
//]);
//

/*
* I am showing these as an example of one variable in the lookup
* table.  This approach is fine if one has one variable or several
* unrelated variables.  Because x,y, and z represent points that the
* effector is being moved to, the array approach is easier to make
* changes to the path.
*
* The cranes module would be called like this.
* cranes(X($t),Y($t),Z($t));
*/
function X(t) = 
    lookup(t, [
    [0/len(loc),0],
    [1/len(loc),50],
    [2/len(loc),-50],
    [3/len(loc),-50],
    [4/len(loc),40],
    [5/len(loc),40],
    [6/len(loc),50],
    [7/len(loc),0],

]);function Y(t) = 
    lookup(t, [
    [0/len(loc),0],
    [1/len(loc),50],
    [2/len(loc),50],
    [3/len(loc),-50],
    [4/len(loc),-40],
    [5/len(loc),40],
    [6/len(loc),0],
    [7/len(loc),0],

]);function Z(t) = 
    lookup(t, [
    [0/len(loc),10],
    [1/len(loc),10],
    [2/len(loc),50],
    [3/len(loc),10],
    [4/len(loc),30],
    [5/len(loc),10],
    [6/len(loc),40],
    [7/len(loc),10],

]);

//Call the main module with variables that depend on $t
cranes(xyz($t,0),xyz($t,1),xyz($t,2));


module cranes(x,y,z)
{
    //Create three cranes and cables 120 degrees apart
    for(i=[0:120:359])
    {
        rotate([0,0,i])
        translate([0,crane_r,0])
        crane();
        //Create the cable going down to the effector
        cable(i,x,y,z);
        //Create the cable going to the top of the rod.
        cable(i,x,y,z+rod_l);
    }
    //Create the rod
    color("brown")
    translate([x,y,z])
    cylinder(r=rod_r,h=rod_l,center=false);
    //Create the effector
    color("red")
    translate([x,y,z])
    sphere(eff_r);
}

/*
* Tricky way to make a cable.  We hull between a cable sized
* sphere at the top of the crane and one at the x,y,z location
* of the other end (effector or top of rod).
*/
module cable(ang,x,y,z)
{
    color("silver")
    hull()
    {
        rotate([0,0,ang])
        translate([0,crane_r,0])
        rotate([crane_tilt,0,0])
        translate([0,0,crane_h])
        sphere(cable_r);
        translate([x,y,z])
        sphere(cable_r);
    }
}

//Simple crane
module crane()
{
    color("black")
    rotate([crane_tilt,0,0])
    cylinder(r1=crane_b,r2=3,h=crane_h,$fn=4);
}