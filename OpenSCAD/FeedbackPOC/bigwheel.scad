/**
 * A gear wheel
 * With axis for the rest of the POC (goes through the bulkhead)
 * with the different parts of the hub.
 *
 * @author OlivierLD
 */
 
use <../gears.scad>

BULKHEAD_THISCKNESS = 6; 

wheelThickness = 5;

module gear() {
	spur_gear(modul=1, 
						tooth_number=96,   // orig 30
						width=wheelThickness,           // Thickness
						bore=0,            // Axis diam. 0 means no drilling.
						pressure_angle=30, // On the teeth. orig 20
						helix_angle=0,     // Teeth angle. orig 20
						optimized=true);   // true: thinner inside, with hollows.
}
 
/*
 * Two axis: 
 * - One to maintain the distance between the wheel and the blukhead
 * - One that goes through the blukhead
 */
distFromBulkhead = 9;
firstAxisDiam = 20;
deltaThickness = 1;
secondAxisDiam = 8;
slack = 0.5;
secondAxisLength = BULKHEAD_THISCKNESS + slack; // From first axis top
 
module axis() {
	union() {
		cylinder(d=firstAxisDiam, h=distFromBulkhead, $fn=50, center=true);
		translate([0, 0, (distFromBulkhead + secondAxisLength) / 2]) {
			difference() { // Axis is drilled
				cylinder(d=secondAxisDiam, h=secondAxisLength, $fn=50, center=true);
				drillDiam = 2;
				drillLength = 15;
				translate([0, 0, ((secondAxisLength - drillLength) / 2) + 1]) { // 1, to see the tip
					cylinder(d=drillDiam, h=drillLength, $fn=50, center=true);
				}
			}
		}
	}
}

/**
 * The one on the other side of the bulkhead, to lock the wheel in place.
 */
throughAxisDiam = secondAxisDiam + 4; // The AXIS in the blukhead!! 
hubWasherThickness = 4;
hubWasherDiam = 30;

module hubLock(hollowDiam=2) {
	
	drillDiam = 2;

	difference() {
		union() {
			difference() {
				cylinder(d=throughAxisDiam, h=(BULKHEAD_THISCKNESS + hubWasherThickness), center=true, $fn=50);
				// Hollow part
				translate([0, 0, -(hubWasherThickness / 2)]) {
					cylinder(d=hollowDiam, h=(BULKHEAD_THISCKNESS + slack), center=true, $fn=50);
				}			
			}
			// washer
			translate([0, 0, (BULKHEAD_THISCKNESS / 2) + hubWasherThickness]) {
				difference() {
					cylinder(d=hubWasherDiam, h=hubWasherThickness, $fn=100, center=true);
					// Drill holes here
					for (angle = [0:90:359]) {
						rotate([0, 0, angle]) {
							translate([3 * (hubWasherDiam / 8), 0, 0]) {
								cylinder(d=drillDiam, h=10, $fn=50, center=true);
							}
						}
					}
				}
			}	
		}
		// drilling
		translate([0, 0, (BULKHEAD_THISCKNESS + hubWasherThickness) / 2]) {
			translate([0, 0, hubWasherThickness]) {
				cylinder(d=drillDiam * 2.5, h=5, $fn=50, center=true); // Screw head
			}
			cylinder(d=drillDiam, h=10, $fn=50, center=true);
		}
	}
}

ALL_OPTIONS = 0;

WHEEL_ONLY = 1;
HUB_LOCK_ONLY = 2;
POT_SOCKET = 3;

option = ALL_OPTIONS;

stuck = false;
 
union() { 
	
	if (option == ALL_OPTIONS || option == WHEEL_ONLY) {
		gear();
		translate([0, 0, (wheelThickness - deltaThickness) + (distFromBulkhead / 2)]) {
			axis();
		}
	}

	if (option == ALL_OPTIONS || option == HUB_LOCK_ONLY) {
		translate([0, 0, stuck ? distFromBulkhead - deltaThickness + secondAxisLength : 30]) {
			hubLock(secondAxisDiam);
		}
	}

	if (option == ALL_OPTIONS || option == POT_SOCKET) {
		translate([0, 0, stuck ? distFromBulkhead - deltaThickness + secondAxisLength + hubWasherThickness + (BULKHEAD_THISCKNESS + (2.1 * hubWasherThickness)): 55]) {
			rotate([180, 0, 0]) {
				// 6: potDiam
				potAxisDiam = 6;
				hubLock(potAxisDiam);
			}
		}
	}
}

