// Generate 2 random values between 10 and 30
r = rands(10, 30, 2);

// Calculate width and length from random values
width = r[1];
length = 3 * r[0];

difference() {
    // Create border
    linear_extrude(2, center = true) {
        square([length + 4, width + 4], center = true);
    }
    // Cut the area for the text
    linear_extrude(2) {
        square([length + 2, width + 2], center = true);
    }
    // Fit the text into the area based on the length
    color("green") {
        linear_extrude(1.5, center = true, convexity = 4) {
            resize([length, 0], auto = true) {
                text("Text goes here!", valign = "center", halign = "center");
            }
        }
    }
}
