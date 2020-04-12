/**
 * @author OlivierLD
 * 
 * A test, a stand for a servoParallax900_00005()
 * With an optional plate for the stand. 
 * -> See 'option' at the bottom of the script.
 */
use <../mechanical.parts.scad>

standThickness = 6;

servoXOffset = 26.6 - standThickness; // From the servo's specs.
servoZOffset = 10;

deeper = -1;

verticalBoardWidth = 50;
verticalBoardHeight = 70;
horizontalStandLength = 50;

// Vertical board, with servo socket
module servoSocket() {
	difference() {
		cube(size=[standThickness, verticalBoardWidth, verticalBoardHeight], center=true);
		translate([- (standThickness / 2) - (servoXOffset) + deeper, 0, servoZOffset]) {
			rotate([0, 90, 0]) {
				// Use the # in front of the lines below to see the parts.
				servoParallax900_00005();
				servoParallax900_00005(drillPattern=true, drillLength=20, drillDiam=2.5);
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
				translate([-standThickness, 0, (verticalBoardWidth / 2) - (3 * standThickness / 2)]) {
					cube(size=[standThickness, verticalBoardWidth, 3 * standThickness]);
				}
			}
		}
	}
}

SERVO_SOCKET_ONLY = 1;
SOCKET_STAND_ONLY = 2;
BOTH = 3;

// Change at will with the values above
option = SERVO_SOCKET_ONLY;

if (option == BOTH) {
  servoSocket();
  socketStand();
} else if (option == SERVO_SOCKET_ONLY) {
  servoSocket();
} else if (option == SOCKET_STAND_ONLY) {
	difference() {
		socketStand();
		servoSocket();
	}
}
