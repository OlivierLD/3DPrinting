 
echo(version=version());

module roundedRect(size, radius) {  
  // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/2D_to_3D_Extrusion
	linear_extrude(height=size.z, center=true, $fn=100) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}

/*
 * Board dims:
 * w: 56mm
 * l: 56mm
 */
// Base plate
// --------------
plateWidth = 56 + 3;
plateLength = 56 + 3;

plateThickNess = 3;
cornerRadius = 5;

// PlateTickness = Wall Thickness
mainPlateWidth  = plateWidth + (2 * plateThickNess);
mainPlateLength = plateLength + (2 * plateThickNess);

module loudSpeakerStand() {
  roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
}

// The feet for the top of the monitor
monitorThickness = 20; // mm
monitorBorderHeight = 15; // mm
feetThickness = 10;

module topMonitorClamp() {
  difference() {
    cube(size=[
               monitorThickness + (2 * feetThickness),
               plateLength, 
               monitorBorderHeight ], center=true);
    cube(size=[
               monitorThickness,
               plateLength, 
               monitorBorderHeight ], center=true);
  }
}

union() {
  // Draw the raspberry. Show, or drill.
  loudSpeakerStand();
  translate([0, 0, -((plateThickNess + monitorBorderHeight) / 2)]) {
    topMonitorClamp();
  }
}
// That's it!
