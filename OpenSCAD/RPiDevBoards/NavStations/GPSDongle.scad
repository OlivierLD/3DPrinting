/*
 * GPS Dongle
 * GPS/GLONASS U-blox7 
 * Like https://www.amazon.com/HiLetgo-G-Mouse-GLONASS-Receiver-Windows/dp/B01MTU9KTF/ref=sr_1_3?keywords=usb+gps+dongle&qid=1691564294&sprefix=USB+GPS%2Caps%2C153&sr=8-3
 */
module GPSDongle() {
  union() {
    translate([0, 0, 0]) {
      rotate([0, 0, 0]) {
        color("white") {
          cube(size=[25, 31, 9], center=true);
        }
      }
    }
    translate([0, -31 / 2, 0]) {
      rotate([0, 0, 0]) {
        color("white") {
          cylinder(h=9, d1=25, d2=25, center=true, $fn=100);
        }
      }
    }
    // USB Socket
    translate([0, 22, 0]) {
      rotate([0, 0, 0]) {
        color("silver") {
          cube(size=[12, 14, 4.5], center=true);
        }
      }
    }
    // Text
    rotate([0, 0, -90]) {
      translate([6, -1, 4.1]) {
         color("black") {
           text("GPS/GLONASS", halign="center", size=3.5);
         }
       }
     }
  }
}

 