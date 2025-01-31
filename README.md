Tangerine Z7_20, soc for Qmtech XC7Z020 board. Can be easily adopted to other Zynq boards.
Project compatible with Vivado 2023.1

Contains:
- VGA controller ( framebuffer in DDR ram - AXI4 dma included )
  - 320x240 16bpp RGB565
  - 320x240 8bpp indexed color
  - 640x480 16bpp
  - Text mode overlay ( 40x30, 80x30, 80x60 ), text buffer in BRAM
  - HDMI output
 
- I2S audio controller with fifo
- Dual, bidirectional PS2 controller for keyboard and mouse ( most USB keyboard/mice work with PS2, just add a pullup to 3.3V on D+ and D- lines )

SOC contains custom, minimalistic implementation of AXI4-Lite Slave ( registers ), and AXI4 Master ( VGA DMA ).

Software examples ( Vitis 2023.1 ):

[Tangerine Z7_20 Vitis Workspace repository](https://github.com/qubeck78/tangerineZ7_20_vitis)

- Commanche engine
- Mandelbrot fractal
- MP3 player
- Norton Commander style shell
- Slideshow ( gbm/jpg viewer )
- Tiny Raytracer example

External ports assigned to:
- HDMI
  - DP(0) AA21
  - DP(1) AA22
  - DP(2) V18
  - CLKP Y20
 
- PS2
  - ps2aClock F21
  - ps2aData F22
  - ps2bClock J18
  - ps2bData K18
 
