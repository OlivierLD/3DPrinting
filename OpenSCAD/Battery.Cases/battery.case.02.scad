/**
 * Housing for 
 * - MCP73871_USB_Solar
 *   - 5V power supply (from solar panel or wall charger)
 *   - USB socket
 * - PowerBooster 1000C
 *   - USB Power supply
 *   - Slide switch 
 * - 6600 mAh LiPo battery
 *
 * MetalSheet Screws: M2.6 * 6
 */
 
 
use <../mechanical.parts.scad> 
 
// internal box dimensions, mm
intWidth = 73;
intHeight = 20; 
intDepth = 100;
wallThickness = 2.5;

centerPoleXOffset = 9;
 
module batteryHousingBox() {

	// Get PoweBoost dimensions from the code. See the functions in mechanical.parts.scad
	pbDims = getPowerBooser1000cDims();
	pbWidth          = pbDims[0]; // 36.2;
	pbHeight         = pbDims[1]; // 22.86;	
	pbBoardThickness = pbDims[2]; // 1.7;
	feetHeight = 4;

	// Get MCP dimensions from the code. See the functions in mechanical.parts.scad
	mcpDims = getMcpUsbSolarDims();
	mcpWidth          = mcpDims[0]; // 40.64;
	mcpHeight         = mcpDims[1]; // 33.1447;	
	mcpBoardThickness = mcpDims[2]; // 1.7;
	//feetHeight = 4;

	// Booster Offsets !!
	switchOffset = -2;
	usbOffset = -5;

  fontSize = 2.5;
	
	difference() {
		// The box
		union() {
			difference() {
				cube(size=[intDepth + (2 * wallThickness), intWidth + (2 * wallThickness), intHeight + (2 * wallThickness)], center=true);
				translate([0, 0, wallThickness + 0.5]) {
					cube(size=[intDepth, intWidth, intHeight + 1], center=true);
				}
				// Labels
				label_1 = "5V OUT";
				translate([(wallThickness + (intDepth / 2)) - 0, 
				           -29,   // left-right on its face
				           -7]) { // up-down of its face
					rotate([0, 90, 0]) {
						linear_extrude(height=1.5, center=true) {
							rotate([0, 0, 90]) {
								translate([0, -(fontSize / 2)]) {
									text(label_1, fontSize);
								}
							}
						}
					}
				}

				label_2 = "5-6V IN";
				translate([(wallThickness + (intDepth / 2)) - 0, 
				           -2,   // left-right on its face
				           -7]) { // up-down of its face
					rotate([0, 90, 0]) {
						linear_extrude(height=1.5, center=true) {
							rotate([0, 0, 90]) {
								translate([0, -(fontSize / 2)]) {
									text(label_2, fontSize);
								}
							}
						}
					}
				}
				
				label_3 = "5V IN";
				translate([(wallThickness + (intDepth / 2)) - 0, 
				           13,   // left-right on its face
				           -7]) { // up-down of its face
					rotate([0, 90, 0]) {
						linear_extrude(height=1.5, center=true) {
							rotate([0, 0, 90]) {
								translate([0, -(fontSize / 2)]) {
									text(label_3, fontSize);
								}
							}
						}
					}
				}
				
				label_4 = "I       O";
				translate([24, // left-right on its face
				           - (wallThickness + (intWidth / 2)),   
				           -7]) { // up-down of its face
					rotate([90, 90, 0]) {
						linear_extrude(height=1.5, center=true) {
							rotate([0, 0, 90]) {
								translate([0, -(fontSize / 2)]) {
									text(label_4, fontSize);
								}
							}
						}
					}
				}
				
			}
			// Small bulkhead next to the battery
			if (true) {
				rotate([0, 0, 90]) {
					translate([0, -5.5, 0]) { // TODO Calculate Y offset
						cube(size=[intWidth - 20, wallThickness, intHeight], center=true);
					}
				}
			}
			// Board stands. Rotation and Translation code is duplicated from below...		
			// PowerBooset 1000C
			rotate([0, 0, -90]) {
				translate([switchOffset + ((intWidth - pbHeight) / 2), 
									 usbOffset + ((intDepth - pbWidth) / 2), 
									 -((intHeight - pbBoardThickness) / 2) + feetHeight + 1.8]) {
					AdafruitPowerboost1000C(withSwitch=true, withStand=false, standOnly=true, standHeight=feetHeight);
				}
			}
			// MCP73871_USB_Solar
			rotate([0, 0, 180]) {
				translate([ -1 * (intDepth - mcpHeight) / 2, 
									 ((intDepth - pbWidth) / 2) - (mcpWidth + 5), // 5: Slack
									 -((intHeight - mcpBoardThickness) / 2) + feetHeight + 1.8]) {
					MCP73871_USB_Solar(bigHangout=true, withStand=false, standOnly=true);
				}
			}
			// "Center" pole, to screw the lid.
			if (true) {
				screwLength = 10;
				rotate([0, 0, 0]) {
					translate([centerPoleXOffset, 0, -(intHeight / 2) - wallThickness]) {
						difference() {
							cylinder(d=10, h=intHeight + (2 * wallThickness), $fn=75);
							translate([0, 0, intHeight - (screwLength / 2) + 1]) {
								cylinder(d=2.5, h=screwLength, $fn=50);
							}
						}
					}
				}
			}
		}
	
		// Battery
		// Get dimensions from the code. See the functions in mechanical.parts.scad
		pkCellDims = getPkCellDims();
		pkcellDiam = pkCellDims[0]; 
		pkcellWidth = 3 * pkcellDiam;
		pkCellLen = pkCellDims[1];
		translate([-(intDepth - pkcellWidth) / 2, 
						   ((intWidth - pkCellLen) / 2) - 2, // -2: slack
			         (20 - pkcellDiam) / 2]) { // Height
			rotate([0, 0, 90]) {
				#PkCell(3);
			}
		}
		// PowerBooset 1000C
		rotate([0, 0, -90]) {
			translate([switchOffset + ((intWidth - pbHeight) / 2), 
								 usbOffset + ((intDepth - pbWidth) / 2), 
								 -((intHeight - pbBoardThickness) / 2) + feetHeight + 1.8]) {
				#AdafruitPowerboost1000C(withSwitch=true, withStand=false, standOnly=false, standHeight=feetHeight);
			}
		}
		// MCP73871_USB_Solar
		rotate([0, 0, -180]) {
			translate([ -1 * (intDepth - mcpHeight) / 2, 
			           ((intDepth - pbWidth) / 2) - (mcpWidth + 5), // 5: Slack
			           -((intHeight - mcpBoardThickness) / 2) + feetHeight + 1.8]) {
				#MCP73871_USB_Solar(bigHangout=true, withStand=false, standOnly=false);
			}
		}
	}
}

fontSize = 2.5;

module batteryHousingLid() {
	difference() {
		union() {
			cube(size=[intDepth + (2 * wallThickness), intWidth + (2 * wallThickness), wallThickness], center=true);
			translate([0, 0, -wallThickness]) {
				difference() {
					cube(size=[intDepth, intWidth, wallThickness], center=true);
					cube(size=[intDepth - (2 * wallThickness), intWidth - (2 * wallThickness), wallThickness], center=true);
				}
			}
		}
		// Led holes
		diam = 3;
		holesCoordinates = [ // From bottom left corner of the lid.
			[ 10, 10 ],   // Power, bottom left
		  [ 55, 25 ],   // Load
		  [ 67, 12.5 ]  // Power, bottom right
		];
		nbHoles = 3; // TODO Take array length
		for (i = [0:2]) {
			translate([(+ (intDepth + (2 * wallThickness)) / 2) - (holesCoordinates[i][1]), 
								 (- (intWidth + (2 * wallThickness)) / 2) + (holesCoordinates[i][0]), 
								 -wallThickness]) {
				cylinder(h=(2 * wallThickness), d=diam, $fn=50);
			}
		}

		// Fixing "center" holes
		centerDiam = 3;
		length = 10;
		translate([centerPoleXOffset, 0, -(1.5 * wallThickness) - (length / 2)]) {
			metalScrewCS(diam=3, length=10);
		}
		// Labels
		label_1 = "PWR";
		translate([(wallThickness + (intDepth / 2)) - 15, // up-down of its face
							 -32.5,   // left-right on its face
							 (0.5 * wallThickness)]) { 
			rotate([0, 0, 0]) {
				linear_extrude(height=1.5, center=true) {
					rotate([0, 0, 90]) {
						translate([0, -(fontSize / 2)]) {
							text(label_1, fontSize);
						}
					}
				}
			}
		}
		label_2 = "PWR";
		translate([(wallThickness + (intDepth / 2)) - 18, // up-down of its face
							 24,   // left-right on its face
							 (0.5 * wallThickness)]) { 
			rotate([0, 0, 0]) {
				linear_extrude(height=1.5, center=true) {
					rotate([0, 0, 90]) {
						translate([0, -(fontSize / 2)]) {
							text(label_2, fontSize);
						}
					}
				}
			}
		}
		label_3 = "LOAD";
		translate([(wallThickness + (intDepth / 2)) - 30, // up-down of its face
							 12,   // left-right on its face
							 (0.5 * wallThickness)]) { 
			rotate([0, 0, 0]) {
				linear_extrude(height=1.5, center=true) {
					rotate([0, 0, 90]) {
						translate([0, -(fontSize / 2)]) {
							text(label_3, fontSize);
						}
					}
				}
			}
		}
		
	}
}

ALL_PARTS = 1;
BOX_ONLY = 2;
LID_ONLY = 3;

option = LID_ONLY;

OPEN = true;

if (option == ALL_PARTS || option == BOX_ONLY) {
	batteryHousingBox();
}
if (option == ALL_PARTS || option == LID_ONLY) {
	translate([0, 0, (OPEN ? 20 : (0 * 0.5) + wallThickness + (intHeight + wallThickness) / 2)]) {
		color("green") { 
			batteryHousingLid();
		}
	}
}
