/**
 * A gear wheel
 * With axis for the rest of the POC (goes through the bulkhead)
 * with the different parts of the hub.
 *
 * Optional small wheel gear.
 *
 * See 'option' variable down the script for printing.
 *
 * @author OlivierLD
 */
 
use <../gears.scad>

BULKHEAD_THISCKNESS = 6; 

wheelThickness = 5;

module gear(teeth=96, opt=true) {
	spur_gear(modul=1, 
						tooth_number=teeth,// orig 30
						width=wheelThickness,           // Thickness
						bore=0,            // Axis diam. 0 means no drilling.
						pressure_angle=30, // On the teeth. orig 20
						helix_angle=0,     // Teeth angle. orig 20
						optimized=opt);    // true: thinner inside, with hollows.
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
 
module big_wheel_axis() {
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

module small_wheel_axis(length=10) {
	servoAxisDiam = 6; // Just like the pot...
	axisLength = length; // TODO To be adjusted!!
	difference() {
		cylinder(d=throughAxisDiam, h=axisLength, center=true, $fn=50);
		// Hollow part
		translate([0, 0, 0.5]) {
			cylinder(d=servoAxisDiam, h=axisLength, center=true, $fn=50);
		}			
		// Axis screw, diam 2mm
		axisScrewDiam = 2;
		axisScrewLength = 4;
		translate([(servoAxisDiam / 2) + ((throughAxisDiam - servoAxisDiam) / 4), 0, 0]) {
			rotate([0, 90, 0]) {
				cylinder(d=axisScrewDiam, h=1.2 * axisScrewLength, center=true, $fn=50);
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
				cylinder(d=throughAxisDiam, h=(BULKHEAD_THISCKNESS + (0 * hubWasherThickness)), center=true, $fn=50);
				// Hollow part
				translate([0, 0, slack * 0.5]) {
					cylinder(d=hollowDiam, h=(BULKHEAD_THISCKNESS + slack), center=true, $fn=50);
				}			
			}
			// washer
			translate([0, 0, (BULKHEAD_THISCKNESS / 2) + (hubWasherThickness / 2)]) {
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
			translate([0, 0, hubWasherThickness - 2]) { // -2: Actual depth
				screwHeadDiam = 5.5; // was drillDiam * 2.5...
				cylinder(d=screwHeadDiam, h=5, $fn=50, center=true); // Screw head
			}
			cylinder(d=drillDiam, h=10, $fn=50, center=true);
		}
	}
}

module smallGear() {
	axisLength = 10;
	difference() {
		union() {
			gear(teeth=30, opt=false);
			translate([0, 0, (wheelThickness) + (axisLength / 2)]) {
				small_wheel_axis(axisLength);
			}
		}
		// Servo axis screw and screw head socket
		screwDiam = 2.5;
		screwHeadDiam = 5.5;
		screwHeadDepth = 3;
		translate([0, 0, (wheelThickness / 2)]) {
			cylinder(d=screwDiam, h=2*wheelThickness, center=true, $fn=50);
		}
		translate([0, 0, -0 * wheelThickness]) {
			cylinder(d=screwHeadDiam, h=screwHeadDepth, center=true, $fn=50);
		}
	}
}

ALL_PARTS = 0;

BIG_WHEEL_ONLY = 1;
HUB_LOCK_ONLY = 2;
POT_SOCKET = 3;

SMALL_WHEEL_ONLY = 4;

option = ALL_PARTS;

stuck = false;
 
union() { 
	
	if (option == ALL_PARTS || option == BIG_WHEEL_ONLY) {
		gear(opt=true);
		translate([0, 0, (wheelThickness - deltaThickness) + (distFromBulkhead / 2)]) {
			big_wheel_axis();
		}
	}

	if (option == ALL_PARTS || option == SMALL_WHEEL_ONLY) {
		translate([(96 + 30) / 2, 0, 0]) { // 96: big wheel teeth, 30: small wheel teeth
			rotate([0, 0, 6]) { // 6 = (360 / 30) * 0.5 - Rotate 1/2 teeth
				smallGear();
			}
		}
	}

	if (option == ALL_PARTS || option == HUB_LOCK_ONLY) {
		translate([0, 0, stuck ? distFromBulkhead - deltaThickness + secondAxisLength : 30]) {
			hubLock(secondAxisDiam);
		}
	}

	if (option == ALL_PARTS || option == POT_SOCKET) {
		translate([0, 0, stuck ? distFromBulkhead - deltaThickness + secondAxisLength + hubWasherThickness + (BULKHEAD_THISCKNESS + (2.1 * hubWasherThickness)): 55]) {
			rotate([180, 0, 0]) {
				// 6: potDiam
				potAxisDiam = 6;
				hubLock(potAxisDiam);
			}
		}
	}
}
