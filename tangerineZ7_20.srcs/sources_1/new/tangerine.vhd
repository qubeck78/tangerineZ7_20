----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 12:26:02
-- Design Name: 
-- Module Name: tangerine - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

--axi slave fix
--https://zipcpu.com/blog/2021/05/22/vhdlaxil.html

--axi lite protocol
--https://zipcpu.com/blog/2020/03/08/easyaxil.html
--https://zipcpu.com/formal/2018/12/28/axilite.html
--https://zipcpu.com/blog/2020/03/23/wbm2axisp.html
--https://www.realdigital.org/doc/a9fee931f7a172423e1ba73f66ca4081
--https://adaptivesupport.amd.com/s/article/1053935?language=en_US
--https://sites.google.com/site/calandigital/tutorials/red-pitaya/custom-axi-lite-slave
--https://indico.ictp.it/event/8342/session/16/contribution/101/material/slides/0.pdf
--https://github.com/suoglu/AXI-lite-slave/blob/main/Sources/ip_repo/artyA7_gpio_1.0/hdl/artyA7_gpio_v1_0.v

--axi master
--https://habr.com/en/articles/572926/
--https://developer.arm.com/documentation/102202/0300/Channel-signals

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;
    
entity tangerine is
port( 
   --axi4-lite bus 00 - root registers
   s00_axi_aclk:     in  std_logic;
   s00_axi_aresetn:  in  std_logic;
   s00_axi_awaddr:   in  std_logic_vector( 31 downto 0 );
   s00_axi_awprot:   in  std_logic_vector( 2 downto 0 );
   s00_axi_awvalid:  in  std_logic;
   s00_axi_awready:  out std_logic;
   s00_axi_wdata:    in  std_logic_vector( 31 downto 0 );
   s00_axi_wstrb:    in  std_logic_vector( 3 downto 0 );
   s00_axi_wvalid:   in  std_logic;
   s00_axi_wready:   out std_logic;
   s00_axi_bresp:    out std_logic_vector( 1 downto 0 );
   s00_axi_bvalid:   out std_logic;
   s00_axi_bready:   in  std_logic;
   s00_axi_araddr:   in  std_logic_vector( 31 downto 0 );
   s00_axi_arprot:   in  std_logic_vector( 2 downto 0 );
   s00_axi_arvalid:  in  std_logic;
   s00_axi_arready:  out std_logic;
   s00_axi_rdata:    out std_logic_vector( 31 downto 0 );
   s00_axi_rresp:    out std_logic_vector( 1 downto 0 );
   s00_axi_rvalid:   out std_logic;
   s00_axi_rready:   in  std_logic;

   --axi4-lite bus 01 - gfx pixel gen registers
   s01_axi_aclk:     in  std_logic;
   s01_axi_aresetn:  in  std_logic;
   s01_axi_awaddr:   in  std_logic_vector( 31 downto 0 );
   s01_axi_awprot:   in  std_logic_vector( 2 downto 0 );
   s01_axi_awvalid:  in  std_logic;
   s01_axi_awready:  out std_logic;
   s01_axi_wdata:    in  std_logic_vector( 31 downto 0 );
   s01_axi_wstrb:    in  std_logic_vector( 3 downto 0 );
   s01_axi_wvalid:   in  std_logic;
   s01_axi_wready:   out std_logic;
   s01_axi_bresp:    out std_logic_vector( 1 downto 0 );
   s01_axi_bvalid:   out std_logic;
   s01_axi_bready:   in  std_logic;
   s01_axi_araddr:   in  std_logic_vector( 31 downto 0 );
   s01_axi_arprot:   in  std_logic_vector( 2 downto 0 );
   s01_axi_arvalid:  in  std_logic;
   s01_axi_arready:  out std_logic;
   s01_axi_rdata:    out std_logic_vector( 31 downto 0 );
   s01_axi_rresp:    out std_logic_vector( 1 downto 0 );
   s01_axi_rvalid:   out std_logic;
   s01_axi_rready:   in  std_logic;
    
-- AXI Master

   m00_axi_aclk:     in  std_logic;
   m00_axi_aresetn:  in  std_logic;

   m00_axi_awaddr:   out std_logic_vector( 31 downto 0 );
   m00_axi_awprot:   out std_logic_vector( 2 downto 0 );
   m00_axi_awvalid:  out std_logic;
   m00_axi_awready:  in  std_logic;
   m00_axi_wdata:    out std_logic_vector( 31 downto 0 );
   m00_axi_wstrb:    out std_logic_vector( 3 downto 0 );
   m00_axi_wvalid:   out std_logic;
   m00_axi_wready:   in  std_logic;
   m00_axi_bresp:    in  std_logic_vector( 1 downto 0) ;
   m00_axi_bvalid:   in  std_logic;
   m00_axi_bready:   out std_logic;
   
   m00_axi_araddr:   out std_logic_vector( 31 downto 0 );
   m00_axi_arprot:   out std_logic_vector( 2 downto 0 );
   m00_axi_arvalid:  out std_logic;
   m00_axi_arready:  in  std_logic;
   m00_axi_rdata:    in  std_logic_vector( 31 downto 0 );
   m00_axi_rresp:    in  std_logic_vector( 1 downto 0 );
   m00_axi_rvalid:   in  std_logic;
   m00_axi_rready:   out std_logic;
   
   -- Extended AXI Master Signals
   m00_axi_arid:     out std_logic_vector ( 3 downto 0 );
   m00_axi_arlen:    out std_logic_vector ( 7 downto 0 );
   m00_axi_arsize:   out std_logic_vector ( 2 downto 0 );
   m00_axi_arburst:  out std_logic_vector ( 1 downto 0 );
   m00_axi_arlock:   out std_logic;
   m00_axi_arcache:  out std_logic_vector ( 3 downto 0 );
   m00_axi_rid:      in  std_logic_vector ( 3 downto 0 );
   m00_axi_rlast:    in  std_logic;
   
   m00_axi_awid:     out std_logic_vector ( 3 downto 0 );
   m00_axi_awlen:    out std_logic_vector ( 7 downto 0 );
   m00_axi_awsize:   out std_logic_vector ( 2 downto 0 );
   m00_axi_awburst:  out std_logic_vector ( 1 downto 0 );
   m00_axi_awlock:   out std_logic;
   m00_axi_wlast:    out std_logic;
   m00_axi_awcache:  out std_logic_vector ( 3 downto 0 );

   --reset, clock
   resetn:         in      std_logic;
   pixelClk:       in      std_logic;
   pixelClk5x:     in      std_logic;
   pixelClk5xps:   in      std_logic;
    
   --block ram ( text mode )
   br1Clk:          out     std_logic;
   br1Rst:          out     std_logic;
    
   br1AddrOut:      out     std_logic_vector( 31 downto 0 );
   br1DOut:         out     std_logic_vector( 31 downto 0 );
   br1DIn:          in      std_logic_vector( 31 downto 0 );
   br1En:           out     std_logic;
   br1We:           out     std_logic_vector( 3 downto 0 );
    
   --block ram ( gfx )
--   br2Clk:          out     std_logic;
--   br2Rst:          out     std_logic;
    
--   br2AddrOut:      out     std_logic_vector( 31 downto 0 );
--   br2DOut:         out     std_logic_vector( 31 downto 0 );
--   br2DIn:          in      std_logic_vector( 31 downto 0 );
--   br2En:           out     std_logic;
--   br2We:           out     std_logic_vector( 3 downto 0 );

   --hdmi out    
   hdmiClkP:   out     std_logic;
   hdmiClkN:   out     std_logic;
    
   hdmiDP:     out     std_logic_vector( 2 downto 0 );
   hdmiDN:     out     std_logic_vector( 2 downto 0 )

);
end tangerine;

--https://stackoverflow.com/questions/46732105/combine-ports-to-bram-interface
--tools/language templates / IP Integrator HDL / Advanced interfaces/ block ram interface
--after grouping is done set master type interface via diagram by selecting port/ window: block interface properties/ expand config / MASTER_TYPE = BRAM_CTRL

--axi4 master
--https://zipcpu.com/blog/2019/04/27/axi-addr.html

architecture Behavioral of tangerine is

--attributes

  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO of br1En: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 EN";
  ATTRIBUTE X_INTERFACE_INFO of br1DOut: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 DIN";
  ATTRIBUTE X_INTERFACE_INFO of br1DIn: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 DOUT";
  ATTRIBUTE X_INTERFACE_INFO of br1We: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 WE";
  ATTRIBUTE X_INTERFACE_INFO of br1AddrOut: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 ADDR";
  ATTRIBUTE X_INTERFACE_INFO of br1Clk: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 CLK";
  ATTRIBUTE X_INTERFACE_INFO of br1Rst: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM1 RST";

--  ATTRIBUTE X_INTERFACE_INFO of br2En: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 EN";
--  ATTRIBUTE X_INTERFACE_INFO of br2DOut: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 DIN";
--  ATTRIBUTE X_INTERFACE_INFO of br2DIn: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 DOUT";
--  ATTRIBUTE X_INTERFACE_INFO of br2We: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 WE";
--  ATTRIBUTE X_INTERFACE_INFO of br2AddrOut: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 ADDR";
--  ATTRIBUTE X_INTERFACE_INFO of br2Clk: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 CLK";
--  ATTRIBUTE X_INTERFACE_INFO of br2Rst: SIGNAL is "xilinx.com:interface:bram:1.0 BLOCK_RAM2 RST";

--components

--dvi encoder
component dvid
port(
    clk:        in  std_logic;
    clk_n:      in  std_logic;
    clk_pixel:  in  std_logic;
    red_p:      in  std_logic_vector(7 downto 0);
    green_p:    in  std_logic_vector(7 downto 0);
    blue_p:     in  std_logic_vector(7 downto 0);
    blank:      in  std_logic;
    hsync:      in  std_logic;
    vsync:      in  std_logic;          
    red_s:      out std_logic;
    green_s:    out std_logic;
    blue_s:     out std_logic;
    clock_s:    out std_logic
);
end component;  

-- font rom
component fontPROM
port (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
);
end component; 

-- text mode pixel and sync gen
component pixelGenTxt
    port(
        --reset
        reset:          in  std_logic;
        pgClock:        in  std_logic;
        pgVSync:        out std_logic;
        pgHSync:        out std_logic;
        pgDe:           out std_logic;
        pgR:            out std_logic_vector( 7 downto 0 );
        pgG:            out std_logic_vector( 7 downto 0 );
        pgB:            out std_logic_vector( 7 downto 0 );

        fontRomA:       out std_logic_vector( 10 downto 0 );
        fontRomDout:    in  std_logic_vector( 7 downto 0 );

        videoRamBA:     out std_logic_vector( 13 downto 0 );
        videoRamBDout:  in  std_logic_vector( 15 downto 0 );
        
        pgXCount:       out std_logic_vector( 11 downto 0 );
        pgYCount:       out std_logic_vector( 11 downto 0 );
        pgDeX:          out std_logic;
        pgDeY:          out std_logic;
        pgPreFetchLine: out std_logic;
        pgFetchEnable:  out std_logic;
    
        pgVideoMode:      in  std_logic_vector( 1 downto 0 );
        pgCursorX:        in  std_logic_vector( 7 downto 0 );
        pgCursorY:        in  std_logic_vector( 7 downto 0 )
    );
end component;


-- gfx pixel gen
component pixelGenGfx is
port(
   
   --cpu interface
   reset:            in  std_logic;
   clock:            in  std_logic;
    
   a:                in  std_logic_vector( 15 downto 0 );
   din:              in  std_logic_vector( 31 downto 0 );
   dout:             out std_logic_vector( 31 downto 0 );
    
   ce:               in  std_logic;
   wr:               in  std_logic;
   dataMask:         in  std_logic_vector( 3 downto 0 );
    
   ready:            out std_logic;
    
   pggClock:         in  std_logic;
   pggR:             out std_logic_vector( 7 downto 0 );
   pggG:             out std_logic_vector( 7 downto 0 );
   pggB:             out std_logic_vector( 7 downto 0 );

    --gfx buffer ram
   gfxBufRamDOut:    in  std_logic_vector( 31 downto 0 );
   gfxBufRamRdA:     out std_logic_vector( 8 downto 0 );

   --2 dma requests
   pggDMARequest:    out std_logic_vector( 1 downto 0 );
   
   --sync gen outputs
   pgVSync:          in  std_logic;
   pgHSync:          in  std_logic;
   pgDe:             in  std_logic;
   pgXCount:         in  std_logic_vector( 11 downto 0 );
   pgYCount:         in  std_logic_vector( 11 downto 0 );
   pgDeX:            in  std_logic;
   pgDeY:            in  std_logic;
   pgPreFetchLine:   in  std_logic;
   pgFetchEnable:    in  std_logic;

   pgVideoMode:      in  std_logic_vector( 1 downto 0 );
   pgEnabled:        in  std_logic

   );
end component; 
 
--sprite gen for mouse pointer
component spriteGen is
port (

    --cpu interface
    reset:      in  std_logic;
    clock:      in  std_logic;
    
    a:          in  std_logic_vector( 15 downto 0 );
    din:        in  std_logic_vector( 31 downto 0 );
    dout:       out std_logic_vector( 31 downto 0 );
    
    ce:         in  std_logic;
    wr:         in  std_logic;
    dataMask:   in  std_logic_vector( 3 downto 0 );
    
    ready:      out std_logic;
    
    --sync gen inputs
    pgDe:       in  std_logic;
    pgXCount:   in  std_logic_vector( 11 downto 0 );
    pgYCount:   in  std_logic_vector( 11 downto 0 );
    
    --video out
    sgClock:    in  std_logic;
    pgVSync:    in  std_logic;
    pgHSync:    in  std_logic;
        
    sgR:        out std_logic_vector( 7 downto 0 );
    sgG:        out std_logic_vector( 7 downto 0 );
    sgB:        out std_logic_vector( 7 downto 0 )
    
);
end component;

component gfxBufRam is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end component;

component inputSync

    generic(
        inputWidth              : integer := 1
    );

    port(

        clock:                          in  std_logic;

        signalInput:                    in  std_logic_vector( inputWidth - 1 downto 0 );
        signalOutput:                   out std_logic_vector( inputWidth - 1 downto 0 )

    );

end component;

--signals

signal  reset:              std_logic;

--HDMI conn signals ( single ended )

signal  hdmiPixelClock:     std_logic;
signal  hdmiEncodedData:    std_logic_vector( 2 downto 0 );

--vga
signal  vgaRed:             std_logic_vector( 7 downto 0 );
signal  vgaGreen:           std_logic_vector( 7 downto 0 );
signal  vgaBlue:            std_logic_vector( 7 downto 0 );
signal  vgaHSync:           std_logic;
signal  vgaVSync:           std_logic;
signal  vgaBlank:           std_logic; 

--font rom signals
signal fontRomA:        std_logic_vector( 10 downto 0 );
signal fontRomDout:     std_logic_vector( 7 downto 0 );

-- video mux signals
signal vmMode:          std_logic_vector( 15 downto 0 );

-- txt pixel gen signals
signal pgVSync:          std_logic;
signal pgHSync:          std_logic;
signal pgDe:             std_logic;
signal pgR:              std_logic_vector( 7 downto 0 );
signal pgG:              std_logic_vector( 7 downto 0 );
signal pgB:              std_logic_vector( 7 downto 0 ); 
signal pgXCount:         std_logic_vector( 11 downto 0 );
signal pgYCount:         std_logic_vector( 11 downto 0 );
signal pgDeX:            std_logic;
signal pgDeY:            std_logic;
signal pgPreFetchLine:   std_logic;
signal pgFetchEnable:    std_logic;
signal videoRamBDout:    std_logic_vector( 15 downto 0 );
signal videoRamBA:       std_logic_vector( 13 downto 0 ); 
signal pgCursorX:        std_logic_vector( 7 downto 0 );
signal pgCursorY:        std_logic_vector( 7 downto 0 );

--vsync signal synchronised to cpu clock domain
signal pgVSyncClkD2:     std_logic;

--gfx pixel gen signals

signal pggRegsClock:          std_logic;
signal pggRegsDoutForCPU:     std_logic_vector( 31 downto 0 );
signal pggRegsCE:             std_logic;
signal pggRegsWr:             std_logic;
signal pggRegsReady:          std_logic;
signal pggRegsA:              std_logic_vector( 15 downto 0 );
signal pggRegsDIn:            std_logic_vector( 31 downto 0 );
signal pggRegsDOut:           std_logic_vector( 31 downto 0 );

signal pgEnabled:             std_logic;
signal pggR:                  std_logic_vector( 7 downto 0 );
signal pggG:                  std_logic_vector( 7 downto 0 );
signal pggB:                  std_logic_vector( 7 downto 0 ); 
signal pggDMARequest:         std_logic_vector( 1 downto 0 );

signal gfxBufRamClock:        std_logic;
signal gfxBufRamDOut:         std_logic_vector( 31 downto 0 );
signal gfxBufRamRdA:          std_logic_vector( 8 downto 0 );

--dma signals
type   dmaState_T is ( dsIdle, dsCh0AxiRead0, dsCh0AxiRead1, dsCh0AxiRead2 );
                               
signal dmaState:            dmaState_T;

signal dmaClock:            std_logic;

--ch0 signals
signal ch0DmaRequest:           std_logic_vector( 1 downto 0 );
signal ch0DmaPointerReset:      std_logic;


signal ch0DmaRequestLatched:    std_logic_vector( 1 downto 0 );
signal ch0DmaPointerStart:      std_logic_vector( 31 downto 0 );
signal ch0DmaPointer:           std_logic_vector( 31 downto 0 );

signal ch0DmaRequestLength:     std_logic_vector( 7 downto 0 );
signal ch0DmaRequest0PtrAdd:    std_logic_vector( 15 downto 0 );
signal ch0DmaRequest1PtrAdd:    std_logic_vector( 15 downto 0 );

signal ch0BufRamDin:            std_logic_vector( 31 downto 0 );
signal ch0BufRamWrA:            std_logic_vector( 8 downto 0 );
signal ch0BufRamWr:             std_logic;
signal ch0TransferCounter:      std_logic_vector( 7 downto 0 );
signal ch0DmaBufPointer:        std_logic_vector( 8 downto 0 );

-- tick timer signals
signal tickTimerClock:            std_logic;
signal tickTimerReset:            std_logic;
signal tickTimerPrescalerCounter: std_logic_vector( 31 downto 0 );
signal tickTimerCounter:          std_logic_vector( 31 downto 0 );

constant tickTimerPrescalerValue:   integer:=   100000 - 1;  --1ms tick timer @100MHz

-- frameTimer signals
signal frameTimerClock:         std_logic;
signal frameTimerReset:         std_logic;
signal frameTimerPgPrvVSync:    std_logic;
signal frameTimerValue:         std_logic_vector( 31 downto 0 );


--axi slave
type axiState_T is ( asIdle, asRead0, asRead1, asRead2, asRead3, 
                             asWrite0, asWrite1, asWrite2, asWrite3 );

--axi slave 0
signal axiS0State:     axiState_T;

--axi slave 1
signal axiS1State:     axiState_T;

begin

    --fill unused signals        
    br1En       <= '1';
    br1We       <= "0000";
    br1DOut     <= ( others => '0' );
    br1Rst      <= '0';

--    br2En       <= '1';
--    br2We       <= "0000";
--    br2DOut     <= ( others => '0' );
--    br2Rst      <= '0';

    --axi master
    
    --write channel not used
    m00_axi_awvalid     <= '0';
    m00_axi_awaddr      <= ( others => '0' );
    m00_axi_awprot      <= ( others => '0' );
    m00_axi_awcache     <= ( others => '0' );
    m00_axi_wvalid      <= '0';
    m00_axi_wdata       <= ( others => '0' );
    m00_axi_wstrb       <= ( others => '0' );
    m00_axi_bready      <= '0';
    
    
    
    --reset
    reset   <= not resetn;    

    --route clocks
    pggRegsClock    <=  s01_axi_aclk;
    tickTimerClock  <=  s00_axi_aclk;    
    frameTimerClock <=  s00_axi_aclk;
    dmaClock        <=  m00_axi_aclk;
--    br2Clk          <=  dmaClock;
    gfxBufRamClock  <=  not pixelClk;
        
    --sync signals from pixel clock domain to axi clock
    
   inputSyncPgVSyncInst: inputSync
    generic map(
    
        inputWidth => 1

    )
    port map(

        clock              => s00_axi_aclk,
        signalInput(0)     => pgVSync,
        signalOutput(0)    => pgVSyncClkD2

    );
   
        
    --connect block ram 1 to pixel gen
    br1Clk          <=  pixelClk;
    br1AddrOut      <=  "0" & x"0000" & videoRamBA( 13 downto 1 ) & "00";
    videoRamBDout   <=  br1DIn( 15 downto 0 ) when videoRamBA( 0 ) = '0' else br1DIn( 31 downto 16 ); 

    --place diff buffers
    
    OBUFDS_blue:    OBUFDS port map ( O  => hdmiDP(0), OB => hdmiDN(0), I  => hdmiEncodedData(0) );
    OBUFDS_green:   OBUFDS port map ( O  => hdmiDP(1), OB => hdmiDN(1), I  => hdmiEncodedData(1) );
    OBUFDS_red:     OBUFDS port map ( O  => hdmiDP(2), OB => hdmiDN(2), I  => hdmiEncodedData(2) );
    OBUFDS_clock:   OBUFDS port map ( O  => hdmiClkP, OB => hdmiClkN, I  => hdmiPixelClock );  
    
    dvidInst: dvid 
    port map(
    
        --inputs ( vga, clocks )
        clk       => pixelClk5x,
        clk_n     => pixelClk5xps, 
        clk_pixel => pixelClk,
        red_p     => vgaRed,
        green_p   => vgaGreen,
        blue_p    => vgaBlue,
        blank     => vgaBlank,
        hsync     => vgaHSync,
        vsync     => vgaVSync,
        
        --outputs ( hdmi )  
        red_s     => hdmiEncodedData(2),
        green_s   => hdmiEncodedData(1),
        blue_s    => hdmiEncodedData(0),
        clock_s   => hdmiPixelClock
        
        );  
    
-- place text mode font rom ( 2048 x 8 )

fontPromInst: fontProm 
port map(
    clka    => pixelClk,
    addra   => fontRomA,
    douta   => fontRomDout
);
    
--Place txt pixel gen

pixelGenInst: pixelGenTxt
port map(
    reset           => reset,
    pgClock         => pixelClk,

    pgVSync         => pgVSync,
    pgHSync         => pgHSync,
    pgDe            => pgDe,
    pgR             => pgR,
    pgG             => pgG,
    pgB             => pgB,

    fontRomA        => fontRomA,
    fontRomDout     => fontRomDout,

    videoRamBA      => videoRamBA,
    videoRamBDout   => videoRamBDout,
        
    pgXCount        => pgXCount,
    pgYCount        => pgYCount,
    pgDeX           => pgDeX,
    pgDeY           => pgDeY,
    pgPreFetchLine  => pgPreFetchLine,
    pgFetchEnable   => pgFetchEnable,
      
    pgVideoMode     => vmMode( 3 downto 2 ),
    pgCursorX       => pgCursorX,
    pgCursorY       => pgCursorY
    
);   

--place gfx pixel gen

pgEnabled   <= '1' when vmMode( 1 downto 0 ) /= "00" else '0';


pixelGenGfxInst: pixelGenGfx
port map(
    reset             => reset,
    clock             => pggRegsClock,
    a                 => pggRegsA,
    din               => pggRegsDIn,
    dout              => pggRegsDOut,
    ce                => pggRegsCE,
    wr                => pggRegsWr,
    dataMask          => "1111",
    ready             => pggRegsReady,
    
    pggClock          => pixelClk,

    pggR              => pggR,
    pggG              => pggG,
    pggB              => pggB,

    --gfx buffer ram
    gfxBufRamDOut     => gfxBufRamDOut,
    gfxBufRamRdA      => gfxBufRamRdA,

    --2 dma requests
    pggDMARequest     => pggDMARequest,

    --sync gen outputs
    pgVSync           => pgVSync,
    pgHSync           => pgHSync,
    pgDe              => pgDe,
    pgXCount          => pgXCount,
    pgYCount          => pgYCount,
    pgDeX             => pgDeX,
    pgDeY             => pgDeY,
    pgPreFetchLine    => pgPreFetchLine,
    pgFetchEnable     => pgFetchEnable,

    pgVideoMode       => vmMode( 5 downto 4 ),
    pgEnabled         => pgEnabled
); 

--place gfx buf ram ( ch0 )
gfxBufRamInst:gfxBufRam
port map( 
    clka    => gfxBufRamClock,
    wea(0)  => '0',
    addra   => gfxBufRamRdA,
    dina    => ( others => '0' ),
    douta   => gfxBufRamDOut,

    clkb    => dmaClock,
    web(0)  => ch0BufRamWr,
    addrb   => ch0BufRamWrA,
    dinb    => ch0BufRamDin
    --doutb   => 
  );


-- place dma process

ch0DmaPointerReset   <= pgVSyncClkD2;
ch0DmaRequest        <= pggDmaRequest;

dma: process( dmaClock )

begin

if rising_edge( dmaClock ) then

   if m00_axi_aresetn = '0' then
        
      ch0DmaRequestLatched    <= ( others => '0' );
      ch0DmaPointer           <= ( others => '0' );
      
      ch0BufRamDin            <= ( others => '0' );
      ch0BufRamWrA            <= ( others => '0' );
      ch0BufRamWr             <= '0';
      ch0TransferCounter      <= ( others => '0' );
      ch0DmaBufPointer        <= ( others => '0' );
      
--      br2AddrOut              <= ( others => '0' );
      
      --axi
      m00_axi_arid            <= x"0";
      m00_axi_arlen           <= ( others => '0' );
      m00_axi_arsize          <= "010";   --32 bits
      m00_axi_arburst         <= "01";    --burst type: increment
      m00_axi_arlock          <= '0';
      m00_axi_arcache         <= "0011";  --0011  
      m00_axi_arprot          <= "000";   --data/secure/unprivileged
      
      m00_axi_araddr          <= ( others => '0' );
      m00_axi_arvalid         <= '0';
      m00_axi_rready          <= '0';
      
        
    else

        --latch ch0 dma requests
        if ch0DmaRequest( 0 ) = '1' then
         
            ch0DmaRequestLatched( 0 ) <= '1';
        
        end if;
        
        if ch0DmaRequest( 1 ) = '1' then
         
            ch0DmaRequestLatched( 1 ) <= '1';
            
        end if;
        
        if ch0DmaPointerReset = '1' then
        
            ch0DmaPointer <= ch0DmaPointerStart;
        
        end if;

      case dmaState is
            
         when dsIdle =>
         
         --check ch0 access
         if ch0DmaRequestLatched( 0 ) = '1' then
         
            ch0DmaBufPointer     <= "000000000";                       
--            ch0TransferCounter   <= x"9f"; --x"9f";           --160 long words
            
            dmaState             <= dsCh0AxiRead0;
                        
         elsif ch0DmaRequestLatched( 1 ) = '1' then
         
            ch0DmaBufPointer    <= "100000000";                       
--            ch0TransferCounter  <= x"9f"; --x"9f";           --160 long words
            
            dmaState             <= dsCh0AxiRead0;
            
         end if;
         
         when dsCh0AxiRead0 =>
              
            if m00_axi_arready = '1' then
               
            --axi burst read
            m00_axi_araddr    <= ch0DmaPointer;
            m00_axi_arvalid   <= '1';
            m00_axi_arlen     <= ch0DmaRequestLength;      --160 long words
            m00_axi_rready    <= '0';

            dmaState          <= dsCh0AxiRead1;
               
            end if;
    
         when dsCh0AxiRead1 =>

            m00_axi_arvalid   <= '0';
            m00_axi_rready    <= '1';
               
            if m00_axi_rvalid = '1' then
               
               ch0BufRamWrA    <= ch0DmaBufPointer;
               ch0BufRamDin    <= m00_axi_rdata;
               ch0BufRamWr     <= '1';
                   
               ch0DmaBufPointer    <= std_logic_vector( unsigned( ch0DmaBufPointer ) + 1 );

               if m00_axi_rlast = '1' then
                  
                  dmaState <= dsCh0AxiRead2;
                  
               end if;
                                                
                  
            end if;
                  
         when dsCh0AxiRead2 =>
            
            ch0BufRamWr             <= '0';
            m00_axi_rready          <= '0';
            m00_axi_arvalid         <= '0';
            
            ch0DmaRequestLatched    <= "00";
            
            if ch0DmaRequestLatched( 0 ) = '1' then

               ch0DmaPointer           <= std_logic_vector( unsigned( ch0DmaPointer ) + unsigned( ch0DmaRequest0PtrAdd ) );
            
            else
            
               ch0DmaPointer           <= std_logic_vector( unsigned( ch0DmaPointer ) + unsigned( ch0DmaRequest1PtrAdd ) );
            
            end if;
               
            dmaState                <= dsIdle;
               
           
         when others =>
            
            dmaState    <= dsIdle;
        
        end case;
    
    end if;

end if;

end process;



videoMux: process( pixelClk )

begin

if rising_edge( pixelClk ) then

    if resetn = '0' then

        vgaHSync            <= '0';
        vgaVSync            <= '0';
        vgaBlank            <= '1';
                
        vgaRed		          <= ( others => '0' );
        vgaGreen            <= ( others => '0' );
        vgaBlue             <= ( others => '0' );

    else
    
        vgaHSync            <= pgHSync;
        vgaVSync            <= pgVSync;
        vgaBlank            <= not pgDe;

        --text over gfx mode
        if	pgR = x"00" and pgG = x"00" and pgB = x"00" then
                        
            vgaRed      <= pggR( 7 downto 0 );
            vgaGreen    <= pggG( 7 downto 0 );
            vgaBlue     <= pggB( 7 downto 0 );
                        
        --gray color -> dim background
        elsif pgR = x"80" and pgG = x"80" and pgB = x"80" then
                
                        
            vgaRed      <= "0" & pggR( 7 downto 1 );
            vgaGreen    <= "0" & pggG( 7 downto 1 );
            vgaBlue     <= "0" & pggB( 7 downto 1 );

        else
    
            vgaRed      <= pgR( 7 downto 3 ) & "000";
            vgaGreen    <= pgG( 7 downto 2 ) & "00";
            vgaBlue     <= pgB( 7 downto 3 ) & "000";
                    
        end if;
    
    end if;
            
end if;

end process;  


-- tick timer process
tickTimer: process( tickTimerClock, tickTimerPrescalerCounter, tickTimerCounter )
begin

   if rising_edge( tickTimerClock ) then
   
      if reset = '1' then
         
         tickTimerPrescalerCounter  <= ( others => '0' );
         tickTimerCounter           <= ( others => '0' );
         
      
      else
      
         if tickTimerPrescalerCounter /= x"00000000" then
            
            tickTimerPrescalerCounter <= std_logic_vector( unsigned( tickTimerPrescalerCounter ) - 1 );
            
         else
         
            --tickTimerPrescalerCounter <= conv_std_logic_vector( tickTimerPrescalerValue, tickTimerPrescalerCounter'length );
            tickTimerPrescalerCounter <= std_logic_vector( to_unsigned( tickTimerPrescalerValue, tickTimerPrescalerCounter'length ) );
            
            tickTimerCounter <= std_logic_vector( unsigned( tickTimerCounter ) + 1 );
         
         end if;
      
         if tickTimerReset = '1' then

            tickTimerPrescalerCounter  <= ( others => '0' );
            tickTimerCounter           <= ( others => '0' );
         
         end if;
         
      
      end if;  --reset = '1'
   
   
   end if; --rising_edge( tickTimerClock )

end process;   


-- frame timer process
frameTimerProcess: process( frameTimerClock )
begin
   
   if rising_edge( frameTimerClock ) then

      if frameTimerReset = '1' then
      
         frameTimerValue <= ( others => '0' );
         
      else
      
         frameTimerPgPrvVSync <= pgVSyncClkD2;
         
         
         if frameTimerPgPrvVSync = '0' and pgVSyncClkD2 = '1' then
      
            frameTimerValue <= std_logic_vector( unsigned( frameTimerValue ) + 1 );
            
         end if;
      
      end if;
   
   end if; -- rising_edge( frameTimerClock )
end process; 


--slave 0 axi bridge ( root registers )

s0axiBridge: process( s00_axi_aclk )

begin
   
   if rising_edge( s00_axi_aclk ) then
   
      if s00_axi_aresetn = '0' then
      
         axiS0State          <= asIdle;
                  
         s00_axi_awready   <= '0';
         s00_axi_wready    <= '0';
         s00_axi_bresp     <= ( others => '0' );
         s00_axi_bvalid    <= '0';
         s00_axi_arready   <= '0';
         s00_axi_rdata     <= ( others => '0' );
         s00_axi_rresp     <= ( others => '0' );
         s00_axi_rvalid    <= '0';
         
         tickTimerReset    <= '0';
         frameTimerReset   <= '0';
         
         ch0DmaPointerStart   <= x"1c000000";
         ch0DmaRequestLength  <= x"9f";
         ch0DmaRequest0PtrAdd <= x"0400";
         ch0DmaRequest1PtrAdd <= x"0400";
         
         vmMode            <= ( others => '0' );
         pgCursorX         <= ( others => '0' );
         pgCursorY         <= ( others => '0' );
         
      else
      
         case axiS0State is
         
            when asIdle =>
            
               --ready for read address reception
               s00_axi_arready   <= '1';
               
               s00_axi_awready   <= '0';

               --read data not exposed
               s00_axi_rvalid    <= '0';
               
               --not ready to write data
               s00_axi_wready    <= '0';
               
               --clear write data ack
               s00_axi_bvalid    <= '0';
               
               --check read
               if s00_axi_arvalid = '1' then
               
                  --read
                  --we do not accept any more addresses for now
                  s00_axi_arready   <= '0';
                  s00_axi_awready   <= '0';
                  
                  case s00_axi_araddr( 9 downto 2 ) is
                  
                     when x"00" =>
                     
                        s00_axi_rdata  <= x"80000000";
                        
                     when x"01" =>
                     
                        s00_axi_rdata  <= x"20250127";
               
                     when x"02" =>
                     
                        s00_axi_rdata  <=  x"0000" & vmMode;
               
                     when x"03" =>
                     
                        s00_axi_rdata   <= x"0000" & x"000" & "000" & pgVSyncClkD2;

                     when x"07" =>
                     
                        s00_axi_rdata   <= tickTimerCounter;
                     
                     when x"08" => 
                        
                        s00_axi_rdata   <= frameTimerValue;

                     when x"09" =>
                     
                        s00_axi_rdata  <= ch0DmaPointerStart;
                                  
                     when x"0a" =>
                     
                        s00_axi_rdata  <= x"000000" & ch0DmaRequestLength;
                     
                     when x"0b" =>
                     
                        s00_axi_rdata  <= x"0000" & ch0DmaRequest0PtrAdd;
                        
                     when x"0c" =>
                                
                        s00_axi_rdata  <= x"0000" & ch0DmaRequest1PtrAdd;

                     when x"0d" =>

                        s00_axi_rdata  <= x"0000" & pgCursorY & pgCursorX;
                        

                     when others =>
                     
                        s00_axi_rdata  <= x"00000000";
                     
               
                  end case;
                  
                  --data exposed
                  s00_axi_rvalid <= '1';
                  
                  --check ready
                  if s00_axi_rready = '0' then

                     --if not ready, wait'til end of cycle                     
                     axiS0State <= asRead0;
                  
                  end if;
               
               --check write
               elsif s00_axi_awvalid = '1' and s00_axi_wvalid = '1'  then
                
                  --not ready for read address
                  s00_axi_arready   <= '0';
                  
                  --ready for write address
                  s00_axi_awready   <= '1';
                  s00_axi_wready    <= '1';
                  s00_axi_bvalid    <= '1';
                  
                  
                  case s00_axi_awaddr( 9 downto 2 ) is
                     
                     when x"02" =>
                     
                        vmMode <= s00_axi_wdata( 15 downto 0 );
                  
                     when x"06" =>
                     
                        tickTimerReset <= s00_axi_wdata( 0 );
                  
                     when x"08" =>
                     
                        frameTimerReset <= '1';
                        
                     when x"09" =>
                     
                        ch0DmaPointerStart      <= s00_axi_wdata( 31 downto 2 ) & "00";

                     when x"0a" =>
                     
                        ch0DmaRequestLength     <= s00_axi_wdata( 7 downto 0 );
                     
                     when x"0b" =>
                     
                        ch0DmaRequest0PtrAdd    <= s00_axi_wdata( 15 downto 0 );
                        
                     when x"0c" =>
                                
                        ch0DmaRequest1PtrAdd    <= s00_axi_wdata( 15 downto 0 );

                     when x"0d" =>
                     
                        pgCursorX   <= s00_axi_wdata( 7 downto 0 );
                        pgCursorY   <= s00_axi_wdata( 15 downto 8 );
                        
                     when others =>
                  
                  end case;
                  
                  axiS0State <= asWrite0;
                  
               end if;
            
            when asRead0 =>
            
               if s00_axi_rready = '1' then

                  --end read cycle
                  s00_axi_rvalid <= '0';
                  axiS0State       <= asIdle;
                  
               end if;
            
            when asWrite0 =>
            
               --clear write triggers
               tickTimerReset  <= '0';
               frameTimerReset <= '0';
   
            
               --not ready for write address
               s00_axi_awready   <= '0';
               s00_axi_wready    <= '0';
            
               if s00_axi_bready = '1' then

                  s00_axi_bvalid    <= '0';

                  axiS0State       <= asIdle;
               
               end if;                                 
                               
            when others =>
            
               axiS0State <= asIdle;
                      
         end case;
            
      end if;
   
   end if; 

end process;

--slave 1 axi bridge ( axi to tangerine bus connected to gfxPixelGen )

s1axiBridge: process( s01_axi_aclk )

begin
   
   if rising_edge( s01_axi_aclk ) then
   
      if s01_axi_aresetn = '0' then
      
         axiS1State          <= asIdle;
                  
         s01_axi_awready   <= '0';
         s01_axi_wready    <= '0';
         s01_axi_bresp     <= ( others => '0' );
         s01_axi_bvalid    <= '0';
         s01_axi_arready   <= '0';
         s01_axi_rdata     <= ( others => '0' );
         s01_axi_rresp     <= ( others => '0' );
         s01_axi_rvalid    <= '0';
         
         pggRegsA    <= ( others => '0' );
         pggRegsDIn  <= ( others => '0' );
         pggRegsCE   <= '0';
         pggRegsWr   <= '0';
                  
      else
      
         case axiS1State is
         
            when asIdle =>
            
               pggRegsCE   <= '0';

               --ready for read address reception
               s01_axi_arready   <= '1';
               
               s01_axi_awready   <= '0';

               --read data not exposed
               s01_axi_rvalid    <= '0';
               
               --not ready to write data
               s01_axi_wready    <= '0';
               
               --clear write data ack
               s01_axi_bvalid    <= '0';
               
               --check read
               if s01_axi_arvalid = '1' then
               
                  --read
                  --we do not accept any more addresses for now
                  s01_axi_arready   <= '0';
                  s01_axi_awready   <= '0';

                  --pass read address
                  pggRegsA    <= s01_axi_araddr( 17 downto 2 ); 
                  pggRegsCE   <= '1';
                  pggRegsWr   <= '0';

                  axiS1State  <= asRead0;

               --check write
               elsif s01_axi_awvalid = '1' and s01_axi_wvalid = '1'  then
                
                  --not ready for read address
                  s01_axi_arready   <= '0';
                  
                  --ready for write address
                  s01_axi_awready   <= '1';
                  s01_axi_wready    <= '1';
                  
                  --pass write address and data
                  pggRegsA    <= s01_axi_awaddr( 17 downto 2 ); 
                  pggRegsDIn  <= s01_axi_wdata;
                  pggRegsCE   <= '1';
                  pggRegsWr   <= '1';
                  
                  
                  axiS1State <= asWrite0;
                  
               end if;
              
            when asRead0 =>
           
               if pggRegsReady = '1' then
                  
                  pggRegsCE      <= '0';
                  
                  s01_axi_rdata  <= pggRegsDOut;
                                   
                  --data exposed
                  s01_axi_rvalid <= '1';
                  
                  --check ready
                  if s01_axi_rready = '0' then

                     --if not ready, wait'til end of cycle                     
                     axiS1State <= asRead1;
               
                  else
                  
                     axiS1State  <= asIdle;
                  
                  end if;
               
               end if;               
            
            when asRead1 =>
            
               if s01_axi_rready = '1' then

                  --end read cycle
                  s01_axi_rvalid    <= '0';
                  axiS1State        <= asIdle;
                  
               end if;
            
            when asWrite0 =>
                           
               --not ready for write address
               s01_axi_awready   <= '0';
               s01_axi_wready    <= '0';
               
               if pggRegsReady = '1' then
               
                  s01_axi_bvalid    <= '1';
                  
                  pggRegsCE   <= '0';
                  axiS1State  <= asWrite1;
                  
               end if;
               
            when asWrite1 =>

               if s01_axi_bready = '1' then

                  s01_axi_bvalid    <= '0';

                  axiS1State       <= asIdle;
               
               end if;                                 
                               
            when others =>
            
               axiS1State <= asIdle;
                      
         end case;
            
      end if;
   
   end if; 

end process;

end Behavioral;
