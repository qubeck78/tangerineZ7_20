library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

--https://www.burtonsys.com/ps2_chapweske.htm
--https://www.eecg.utoronto.ca/~jayar/ece241_08F/AudioVideoCores/ps2/ps2.html
--http://www.ue.eti.pg.gda.pl/fpgalab/info_kbd/info_kbd_en.html
--https://www.networktechinc.com/ps2-prots.html
--https://www.youtube.com/watch?v=nXH-jXimE0g

entity ps2Host is
port (

   --axi4-lite bus
   s00_axi_aclk:     in std_logic;
   s00_axi_aresetn:  in std_logic;
   s00_axi_awaddr:   in std_logic_vector( 31 downto 0 );
   s00_axi_awprot:   in std_logic_vector( 2 downto 0 );
   s00_axi_awvalid:  in std_logic;
   s00_axi_awready:  out std_logic;
   s00_axi_wdata:    in std_logic_vector( 31 downto 0 );
   s00_axi_wstrb:    in std_logic_vector( 3 downto 0 );
   s00_axi_wvalid:   in std_logic;
   s00_axi_wready:   out std_logic;
   s00_axi_bresp:    out std_logic_vector( 1 downto 0 );
   s00_axi_bvalid:   out std_logic;
   s00_axi_bready:   in std_logic;
   s00_axi_araddr:   in std_logic_vector( 31 downto 0 );
   s00_axi_arprot:   in std_logic_vector( 2 downto 0 );
   s00_axi_arvalid:  in std_logic;
   s00_axi_arready:  out std_logic;
   s00_axi_rdata:    out std_logic_vector( 31 downto 0 );
   s00_axi_rresp:    out std_logic_vector( 1 downto 0 );
   s00_axi_rvalid:   out std_logic;
   s00_axi_rready:   in std_logic;


--VIVADO bug/feature? :)
--to get inout working in block design 'Synthesis options/Global' has to be selected while generating output products of block design
   ps2aClock:  inout    std_logic;
   ps2aData:   inout    std_logic;
   
   ps2bClock:  inout    std_logic;
   ps2bData:   inout    std_logic
 );
end ps2Host;

architecture Behavioral of ps2Host is

--components
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

COMPONENT ps2KeyboardFifo
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC 
  );
END COMPONENT;

--constants

--clock pulse width while initiating ps2 write
constant clockPulseTimerValue:   integer:=   32 + ( 100 * 100 );  --100us @ 100MHz
constant watchdogTimerPeriod:    integer:=   50000000;         --500ms @ 100MHz

--signals

signal reset:                 std_logic;

--keyboard fifo

signal keyboardFifoWrEn:      std_logic;
signal keyboardFifoRdEn:      std_logic;
signal keyboardFifoDOut:      std_logic_vector( 7 downto 0 );
signal keyboardFifoFull:      std_logic;
signal keyboardFifoEmpty:     std_logic;

--ps2
signal ps2aClockSync:         std_logic;
signal ps2aDataSync:          std_logic;

signal ps2aParity:            std_logic;

signal ps2aDataInBuf:         std_logic_vector( 7 downto 0 );
signal ps2aDataIn:            std_logic_vector( 7 downto 0 );

--ps2a write
signal ps2aWatchdogTimer:     std_logic_vector( 31 downto 0 );
signal ps2aClockPulseTimer:   std_logic_vector( 15 downto 0 );
signal ps2aDataOut:           std_logic_vector( 7 downto 0 );
signal ps2aDataOutBuf:        std_logic_vector( 7 downto 0 );
signal ps2aWriteModeTrigger:  std_logic;
signal ps2aWriteMode:         std_logic;

type ps2State_t is ( ps2StartH, ps2StartL, ps2DataH, ps2DataL, ps2ParityH, ps2ParityL, ps2StopH, ps2StopL,
                     ps2WrPulseClock, ps2WrStarth, ps2WrStartL, ps2wrDataH, ps2wrDataL, ps2wrParityH,ps2wrParityL, ps2wrStopH, ps2wrStopL, ps2WrAckL 
                     );
                  
signal ps2aState:             ps2State_t;
signal ps2ProcessClock:       std_logic;
signal ps2aDataCounter:       std_logic_vector( 3 downto 0 );

--axi
type axiState_T is ( asIdle, asRead0, asWrite0 );
signal axiState:     axiState_T;

begin

--assign clocks

ps2ProcessClock   <= s00_axi_aclk;
reset             <= not s00_axi_aresetn;

--ps2

ps2a: process ( ps2ProcessClock, reset, ps2aClock, ps2aData )
begin

   if rising_edge( ps2ProcessClock ) then
   
      if reset = '1' then
         
         ps2aState            <= ps2starth;
         ps2aDataInBuf        <= ( others => '0' );
         ps2aDataIn           <= ( others => '0' );
         ps2aDataOutBuf       <= ( others => '0' );
         
         ps2aClock            <= 'Z';
         ps2aData             <= 'Z';
   
         ps2bClock            <= 'Z';
         ps2bData             <= 'Z';
         
         ps2aParity           <= '1';
         ps2aWriteMode        <= '0';
         
         ps2aClockPulseTimer  <= ( others => '0' );
         ps2aWatchdogTimer    <= std_logic_vector( to_unsigned( watchdogTimerPeriod, 32 ) );

      else
         
         --latch write mode trigger
         
         if ps2aWriteModeTrigger = '1' then
         
            ps2aWriteMode  <= '1';
            
         end if;

         if ps2aState /= ps2Starth then
         
            if ps2aWatchdogTimer /= x"00000000" then
               
               ps2aWatchdogTimer <= std_logic_vector( unsigned( ps2aWatchdogTimer ) - 1 ); 
         
            else
            
               --reset fsm if transmission not finished in desired time
               
               ps2aState      <= ps2Starth;
               ps2aWriteMode  <= '0';
               
           end if;
           
         end if;      
      
         case ps2aState is
         
            when ps2Starth =>
            
               ps2aClock            <= 'Z';
               ps2aData             <= 'Z';
               
               if ps2aWriteMode = '1' then
               
                  ps2aClock   <= '0';
                  ps2aData    <= 'Z';

                  ps2aDataOutBuf       <= ps2aDataOut;
                  ps2aClockPulseTimer  <= std_logic_vector( to_unsigned( clockPulseTimerValue, 16 ) );
                  ps2aWatchdogTimer    <= std_logic_vector( to_unsigned( watchdogTimerPeriod, 32 ) );
                  
                  ps2aState            <= ps2WrPulseClock;                  
               
               end if;


               if ps2aClockSync = '0' then
         
                     ps2aWatchdogTimer    <= std_logic_vector( to_unsigned( watchdogTimerPeriod, 32 ) );

                     ps2aParity  <= '1';      
                     ps2aState   <= ps2Startl;            
                                    
               end if;

            when ps2Startl =>

               if ps2aClockSync = '1' then
               
                  if ps2aDataSync = '0' then
                  
                     ps2aState <= ps2datah;            

                     ps2aDataCounter <= x"7";
                                       
                  end if;               
 
               end if;

            when ps2datah =>
            
               if ps2aClockSync = '0' then
               
                  ps2aState         <= ps2datal;            
               
               end if;
            
            when ps2datal =>
            
               if ps2aClockSync = '1' then
               
                  if ps2aDataSync = '1' then
                  
                     ps2aParity  <= not ps2aParity;
                  
                  end if;
                  
                  ps2aDataInBuf  <= ps2aDataSync & ps2aDataInBuf( 7 downto 1 );
                        
                  if ps2aDataCounter /= x"0" then
                  
                     ps2aDataCounter   <= std_logic_vector( unsigned( ps2aDataCounter ) - 1 );
                     
                     ps2aState         <= ps2datah;            

                  else
                  
                 
                     ps2aState         <= ps2parityh;
                  
                  end if;
                    
               end if;

            when ps2parityh =>

               if ps2aClockSync = '0' then
                  
                  ps2aDataIn  <= ps2aDataInBuf;
                                    
                  ps2aState <= ps2parityl;            
               
               end if;

            when ps2parityl =>
               
               if ps2aClockSync = '1' then
               
                  if keyboardFifoFull = '0' and ps2aDataSync = ps2aParity then
                  
                     keyboardFifoWrEn <= '1';
                     
                  end if;

                  ps2aState <= ps2stoph;            
               
               end if;
         
            when ps2stoph =>

               keyboardFifoWrEn <= '0';

               if ps2aClockSync = '0' then
               
                  ps2aState <= ps2stopl;            
               
               end if;

            when ps2stopl =>
            
               if ps2aClockSync = '1' then
               
                  ps2aState <= ps2starth;            
               
               end if;


            when ps2WrPulseClock =>
            
               if ps2aClockPulseTimer = x"0020" then
               
                  --release ps2aClock early, and give time for it to stabilize

                  ps2aClock   <= 'Z';
                  ps2aData    <= '0';
               
               end if;            
            
               if ps2aClockPulseTimer /= x"0000" then
               
         
                  ps2aClockPulseTimer  <= std_logic_vector( unsigned( ps2aClockPulseTimer ) - 1 );
               
               else
               
                  ps2aClock   <= 'Z';
                  ps2aData    <= '0';
                                 
                  ps2aState   <= ps2WrStartH;
                  
               end if;
               
            when ps2WrStartH =>

               ps2aData    <= '0';

               if ps2aClockSync = '0' then
                           
                     ps2aParity        <= '1';      
                     ps2aDataCounter   <= x"7";       

                     ps2aState         <= ps2WrDataL;            
                                    
               end if;            
            
            

            when ps2WrDataL =>
            
               if ps2aDataOutBuf( 0 ) = '1' then
                                 
                  ps2aData    <= 'Z';
               
               else
               
                  ps2aData    <= '0';
                  
               end if;


               if ps2aClockSync = '1' then

                  if ps2aDataOutBuf( 0 ) = '1' then
                  
                     ps2aParity  <= not ps2aParity;
                  
                  end if;
                                   
                  ps2aDataOutBuf <= '0' & ps2aDataOutBuf( 7 downto 1 );
               
                  ps2aState         <= ps2WrDataH;            
               
               end if;
            
            when ps2WrDataH =>
            
               if ps2aClockSync = '0' then
                                                         
                  if ps2aDataCounter /= x"0" then
                  
                     ps2aDataCounter   <= std_logic_vector( unsigned( ps2aDataCounter ) - 1 );
                     
                     ps2aState         <= ps2WrdataL;            

                  else
                                   
                     ps2aState         <= ps2WrParityL;
                  
                  end if;
                    
               end if;
            
            when ps2WrParityL =>

               if ps2aParity = '1' then
               
                  ps2aData <= 'Z';
               
               else
               
                  ps2aData <= '0';
                  
               end if;

               if ps2aClockSync = '1' then
                                                      
                  ps2aState <= ps2WrParityH;            

               
               end if;

            when ps2WrParityH =>
                              
               if ps2aClockSync = '0' then
                    
                  ps2aData <= 'Z';          

                  ps2aState <= ps2WrStopL;            
               
               end if;

            when ps2WrStopL =>
               
               if ps2aClockSync = '1' then
               
                  
                  ps2aState <= ps2WrStopH;            
               
               end if;

            when ps2WrStopH =>
               
               if ps2aClockSync = '0' then
                  
                  ps2aState <= ps2WrAckL;            
               
               end if;

            when ps2WrAckL =>

               if ps2aClockSync = '1' then
               
                  ps2aWriteMode  <= '0';
                  
                  ps2aState <= ps2StartH;            
               
               end if;

            when others =>
            
               ps2aState <= ps2StartH;
         
         
         end case;
      
      end if;
   
   end if;

end process;

inputSyncPs2AInst: inputSync
    generic map(
        inputWidth => 2
    )

    port map(

        clock              => ps2ProcessClock,
        signalInput(0)     => ps2aClock,
        signalInput(1)     => ps2aData,
        signalOutput(0)    => ps2aClockSync,
        signalOutput(1)    => ps2aDataSync

    );


--place keyboard fifo
ps2KeyboardFifoInst:ps2KeyboardFifo
port map(
    clk     => ps2ProcessClock,
    rst     => reset,
    din     => ps2aDataInBuf,
    wr_en   => keyboardFifoWrEn,
    rd_en   => keyboardFifoRdEn,
    dout    => keyboardFifoDOut,
    full    => keyboardFifoFull,
    empty   => keyboardFifoEmpty
  );


axiBridge: process( s00_axi_aclk )

begin
   
   if rising_edge( s00_axi_aclk ) then
   
      if s00_axi_aresetn = '0' then
      
         axiState          <= asIdle;
                  
         s00_axi_awready   <= '0';
         s00_axi_wready    <= '0';
         s00_axi_bresp     <= ( others => '0' );
         s00_axi_bvalid    <= '0';
         s00_axi_arready   <= '0';
         s00_axi_rdata     <= ( others => '0' );
         s00_axi_rresp     <= ( others => '0' );
         s00_axi_rvalid    <= '0';
         
         keyboardFifoRdEn  <= '0';
         ps2aDataOut       <= ( others => '0' );
         
      else
      
         --clear keyboard fifo read trigger
         keyboardFifoRdEn     <= '0';
         
         --clear ps2a write trigger
         ps2aWriteModeTrigger <= '0';
         
         case axiState is
         
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
                  
                     -- r- id
                     when x"00" =>
                     
                        s00_axi_rdata  <= x"8000000a";
                        
                     -- r- version 
                     when x"01" =>
                     
                        s00_axi_rdata  <= x"20250128";
               
                     -- rw keyboardData
                     when x"02" =>
                     
                        s00_axi_rdata     <= x"000000" & keyboardFifoDOut;
                        keyboardFifoRdEn  <= '1';

                     -- r- keyboardStatus                          
                     when x"03" =>
                     
                        s00_axi_rdata     <= x"0000000" & "00" & ps2aWriteMode & keyboardFifoEmpty;

                     when others =>
                     
                        s00_axi_rdata  <= x"00000000";
                     
               
                  end case;
                  
                  --data exposed
                  s00_axi_rvalid <= '1';
                  
                  --check ready
                  if s00_axi_rready = '0' then

                     --if not ready, wait'til end of cycle                     
                     axiState <= asRead0;
                  
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
                     
                        ps2aDataOut          <= s00_axi_wdata( 7 downto 0 );
                        ps2aWriteModeTrigger <= '1';
                                   
                     when others =>
                  
                  end case;
                  
                  axiState <= asWrite0;
                  
               end if;
            
            when asRead0 =>
            
               if s00_axi_rready = '1' then

                  --end read cycle
                  s00_axi_rvalid <= '0';
                  axiState       <= asIdle;
                  
               end if;
            
            when asWrite0 =>
            
               --not ready for write address
               s00_axi_awready   <= '0';
               s00_axi_wready    <= '0';
            
               if s00_axi_bready = '1' then

                  s00_axi_bvalid    <= '0';

                  axiState       <= asIdle;
               
               end if;                                 
                               
            when others =>
            
               axiState <= asIdle;
                      
         end case;
            
      end if;
   
   end if; 

end process;



end Behavioral;
