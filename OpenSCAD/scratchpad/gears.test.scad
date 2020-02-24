/**
 * Hawaii, Big Island, Kona.
 * Feb 21, 2020.
 */
use <../gears.scad>
use <../SolarPanelStand/mechanical.parts.scad>

// Base diam is given by the number of teeth of the big wheel.
// Seems to be the same: 40 teeth => diam 40
gear_teeth = 60;  // was 40
pinion_teeth = 20; // was 12
base_thickness = 10;
pinion_base_thickness = 10;
pinion_base_diam = 10;
pinion_base_screw_diam = 2;
base_diam = 60; // Part Cone Diameter at the Cone Base, seems to be like gear_teeth // was 40
pinion_diam = pinion_teeth; // like pinion_teeth... Like above
//
bevel_gear_height = 11.0997; // 7.27206; //  Gear Height
big_axis_diam = 5;
small_axis_diam = 5;

build_together = true; 
with_gear = true;
with_pinion = true;

// Gear test

if (!with_gear && !with_pinion) {
	echo("---------------------");
	echo("Nothing to display...");
	echo("---------------------");
} else {
	difference() {
		union() {
			bevel_gear_pair(
					modul=1.0,           // Scale?
					gear_teeth=gear_teeth,       
					pinion_teeth=pinion_teeth,    
					axis_angle=90,       
					tooth_width=7.5,     
					gear_bore=big_axis_diam,  
					pinion_bore=small_axis_diam,
					pressure_angle = 20, 
					helix_angle = 0,     // 0: goes both ways, back and forth
					together_built = build_together,
					with_gear = with_gear,
					with_pinion = with_pinion);
				// Base
			if (with_gear) {
				translate([0, 0, -(base_thickness / 2)]) {		
					cylinder(h=base_thickness, d=base_diam, center=true, $fn=100); 
				}
			}
			if (with_pinion) {
				// Pinion base
				if (pinion_base_thickness > 0) {
					if (!build_together) {
						// TODO X-Offset not right...
						translate([with_gear ? ((base_diam + pinion_base_diam) / 2) + 13.5 : 0, 0, -(pinion_base_thickness / 2)]) {		
							difference() {
								cylinder(h=pinion_base_thickness, d=pinion_base_diam, center=true, $fn=100); 
								// Pinion axis
								cylinder(d=small_axis_diam, h=pinion_base_thickness * 2, center=true, $fn=50);
								// Base screw
								rotate([0, 90, 0]) {
									translate([0, 0, pinion_base_diam / 2]) {
										cylinder(d=pinion_base_screw_diam, h=pinion_base_thickness * 1, center=true, $fn=50);
									}
								}
							}
						}
					} else {
						translate([-((base_diam / 2) + (pinion_base_thickness / 2)), 0, bevel_gear_height]) { 
							rotate([0, 90, 0]) {
								difference() {
									cylinder(h=pinion_base_thickness, d=pinion_base_diam, center=true, $fn=100); 
									// Base screw
									rotate([0, 90, 0]) {
										translate([0, 0, pinion_base_diam / 2]) {
											cylinder(d=pinion_base_screw_diam, h=pinion_base_thickness * 1, center=true, $fn=50);
										}
									}
								}
							}
						}
					}
				}
			}
		}
		if (with_gear) {
			union() {
				// Vertical axis
				cylinder(h=base_diam, d=big_axis_diam, center=true, $fn=50);
				translate([-(base_diam / 2), 0, bevel_gear_height]) { 
					rotate([0, 90, 0]) {
						if (build_together) {
							// Horizontal axis
							cylinder(h=base_diam * 1.25, d=small_axis_diam, center=true, $fn=50);
						}
					}
				}
			}
			// Screws
			screw_length = 50;
			for (angle=[0, 120, 240]) {
				rotate([0, 0, angle]) {
					translate([12, 0, -(screw_length + 5)]) {
						// #cylinder(d=4, h=50, center=true, $fn=40);
						metalScrewHB(diam=4, length=screw_length, top=20);
					}
				}
			}
		}
	}
}
		