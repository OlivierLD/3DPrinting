/* A 4400 mAh power bank */

module roundedRect(size, radius, center=true) {  
	linear_extrude(height=size.z, center=center) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = center);
		}
	}
}

module PowerBank4400() {
  union() {
    color("white") {
      roundedRect([41, 98, 22], 5, $fn=100); 
    }
        // Text
    rotate([0, 0, 0]) {
      translate([0, -40, 11]) {
         color("black") {
           text("4400 mAh", halign="center", size=3.5);
         }
       }
     }
  }
}

// PowerBank4400();
