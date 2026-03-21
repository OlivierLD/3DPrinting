/*
 * Fridge parts.
 * Eye only
 */
 difference() {
   rotate([0, 0, 0]) {
     translate([0, 0, 0]) {
       cube([2.5, 9, 12], center=true);
     }
   }
   rotate([0, 90, 0]) {
     translate([1, -1.8, 0]) {
       cylinder(h=5, r=4.5 / 2, center=true, $fn=100);
     }
   }
   translate([0, 0, 7]) {
     rotate([-20, 0, 0]) {
       cube([3, 15, 5], center=true);
     }
   }
 }