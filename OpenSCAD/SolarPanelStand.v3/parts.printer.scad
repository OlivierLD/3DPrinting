/**
 * To print all parts 
 * for the solar panel stand
 *
 * Uses all.parts.scad (in the 'use' statement below)
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
 * @param withCylinder Boolean. Set to false to print the bevel gear only
 * @param withMotor Boolean. Draws a motor (for display)
 * @param withBevelGear Boolean. Set to false to print the base only.
 * @param builtTogether Boolean. If withBevelGear == true, print gear together or not
 * @param withGear Boolean.  If withBevelGear == true, print gear.
 * @param withPinion Boolean. If withBevelGear == true, print pinion.
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
									withCylinder = true,
									withMotor = true,
									withBevelGear = true,
									builtTogether = true,
									withGear = true,
									withPinion = true,
									bevelGearScrewCircleRadius = 8,
									bevelGearScrewDiam = 4,
									topCylHeight = 20) {

	echo(str("--- Current Settings for Bottom Base ---"));
  echo(str("Base Height..................................................: ", cylHeight));												
  echo(str("External diameter............................................: ", extDiam));												
  echo(str("Torus diameter...............................................: ", torusDiam));												
  echo(str("Internal diameter............................................: ", intDiam));												
  echo(str("Balls diameter...............................................: ", ballsDiam));												
  echo(str("Fixing feet size (H & L).....................................: ", fixingFootSize));												
  echo(str("Fixing feet width............................................: ", fixingFootWidth));												
  echo(str("Fixing feet screw size.......................................: ", screwDiam));												
  echo(str("Fixing feet min wall thickness...............................: ", minWallThickness));												
  echo(str("Vertical axis diameter.......................................: ", verticalAxisDiam));												

	dims = getBBDims(verticalAxisDiam); // [id, od, t]
										
	if (true) {
		echo(str(">> Ball Bearing, ID :", dims[0]));
		echo(str(">> Ball Bearing, OD :", dims[1]));
		echo(str(">> Ball Bearing, Th :", dims[2]));
	}		
										
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
			if (withCylinder) {
				difference() {
					// Footed Cylinder
					footedBase(cylHeight, 
										 extDiam, 
										 torusDiam, 
										 intDiam, 
										 ballsDiam, 
										 fixingFootSize, 
										 fixingFootWidth, 
										 screwDiam, 
										 minWallThickness, 
										 crosshairThickness=socketTotalHeight,
                     feetFacingUp=true);	
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
					if (withMotor) {
						translate([-extraOffset - motorSocketWallThickness, 0, 0]) {
							rotate([0, 0, -90]) {
								#motor(withScrews=true, wallThickness=motorSocketWallThickness);
							}
						}
					}
				}
							
				// Bottom ball bearing socket, facing down.
				rotate([180, 0, 0]) {
					translate([0, 0, -socketTotalHeight]) {
						difference() {
							// Ball bearing enclosure
							translate([0, 0, 0]) {
								rotate([0, 0, 0]) {
									cylinder(d=dims[1] + socketWallThickness, h=socketTotalHeight, $fn=50);
								}
							}
							// This is "repeated" at the end of the module.
							// Ball bearing socket
							translate([0, 0, bbSocketBaseThickness]) {
								rotate([0, 0, 0]) {
									cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
								}
							}
							// Axis
							translate([0, 0, -5]) { 
								rotate([0, 0, 0]) {
									// Drill. Axis (for debug visualization)
									cylinder(d=(1 * dims[0]), h=dims[2] * 5, $fn=50);
								}
							}
							translate([0, 0, -1]) {
								rotate([0, 0, 0]) {
									// Drill. Axis. Big enough for the washer (or just nut).
									cylinder(d=(dims[0] * 2), h=dims[2] * 5, $fn=50);
								}
							}
						}
					}
				}
			}
			
			// For display (for now) bevel gears pair
			if (withBevelGear) {
				difference() {
					motorAxisHeight = (motorSide + (2 * motorSocketWallThickness)) / 2;
					bevel_gear_height = 11.0997; // Do something smart here. See in bevelGearPair module
					translate([0, 0, motorAxisHeight + bevel_gear_height]) {
						rotate([180, 0, 0]) {
							// TODO Values from parameters
							// The cylinder supporting the gear (facing downward).
							bevelGearPair(gear_teeth=40,
														pinion_teeth = 20,
														base_thickness = 52.5,
														pinion_base_thickness = 5,
														pinion_base_diam = 10,
														base_diam = 40, // Part Cone Diameter at the Cone Base, seems to be like gear_teeth // was 40
														big_axis_diam = 5,
														small_axis_diam = 5,
														build_together = builtTogether,
														with_gear = withGear,
														with_pinion = withPinion,
														screw_circle_radius = bevelGearScrewCircleRadius,
														screw_diam = bevelGearScrewDiam);
						}
					}
					// To print the top crosshair on top of the gear base cylinder
					// inverted one on top, under the rotating stand
					// Comment '#' the printBase2 to see it.
					translate([0, 0, (cylHeight + topCylHeight + 1)]) {
						rotate([180, 0, 0]) {
							printBase2(10, // topCylinderHeight, 
												 extDiam, 
												 torusDiam, 
												 intDiam, 
												 ballsDiam, 
												 fixingFootSize, // 20
												 fixingFootWidth, // 20
												 4, // fixingFootScrewDiam, 
												 minWallThickness, // 4
												 feetInside=true, // topBaseFeetInside,
												 bevelGearScrewDiam=bevelGearScrewDiam);
						}
					}
				}
			}
		}
		// Space for screwdiver or allen key, to fix the motor
		if (!withMotor) {
			translate([-extraOffset -((extDiam - socketDepth) / 2), 0, (motorSide + (2 * motorSocketWallThickness)) / 2]) {
				rotate([0, 90, 180]) {
					motorSocket(socketDepth = socketDepth,
											wallThickness = motorSocketWallThickness,
											placeHolder = false,
											justRedrillScrewHoles = true);
				}
			}
		}
		// Drill everything from bottom
		translate([0, 0, -bbSocketBaseThickness]) {
			rotate([0, 0, 0]) {
				cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
			}
		}
		// Axis
		translate([0, 0, -5]) { 
			rotate([0, 0, 0]) {
				// Drill. Axis (for debug visualization)
				#cylinder(d=(1 * dims[0]), h=dims[2] * 5, $fn=50);
			}
		}
		translate([0, 0, -1]) {
			rotate([0, 0, 0]) {
				// Drill. Axis. Big enough for the washer (or just nut).
				cylinder(d=(dims[0] * 2), h=dims[2] * 5, $fn=50);
			}
		}
	}
}

// WIP. Will need more parameters
module printBase1_v2(bottomCylinderHeight, // see below how it is used
			               topCylinderHeight,
										 extDiam, 
										 torusDiam, 
										 intDiam, 
										 ballsDiam, 
										 fixingFootSize, 
										 fixingFootWidth, 
										 fixingFootScrewDiam, 
										 minFootWallThickness,
										 screwDiam=4,
                     motorSide=42.5,
										 withGearsAndCoupler=true,
                     forBasePrinting=false,
									   forConePrinting=false) {

	if (forBasePrinting && forConePrinting) {
		echo("WARNING: forBasePrinting and forConePrinting are set to true. That might not be right...");
	}

	BETWEEN_AXIS = 19; // mm, for the worm gear used here.

  _motorSide = motorSide;											 
	WITH_GEARS_AND_COUPLER = withGearsAndCoupler; // Set to false for printing, true to visualize
	
	boxWallThickness = 2;
	wormGearSystemHeightFromBottom = 10; // Bottom of the motor socket
											 
	AXIS_HEIGHT = (_motorSide / 2) + boxWallThickness;
	WG_Z_POS = AXIS_HEIGHT + (getSpurGearThickness() / 2);
		
	verticalAxisDiam = 5;
	dims = getBBDims(verticalAxisDiam); // [id, od, t]
	boltDims = getHBScrewDims(verticalAxisDiam);
										
	bbSocketBaseThickness = 3; // Bottom ball bearing in its socket, facing down.
	socketWallThickness = 3;
	
	socketTotalHeight = (dims[2] * 1.1) + (boltDims[0]) + bbSocketBaseThickness;
											 
	// Needed because the feet are oriented upward.										 
  adjustedBaseHeight = bottomCylinderHeight + 17 + wormGearSystemHeightFromBottom;											 

	motorOffset = -65;
	morotSocketDepth = 25;
	tunnelLength = 30;

  if (!forConePrinting) {
		difference() {
			// The base cylinder?
			translate([0, BETWEEN_AXIS, 0]) {
				difference() {
					union() {
						rotate([0, 0, 0]) {
							footedBase(adjustedBaseHeight, 
												 extDiam, 
												 torusDiam, 
												 intDiam, 
												 ballsDiam, 
												 fixingFootSize, 
												 fixingFootWidth, 
												 screwDiam, 
												 minFootWallThickness,
												 crosshairThickness=socketTotalHeight,
												 withCardPoints=false,
												 feetFacingUp=true);
						}
						// Bottom ball bearing socket, facing down.
						rotate([180, 0, 0]) {
							translate([0, 0, -socketTotalHeight]) {
								difference() {
									// Ball bearing enclosure
									translate([0, 0, 0]) {
										rotate([0, 0, 0]) {
											cylinder(d=dims[1] + socketWallThickness, h=socketTotalHeight, $fn=50);
										}
									}
									// This is "repeated" at the end of the module.
									// Ball bearing socket
									translate([0, 0, bbSocketBaseThickness]) {
										rotate([0, 0, 0]) {
											cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
										}
									}
									// Axis
									translate([0, 0, -5]) { 
										rotate([0, 0, 0]) {
											// Drill. Axis (for debug visualization)
											cylinder(d=(1 * dims[0]), h=dims[2] * 5, $fn=50);
										}
									}
									translate([0, 0, -1]) {
										rotate([0, 0, 0]) {
											// Drill. Axis. Big enough for the washer (or just nut).
											cylinder(d=(dims[0] * 2), h=dims[2] * 5, $fn=50);
										}
									}
								}
							}
						}
					}
					// 2 holes, to see the gears through the cylinder
					holeDiam = 35;
					translate([25 * sin(20), -25 * cos(20), WG_Z_POS + wormGearSystemHeightFromBottom]) {
						rotate([90, 0, 20]) {
							cylinder(d=holeDiam, h=50, $fn=100);
						}
					}
					translate([25 * sin(180-20), -25 * cos(180-20), WG_Z_POS + wormGearSystemHeightFromBottom]) {
						rotate([90, 0, 180-20]) {
							cylinder(d=holeDiam, h=50, $fn=100);
						}
					}
					// Space for screwdiver or allen key, to fix the motor
					if (false) {
						extraOffset = 8;
						translate([-extraOffset -((extDiam - morotSocketDepth) / 2), 
											 -BETWEEN_AXIS, 
											 ((_motorSide + (2 * boxWallThickness)) / 2)  + wormGearSystemHeightFromBottom]) {
							rotate([0, 90, 180]) {
								motorSocket(socketDepth = morotSocketDepth,
														wallThickness = boxWallThickness,
														placeHolder = false,
														justRedrillScrewHoles = true);
							}
						}
					}
					// Repeat: Drill everything from bottom
					translate([0, 0, -bbSocketBaseThickness]) {
						rotate([0, 0, 0]) {
							cylinder(d=dims[1], h=((dims[2] * 1.1) + (boltDims[0]) * 1.5), $fn=50);
						}
					}
					// Axis
					translate([0, 0, -5]) { 
						rotate([0, 0, 0]) {
							// Drill. Axis (for debug visualization)
							cylinder(d=(1 * dims[0]), h=dims[2] * 5, $fn=50);
						}
					}
					translate([0, 0, -1]) {
						rotate([0, 0, 0]) {
							// Drill. Axis. Big enough for the washer (or just nut).
							cylinder(d=(dims[0] * 2), h=dims[2] * 5, $fn=50);
						}
					}
				}
			}
			
			// Motor box (and maybe motor, comment it in the code)
			translate([motorOffset, 0, (_motorSide / 2) + boxWallThickness + wormGearSystemHeightFromBottom]) {
				rotate([0, 90, 180]) {
					motorSocket(socketDepth = morotSocketDepth,
											wallThickness = boxWallThickness,
											placeHolder=true);
				}
			}
			// Filler, to expose the face of the motorSocket above // TODO Do the tunnel here?
			translate([motorOffset + (tunnelLength / 2) + (morotSocketDepth / 2), 
			           0, 
			           (_motorSide / 2) + boxWallThickness + wormGearSystemHeightFromBottom]) {
				rotate([0, 90, 180]) {
					motorSocket(socketDepth = tunnelLength,
											wallThickness = 0, // boxWallThickness,
											placeHolder=true);
				}
			}
			
			// Ball Bearing stand, aligned with the motor axis.
			translate([41, 0, wormGearSystemHeightFromBottom]) {
				rotate([0, 0, 180]) {
					ballBearingStand(0.25, // * 25.4,   // TODO, some slack in the OD..
													 AXIS_HEIGHT, // 30,
													 fixingFootSize, 
													 fixingFootWidth, 
													 screwDiam, 
													 minFootWallThickness,
													 justBBSocket=true,
													 drillBottom=true,
													 socketThickness=3);
				}
			}	
			// Redrill axis
			translate([0, BETWEEN_AXIS, WG_Z_POS + wormGearSystemHeightFromBottom]) {
				rotate([0, 180, 90]) {
					translate([BETWEEN_AXIS, 0, 0]) {
						#actobotics615462(axisOnly=true, axisLength=150);
					}
				}
			}
		}

		// Motor box (and maybe motor, comment in the code)
		translate([motorOffset, 0, (_motorSide / 2) + boxWallThickness + wormGearSystemHeightFromBottom]) {
			rotate([0, 90, 180]) {
				motorSocket(socketDepth = morotSocketDepth,
										wallThickness = boxWallThickness,
										placeHolder=false);
			}
			// And a "cheek" on the external side
//			translate([10 + boxWallThickness, 
//								 - (_motorSide / 2) - boxWallThickness, 
//								 - (_motorSide / 2) - boxWallThickness]) {
//				color("green") {
//					cube(size=[10, 2, _motorSide + (2 * boxWallThickness)]);
//				}
//			}
			// The tunnel
			translate([tunnelLength + boxWallThickness - morotSocketDepth, 
								 - (_motorSide / 2) - boxWallThickness, 
								 - (_motorSide / 2) - boxWallThickness]) {
				difference() {
					cube(size=[tunnelLength, 
					           _motorSide + (2 * boxWallThickness), 
					           _motorSide + (2 * boxWallThickness)], center=false);
					translate([0, boxWallThickness, boxWallThickness]) {
						cube(size=[tunnelLength + 1, 
											 _motorSide + (0 * boxWallThickness), 
											 _motorSide + (0 * boxWallThickness)], center=false);
					}
					// Remove what's inside the cylinder
					translate([(tunnelLength + boxWallThickness - morotSocketDepth) + (intDiam / 2), 
										 ((_motorSide + (2 * boxWallThickness)) / 2) + BETWEEN_AXIS, 
										 WG_Z_POS - (2 * boxWallThickness)]) {
						cylinder(d=intDiam, h=(_motorSide + (2 * boxWallThickness)) * 1.1, center=true, $fn=100);
					}
				}
			}
		}

		// Worm Gear
		if (WITH_GEARS_AND_COUPLER) {
			translate([0, BETWEEN_AXIS, WG_Z_POS + wormGearSystemHeightFromBottom]) {
				rotate([0, 180, 90]) {
					difference() {
						actobotics615464(); // The gear
						// #actobotics615464(justDrillHoles=true, holeDepth=20); // Drilling
					}
					translate([BETWEEN_AXIS, 0, 0]) {
						actobotics615462();
						%actobotics615462(axisOnly=true, axisLength=150);
					}
				}
			}
			difference() {
				// Coupler 
				translate([-25, 0, AXIS_HEIGHT + wormGearSystemHeightFromBottom]) {
					rotate([0, 90, 0]) {
						color("silver") {
							cylinder(d=10.6, h=19, $fn=50, center=true);
						}
					}
				}	
				// Redrill axis
				translate([0, BETWEEN_AXIS, WG_Z_POS + wormGearSystemHeightFromBottom]) {
					rotate([0, 180, 90]) {
						translate([BETWEEN_AXIS, 0, 0]) {
							actobotics615462(axisOnly=true, axisLength=150);
						}
					}
				}
			}
		}
		// Ball Bearing stand, horizontal axis
		difference() {
			translate([41, 0, wormGearSystemHeightFromBottom]) {
				rotate([0, 0, 180]) {
					ballBearingStand(0.25, //  * 25.4,
													 AXIS_HEIGHT, // 30,
													 fixingFootSize, 
													 fixingFootWidth, 
													 screwDiam, 
													 minFootWallThickness,
													 justBBSocket=true,
													 drillBottom=true,
													 socketThickness=3);
				}
			}	
			// Re drill worm gear axis
			translate([0, BETWEEN_AXIS, WG_Z_POS + wormGearSystemHeightFromBottom]) {
				rotate([0, 180, 90]) {
					translate([BETWEEN_AXIS, 0, 0]) {
						#actobotics615462(axisOnly=true, axisLength=150);
					}
				}
			}
		}
	}
	
	if (!forBasePrinting) {
		translate([0, BETWEEN_AXIS, 0]) {
		
			bevelGearScrewDiam = 4;	
			bevelGearScrewCircleRadius = 8;
		
			difference() {
				translate([0, 0,  WG_Z_POS + wormGearSystemHeightFromBottom]) {
					rotate([180, 0, 0]) {
						// The cone/cylinder supporting the gear (facing downward).
						wormGearWheelSupport(support_height = adjustedBaseHeight + topCylinderHeight - WG_Z_POS - wormGearSystemHeightFromBottom,
																 big_base_diam = 40, 
																 small_base_diam = getSpurGearOD(),
																 vert_axis_diam = 5,
																 screw_circle_radius = bevelGearScrewCircleRadius,
																 screw_diam = bevelGearScrewDiam);
					}
				}
				// Drill holes for the worm gear spur
				translate([0, 0, WG_Z_POS + wormGearSystemHeightFromBottom]) {
					rotate([0, 180, 0]) {
						// #actobotics615464(); // The gear 
						ratio = 0.5;
						echo(str("Drilling for spur gear at ", getSpurGearScrewDiam() * ratio));
						actobotics615464(justDrillHoles=true, holeDepth=20, holeDiam=getSpurGearScrewDiam() * ratio); // Drilling
					}
				}
				
				// To print the top crosshair on top of the gear base cylinder
				// inverted one on top, under the rotating stand
				// Comment '#' the printBase2 to see it.
				// + 1 is the slack for the balls
				translate([0, 0, (adjustedBaseHeight + topCylinderHeight + 1)]) {
					rotate([180, 0, 0]) {
						printBase2(topCylinderHeight, 
											 extDiam, 
											 torusDiam, 
											 intDiam, 
											 ballsDiam, 
											 fixingFootSize, // 20
											 fixingFootWidth, // 20
											 4, // fixingFootScrewDiam, 
											 minFootWallThickness, // 4
											 feetInside=true, // topBaseFeetInside,
											 bevelGearScrewDiam=bevelGearScrewDiam);
					}
				}
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
									feetInside = false,
									bevelGrearScrewCircleRadius = 8,
									bevelGearScrewDiam = 4) {

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
  echo(str("Screw Circle Radius.......: ", bevelGrearScrewCircleRadius));												

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
		// Drill bevel base screws
		screw_length = 60;
		for (angle=[0, 120, 240]) {
			rotate([0, 0, angle]) {
				translate([bevelGrearScrewCircleRadius, 0, 0/*-(screw_length + 5)*/]) {
					cylinder(d=bevelGearScrewDiam, h=50, center=true, $fn=40);
					// metalScrewHB(diam=bevelGearScrewDiam, length=screw_length, top=20);
				}
			}
		}
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
											gearBaseScrewCircleRadius=8,
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
							gearBaseScrewCircleRadius=gearBaseScrewCircleRadius,
							printOption=printOption);
		translate([0, 0, 0]) {
			drillingPattern(extDiam, 
											fixingFootSize, 
											screwDiam, 
											minWallThickness, 
											100, 
											feetInside=topFeetInside,
											gearBaseScrewCircleRadius=gearBaseScrewCircleRadius);
		}
		// Axis drilling pattern. Same as above.
		dims = getHBScrewDims(verticalAxisDiam);
		headThickness = dims[0];
		len = 20;
		translate([0, 0, 0]) {
			axisDrillingPattern(length=100, diam=verticalAxisDiam);
			// Add Hex Head. TODO an option
			if (false) {
				translate([0, 0, -(len + (headThickness * 0.75))]) {
					// #metalScrewHB(verticalAxisDiam, len);
					cylinder(h=len * 2, d=verticalAxisDiam, center=false);
				}
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

echo("+---------------------------------");
echo("| This script will show nothing...");
echo("+---------------------------------");
