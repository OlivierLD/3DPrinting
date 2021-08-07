/*
 * Modified version, for the connector.
 */
difference() { 
  translate([-220, 0, -30]) {
    import("/Users/olivierlediouris/3DPrinting/smartphone-and-tablet-stand-by-bq-3d/cell_phone.stl");
  }
  rotate([80, -13, 40]) {
    translate([-34, 13, -14]) {
      cube(size=[15, 20, 30]);
    }
  }
}
