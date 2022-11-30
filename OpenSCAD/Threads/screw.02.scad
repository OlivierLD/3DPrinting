use <threads-library-by-cuiso-v1.scad>


// A simple SCREW with hexagonal head. See the 'pitch' parameter.
// From https://www.thingiverse.com/thing:3131126/files


BOLT_DIAMETER  = 16;
BOLT_LENGTH    = 35;
HEAD_DIAMETER  = 42;
HEAD_THICKNESS = 16;

// Threaded part. Length includes the head's thickness.
// thread_for_screw(diameter=BOLT_DIAMETER, length=(BOLT_LENGTH + HEAD_THICKNESS)); 
// More threads: smaller pitch
thread_for_screw_fullparm(diameter=BOLT_DIAMETER, length=(BOLT_LENGTH + HEAD_THICKNESS), pitch=3.5);

// Head
cylinder(d=HEAD_DIAMETER, h=HEAD_THICKNESS, $fn=6);
