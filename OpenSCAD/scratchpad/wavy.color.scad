// Multicolor wavy object
for (i=[0:72]) {
    for (j=[0:72]) {
        color( [0.5+sin(10*i)/2, 0.5+sin(10*j)/2, 0.5+sin(10*(i+j))/2] ) {
            translate( [i - 36, j - 36, 0] ) {
                cube( size = [1, 1, 11+10*cos(10*i)*sin(10*j)] );
            }
        }
    }
 }
 