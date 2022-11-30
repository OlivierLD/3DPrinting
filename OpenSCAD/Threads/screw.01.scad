use <threads-library-by-cuiso-v1.scad>


// A simple SCREW with hexagonal head.
// From https://www.thingiverse.com/thing:3131126/files


BOLT_DIAMETER  = 16;
BOLT_LENGTH    = 40;
HEAD_DIAMETER  = 42;
HEAD_THICKNESS = 16;

// Threaded part. Length includes the head's thickness.
thread_for_screw(diameter=BOLT_DIAMETER, length=(BOLT_LENGTH + HEAD_THICKNESS)); 
// Head
cylinder(d=HEAD_DIAMETER, h=HEAD_THICKNESS, $fn=6);
