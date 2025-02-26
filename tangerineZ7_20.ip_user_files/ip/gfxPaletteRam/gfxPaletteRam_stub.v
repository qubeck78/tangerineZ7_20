// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Sat Jan 18 12:48:41 2025
// Host        : DESKTOP-T3E75FC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/qubeck/Documents/Development/ProjektyVHDL/Zynq7020CoreBoard/tangerineZ7_20/tangerineZ7_20.gen/sources_1/ip/gfxPaletteRam/gfxPaletteRam_stub.v
// Design      : gfxPaletteRam
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *)
module gfxPaletteRam(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="wea[0:0],addra[7:0],dina[23:0],douta[23:0],web[0:0],addrb[7:0],dinb[23:0],doutb[23:0]" */
/* synthesis syn_force_seq_prim="clka" */
/* synthesis syn_force_seq_prim="clkb" */;
  input clka /* synthesis syn_isclock = 1 */;
  input [0:0]wea;
  input [7:0]addra;
  input [23:0]dina;
  output [23:0]douta;
  input clkb /* synthesis syn_isclock = 1 */;
  input [0:0]web;
  input [7:0]addrb;
  input [23:0]dinb;
  output [23:0]doutb;
endmodule
