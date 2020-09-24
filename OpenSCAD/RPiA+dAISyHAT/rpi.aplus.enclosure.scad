/*
 * Raspberry Pi A+ Enclosure, with a dAISy HAT on it.
 * Check https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_3aplus_case.pdf
 * and https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_3aplus.pdf
 */
use <../oliv.utils.scad>;

echo(version=version());

// RPI A+ Dimensions 65.18 x 56.10

// Box dimensions
slack = 2; // Slack required, to be able to stick the raspberry in its box.
outerWidth = 72.5 + slack; // 72.5, + 2mm slack
outerLength = 62.5 + slack; // 62.5, + 2mm slack
outerHeight = 30; // 25.5;
outerRadius = 6;
boxThickness = 2.5;

basePegDiam = 6;
basePegHeight = 3.2;
basePegInnerDiam = 1.75; // 2.5;

module box() {
	difference() {
		roundedRect([outerWidth,
								 outerLength,
								 outerHeight ],
								outerRadius, $fn=100);

		translate([0, 0, boxThickness]) {
			roundedRect([outerWidth - (boxThickness * 2),
									 outerLength - (boxThickness * 2),
									 (1.01 * outerHeight) - (boxThickness * 1) ],
									outerRadius - boxThickness, $fn=100);
		}
    // Drill holes, to cool the RPi.
    translate([0, 0, -(outerHeight + 10) / 2]) {
      translate([10, 10, 0]) {
        cylinder(d=10, h=10, $fn=40);
      }
      translate([-10, 10, 0]) {
        cylinder(d=10, h=10, $fn=40);
      }
      translate([10, -10, 0]) {
        cylinder(d=10, h=10, $fn=40);
      }
      translate([-10, -10, 0]) {
        cylinder(d=10, h=10, $fn=40);
      }
    }
	}
}

// Pegs
widthBetweenPegs = 49.3;
lengthBetweenPegs = 58.1; // 57.7

module pegs() {
	color("green") {
		translate([ (lengthBetweenPegs / 2) + slack,
						    (widthBetweenPegs / 2) - slack,
						    - 1 - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight + 1, d1=basePegDiam * 1.5, d2=basePegDiam, center=true, $fn=100);
		}
		translate([ (lengthBetweenPegs / 2) + slack,
						    - (widthBetweenPegs / 2) - slack,
						   - 1 - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight + 1, d1=basePegDiam * 1.5, d2=basePegDiam, center=true, $fn=100);
		}
		translate([ - (lengthBetweenPegs / 2) + slack,
						    (widthBetweenPegs / 2) - slack,
						    - 1 - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight + 1, d1=basePegDiam * 1.5, d2=basePegDiam, center=true, $fn=100);
		}
		translate([ - (lengthBetweenPegs / 2) + slack,
						    - (widthBetweenPegs / 2) - slack,
						    - 1 - (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=basePegHeight + 1, d1=basePegDiam * 1.5, d2=basePegDiam, center=true, $fn=100);
		}
	}
}         

module drillPegs() {
	drillLength = basePegHeight * 1.1;
	color("red") {
		translate([ (lengthBetweenPegs / 2) + slack,
								(widthBetweenPegs / 2) - slack,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=drillLength, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
		translate([ (lengthBetweenPegs / 2) + slack,
								- (widthBetweenPegs / 2) - slack,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=drillLength, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
		translate([ - (lengthBetweenPegs / 2) + slack,
								(widthBetweenPegs / 2) - slack,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=drillLength, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
		translate([ - (lengthBetweenPegs / 2) + slack,
								- (widthBetweenPegs / 2) - slack,
								- (outerHeight / 2) + (boxThickness + basePegHeight)]) {
			cylinder(h=drillLength, d1=basePegInnerDiam, d2=basePegInnerDiam, center=true, $fn=100);
		}
	}
}  

module boxPegsAndScrews() {
	difference() {
		union() {
			box();
			pegs();
		}
		drillPegs();
	}
}

// To drill USB socket through the blukhead (bigger than USB itself)
module USB() {
	cube(size=[17, 7.5, 7], center=true);
	//         |   |    |
	//         |   |    h
	//         |   depth
	//         w
}

// To drill RCA socket through the blukhead (bigger than RCA itself)
module RCA() {
	cylinder(d=6.5, h=7.5, $fn=30, center=true);
}

// To drill HDMI socket through the blukhead (bigger than HDMI itself)
module HDMI() {
	hdmiHeight = 6.0;
	hdmiWidth = 16;
	hCorner = 2.5;
	vCorner = 4;
	points = [
	  [ 0, hdmiHeight - vCorner ],         // 0
	  [ 0, hdmiHeight ],                   // 1
	  [ hdmiWidth, hdmiHeight ],           // 2
	  [ hdmiWidth, hdmiHeight - vCorner ], // 3
	  [ hdmiWidth - hCorner, 0 ],          // 4
    [ hCorner, 0]                        // 5	
	];
	paths = [[ 0, 1, 2, 3, 4, 5 ]];
	
	linear_extrude(height=10, center=true) {
	  polygon(points, paths, convexity=10);
	}
}

// To drill Mini-USB socket through the blukhead (bigger than mini-USB itself)
module powerSupply() {
	usbHeight = 3.9;
	usbWidth = 8.5;
	hCorner = 2.0;
	vCorner = 2.5;
	points = [
	  [ 0, usbHeight - vCorner ],        // 0
	  [ 0, usbHeight ],                  // 1
	  [ usbWidth, usbHeight ],           // 2
	  [ usbWidth, usbHeight - vCorner ], // 3
	  [ usbWidth - hCorner, 0 ],         // 4
    [ hCorner, 0]                      // 5	
	];
	paths = [[ 0, 1, 2, 3, 4, 5 ]];
	
	linear_extrude(height=10, center=true) {
	  polygon(points, paths, convexity=10);
	}
}

// To drill SDCard socket through the blukhead (bigger than SDCard itself)
module SDCard() {
	cube(size=[15, 4, 12.5], center=true);
	/*         |   |  |
	 *         |   |  card slot witdh
	 *         |   card slot thickness
	 *         fake card length 
	 *         
	 */
}

module oneHeaderPin() {
	union() {
		color("black") {
			cube(size=[2.5, 2.5, 2.5], center=true);
		}
		translate([0, 0, 3.24 - (11.46 / 2)]) {
			color("silver") {
				cube(size=[0.5, 0.5, 11.46], center=true);
			}
		}
	}
}

module pinHeader(nbPins) {
	translate([-(nbPins * 2.5) / 2, 0, 0]) {
		for (i = [1:nbPins]) {
			translate([(2.5 / 2) + ((i-1) * 2.5), 0, 0]) {
				oneHeaderPin();
			}
		}
	}
}

// RPi A+, with room for the connectors
module rpiAPlusWithConnectors() {
	union() {
		translate([slack, -slack, 0]) {
			translate([665, -524.3, 2.75]) {
				color("green") {
//				import("/Users/olivierlediouris/repos/3DPrinting/Raspberry_Pi_A+_board/A+_Board.stl");
  				import("../../Raspberry_Pi_A+_board/A+_Board.stl");
				}
			}
			translate([35, 4.5, -2.4]) {
				rotate([0, 0, 90]) {
					USB();
				}
			} 
			translate([20.7, -30, -3.0]) {
				rotate([0, 90, 90]) {
					RCA();
				}
			}
			translate([-9, -30, -6.25]) {
				rotate([90, 0, 0]) {
					HDMI();
				}
			}
			translate([-26.65, -30, -7.4]) {
				rotate([90, 0, 0]) {
					powerSupply();
				}
			}
			translate([-33, 0.5, -8.5]) {
				rotate([90, 0, 0]) {
					SDCard();
				}
			}
		}
	}
}

/**
 * Customized for the dAISy HAT, Antenna connector
 */
module protoPiHat(slack=1) {
	union() {
    plateWidth = 65;
    plateLength = 56.38;
    plateThickness = 1.7;
		// The plate
		color("red") {
			roundedRect([plateWidth,
									 plateLength,
									 plateThickness ],
									4.8, $fn=100);
		}
		// The connector
		translate([-0.2, 24.3, -(8 + 1.7) / 2]) {
			rotate([0, 0, 0]) {
				color("black") {
					cube(size=[51.2, 5, 8], center=true);
				}
			}
		}
    // Antenna Connector
    squareWidth = 6.6;
    squareHeight = 6.6;
    antennaConnectorDiam = 6.6;
    antennaConnectorLength = 8;
    squareThickness = 1.78;
    antennaAxisOffset = 13;
    color("gold") {
      translate([-(plateWidth / 2) + antennaAxisOffset, 
                 -(plateLength / 2) - (squareThickness / 2), 
                 2]) { 
        rotate([90, 0, 0]) {
          cube(size=[squareWidth * slack, squareHeight * slack, squareThickness * (slack == 1 ? slack : 2 * slack)], center=true);
          translate([0, 0, 0]) {
            difference() {
              cylinder(d=antennaConnectorDiam * slack, h=antennaConnectorLength, $fn=50);            
              cylinder(d=1, h=antennaConnectorLength * 1.1, $fn=50);
            }
          }
        }
      }
    }
	}
}

// A lid.
lidThickness = 2.5;
module lid() {
	difference() {
		union() {
			roundedRect([outerWidth,
									 outerLength,
									 lidThickness ],
									outerRadius, $fn=100);

			translate([0, 0, -boxThickness]) {
				difference() {
					roundedRect([outerWidth - (boxThickness * 2),
											 outerLength - (boxThickness * 2),
											 lidThickness ],
											outerRadius - boxThickness, $fn=100);
					roundedRect([outerWidth - (boxThickness * 4),
											 outerLength - (boxThickness * 4),
											 lidThickness ],
											outerRadius - boxThickness, $fn=100);
				}
			}
			// Key ring
			translate([(outerWidth / 2) + 0, (outerLength / 2), 0]) {
				rotate([0, 0, 0]) {
					difference() {
						cylinder(d=10, h=boxThickness, $fn=50, center=true);
						cylinder(d=4, h=boxThickness * 1.1, $fn=50, center=true);
					}
				}
			}
		}
		// space for a nut, bottom right corner
		translate([(outerWidth / 2) - (boxThickness * 2.5), 
		           -((outerLength / 2) - (boxThickness * 2.5)), 
		            -boxThickness]) {
			cylinder(d=10, h=boxThickness, $fn=30, center=true);
		}
		
	}
}

ALL_PARTS = 0;

BOX_ONLY = 1;
LID_ONLY = 2;
ALL_PARTS_WITH_CONTENT = 3;

option = BOX_ONLY;

appart = 5.0; //

ONE_BY_ONE = false;

if (!ONE_BY_ONE) {
  if (option != ALL_PARTS_WITH_CONTENT) {
    difference() {
      union() {
        if (option == ALL_PARTS || option == BOX_ONLY) {
          boxPegsAndScrews();
        }
        if (option == ALL_PARTS || option == LID_ONLY) {
          translate([0, 0, appart + ((boxThickness + outerHeight) / 2)]) {
            lid();
          }
        }
      }
      translate([0, 0, (30 - outerHeight) / 2]) {
        union() { // Add a '%' in front to see the box's content, remove it to print.
          rpiAPlusWithConnectors(); // Add % to see just the rPi
          translate([slack, -slack, 5.35]) {
            rotate([0, 0, 0]) {
              protoPiHat(1.1);
            }
          }
        }
      }
    }
  } else {
    union() {
      boxPegsAndScrews();
      translate([0, 0, appart + ((boxThickness + outerHeight) / 2)]) {
        lid();
      }
    }
    translate([0, 0, (30 - outerHeight) / 2]) {
      union() { // Add a '%' in front to see the box's content, remove it to print.
        rpiAPlusWithConnectors(); // Add % to see just the rPi
        translate([slack, -slack, 5.35]) {
          rotate([0, 0, 0]) {
            protoPiHat(1.1);
          }
        }
      }
    }
  }
} else {
  //rpiAPlusWithConnectors();
  //oneHeaderPin();
  //pinHeader(5);
  //protoPiHat();
}
