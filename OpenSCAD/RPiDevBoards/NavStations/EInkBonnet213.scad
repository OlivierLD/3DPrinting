/*
 * Adafruit 2.13" eink bonnet
 */
 
module roundedRect(size, radius, center=true) {  
	linear_extrude(height=size.z, center=center) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = center);
		}
	}
}
 
module einkBonner213() {
  plateWidth = 31.66;
  plateLength = 65.1;
  plateThickness = 1.7;
  plateBorderRadius = 1.5;
  
  screenWidth = 29.7;
  screenLength = 59.3;
  screenThickness = 1.5;
  
  union() {
    // Base plate
    color("black") {
      roundedRect([plateWidth, plateLength, plateThickness], plateBorderRadius, $fn=100);
    }
    // Screen
    union() {
      translate([0.8, 2, plateThickness / 2]) {
        color("silver") {
          cube(size=[screenWidth, screenLength, screenThickness], center=true);
        }
      }
      translate([0, 0, 1.3]) {
        rotate([0, 0, 90]) {
          color("gray") {
            text("Adafruit e-ink 2.13\"", halign="center", size=4);
          }
        }
      }
    }
    // Header connector
    headerWidth = 5.0;
    headerLength = 51.16;
    headerThickness = 3.25;
    translate([-12, 0, -(headerThickness + plateThickness) / 2]) {
      rotate([0, 0, 0]) {
        color("black") {
          cube(size=[headerWidth, headerLength, headerThickness], center=true);
        }
      }
    }
    // TODO Push Buttons...
    
  }
  
}

// einkBonner213();
