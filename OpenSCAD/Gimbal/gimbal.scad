/**
 * A gimbal for a small magnetometer
 *
 * HMC5883L is about 17.78mm x 19.05mm x 1.5mm
 * Between hole centers 0.52" -> 13.208mm
 * Screw radius 0.05 -> 1.27mm -> diam 2.54mm
 * Corner radius (0.7 - 0.52) / 2 -> 2.286mm
 * See https://learn.adafruit.com/adafruit-hmc5883l-breakout-triple-axis-magnetometer-compass-sensor?view=all#breakout-board-design-5-4
 *
 * @author OlivierLD
 */
 use <../mechanical.parts.scad>

echo(version=version());

module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}
 
module bracket(ep = 5, diam = 5, thick = 5) {
	rotate([0, 90, 0]) {
		translate([-ep, 0, 0]) {
			difference() {
				union() {
					translate([ep / 2, 0, 0]) {
						cube(size = [ep, (4 * ep) + diam, thick], center=true);
					}
					rotate([0, 0, 0]) {
						translate([ep, 0, 0]) {
							cylinder(h=ep, d=(diam + (2*ep)), $fn=50, center=true);
						}
					}
				}
				translate([(2 * ep), 0, 0]) {
					cube(size = [2 * ep, (4 * ep) + diam, 1.1 * thick], center=true);
				}
				translate([(1 * ep), 0, 0]) {
					rotate([0, 0, 0]) {
						cylinder(d=diam, h=(thick * 1.1), $fn=50, center=true);
					}
				}
			}
			// TODO Drill screw holes...
		}
	}
}

HOLLOW_OPTION = 1;
PILLAR_OPTION = 2;

pcb_socket_option = PILLAR_OPTION;

module mainBucket(diameter,
									 height,
									 thickness,
									 bottomThickness = 3,
									 sideAxisLen = 20,
									 sideAxisDiam = 4,
									 washerThickness = 2) {
	union() {											
		difference() {												
			cylinder(h=height,
							 d=diameter,
							 $fn=100,
							 center=true);
			translate([0, 0, (pcb_socket_option == HOLLOW_OPTION ? bottomThickness : thickness)]) {
				cylinder(h=height,
								 d=diameter - (2 * thickness),
								 $fn=100,
								 center=true);
			}
			if (pcb_socket_option == HOLLOW_OPTION) {
				// Socket for a HMC5883L
				if (true || withPCB) { 
					translate([-2.5, 0, -9]) {
						cube(size=[15, 17, 20], center=true);
					}
					// Screws
					rotate([0, 0, 0]) {
						translate([(19.05 / 2) - 2.286, (17.78 / 2) - 2.286, 0]) {
							cylinder(h=10, d=2.0, $fn=50, center=true);
						}
						translate([(19.05 / 2) - 2.286, -((17.78 / 2) - 2.286), 0]) {
							cylinder(h=10, d=2.0, $fn=50, center=true);
						}
					}
				}
			}
		}
		
		if (pcb_socket_option == PILLAR_OPTION) {
			// Pillars
			// TODO Fix cylinder length
			difference() {
				translate([0, 0, 0]) {
					rotate([0, 0, 0]) {
						translate([(19.05 / 2) - 2.286, (17.78 / 2) - 2.286, 0]) {
							cylinder(h=bottomThickness, d=5.0, $fn=50, center=true);
						}
						translate([(19.05 / 2) - 2.286, -((17.78 / 2) - 2.286), 0]) {
							cylinder(h=bottomThickness, d=5.0, $fn=50, center=true);
						}
					}
				}
				// Screws
				rotate([0, 0, 0]) {
					translate([(19.05 / 2) - 2.286, (17.78 / 2) - 2.286, 0]) {
						cylinder(h=bottomThickness * 1.1, d=2.0, $fn=50, center=true);
					}
					translate([(19.05 / 2) - 2.286, -((17.78 / 2) - 2.286), 0]) {
						cylinder(h=bottomThickness * 1.1, d=2.0, $fn=50, center=true);
					}
				}
			}
		}

		// Axis on the side
		rotate([90, 0, 0]) {
			translate([0, (height / 2) * 0.75, (diameter / 2) + (sideAxisLen / 2) - thickness]) {
				cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
				 // Washer at the end
				 translate([0, 0, -(1 + (washerThickness / 2))]) {
					 cylinder(h=washerThickness, d=sideAxisDiam * 2, center=true, $fn=40);
				 }
			}
			translate([0, (height / 2) * 0.75, -((diameter / 2) + (sideAxisLen / 2) - thickness)]) {
				cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
				 // Washer at the end
				 translate([0, 0, +(1 + (washerThickness / 2))]) {
					 cylinder(h=washerThickness, d=sideAxisDiam * 2, center=true, $fn=40);
				 }
			}
		}
	}		
}
 
module firstRing(intDiameter, 
								  extDiameter, 
								  thickness, 
								  grooveDiam = 4,
									sideAxisLen = 20,
									sideAxisDiam = 4,
									washerThickness = 2) {
	 grooveLen = 1.1 * (extDiameter - intDiameter) / 2;
	 union() {
		 difference() {
			 cylinder(d=extDiameter, h=thickness, center=true, $fn=100);
			 cylinder(d=intDiameter, h=thickness * 1.1, center=true, $fn=100);
			 rotate([90, 0, 0]) {
				 translate([0, 
										thickness / 2, // z
										((extDiameter / 2) - (grooveLen / 2))]) { 
					 cylinder(d=grooveDiam, h=grooveLen, $fn=50, center=true);
				 }
				 translate([0, 
										thickness / 2, // z
										-((extDiameter / 2) - (grooveLen / 2))]) { 
					 cylinder(d=grooveDiam, h=grooveLen, $fn=50, center=true);
				 }
			 }
		 }
		 // Axis
		 rotate([90, 0, 90]) {
			 translate([0, 0, (extDiameter / 2) + (sideAxisLen / 2) - 0]) {
		 		 cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
				 // Washer at the end
				 translate([0, 0, 1 + (washerThickness / 2)]) {
					 cylinder(h=washerThickness, d=sideAxisDiam * 2, center=true, $fn=40);
				 }
	 		 }
			 translate([0, 0, -((extDiameter / 2) + (sideAxisLen / 2) - 0)]) {
				 cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
				 // Washer at the end
				 translate([0, 0, -(1 + (washerThickness / 2))]) {
					 cylinder(h=washerThickness, d=sideAxisDiam * 2, center=true, $fn=40);
				 }
			 }
		 }
	 }
 }
 
module outerRing(intDiameter, 
								  extDiameter, 
								  height, 
								  grooveDiam = 4) {
	 grooveLen = 1.1 * (extDiameter - intDiameter) / 2;
	 union() {
		 difference() {
			 cylinder(d=extDiameter, h=height, center=true, $fn=100);
			 cylinder(d=intDiameter, h=height * 1.1, center=true, $fn=100);
			 rotate([90, 0, 90]) {
				 translate([0, 
										height / 2, // z
										((extDiameter / 2) - (grooveLen / 2))]) { 
					 cylinder(d=grooveDiam, h=grooveLen, $fn=50, center=true);
				 }
				 translate([0, 
										height / 2, // z
										-((extDiameter / 2) - (grooveLen / 2))]) { 
					 cylinder(d=grooveDiam, h=grooveLen, $fn=50, center=true);
				 }
			 }
		 }
	 }
}

module fixingFeet(l, w, h, screwDiam) {
	translate([ 0, 0, h / 2]) {
		rotate([0, 0, 0]) {
			difference() {
				cube(size=[l, w, h], center=true);
				// Screw
				translate([0, 0, -10]) { // PRM this 10
					metalScrewCS(screwDiam, h, h);
				}
			}
		}
	}
}
 
mainBucketDiam = 40;
mainBucketHeight = 40;
mainBucketThickness = 3;
axisDiam = 5;

firstRingExtDiam = 75;
firstRingIntDiam = 55;
firstRingThickness = 10;

outerRingIntDiam = 85;
outerRingExtDiam = 95;
outerRingHeight = 35;

firstDeltaZ = ((mainBucketHeight / 2) * 0.75) - axisDiam;
secondDeltaZ = -(outerRingHeight - firstDeltaZ - firstRingThickness) / 2;

apart = false;
deltaApart = 10;

withColor = false;
withPCB = true;

swingFirstRing = [-20, 20]; // Degrees
swingBucket = [-15, 15];    // Degrees

animate = false;

function timeToTilt(t, mini, maxi) =
	animate ? lookup(t, [
		[ 0, maxi ], // max
		[ 0.125, maxi / 2 ],
		[ 0.25, 0],  // null
		[ 0.375, mini / 2 ],
		[ 0.5, mini],   // min
		[ 0.625, mini / 2 ],
		[ 0.75, 0],  // null
		[ 0.875, maxi / 2 ],
		[ 1, maxi ]  // max
	]) : 0;

NONE = -1;
ALL_ELEMENTS = 0;

BUCKET_ONLY = 1;
FIRST_RING_ONLY = 2;
OUTER_RING_ONLY = 3;

option = ALL_ELEMENTS;

union() {
	firstRingSwing = timeToTilt($t, swingFirstRing[0], swingFirstRing[1]);
	bucketSwing = timeToTilt($t, swingBucket[0], swingBucket[1]);

	yOffset = firstRingThickness * sin(firstRingSwing);
	translate([0, yOffset, 0]) {

		rotate([firstRingSwing, 0, 0]) {
			color(withColor ? "red" : undef) {
				xOffset = ((mainBucketHeight / 2) * 0.75) * sin(bucketSwing);
				if (option == ALL_ELEMENTS || option == BUCKET_ONLY) {
					translate([-xOffset, 0, 0]) { // -(mainBucketHeight / 2) * 0.75]) {
						rotate([0, bucketSwing, 0]) {
							mainBucket(mainBucketDiam, 
												 mainBucketHeight, 
												 mainBucketThickness, 
												 bottomThickness = 20,
												 sideAxisLen = 22, 
												 sideAxisDiam = axisDiam);
							if (withPCB) {
								color("DodgerBlue", 0.75) {
									rotate([0, 0, 0]) {
										translate([0, 0, 11]) { // TODO Parameterize the 11...
											// PCB
											difference() {
												roundedRect([19.05, 17.78, 1.5], 2.286);
												// Screws
												rotate([0, 0, 0]) {
													translate([(19.05 / 2) - 2.286, (17.78 / 2) - 2.286, 0]) {
														cylinder(h=2, d=2.54, $fn=50, center=true);
													}
													translate([(19.05 / 2) - 2.286, -((17.78 / 2) - 2.286), 0]) {
														cylinder(h=2, d=2.54, $fn=50, center=true);
													}
												}
												// Write PCB ID on it ?
												rotate([0, 0, -90]) {
													color("yellow") {
														translate([0, 0, (1.5 / 2)]) {
															linear_extrude(2.0, center=true, convexity = 4) {
																resize([17.78 * 0.75, 0], auto=true) {
																	text("HMC5883L", valign="center", halign="center");
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			color(withColor ? "blue" : undef) {
				if (option == ALL_ELEMENTS || option == FIRST_RING_ONLY) {
					translate([0, 0, firstDeltaZ - (apart ? (1 * deltaApart) : 0)]) { 
						difference() {
						firstRing(firstRingIntDiam, 
											firstRingExtDiam, 
											firstRingThickness, 
											grooveDiam = axisDiam * 1.1,
											sideAxisLen = 20,
											sideAxisDiam = axisDiam);
						// Engrave N ad S
						rotate([0, 0, -90]) {
							color("yellow") {
								yOffset = (firstRingIntDiam / 2) + ((firstRingExtDiam - firstRingIntDiam) / 4);
								zOffset = 4  + (1.5 / 2);
								translate([0, yOffset, zOffset]) {
									linear_extrude(2.0, center=true, convexity = 4) {
										resize([20 * 0.5, 0], auto=true) {
											text("- N -", valign="center", halign="center");
										}
									}
								}
								translate([0, -yOffset, zOffset]) {
									linear_extrude(2.0, center=true, convexity = 4) {
										resize([20 * 0.5, 0], auto=true) {
											text("- S -", valign="center", halign="center");
										}
									}
								}
							}
						}
					}

						// Brackets
						if (false) {
							rotate([0, 0, 90]) {
								bracketEp = 5;
								translate([((firstRingIntDiam / 2) + ((firstRingExtDiam - firstRingIntDiam) / 4)), 0, bracketEp]) {
									bracket(ep = bracketEp, diam = axisDiam * 1.1, thick = bracketEp);
								}
								translate([-((firstRingIntDiam / 2) + ((firstRingExtDiam - firstRingIntDiam) / 4)), 0, bracketEp]) {
									bracket(ep = bracketEp, diam = axisDiam * 1.1, thick = bracketEp);
								}
							}
						}
					}
				}
			}
		}
	}
	color(withColor ? "green" : undef) {
		if (option == ALL_ELEMENTS || option == OUTER_RING_ONLY) {
			translate([0, 0, secondDeltaZ - (apart ? (2 * deltaApart) : 0)]) {
				difference() {
					union() {
						outerRing(outerRingIntDiam, 
											outerRingExtDiam, 
											outerRingHeight, 
											grooveDiam = axisDiam * 1.1);
						footLen = 14;
						footWidth = 12;
						footHeight = 10;
						footFixingScrewDiam = 4;
						for (angle=[0, 120, 240]) {
							rotate([0, 0, angle]) {
								translate([(outerRingExtDiam / 2) + (footLen / 2) - 2, 0, -17.5]) {
									rotate([0, 0, 180]) {
										fixingFeet(footLen, footWidth, footHeight, footFixingScrewDiam);
									}
								}
							}
						}
					}
					// Hole for the wires
					// echo("First Delta Z:", firstDeltaZ);
					// echo("Second Delta Z:", secondDeltaZ);
					rotate([0, 90, 0]) {
						translate([secondDeltaZ + (outerRingHeight - firstDeltaZ), 0, -((outerRingIntDiam / 2) + ((outerRingExtDiam - outerRingIntDiam) / 4))]) {
							cylinder(d=10, h=10, center=true, $fn=50);
						}
					}
				}
			}
		}
	}
}
 