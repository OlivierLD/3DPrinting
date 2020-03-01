/**
 * A gimbal for a small magnetometer
 * HMC5883L is about 18mm x 20mm x 1.5mm
 *
 * @author OlivierLD
 */
 
 module roundedRect(size, radius) {  
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}
 
 module mainBucket(diameter,
									 height,
									 thickness,
									 sideAxisLen = 20,
									 sideAxisDiam = 4) {
	union() {											
		difference() {												
			cylinder(h=height,
							 d=diameter,
							 $fn=100,
							 center=true);
			translate([0, 0, thickness]) {
				cylinder(h=height,
								 d=diameter - (2 * thickness),
								 $fn=100,
								 center=true);
			}
		}
		// Axis on the side
		rotate([90, 0, 0]) {
			translate([0, (height / 2) * 0.75, (diameter / 2) + (sideAxisLen / 2) - thickness]) {
				cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
			}
			translate([0, (height / 2) * 0.75, -((diameter / 2) + (sideAxisLen / 2) - thickness)]) {
				cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
			}
		}
	}		
}
 
 module firstRing(intDiameter, 
								  extDiameter, 
								  thickness, 
								  grooveDiam = 4,
									sideAxisLen = 20,
									sideAxisDiam = 4) {
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
	 		 }
			 translate([0, 0, -((extDiameter / 2) + (sideAxisLen / 2) - 0)]) {
				 cylinder(h=sideAxisLen, d=sideAxisDiam, center=true, $fn=40);
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
		 // Nothing else in the union for now...
		 // TODO Feet...
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
withPCB = false;

swingFirstRing = [-20, 20]; // Degrees
swingBucket = [-15, 15];    // Degrees

function timeToTilt(t, mini, maxi) =
	lookup(t, [
		[ 0, maxi ], // max
		[ 0.125, maxi / 2 ],
		[ 0.25, 0],  // null
		[ 0.375, mini / 2 ],
		[ 0.5, mini],   // min
		[ 0.625, mini / 2 ],
		[ 0.75, 0],  // null
		[ 0.875, maxi / 2 ],
		[ 1, maxi ]  // max
	]);

ALL_ELEMENTS = 0;

BUCKET_ONLY = 1;
FIRST_RING_ONLY = 2;
OUTER_RING_ONLY = 3;

option = ALL_ELEMENTS;

union() {
	if (withPCB) {
		translate([0, 0, 30]) {
			// PCB
			roundedRect([20, 18, 1.5], 5);
		}
	}
	
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
												 sideAxisLen = 22, 
												 sideAxisDiam = axisDiam);
						}
					}
				}
			}
			color(withColor ? "blue" : undef) {
				if (option == ALL_ELEMENTS || option == FIRST_RING_ONLY) {
					translate([0, 0, firstDeltaZ - (apart ? (1 * deltaApart) : 0)]) { 
						firstRing(firstRingIntDiam, 
											firstRingExtDiam, 
											firstRingThickness, 
											grooveDiam = axisDiam * 1.1,
											sideAxisLen = 20,
											sideAxisDiam = axisDiam);
					}
				}
			}
		}
	}
	color(withColor ? "green" : undef) {
		if (option == ALL_ELEMENTS || option == OUTER_RING_ONLY) {
			translate([0, 0, secondDeltaZ - (apart ? (2 * deltaApart) : 0)]) {
				outerRing(outerRingIntDiam, 
									outerRingExtDiam, 
									outerRingHeight, 
									grooveDiam = axisDiam * 1.1);
			}
		}
	}
}
 