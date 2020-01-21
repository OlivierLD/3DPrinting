//
// An example: Text embossing
//
module roundedRect(size, radius) {  
  linear_extrude(height=size.z, center=true) {
    offset(radius) offset(-radius) {
      square([size.x, size.y], center = true);
    }
  }
}

// Text?
text="Oliv did it";
// TODO Find text dimesions.
difference() {  
    roundedRect([100, 50, 5], 10);
    linear_extrude(height=5, center=true) {
        rotate([0, 0, 0]) {
            translate([-25, -5, 10]) {
                text(text, 10);
            }
        }
    }
}
