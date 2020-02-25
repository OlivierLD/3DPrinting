/**
 * To print all parts 
 * for the solar panel stand
 *
 * Uses all.parts.scad
 *
 * Note: Use it from printing.scad and similar scripts, along with param.set.XX.scad.
 */
use <../mechanical.parts.scad>
use <./all.parts.scad>

include <./printing.options.scad>

/**
 * Panel Bracket.
 * All dimensions in mm
 *
 * @param horizontalAxisDiam Number. Horizontal axis diameter. Also used to find ball bearings' dimensions.
 * @param sizeAboveAxis Number. Size out all above axis
 * @param sizeBelowAxis Number. Size out all below axis
 * @param widthOutAll Number. Bracket's width out all
 * @param thickness Number. Bracket's thickness
 * @param plateWidth Number. Bracket's width
 * @param betweenAxis Number. Length bewteen main axis and motor axis
 * @param bottomCylinderDiam Number. Bottom cylinder diameter, for the cylinder's flanks.
 * @param motorDepth Number. USed to display the motor if required.
 * @param withMotor Boolean, default false.
 * @param withCylinder Boolean, default false.
 *
 * TODO Other params.
 * TODO Other motor dimensions, width and height (currently defaulted to NEMA-17)
 */
module printBracket(horizontalAxisDiam,
									  sizeAboveAxis,
									  sizeBelowAxis,
									  widthOutAll,
									  thickness,
									  plateWidth,
									  betweenAxis, 
									  bottomCylinderDiam,
										motorDepth=39,
									  withMotor=false,
									  withCylinder=false,
										withFixingFeet=false,
										printOption=ALL_PARTS) {
	echo(str("--- Current Settings for Bracket ---"));
  echo(str("Horizontal axis diam...........: ", horizontalAxisDiam));												
  echo(str("Above axis.....................: ", sizeAboveAxis));												
  echo(str("Below axis.....................: ", sizeBelowAxis));												
  echo(str("Total width....................: ", widthOutAll));												
  echo(str("Wall thickness.................: ", thickness));												
  echo(str("Sides and plate width..........: ", plateWidth));												
  echo(str("Between axis (motor and main)..: ", betweenAxis));												
  echo(str("Counterweight cylinder diam....: ", bottomCylinderDiam));												
  echo(str("Motor depth....................: ", motorDepth));												
  echo(str("With motor.....................: ", (withMotor?"yes":"no")));												
  echo(str("With counterweight cylinder....: ", (withCylinder?"yes":"no")));												
  echo(str("With fixing feet...............: ", (withFixingFeet?"yes":"no")));												

	panelBracket(horizontalAxisDiam,
							 sizeAboveAxis,
							 sizeBelowAxis,
							 widthOutAll,
							 thickness,
							 plateWidth,
							 betweenAxis, 
							 bottomCylinderDiam,
							 motorDepth,
							 withMotor,
							 withCylinder,
							 withFixingFeet=withFixingFeet,
							 printOption=printOption);
}

/** 
 * Bottom base
 * All dimensions in millimeters.
 *
 * @param cylHeight Number. Cylinder height 
 * @param extDiam Number. Cylinder external diameter
 * @param torusDiam Number. Torus diameter, the one the balls roll in
 * @param intDiam Number. Cylinder internal diameter
 * @param ballsDiam Number. Diameter of the balls in the torus (the groove on top)
 * @param fixingFootSize Number. Height and length of the fixing foot
 * @param fixingFootWidth Number. Fixing foot width
 * @param screwDiam Number. Diameter of the screws for the fixing foot
 * @param minWallThickness Number. How far inside the cylinder the fixing foot goes
 * @param wormGearAxisDiam Number. Diameter of the HOLE the worm gear axis spins in
 * @param workGearOffset Number. Distance between the vertical axis and the worm gear axis
 * @param wormGearHeight Number. Heigth of the worm gear axis
 */
module printBase1(cylHeight, 
									extDiam, 
									torusDiam, 
									intDiam, 
									ballsDiam, 
									fixingFootSize, 
									fixingFootWidth, 
									screwDiam, 
									minWallThickness,
									verticalAxisDiam,
									wormGearAxisDiam,
									workGearOffset,
									wormGearHeight) {

	echo(str("--- Current Settings for Bottom Base ---"));
  echo(str("Height.......................................................: ", cylHeight));												
  echo(str("External diameter............................................: ", extDiam));												
  echo(str("Torus diameter...............................................: ", torusDiam));												
  echo(str("Internal diameter............................................: ", intDiam));												
  echo(str("Balls diameter...............................................: ", ballsDiam));												
  echo(str("Fixing feet size (H & L).....................................: ", fixingFootSize));												
  echo(str("Fixing feet width............................................: ", fixingFootWidth));												
  echo(str("Fixing feet screw size.......................................: ", screwDiam));												
  echo(str("Fixing feet min wall thnickness..............................: ", minWallThickness));												
  echo(str("Vertical axis diameter.......................................: ", verticalAxisDiam));												
  echo(str("Worm gear axis (tube) diameter...............................: ", wormGearAxisDiam));												
  echo(str("Worm gear axis offset (between vertical and worm gear axis)..: ", workGearOffset));												
  echo(str("Worm gear axis height........................................: ", wormGearHeight));												

	dims = getBBDims(verticalAxisDiam); // [id, od, t]
	boltDims = getHBScrewDims(verticalAxisDiam);
	bbSocketBaseThickness = 3; // Bottom ball bearing in its socket, facing down.
	socketWallThickness = 3;
	
	socketTotalHeight = (dims[2] * 1.1) + (boltDims[0]) + bbSocketBaseThickness;
			
	socketDepth = 25;
	motorSocketWallThickness = 2;
	motorSide = 42.3; // in the param.set.XX.scad
	extraOffset = 8;

	difference() {
		union() {
			difference() {
				footedBase(cylHeight, 
									 extDiam, 
									 torusDiam, 
									 intDiam, 
									 ballsDiam, 
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness, 
									 crosshairThickness=socketTotalHeight);	
				// No worm gear in this version
				// wormGearAxis(wormGearAxisDiam, workGearOffset, wormGearHeight);	
				// hole at the back, to access the screw on the axis
				if (false) {
					translate([-torusDiam / 2, 0, cylHeight / 3]) {
						rotate([0, 90, 0]) {
							holeDepth = (extDiam - intDiam) * 2;
							linear_extrude(height=holeDepth, center=true) {		
								resize([cylHeight / 3, (cylHeight / 3) * 2]) {
									circle(d=cylHeight / 3, $fn=100);
								}
							}
						}
					}
				}
				// Motor stand extrusion, in the South (TODO: Option in North)
				translate([-extraOffset -((extDiam - socketDepth) / 2), 0, (motorSide + (2 * motorSocketWallThickness)) / 2]) {
					rotate([0, 90, 180]) {
						motorSocket(socketDepth = socketDepth,
												wallThickness = motorSocketWallThickness,
												placeHolder = true);
					}
				}
				
				// E-W holes
//				translate([0, (extDiam * 1.1) / 2, cylHeight / 3]) {
//					rotate([90, 0, 0]) {
//						cylinder(d=cylHeight / 3, h=extDiam * 1.1, $fn=100);
//					}
//				}
			}
			// Actual motor socket
			translate([-extraOffset -((extDiam - socketDepth) / 2), 0, (motorSide + (2 * motorSocketWallThickness)) / 2]) {
				rotate([0, 90, 180]) {
					motorSocket(socketDepth = socketDepth,
											wallThickness = motorSocketWallThickness,
											placeHolder = false);
				}
				// A motor
				translate([-extraOffset - motorSocketWallThickness, 0, 0]) {
					rotate([0, 0, -90]) {
						motor(withScrews=true, wallThickness=motorSocketWallThickness);
					}
				}
			}
			
			// For test (for now) bevel gears pair
			motorAxisHeight = (motorSide + (2 * motorSocketWallThickness)) / 2;
			bevel_gear_height = 11.0997; // Do something smart here. See in bevelGearPair module
			translate([0, 0, motorAxisHeight + bevel_gear_height]) {
				rotate([180, 0, 0]) {
					bevelGearPair(gear_teeth=40,
												pinion_teeth = 20,
												base_thickness = 52.5,
												pinion_base_thickness = 5,
												pinion_base_diam = 10,
												base_diam = 40, // Part Cone Diameter at the Cone Base, seems to be like gear_teeth // was 40
												big_axis_diam = 5,
												small_axis_diam = 5,
												build_together = true,
												with_gear = true,
												with_pinion = true);
				}
			}
			
			// Bottom ball bearing socket, facing down.
			rotate([180, 0, 0]) {
				translate([0, 0, -socketTotalHeight]) {
					difference() {
						translate([0, 0, 0]) {
							rotate([0, 0, 0]) {
								cylinder(d=dims[1] + socketWallThickness, h=socketTotalHeight, $fn=50);
							}
						}
						translate([0, 0, bbSocketBaseThickness]) {
							rotate([0, 0, 0]) {
								cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
							}
						}
						translate([0, 0, -1]) { // Drill
							rotate([0, 0, 0]) {
								cylinder(d=dims[0], h=dims[2] * 5, $fn=50);
							}
						}
					}
				}
			}
		}
		// Drill everything from bottom
		translate([0, 0, -bbSocketBaseThickness]) {
			rotate([0, 0, 0]) {
				cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
			}
		}
	}
}

/**
 * Top base, the one upside down
 * All dimensions in millimeters.
 *
 * @param cylHeight Number. Cylinder height 
 * @param extDiam Number. Cylinder external diameter
 * @param torusDiam Number. Torus diameter, the one the balls roll in
 * @param intDiam Number. Cylinder internal diameter
 * @param ballsDiam Number. Diameter of the balls in the torus (the groove on top)
 * @param fixingFootSize Number. Height and length of the fixing foot
 * @param fixingFootWidth Number. Fixing foot width
 * @param screwDiam Number. Diameter of the screws for the fixing foot
 * @param minWallThickness Number. How far inside the cylinder the fixing foot goes
 * @param feetInside Boolean. default false
 */
module printBase2(cylHeight, 
								  extDiam, 
								  torusDiam, 
								  intDiam, 
								  ballsDiam, 
								  fixingFootSize, 
								  fixingFootWidth, 
								  screwDiam, 
								  minWallThickness,
									feetInside = false) {

	echo(str("--- Current Settings for Top Base ---"));
  echo(str("Height....................: ", cylHeight));												
  echo(str("External diameter.........: ", extDiam));												
  echo(str("Torus diameter............: ", torusDiam));												
  echo(str("Internal diameter.........: ", intDiam));												
  echo(str("Balls diameter............: ", ballsDiam));												
  echo(str("Fixing feet size (H & L)..: ", fixingFootSize));												
  echo(str("Fixing feet width.........: ", fixingFootWidth));												
  echo(str("Fixing feet screw size....: ", screwDiam));												
  echo(str("Fixing feet inside........: ", (feetInside ? "yes":"no")));												

	difference() {									
		footedBase(cylHeight, 
							 extDiam, 
							 torusDiam, 
							 intDiam, 
							 ballsDiam, 
							 fixingFootSize, 
							 fixingFootWidth, 
							 screwDiam, 
							 minWallThickness, 
							 fullIndex=false,
							 feetInside=feetInside);
		drillingPattern(extDiam, 
										fixingFootSize, 
										screwDiam, 
										minWallThickness, 
										feetInside=feetInside);
	}
}

/**
 * The stand holding the bracket, fixed on the top base, rotarting on the bottom one.
 * All dimensions in millimeters
 *
 * @param totalStandWidth Number. Width out all.
 * @param length Number. Length out all.
 * @param height Number. Height of the horizontal axis
 * @param topWidth Number. Width of the top, on which the flaps sit (the ones hnolding the main axis)
 * @param thickness Number. Wall tickness
 * @param verticalAxisDiam Number. Vertical axis diameter
 * @param horizontalAxisDiam Number. Horizontal axis diameter
 * @param flapScrewDiam Number. Diam of the screws fixing the main axis in place
 * @param extDiam Number. Used to find the fixig foot drilling.
 * @param fixingFootSize Number. Used to find the fixig foot drilling.
 * @param screwDiam Number. Used to find the fixig foot drilling.
 * @param minWallThickness Number. Used to find the fixig foot drilling.
 * @param wheelStandDrillingPattern Array. Defvault is defined in all.parts.scad, used to drill the holes for the big wheel stand.
 */
module printMainStand(totalStandWidth, 
											length, 
											height, 
											topWidth, 
											thickness, 
											verticalAxisDiam,
											horizontalAxisDiam, 
											flapScrewDiam,
											extDiam, 
											fixingFootSize, 
											screwDiam, 
											minWallThickness,
											topFeetInside=false,
											wheelStandThickness=10,
											wheelStandDrillingPattern=[],
											fixingFeetOnBase=false,
											printOption=ALL_PARTS) {

	echo(str("--- Current Settings for Main Stand ---"));
  echo(str("Total width...................: ", totalStandWidth));					
  echo(str("Length........................: ", length));												
  echo(str("Height........................: ", height));												
  echo(str("Top length....................: ", topWidth));												
  echo(str("Wall thickness................: ", thickness));												
  echo(str("Verticxal axis diam...........: ", verticalAxisDiam));												
  echo(str("Horizontal axis diam..........: ", horizontalAxisDiam));												
  echo(str("Flap screws diam..............: ", flapScrewDiam));												
  echo(str("Cylinder below ext diam.......: ", extDiam));												
  echo(str("Fixing feet size..............: ", fixingFootSize));												
  echo(str("Fixing feet screw diam........: ", screwDiam));												
  echo(str("Fixing feet min wall thickness: ", minWallThickness));												
  echo(str("Feet inside...................: ", (topFeetInside ? "yes" : "no")));
  echo(str("Wheel stand thickness.........: ", wheelStandThickness));												
												
	difference() {
		mainStand(totalStandWidth, 
							length, 
							height, 
							topWidth, 
							thickness, 
							horizontalAxisDiam, 
							flapScrewDiam,
							baseFixingFeet=fixingFeetOnBase,
							printOption=printOption);
		translate([0, 0, 0]) {
			drillingPattern(extDiam, 
											fixingFootSize, 
											screwDiam, 
											minWallThickness, 
											100, 
											feetInside=topFeetInside);
		}
		// Axis drilling pattern. Same as above.
		dims = getHBScrewDims(verticalAxisDiam);
		headThickness = dims[0];
		len = 20;
		translate([0, 0, 0]) {
			axisDrillingPattern(length=100, diam=verticalAxisDiam);
			// Add Hex Head. TODO an option
			translate([0, 0, -(len + (headThickness * 0.75))]) {
				metalScrewHB(verticalAxisDiam, len);
			}
		}
		// Drill holes for wheel stand
		if (len(wheelStandDrillingPattern) > 0) {
			translate([(topWidth / 6), -((totalStandWidth / 2) - (0 * thickness)), height]) {
				rotate([90, 0, 0]) {
					drillBigWheelStand(wheelStandDrillingPattern, (wheelStandThickness + thickness) * 1.1);
				}
			}
		}
	}
}

/**
 * The counterweight cylinder at the bottom of the panel bracket
 * All dimensions in millimeters
 *
 * @param widthOutAll Number. Bracket's width out all
 * @param thickness Number. Bracket's thickness
 * @param bottomCylinderDiam Number. External cylinder's diameter
 */
module printCylinder(widthOutAll, thickness, bottomCylinderDiam) {
	
	echo(str("--- Current Settings for Cylinder ---"));
  echo(str("Total bracket width......: ", widthOutAll));					
  echo(str("Bracket walls thickness..: ", thickness));					
  echo(str("Cylinder diameter........: ", bottomCylinderDiam));					

	cylinderLength = widthOutAll - (2 * thickness) - (2 * thickness);
	cylinderThickness = 1; // TODO Prm
	counterweightCylinder(cylinderLength, bottomCylinderDiam, cylinderThickness);	
}

/**
 * Print the big wheel stand, drilled.
 *
 * @param wheelDiam Number. Wheel diameter
 * @param centerHoleDiam Number. Axis diameter
 * @param thickness Number. Wheel thickness
 * @param drillingPattern Array of [angle, radius, diam]. See code for details.
 */
module printBigWheelStand(wheelDiam, 
													centerHoleDiam, 
													thickness, 
													drillingPattern) {

	echo(str("--- Current Settings for Big Wheel Stand ---"));
  echo(str("Wheel diam........: ", wheelDiam));					
  echo(str("Axis diam.........: ", centerHoleDiam));					
  echo(str("Stand thickness...: ", thickness));					

	bigWheelStand(wheelDiam, centerHoleDiam, thickness, drillingPattern);
}

/**
 * Horizontal ball bearing stand (used for the worm gear axis).
 * All dimensions in millimeters
 *
 * @param diam Number. Axis diameter.
 * @param height Number. Axis height
 * @param fixingFootSize Number. Used for the fixing feet
 * @param fixingFootWidth Number. Used for the fixing feet 
 * @param screwDiam Number. Used for the fixing feet
 * @param minWallThickness Number. Used for the fixing feet
 */
module printBallBearingStand(diam,
														 height,
														 fixingFootSize, 
														 fixingFootWidth, 
														 screwDiam, 
														 minWallThickness) {
															 
	echo(str("--- Current Settings for Ball Bearing Stand ---"));
  echo(str("Axis diameter...................: ", diam));					
  echo(str("Axis height.....................: ", height));					
  echo(str("Fixing feet Height and Length...: ", fixingFootSize));					
  echo(str("Fixing feet width...............: ", fixingFootWidth));					
  echo(str("Fixing feet screws diameter.....: ", screwDiam));					
  echo(str("Fixing feet min wall thickness..: ", minWallThickness));					

	ballBearingStand(diam,
									 height,
									 fixingFootSize, 
									 fixingFootWidth, 
									 screwDiam, 
									 minWallThickness);
} 

module customPrint() { // You choose!
	
	// A tube under the pinion of the worm gear.
	difference() {
		cylinder(d=10, h=14, $fn=100, center=true);
		cylinder(d=8, h=16, $fn=100, center=true);
	}
	
}

echo("This script will show nothing...");
