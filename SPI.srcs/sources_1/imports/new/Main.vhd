----------------------------------------------------------------------------------
-- Project: Project Course on Drive Systems and Power Electronics 
-- Course: Master of Science in Power Engineering
-- University: Technical University of Munich
-- Create Date: 04.04.2018 15:35:36
-- Design Name: SPI for DAC
-- Module Name: Main - SPI
-- Target Device : ZEDBoard
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Main is
  Port ( SCLK : in STD_LOGIC;
         CSn: in STD_LOGIC := '1';
         RSTn: in STD_LOGIC := '1';
         SDI: in STD_LOGIC := '0';
         SPIreg: inout STD_LOGIC_VECTOR(23 downto 0) := (others=>'0'));
end Main;

architecture SPI of Main is
signal test: integer := 0;
signal count: integer := 0 ; -- test signal
signal bitDiff: integer := 0; -- counting how many bits are excess or less
begin
    process(SCLK, CSn, RSTn)
    begin
        if (RSTn = '0') then                      --asynchronous reset
            test <= 0;
            count<= 0;                    
        elsif(CSn'event and CSn = '0') then       --detect falling edge of chip select             
            test<= 1;
        end if;
        if (test = 1) then    
            if (SCLK'event and SCLK = '0') then   --detect falling edge of Serial Clock after falling edge of Chip select
                count <= count + 1;               --flag to take only 24 bits of data input  
         --[MAIN EVENT AREA]-------                                       
            end if;
           -- if (count = 24) then
           --     CSn <= '1' after 4ns;
           --     test<=0;                          --RESET Chip select flag and wait for next faling edge
           --     count <= 0;                       -- RESET bit count              
           -- end if;
           if (CSn'event and CSn = '1') then
                bitDiff <= count -24 ;
                test<=0;                            --stop taking in serial data
                count<=0;                           --reset count
           end if;
        end if;
        if (bitDiff<0) then
            -- reset the SPI register when all 24 bits have not been transfered 
        end if;
    end process;
end SPI;
