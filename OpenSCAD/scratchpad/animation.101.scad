/**
 * Basic Animation
 * No animation: $t = 0
 * During animation: $t in [0..1]
 *
 * To start animation: use OpenSCAD Menu, View -> Animation.
 * Then FPS: 10, Steps: 360.
 */

module drawSomethingNice() {
	echo("T:", $t);
	rotate([0, 0, ($t * 360) % 360]) {
		cube(10, center=true);
	}
}	

drawSomethingNice();
