/**
 * Basic Animation
 * No animation: $t = 0
 * During animation: $t in [0..1]
 */

module drawSomethingNice() {
	echo("T:", $t);
	rotate([0, 0, ($t * 360) % 360]) {
		cube(10, center=true);
	}
}	

drawSomethingNice();
