/**
 * Adafruit 3.5" TFT screen
 * https://learn.adafruit.com/adafruit-pitft-3-dot-5-touch-screen-for-raspberry-pi?view=all
 *
 * Just screen:
 * https://cdn-shop.adafruit.com/datasheets/Adafruit35inTFT.pdf
 */
 use <./pin_header.scad>
 
// Plate
plateWidth = 56.62;
plateLength = 87; // 84.86;
betweenHolesWidth = 49.91;
betweenHolesLength = 91.19;
_plateThickness = 1.7;
holesDiam = 2.0;
plateExtensionWidth = 5.5;
plateExtensionLength = 97.5;

// Screen, out all.
screenThickness = 3.3;
screenWidth = 55.5;
screenLength = 86.5; // 84.07;

screenEdgeOffset = 2.3; // TODO Might need tuning

headerConnectorLength = 51.28;
headerConnectorWidth = 5.1;
headerConnectorHeight = 13.0;
headerSideFromEdge = 1.5;
headerOffset = 7.57; // from the narrow side of the plate


// Getters, called from other modules.
function getScreenPlateWidth() =
	plateWidth;
function getScreenPlateLength() =
	plateLength;
function getPlateExtensionWidth() =
  plateExtensionWidth;

module drawScreen(extrudeTop=false, extrudeBottom=false, screenDimFactor=1.0) {
  plateThickness = _plateThickness * (extrudeBottom ? 5 : 1);
  union () {
    // Plate
    zTranslate = extrudeBottom ? -(plateThickness - _plateThickness) / 2 : 0;
    translate([0, 0, zTranslate]) {
      rotate([0, 0, 0]) {
        color("green") {
          union() {
            cube(size=[plateWidth, plateLength, plateThickness], center=true);
            // Left
            translate([(plateWidth - plateExtensionWidth) / 2, 0, 0]) {
              difference() {
                union() {
                  cube(size=[plateExtensionWidth, plateExtensionLength - plateExtensionWidth, plateThickness], center=true);
                  translate([0, (plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                    cylinder(h=plateThickness, d=plateExtensionWidth, center=true, $fn=50);
                  }
                  translate([0, -(plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                    cylinder(h=plateThickness, d=plateExtensionWidth, center=true, $fn=50);
                  }
                }
                // Holes 
                translate([0, (plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                  cylinder(h=plateThickness * 2, d=holesDiam, center=true, $fn=50);
                }
                translate([0, -(plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                  cylinder(h=plateThickness * 2, d=holesDiam, center=true, $fn=50);
                }
              }
            }
            // Right
            translate([- (plateWidth - plateExtensionWidth) / 2, 0, 0]) {
              difference() {
                union() {
                  cube(size=[plateExtensionWidth, plateExtensionLength - plateExtensionWidth, plateThickness], center=true);
                  translate([0, (plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                    cylinder(h=plateThickness, d=plateExtensionWidth, center=true, $fn=50);
                  }
                  translate([0, -(plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                    cylinder(h=plateThickness, d=plateExtensionWidth, center=true, $fn=50);
                  }
                }
                // Holes 
                translate([0, (plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                  cylinder(h=plateThickness * 2, d=holesDiam, center=true, $fn=50);
                }
                translate([0, -(plateExtensionLength - plateExtensionWidth) / 2, 0]) {
                  cylinder(h=plateThickness * 2, d=holesDiam, center=true, $fn=50);
                }
              }
            }
          }
        }
      }
    }
    // Screen
    dimFactor = screenDimFactor;
    translate([0, 0, (screenThickness + _plateThickness) / 2]) {
      rotate([0, 0, 0]) {
        union() {
          color("darkgray") {
            cube(size=[screenWidth * dimFactor, 
                       screenLength * dimFactor, 
                       screenThickness * dimFactor], 
                 center=true);
          }
          color("gray") {
            cube(size=[screenWidth - (2 * screenEdgeOffset), 
                       screenLength - (2 * screenEdgeOffset), 
                       screenThickness], 
                 center=true);
          }
          translate([0, 0, 1.16]) {
            rotate([0, 0, 90]) {
              color("cyan") {
                text("Adafruit 3.5\" TFT", halign="center", size=6);
              }
            }
          }
        }
      }
    }
    // Connector(s)
    // Header Connector
    translate([((plateWidth - headerConnectorWidth) / 2) - headerSideFromEdge, 
               ((plateLength - headerConnectorLength) / 2) - headerOffset, 
               -(_plateThickness + headerConnectorHeight) / 2]) {
      rotate([0, 0, 0]) {
        color("black") {
          cube(size=[headerConnectorWidth, headerConnectorLength, headerConnectorHeight], center=true);
        }
      }
    }
    // Other connector
    translate([0, (plateLength / 2) - (8 + 2.54), 1]) {
      rotate([180, 0, 90]) {
        header(rows=13, pitch=2.54);
      }
    }
    // Extrude the top to see the screen
    if (extrudeTop) {
      howThick = 20;
      translate([0, 0, (howThick / 2)]) {
        color("pink") {
          cube(size=[screenWidth - (2 * screenEdgeOffset), 
                     screenLength - (2 * screenEdgeOffset), 
                     howThick], 
               center=true);
        }
      }
    }
  }
}

drawScreen(extrudeBottom=false);
