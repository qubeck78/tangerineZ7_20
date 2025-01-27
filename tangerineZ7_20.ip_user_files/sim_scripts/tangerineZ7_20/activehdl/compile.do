transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/qubeck/Documents/Development/ProjektyVHDL/Zynq7020CoreBoard/tangerineZ7_20/tangerineZ7_20.cache/compile_simlib/activehdl}
vlib activehdl/xilinx_vip
vlib activehdl/xpm
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_14
vlib activehdl/processing_system7_vip_v1_0_16
vlib activehdl/xil_defaultlib
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/proc_sys_reset_v5_0_13
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/axi_register_slice_v2_1_28
vlib activehdl/fifo_generator_v13_2_8
vlib activehdl/axi_data_fifo_v2_1_27
vlib activehdl/axi_crossbar_v2_1_29
vlib activehdl/axi_bram_ctrl_v4_1_8
vlib activehdl/blk_mem_gen_v8_4_6
vlib activehdl/axi_protocol_converter_v2_1_28

vlog -work xilinx_vip  -sv2k12 "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"D:/Xilinx2023.1/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx2023.1/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"D:/Xilinx2023.1/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_14  -sv2k12 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ed63/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_16  -sv2k12 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_processing_system7_0_0/sim/tangerineZ7_20_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_proc_sys_reset_0_0/sim/tangerineZ7_20_proc_sys_reset_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_28  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/87d1/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_8  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/c97d/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_8 -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/c97d/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_8  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/c97d/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_27  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/fab7/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_29  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/f8f3/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_xbar_0/sim/tangerineZ7_20_xbar_0.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_clk_wiz_0_0/tangerineZ7_20_clk_wiz_0_0_clk_wiz.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_clk_wiz_0_0/tangerineZ7_20_clk_wiz_0_0.v" \

vcom -work axi_bram_ctrl_v4_1_8 -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/85f5/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_axi_bram_ctrl_0_0/sim/tangerineZ7_20_axi_bram_ctrl_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_6  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/bb55/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_blk_mem_gen_0_0/sim/tangerineZ7_20_blk_mem_gen_0_0.v" \

vcom -work xil_defaultlib -93  \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_axi_bram_ctrl_1_0/sim/tangerineZ7_20_axi_bram_ctrl_1_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_blk_mem_gen_1_0/sim/tangerineZ7_20_blk_mem_gen_1_0.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_ps2Host_0_0/sim/tangerineZ7_20_ps2Host_0_0.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_is2Controller_0_0/sim/tangerineZ7_20_is2Controller_0_0.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_tangerine_0_0/sim/tangerineZ7_20_tangerine_0_0.v" \

vlog -work axi_protocol_converter_v2_1_28  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/8c02/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/ec67/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/aed8/hdl" "+incdir+../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ipshared/30ef" "+incdir+D:/Xilinx2023.1/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_14 -l processing_system7_vip_v1_0_16 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_13 -l generic_baseblocks_v2_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l blk_mem_gen_v8_4_6 -l axi_protocol_converter_v2_1_28 \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_auto_pc_3/sim/tangerineZ7_20_auto_pc_3.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_auto_pc_0/sim/tangerineZ7_20_auto_pc_0.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_auto_pc_1/sim/tangerineZ7_20_auto_pc_1.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/ip/tangerineZ7_20_auto_pc_2/sim/tangerineZ7_20_auto_pc_2.v" \
"../../../../tangerineZ7_20.gen/sources_1/bd/tangerineZ7_20/sim/tangerineZ7_20.v" \

vlog -work xil_defaultlib \
"glbl.v"

