/*
 * Getting started...
 */
echo(version=version());
 
if (false) {
	 polyhedron (
		 points=[ [10,10,0],[10,-10,0],[-10,-10,0],[-10,10,0], // the four points at base
							 [0,0,10]  ],                                 // the apex point 
		faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
								[1,0,3],[2,1,3] ]                         // two triangles for square base
	 );
}
 
module axis(thickness, height, diam) {
	translate([0, -thickness / 2, height - 0.3]) {
		rotate([90, 0, 0]) {
			cylinder(h=thickness, d1=diam, d2=diam, center=true, $fn=100);
		}
	}
}

module oneSide(thickness, baseLen, height, topWidth) { 
	points = [
		[-baseLen / 2, 0, 0],           
		[baseLen / 2, 0, 0],
		[topWidth / 2, 0, height],
		[-topWidth / 2, 0, height],
	
		[-baseLen / 2, -thickness, 0],
		[baseLen / 2, -thickness, 0],
		[topWidth / 2, -thickness, height],	
		[- topWidth / 2, -thickness, height]	
	];
	
	faces = [
		[0, 3, 2, 1], // Left
		[4, 7, 6, 5], // right
		[5, 4, 0, 1], // Base
		[4, 7, 3, 0], // Front slope
		[1, 2, 6, 5]/*, // Back slope
		[7, 6, 2, 3] */// Top
	];
	
	union() {
		polyhedron(points=points, faces=faces, convexity = 1);
		// Rounded top
		axis(thickness, height - 0.1, topWidth);
	}
}

thickness = 1.5;
baseLen = 15;
height = 20;
topWidth = 5;
axisDiam = 3;
	
color("yellow") {
	difference() {
		oneSide(thickness, baseLen, height, topWidth);
		//axis(thickness * 2.5, height - 0.1, axisDiam);
	}
}

