logo = "RPiLogo.png"; // res 240 x 300

wid = 60; // Plate dim
logox = 200; 
logoy = 200; 

if (true) {
    translate([-30, -30, 0]) {
        difference() {
            cube([wid, wid, 2]);
            translate([wid/4, (wid/4) - 7, 3]) {
                scale([.5 * wid / logox, .5 * wid / logoy, .02]) {
                    surface(file=logo, invert=true);
                }
            }
        }
    }
} else {
    translate([-120, -150, 0]) {
        surface(file=logo, invert=true);
    }
}
