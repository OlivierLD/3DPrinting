/**
 * Housing for 
 * - MCP73871_USB_Solar
 *   - 5V power supply (from solar panel or wall charger)
 *   - USB socket
 * - PowerBooster 1000C
 *   - USB Power supply
 *   - Slide switch 
 * - 6600 mAh LiPo battery
 */
 
use <../mechanical.parts.scad> 
 
// internal box dimensions, mm
intWidth = 130;
intHeight = 20; 
intDepth = 70;
wallThickness = 2.5;
 
module batteryHousingBox() {

	// TODO Get PoweBoost dimensions from the code. See the functions in mechanical.parts.scad
	pbWidth = 36.2;
	pbHeight = 22.86;	
	pbBoardThickness = 1.7;
	feetHeight = 4;

	// TODO Get MCP dimensions from the code. See the functions in mechanical.parts.scad
	mcpWidth = 40.64;
	mcpHeight = 33.1447;	
	mcpBoardThickness = 1.7;
	//feetHeight = 4;

	difference() {
		// The box
		union() {
			difference() {
				cube(size=[intDepth + (2 * wallThickness), intWidth + (2 * wallThickness), intHeight + (2 * wallThickness)], center=true);
				translate([0, 0, wallThickness + 0.5]) {
					cube(size=[intDepth, intWidth, intHeight + 1], center=true);
				}
			}
			// Board stands. Rotation and Translation code is duplicated from below...		
			// PowerBooset 1000C
			rotate([0, 0, -90]) {
				translate([(intWidth - pbHeight) / 2, 
									 (intDepth - pbWidth) / 2, 
									 -((intHeight - pbBoardThickness) / 2) + feetHeight + 1.8]) {
					AdafruitPowerboost1000C(withSwitch=true, withStand=false, standOnly=true, standHeight=feetHeight);
				}
			}
			// MCP73871_USB_Solar
			rotate([0, 0, 180]) {
				translate([ -1 * (intDepth - mcpHeight) / 2, 
									 (intDepth - mcpWidth) / 2, 
									 -((intHeight - mcpBoardThickness) / 2) + feetHeight + 1.8]) {
					MCP73871_USB_Solar(bigHangout=true, withStand=false, standOnly=true);
				}
			}
		}
	
		// Battery
		// TODO Get dimensions from the code. See the functions in mechanical.parts.scad
		pkcellDiam = 17.44; 
		pkcellWidth = 3 * pkcellDiam;
		translate([0, (intWidth - pkcellWidth) / 2, (20 - pkcellDiam) / 2]) {
			#PkCell(3);
		}
		// PowerBooset 1000C
		rotate([0, 0, -90]) {
			translate([(intWidth - pbHeight) / 2, 
			           (intDepth - pbWidth) / 2, 
			           -((intHeight - pbBoardThickness) / 2) + feetHeight + 1.8]) {
				#AdafruitPowerboost1000C(withSwitch=true, withStand=false, standOnly=false, standHeight=feetHeight);
			}
		}
		// MCP73871_USB_Solar
		rotate([0, 0, 180]) {
			translate([ -1 * (intDepth - mcpHeight) / 2, 
			           (intDepth - mcpWidth) / 2, 
			           -((intHeight - mcpBoardThickness) / 2) + feetHeight + 1.8]) {
				#MCP73871_USB_Solar(bigHangout=true, withStand=false, standOnly=false);
			}
		}
	}
}


module batteryHousingLid() {
	union() {
		cube(size=[intDepth + (2 * wallThickness), intWidth + (2 * wallThickness), wallThickness], center=true);
		translate([0, 0, -wallThickness]) {
			difference() {
				cube(size=[intDepth, intWidth, wallThickness], center=true);
				cube(size=[intDepth - (2 * wallThickness), intWidth - (2 * wallThickness), wallThickness], center=true);
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
	translate([0, 0, (OPEN ? 20 : (0 * 0.5) + wallThickness + (intHeight + wallThickness) / 2)]) {
		color("green") { 
			batteryHousingLid();
		}
	}
}
