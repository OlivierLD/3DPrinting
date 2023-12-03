# Navigation Stations

## Small one, with optional e-ink Bonnet
GPS and Power supply externalized.  
[Code](../ProjectBoxRPiZeroBox.scad), 
[Details](https://github.com/OlivierLD/ROB/blob/master/raspberry-sailor/MUX-implementations/NMEA-multiplexer-basic/HOWTO.md)

| Empty                       | With a Raspberry Pi            | With Top                 |
|:---------------------------:|:------------------------------:|:------------------:|
| ![Empty](./small.empty.png) | ![WithRPi](./small.no.top.png) | ![WithTop](./small.with.top.png) |

## Autonomous, self contained, with optional e-ink Bonnet
GPS, Power Bank, e-ink bonnet.  The software part is the same as above.  

[3D part Code](./raspberry.pi.zero.custom.plate.scad)


| | |
|:-----------------------------------------------:|:-----------------------------------------------:|
| ![Pic.01](./raspberry.pi.zero.custom.plate.png) | ![Pic.02](./raspberry.pi.zero.custom.plate.eink.png) | 
| No e-ink screen | With e-ink screen |
| ![Pic.03](./raspberry.pi.zero.custom.plate.wtop.png) | ![For real](./pix/full-station.jpg) |
| with top | For real |

### With a BME280 (for PRMSL)
| | |
|:-------------:|:------------:|
| ![Barograph](../BarographBox.png) | ![The box](./pix/01.the.box.jpg) |
| A bigger box, for I2C connection on the header | Printed |
| ![The lid](./pix/02.printing.jpg) | ![](./pix/03.first.test.jpg) |
| Printing the lid | First test |
| ![For real, one](./pix/inplace.01.jpg) | ![For real, two](./pix/inplace.02.jpg) |
| Ready to go, one | Ready to go, two |


## RasPi A+
BME280 and Oled Screen  
[Code](../../RPiA+Logger/rpi.aplus.enclosure.scad), [Details](https://github.com/OlivierLD/ROB/blob/master/raspberry-sailor/MUX-implementations/NMEA-multiplexer-basic/use_cases/USE_CASES_2.md)


## TODO
- With a compass (magnetometer)
- Document the Barograph / Thermograph, with a BMP180, BME180 or BME280
    - A Barograph is a very useful instrument for marine weather and forecasts. But it can be quite expensive (see [here](https://www.naudet.com/barometre-enregistreur-c102x2726134)). We'll trry to build one with a Raspberry Pi Zero, and a sensor like a BME280 sensor (less that $2.00).
