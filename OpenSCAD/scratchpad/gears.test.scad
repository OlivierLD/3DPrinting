/**
 * Hawaii, Big Island, Kona.
 * Feb 21, 2020.
 */
use <../gears.scad>
use <../SolarPanelStand/mechanical.parts.scad>

// Base diam is given by the number of teeth of the big wheel.
// Seems to be the same: 40 teeth => diam 40
gear_teeth = 60;  // was 40
base_thickness = 10;
base_diam = 60; // 40: Part Cone Diameter at the Cone Base // was 40
bevel_gear_height = 7.27206; // 7.27206: Bevel Gear Height
big_axis_diam = 5;
small_axis_dfiam = 5;

build_together = false;

// Gear test
difference() {
	union() {
		bevel_gear_pair(
				modul=1.0,           // Scale?
				gear_teeth=gear_teeth,       
				pinion_teeth=12,     
				axis_angle=90,       
				tooth_width=7.5,     
				gear_bore=big_axis_diam,  
				pinion_bore=small_axis_dfiam,
				pressure_angle = 20, 
				helix_angle = 0,     // 0: goes both ways, back and forth
				together_built = build_together);
		// Base
		translate([0, 0, -(base_thickness / 2)]) {		
			cylinder(h=base_thickness, d=base_diam, center=true, $fn=100); 
		}
	}
	// Vertical axis
  cylinder(h=base_diam, d=big_axis_diam, center=true, $fn=50);
	translate([-(base_diam / 2), 0, bevel_gear_height]) { 
		rotate([0, 90, 0]) {
			// Horizontal axis
			cylinder(h=base_diam * 1.25, d=small_axis_dfiam, center=true, $fn=50);
		}
	}
	// Screws
	screw_length = 50;
	for (angle=[0, 120, 240]) {
		rotate([0, 0, angle]) {
			translate([8.5, 0, -(screw_length + 5)]) {
				// #cylinder(d=4, h=50, center=true, $fn=40);
				metalScrewHB(diam=4, length=screw_length, top=20);
			}
		}
	}
}
		