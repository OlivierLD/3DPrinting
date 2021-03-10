/**
 * Logo test
 */
 
logo = "./RPiLogo.png";

difference() {
  translate([0, 0, -5]) {
     cube(size=[40, 40, 5], center=true);
  }

  scale([0.1, 0.1, 0.2]) {
    color("green") {
      rotate([0, 0, 0]) {
        surface(file=logo, invert=true, center=true);
      }
    }
  }
}

/*
color("red") {
  linear_extrude(height=5, center=true, convexity=10) {
    import(file=logo);
  }
}
*/
