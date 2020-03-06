/*
 * Example 3, from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#polyhedron
 */
module prism(l, w, h) {
  polyhedron(
    points = [
      [0,0,0], // 0
      [l,0,0], // 1  
      [l,w,0], // 2
      [0,w,0], // 3
      [0,w,h], // 4
      [l,w,h]  // 5
    ],
    faces = [
      [0,1,2,3], // Bottom, A
      [5,4,3,2], // Front, B 
      [0,4,5,1], // Back, the slope, C
      [0,3,4],   // Left, vertical, D
      [5,2,1]    // Right, vertical, E
    ]
  );
       
  // preview unfolded (do not include in your function)
  z = 0.08;
  separation = 2; // Between prism anf first flattened panel.
  border = .2; // Between panels, when flattened.
  translate([0, w + separation, 0])
    cube([l, w, z]);
  translate([0, w + separation+w+border, 0])
    cube([l, h, z]);
  translate([0, w + separation + w + border + h + border, 0])
    cube([l, sqrt(w * w + h * h), z]);
  translate([l + border, w + separation + w + border + h + border, 0])
    polyhedron(
      points = [
        [0, 0, 0], 
        [h, 0, 0], 
        [0, sqrt(w * w + h * h), 0], 
        [0, 0, z], 
        [h, 0, z], 
        [0, sqrt(w * w + h * h), z]
      ],
      faces = [
        [0, 1, 2], 
        [3, 5, 4], 
        [0, 3, 4, 1], 
        [1, 4, 5, 2], 
        [2, 5, 3, 0]
      ]
    );
  translate([0 - border, w + separation + w + border + h + border, 0])
    polyhedron(
      points = [
        [0, 0, 0],
        [0 - h, 0, 0],
        [0, sqrt(w * w + h * h), 0], 
        [0, 0, z],
        [0 - h, 0, z],
        [0, sqrt(w * w + h * h), z]
      ],
      faces = [
        [1, 0, 2],
        [5, 3, 4],
        [0, 1, 4, 3],
        [1, 2, 5, 4],
        [2, 0, 3, 5]
      ]
    );
}
   
w = 100;
l = 50;
h = 30;

diam = 10;
// Draw a prism
if (false) {
    prism(w, l, h);
}

// Prism with a hole in it.
if (false) {
	difference() {
			prism(w, l, h);
			translate([w/2, l/2, h/2]) {
					cylinder(h=2*h, d1=diam, d2=diam, center=true); 
			}
	}
}

// A tube
if (false) {
    translate([w/2, l/2, h/2]) {
        difference() {  
            cylinder(h=2*h, d1=diam, d2=diam, center=true);
            cylinder(h=2*h, d1=diam*0.9, d2=diam*0.9, center=true);
        }
    }
}
 
module roundedRect(size, radius) {  // more elegant version
  linear_extrude(height=size.z, center=true) {
    offset(radius) offset(-radius) {
      square([size.x, size.y], center = true);
    }
  }
}

if (false) {
    roundedRect([10, 10, 1], 3);
}

module ellipse(D, d) {
	resize([D, d]) {
		circle(d=(D + d) / 2, $fn=100);
	}
}

// Simple ellipse
if (false) {
	ellipse(200, 150);
}

// Elliptic Tube
if (false) {
  linear_extrude(height=50, center=true) {
		difference() {
			ellipse(200, 150);
			ellipse(180, 130);
		}
	}
}

// Elliptic half tube
if (true) {
	intersection() {
		linear_extrude(height=50, center=true) {
			difference() {
				ellipse(200, 150);
				ellipse(180, 130);
			}
		}
		translate([0, 150 / 4, 0]) {
			cube([200, 150 / 2, 50], center=true);
		}
	}
}




