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
  Port (CSn, SCLK, RSTn : in STD_LOGIC );
end Main;

architecture SPI of Main is

begin
    process(SCLK, CSn, RSTn)
    begin
        if (RSTn = '0') then                      --asynchronous reset
                            
        elsif(CSn'event and CSn = '0') then       --detect falling edge of chip select             
            if (SCLK'event and SCLK = '0') then   --detect falling edge of Serial Clock
            
            end if;
        end if;
    end process;

end SPI;