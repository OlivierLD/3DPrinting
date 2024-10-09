/*
 * Cake stamp.
 * A Stamp on the cake. ELLIE, EVA, FEFE, BABA.
 * Uncomment at will. Works with TEXT.
 *
 * https://dev.to/erikaheidi/how-to-create-letter-molds-and-stamps-for-3d-printing-on-openscad-18am
 */
echo(version=version());

font = "DejaVu Sans:style=Bold";
letter_size = 40;
height = 10;

string = "ELLIE";
// string = "EVA";
// string = "FÉFÉ";
// string = "BABA";
textlen = len(string);

box_width = letter_size*textlen*1.1;
box_height = letter_size*1.5;

union() {
    linear_extrude(1) {
        square([box_width, box_height], center = true);
    }

    linear_extrude(height) {
      rotate([0, 180, 0]) {
        text(string, size = letter_size, font = font, halign = "center", valign = "center", $fn = 64);
      }
    }
}

