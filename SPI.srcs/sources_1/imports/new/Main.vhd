----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 15:35:36
-- Design Name: 
-- Module Name: Main - SPI
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main is
  Port ( SCLK : in STD_LOGIC;
         CSn: inout STD_LOGIC := '1';
         RSTn: in STD_LOGIC := '1');
end Main;

architecture SPI of Main is
signal test: integer := 0;
signal count: integer := 0 ; -- test signal
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
            if (count = 24) then
                CSn <= '1' after 4ns;
                test<=0;                          --RESET Chip select flag and wait for next faling edge
                count <= 0;                       -- RESET bit count              
            end if;
        end if;
    end process;

end SPI;
