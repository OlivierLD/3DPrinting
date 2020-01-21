/*
 * 20-Jan-2020, discovering OpenSCAD.
 *
 * Raspberry Pi Zero dev board, 
 * A Raspberry Pi Zero, next to a small breadboard.
 *
 * For the Raspberry Pi dimension:
 * See https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
*/
module roundedRect(size, radius) {  
  linear_extrude(height=size.z, center=true) {
    offset(radius) offset(-radius) {
      square([size.x, size.y], center = true);
    }
  }
}

// Base plate
// ----------
plateWidth=90;
plateLength=90;
plateThickNess=3;
cornerRadius=10;

// roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);

text="Oliv did it";
difference() {  
    roundedRect([plateWidth, plateLength, plateThickNess], cornerRadius);
    linear_extrude(height=plateThickNess, center=true) {
        rotate([0, 0, -90]) {
            translate([
             -13, // left - right (Y)
             -20, // Top - bottom (X)
             10   // Up - down    (Z)
            ]) {
                text(text, 5);
            }
        }
    }
}

// Raspberry Pi holes: diameter: 2.5mm
// 23mm x 58mm (between holes axis)
rPiWidth=58;
rPiLength=23;

// Raspberry Pi pegs
// ----------------
// Base Pegs
basePegDiam=5;
basePegHeight=3;
offset=7;
translate([ ((plateLength/2) - offset), (rPiWidth / 2), plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
}
translate([ ((plateLength/2) - offset), -(rPiWidth / 2), plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
}
translate([ ((plateLength/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
}
translate([ ((plateLength/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
            cylinder(h=basePegHeight, d1=basePegDiam, d2=basePegDiam, center=true, $fn=100);
}
topPegDiam=2;
topPegHeight=7;
translate([ ((plateLength/2) - offset), (rPiWidth / 2), plateThickNess]) {
            cylinder(h=topPegHeight, d1=topPegDiam, d2=topPegDiam, center=true, $fn=100);
}
translate([ ((plateLength/2) - offset), -(rPiWidth / 2), plateThickNess]) {
            cylinder(h=topPegHeight, d1=topPegDiam, d2=topPegDiam, center=true, $fn=100);
}
translate([ ((plateLength/2) - offset) - rPiLength, (rPiWidth / 2), plateThickNess]) {
            cylinder(h=topPegHeight, d1=topPegDiam, d2=topPegDiam, center=true, $fn=100);
}
translate([ ((plateLength/2) - offset) - rPiLength, -(rPiWidth / 2), plateThickNess]) {
            cylinder(h=topPegHeight, d1=topPegDiam, d2=topPegDiam, center=true, $fn=100);
}

// Small Breadboard: 35mm x 45.6mm
breadboardLength=45.6;
breadboardWidth=35;
borderHeight=5;
borderThickness=3;
// Same offset for the breadboard as for the raspberry

// Breadboard frame
// ----------------
slack = 1.05;
// Outer width (close to the edge()
translate([ -((plateLength/2) - offset + ((slack * borderThickness) / 2)), 
            0, 
            plateThickNess ]) {
    cube(size=[ borderThickness, 
                breadboardLength + (2 * borderThickness * slack), 
                borderHeight], 
         center=true);
}
// Inner width (close to the center)
translate([-((plateLength / 2) - offset - (slack * breadboardWidth) - borderThickness - (borderThickness / 2)), 
            0, 
            plateThickNess ]) {
    cube(size=[ borderThickness, 
                breadboardLength + (2 * borderThickness * slack), 
                borderHeight], 
         center=true);
}
// Left
translate([ -((plateLength / 2) - offset - (slack * breadboardWidth / 2)), 
            (breadboardLength / 2) + ((slack * borderThickness) / 2), 
            plateThickNess ]) {
    cube(size=[ (breadboardWidth * slack) + (2 * borderThickness), 
                borderThickness, 
                borderHeight], 
         center=true);
}
// Right
translate([ -((plateLength / 2) - offset - (slack * breadboardWidth / 2)), 
            -((breadboardLength / 2) + ((slack * borderThickness) / 2)), 
            plateThickNess ]) {
    cube(size=[ (breadboardWidth * slack) + (2 * borderThickness), 
                borderThickness, 
                borderHeight], 
         center=true);
}
// That's it!

