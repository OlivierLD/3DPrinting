/*
 * Embout de rail (Pordin-Nancq)
 * With a sphere. with scale (=> rugby ball shape)
 */

// Globals rail
top_thickness = 4;
bottom_thickness = 11;
top_width = 32;
bottom_width = 10; // TODO Check that

module rail(length) {
  union() {
    // Top
    translate([0, 0, (bottom_thickness + (top_thickness / 2))]) {
        cube(size = [length, top_width, top_thickness], center = true);
    }
    // Bottom
    translate([0, 0, bottom_thickness / 2]) {
        cube(size = [length, bottom_width, bottom_thickness], center = true);
    }
  }
}

module the_stuff(sphere_diam, thickness) {
  difference() {
    scale([1, 0.85, 1]) { // Rugby ball shape !
      sphere(d = sphere_diam / 1.0, $fn=100);
    }
    // Left-right screen
    translate([(-sphere_diam / 2), 0, 0]) {
      cube(size=[sphere_diam, sphere_diam, sphere_diam], center=true);
    }
    // Top-bottom screen
    translate([0, 0, - thickness]) {
      cube(size=[sphere_diam, sphere_diam, sphere_diam], center=true);
    }
  }
}

rail_length = 100;
sphere_diam = 100;
on_top = 5;
inside = 10;
  
difference() {

  translate([-inside, 0, (- sphere_diam / 2) + (top_thickness + bottom_thickness) + on_top ]) {
    the_stuff(sphere_diam, (top_thickness + bottom_thickness) + on_top);
  }

  translate ([-(rail_length / 2), 0, 0]) {
    rail(rail_length);
  }
}

