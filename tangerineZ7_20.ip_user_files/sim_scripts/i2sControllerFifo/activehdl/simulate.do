transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+i2sControllerFifo  -L xilinx_vip -L xpm -L fifo_generator_v13_2_8 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.i2sControllerFifo xil_defaultlib.glbl

do {i2sControllerFifo.udo}

run 1000ns

endsim

quit -force
