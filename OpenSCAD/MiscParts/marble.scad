/*
 * Spheres, marbles, etc
 * https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
 */
 module marble(diam) {
   sphere(r=(diam/2), $fn=100);
 }
 
 marble(23);
 
 