//
// Various reusable utilities
//
/**
 * size is a triplet [x, y, z]
 * radius if the radius of the rounded corner
 */
module roundedRect(size, radius) {
	linear_extrude(height=size.z, center=true) {
		offset(radius) offset(-radius) {
			square([size.x, size.y], center = true);
		}
	}
}
