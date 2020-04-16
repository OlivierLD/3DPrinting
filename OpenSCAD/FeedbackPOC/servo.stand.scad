/**
 * @author OlivierLD
 * 
 * A test, a stand for a servoParallax900_00005()
 */
use <../mechanical.parts.scad>
use <./bigwheel.scad>

servoXOffset = 29.1; // From the servo's specs. See in mechanical.parts.scad
servoZOffset = 10;
standThickness = 6;

deeper = 1;

// ServoCity 615286, https://www.servocity.com/32p-24t-c1-spline-servo-mount-gears-metal
// Wheel Pitch Diam: 0.750"
// smallWheelPitchDiam = 25.4 * 0.750;

// 3D printed one
smallWheelPitchDiam = 30;

betweenWheelAxis = (96 + smallWheelPitchDiam) / 2;

verticalBoardWidth = 50;
verticalBoardHeight = 70;
horizontalStandLength = 50;

module servoSocket() {
	difference() {
		cube(size=[standThickness, verticalBoardWidth, verticalBoardHeight], center=true);
		translate([- (standThickness / 2) - (servoXOffset) + deeper, 0, servoZOffset]) {
			rotate([0, 90, 0]) {
				color("darkgrey", 0.95) {
					servoParallax900_00005();
				}
				translate([0, 0, 5]) {
					color("silver") {
						servoParallax900_00005(drillPattern=true, drillDiam=2.5, drillLength=10);
					}
				}
				// Servo axis? Uncomment below if visualization is needed.
				// cylinder(d=2, h=100, center=true, $fn=50);
			}
		}
	}
	// Other servo axis, for verification
	otherAxis = false;
	if (otherAxis) {
		translate([0, 0, servoZOffset]) {
			rotate([0, 90, 0]) {
				cylinder(d=2, h=100, center=true, $fn=50);
			}
		}
	}
}

// Horizontal stand
module socketStand() {
	rotate([0, 90, 0]) {
		translate([(verticalBoardHeight / 2), 
							 -(verticalBoardWidth / 2), 
							 -(horizontalStandLength / 2)]) {
			union() {							 
				cube(size=[standThickness, verticalBoardWidth, horizontalStandLength]);
				difference() {
					translate([-standThickness, 0, (verticalBoardWidth / 2) - (3 * standThickness / 2)]) {
						cube(size=[standThickness, verticalBoardWidth, 3 * standThickness]);
					}
					rotate([90, 0, 0]) {
						cylinderDiam = standThickness * 1.5;
						translate([-standThickness, // Height
										   (horizontalStandLength / 2) - (3 * standThickness / 2), 
						           -verticalBoardWidth * 1.05]) {
							cylinder(h=verticalBoardWidth * 1.1, d=cylinderDiam, $fn=50);
						}
						translate([-standThickness, // Height
										   (horizontalStandLength / 2) + (3 * standThickness / 2), 
						           -verticalBoardWidth * 1.05]) {
							cylinder(h=verticalBoardWidth * 1.1, d=cylinderDiam, $fn=50);
						}
					}
				}
			}
		}
	}
}

module fullPlate() {
	
	totalHeight = 130;
	difference() {
		union() {
			servoSocket();
			translate([-(standThickness / 2), 
								 -(verticalBoardWidth / 2), 
			           +(verticalBoardHeight / 2)]) {
				cube(size=[standThickness, verticalBoardWidth, (totalHeight - verticalBoardHeight)]);
			}
		}
		gearThickness = 5;
		distFromPlate = 9;
		slack = 0.5;
		
		rotate([0, 90, 180]) {
			translate([-servoZOffset - betweenWheelAxis, 
								 0, 
								 -(standThickness / 2) - (1 * gearThickness) - (1 * distFromPlate) + (0.6 * slack)]) {
				color("green") {
					allGears(stuck = true);
				}
			}
		}
	}
}

// Pot bracket, 25mm wide, mini inner width = (2 * washer-thickness) + wallThickness + ~6mm
// Here (2 * 4) + 6 + 6 = 20mm, + whatever.

minPotPlateHeight = 20 + 3;

topPlateWidth = 25;
topStandThickness = 6;
potPlateOffset = 20; // minimum hubWasherDiam / 2


module topPlateScrews() {
	screwDiam = 2.5;
	screwLen = 30;
	
	rotate([0, 90, 0]) {
		translate([-(potPlateOffset + 5), topPlateWidth / 3, -5]) {
			cylinder(d=screwDiam, h=screwLen, $fn=50);
		}
		translate([-(potPlateOffset + 5), -topPlateWidth / 3, -5]) {
			cylinder(d=screwDiam, h=screwLen, $fn=50);
		}
	}
}

module topPlate() {
  bottomToFirstPlateTop = 8.2 + 1.3; // + 2.2;
  standThickness = topStandThickness;
	
	plateLength = potPlateOffset + 20;

	difference() {
		translate([0, 0, -potPlateOffset + 20 + 10]) {
			cube(size=[standThickness, topPlateWidth, plateLength], center=true);
		}
		// #topPlateScrews();
		translate([- (standThickness / 2) - bottomToFirstPlateTop, 0, 0]) {
			rotate([0, 90, 0]) {
				rotate([0, 0, -90]) {
					color("silver") {
						B10K();
					}
				}
			}
		}
	}
}

TOP_PLATE_ONLY = 1;
NO_TOP_PLATE = 2;
WITH_TOP_PLATE = 3;

module b10kBracket(option=WITH_TOP_PLATE) {
	standLength = 20;

	if (option == WITH_TOP_PLATE || option == TOP_PLATE_ONLY) {
		rotate([0, -90, -90]) {
			translate([-(topStandThickness / 2), (topPlateWidth / 2), -potPlateOffset]) {
				difference() {
					topPlate();
					topPlateScrews();
				}
			}
		}
	}
	
	if (option != TOP_PLATE_ONLY) {	
		translate([0, 0, -topStandThickness]) {
			difference() {
				cube(size=[topPlateWidth, standLength, minPotPlateHeight + topStandThickness]);
				translate([(topPlateWidth / 2), standLength + 10, 0]) {
					rotate([0, 90, 0]) {
						linear_extrude(height=topPlateWidth * 1.1, center=true) {
							resize([2 * minPotPlateHeight, (2 * standLength)]) {
								circle(d=20, $fn=100);
							}
						}
						rotate([90, 0, 0]) {
							translate([-15, 0, 0]) {
								topPlateScrews();
							}
						}
					}
				}
			}
		}
	}
}


SERVO_SOCKET_ONLY = 1;
SOCKET_STAND_ONLY = 2;
POT_BRACKET_ONLY = 3; // Not to print
TOP_POT_PLATE_ONLY = 4;

ALL_PARTS = 10;

// Change at will with the values above
option = ALL_PARTS;

if (option == ALL_PARTS) {
  fullPlate();
  socketStand();
	rotate([0, 90, 0]) {
		rotate([0, 0, -90]) {
			translate([-(topPlateWidth / 2), 
								 // -52.85, // TODO Replace this one, betweenWheelAxis and friends
								 - (betweenWheelAxis - servoZOffset),
								 -(standThickness / 2) - (minPotPlateHeight)]) {
				b10kBracket();
			}
		}
	}
} else if (option == SERVO_SOCKET_ONLY) {
  // servoSocket();
	fullPlate();
	rotate([0, 90, 0]) {
		rotate([0, 0, -90]) {
			translate([-(topPlateWidth / 2), 
								 // -52.85, // TODO Replace this one, betweenWheelAxis and friends
								 - (betweenWheelAxis - servoZOffset),
								 -(standThickness / 2) - (minPotPlateHeight)]) {
				b10kBracket(NO_TOP_PLATE);
			}
		}
	}
} else if (option == SOCKET_STAND_ONLY) {
	difference() {
		socketStand();
		servoSocket();
	}
} else if (option == TOP_POT_PLATE_ONLY) {
	b10kBracket(option=TOP_PLATE_ONLY);
} else if (option == POT_BRACKET_ONLY) {
	b10kBracket(option=WITH_TOP_PLATE);
}
