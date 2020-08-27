/**
 * Camera Stand
 * - with https://www.adafruit.com/product/1434
 * - and a stand like https://www.bhphotovideo.com/c/product/1453863-REG/camvate_c1180_1_4_20_mini_ball_head.html
 * - or https://www.amazon.com/gp/product/B000CNPK3M/ref=oh_aui_search_detailpage?ie=UTF8&psc=1
 *
 * Interesting ones at https://all3dp.com/raspberry-pi-camera-cases-mounts/
 */
 
use <../../mechanical.parts.scad> 
plateThickness = 3; 
baseScrewDiam = .25 * 25.4; // 6;
standThickness = 12;
standHeight = 20;
 
screwDim = getHBScrewDims(baseScrewDiam); 

screwLen = 30;

 module cameraStand() {
   
   difference() {
     union() {
       cube(size=[40, standThickness, standHeight], center=true);
       cylinder(d=20, h=standHeight, center=true, $fn=100);
     }
     translate([0, 0, -6]) {
       cube(size=[50, plateThickness, 12], center=true);
     }
     translate([0, 0, screwLen + screwDim[0]]) {
       rotate([180, 0, 0]) {
         metalScrewHB(baseScrewDiam, screwLen, top=20);
       }
     }
   }
 }
 
 cameraStand();
 