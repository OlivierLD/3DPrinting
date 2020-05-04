/**
 * ONE SIZE FITS ALL !
 *
 * Housing for 
 * - MCP73871_USB_Solar (https://www.adafruit.com/product/390)
 *   - 5V power supply (from solar panel or wall charger)
 *   - USB socket
 * - PowerBooster 1000C (https://www.adafruit.com/product/2465)
 *   - USB Power supply
 *   - Slide switch 
 * - 2200 mAh LiPo battery (https://www.adafruit.com/product/1781)
 * - 4400 mAh LiPo battery (https://www.adafruit.com/product/354)
 * - 6600 mAh LiPo battery (https://www.adafruit.com/product/353)
 * Modify the nbCell variable below to change the size of the box. Use 1, 2, or 3.
 *
 * MetalSheet Screws: M2.6 * 6
 * For the lid: Flat HEad Screw 4-40 3/8"
 */
 
 
use <../mechanical.parts.scad> 

nbCell = 3;
 
// internal box dimensions, mm
intWidth = 73;
intHeight = 20; 
intDepth = 101 - ((3 - nbCell) * getPkCellDims()[0]);
wallThickness = 2.5;

// Get PowerBoost dimensions from the code. See the functions in mechanical.parts.scad
pbDims = getPowerBooster1000cDims();
pbWidth          = pbDims[0]; // 36.2;
pbHeight         = pbDims[1]; // 22.86;	
pbBoardThickness = pbDims[2]; // 1.7;
feetHeight = 4;

// Get MCP dimensions from the code. See the functions in mechanical.parts.scad
mcpDims = getMcpUsbSolarDims();
mcpWidth          = mcpDims[0]; // 40.64;
mcpHeight         = mcpDims[1]; // 33.1447;	
mcpBoardThickness = mcpDims[2]; // 1.7;

// Booster Offsets !!
switchOffset = -2;
usbOffset = -5;

module batteryHousingBox() {

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
			// Small bulkhead next to the battery, and main screw axis
			if (true) {
				bulkHeadOffset = ((pbWidth - usbOffset + wallThickness) / 1) - (intDepth / 2) + 1; // 1: Slack
				// echo("Half ", (intDepth / 2), "PBWidth ", (pbWidth), "Bulkhead offset ", bulkHeadOffset);
				rotate([0, 0, 90]) {
					translate([0, bulkHeadOffset, 0]) { 
						cube(size=[intWidth - 20, 
						           wallThickness, 
						           intHeight], center=true);

						// "Center" pole, to screw the lid.
						translate([0, -3, -(intHeight/ 2) - wallThickness]) {
							screwLength = 10;
							difference() {
								cylinder(d=8, h=intHeight + (2 * wallThickness), $fn=6);
								translate([0, 0, intHeight - (screwLength / 2) + 1]) {
									cylinder(d=2.5, h=screwLength, $fn=50);
								}
							}
						}
					}
				}
			}

			// Board stands. Rotation and Translation code is duplicated from below...		
			// PowerBooster 1000C
			rotate([0, 0, -90]) {
				translate([switchOffset + ((intWidth - pbHeight) / 2), 
									 usbOffset + ((intDepth - pbWidth) / 2), 
									 -((intHeight - pbBoardThickness) / 2) + feetHeight + 1.8]) {
					AdafruitPowerboost1000C(withSwitch=true, withStand=false, standOnly=true, standHeight=feetHeight);
				}
			}
			// MCP73871_USB_Solar
			rotate([0, 0, 180]) {
				translate([ (-1 * (intDepth - mcpHeight) / 2), 
  								 (((intWidth / 2) - (pbHeight - (1 * switchOffset)) - (1 * mcpWidth / 2)) - 5), // 5: Slack & offset
									 -((intHeight - mcpBoardThickness) / 2) + feetHeight + 1.8]) {
					MCP73871_USB_Solar(bigHangout=true, withStand=false, standOnly=true);
				}
			}
		}
	
		// Battery
		// Get dimensions from the code. See the functions in mechanical.parts.scad
		pkCellDims = getPkCellDims();
		pkcellDiam = pkCellDims[0]; 
		pkcellWidth = nbCell * pkcellDiam;
		pkCellLen = pkCellDims[1];
		translate([- (1 * ((intDepth - pkcellWidth) / 2)) - (nbCell == 2 ? (pkcellDiam / 2) : 0), 
						   ((intWidth - pkCellLen) / 2) - 2, // -2: slack, left-right
			         (20 - pkcellDiam) / 2]) { // Height
			rotate([0, 0, 90]) {
				#PkCell(nbCell);
			}
		}
		// PowerBooster 1000C
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
  								(((intWidth / 2) - (pbHeight - (1 * switchOffset)) - (1 * mcpWidth / 2)) - 5), // 5: Slack & offset
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
			[  7, 10 ],  // Power, bottom left
		  [ 56, 28 ],  // Load
		  [ 49, 28 ],  // Done
		  [ 67, 10 ]   // Power, bottom right
		];
		nbHoles = len(holesCoordinates); // Array length
		for (i = [0 : nbHoles - 1]) {
			translate([(+ (intDepth + (2 * wallThickness)) / 2) - (holesCoordinates[i][1]), 
								 (- (intWidth + (2 * wallThickness)) / 2) + (holesCoordinates[i][0]), 
								 -wallThickness]) {
				cylinder(h=(2 * wallThickness), d=diam, $fn=50);
			}
		}

		// Fixing "center" holes
		centerDiam = 3;
		screwLength = 10;
		if (true) {
				bulkHeadOffset = ((pbWidth - usbOffset + wallThickness) / 1) - (intDepth / 2) + 1; // 1: Slack
				// echo("Half ", (intDepth / 2), "PBWidth ", (pbWidth), "Bulkhead offset ", bulkHeadOffset);
				rotate([0, 0, 90]) {
					translate([0, bulkHeadOffset, (3.5 * wallThickness) - (screwLength / 2)]) { 
						translate([0, -3, -(intHeight/ 2) - wallThickness]) {
							#metalScrewCS(diam=centerDiam, length=screwLength);
						}
					}
				}
			}
		// Labels
		label_1 = "PWR";
		translate([(wallThickness + (intDepth / 2)) - 15, // up-down of its face
							 -35.5,   // left-right on its face
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
		translate([(wallThickness + (intDepth / 2)) - 15, // up-down of its face
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
		label_3 = "CHRG";
		translate([(wallThickness + (intDepth / 2)) - 28, // up-down of its face
							 21,   // left-right on its face
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
		label_4 = "LOAD";
		translate([(wallThickness + (intDepth / 2)) - 28, // up-down of its face
							 -3,   // left-right on its face
							 (0.5 * wallThickness)]) { 
			rotate([0, 0, 0]) {
				linear_extrude(height=1.5, center=true) {
					rotate([0, 0, 90]) {
						translate([0, -(fontSize / 2)]) {
							text(label_4, fontSize);
						}
					}
				}
			}
		}
		// Capacity label
		capacityLabels = [ "2200 mAh", "4400 mAh", "6600 mAh" ];
		label_5 = capacityLabels[nbCell - 1];
		capacityFontSize = 10;
		translate([(wallThickness + (intDepth / 2)) - 54, // up-down of its face
							 -30,   // left-right on its face
							 (0.5 * wallThickness)]) { 
			rotate([0, 0, 0]) {
				linear_extrude(height=1.5, center=true) {
					rotate([0, 0, 90]) {
						translate([0, -(fontSize / 2)]) {
							text(label_5, capacityFontSize);
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

option = ALL_PARTS;

OPEN = true;

if (option == ALL_PARTS || option == BOX_ONLY) {
	batteryHousingBox();
}
if (option == ALL_PARTS || option == LID_ONLY) {
	translate([0, 0, (OPEN ? 30 : (0 * 0.5) + wallThickness + (intHeight + wallThickness) / 2)]) {
		//color("green") { 
			batteryHousingLid();
		//}
	}
}
