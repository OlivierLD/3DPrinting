

module centerBoard(width = 37.0, wlRatio = 6.0, thickness = 5.0) {
    
    linear_extrude(height = thickness, center = true) {
        union() {
            difference() {
                scale([1.0, wlRatio]) {
                    circle(d=width);
                }
                translate([- width / 2, 0, 0]) {
                    square([width, width * wlRatio / 2], center=false);
                }
            }
            circle(d=width);
        }
    }
}

// Uncomment below for rendering here in this module (for dev).
// centerBoard();