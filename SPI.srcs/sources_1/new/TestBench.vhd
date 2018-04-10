----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2018 15:46:50
-- Design Name: 
-- Module Name: TestBench - Behavioral
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
library work;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench is
end TestBench;

architecture SPI_tb of TestBench is
component Main port ( SCLK : in STD_LOGIC;
         CSn: in STD_LOGIC := '1';
         RSTn: in STD_LOGIC := '1';
         SDI: in STD_LOGIC := '0';
         SPIreg: inout STD_LOGIC_VECTOR(23 downto 0) := (others=>'0'));
end component;
signal SCLK: STD_LOGIC:='1';
signal CSn:STD_LOGIC:='1'; 
signal RSTn: STD_LOGIC:='0';
signal SDI: STD_LOGIC := '0';
signal SPIreg: STD_LOGIC_VECTOR(23 downto 0):= (others=>'0'); 
-- TIME----------
constant offset:time:= 5ns;
constant period: time:= 25ns;
constant ChipSel: time:= 35ns;
constant duty:real:=0.5;
----------------
type testblk is record 
    SDI: STD_LOGIC;
    SPIreg: STD_LOGIC_VECTOR(23 downto 0);
end record;
type TestVec is array(natural range <>)of testblk ;
constant test : TestVec:= (('1', X"000001"),('0',X"000002"),('1',X"000003"),('1',X"00000B"),
                           ('0',X"000016"),('1',X"00002D"),('1',X"00005B"),('0',X"0000B6"),
                           ('1',X"00016D"),('1',X"0002DB"),('0',X"0005B6"),('1',X"000B6D"),
                           ('0',X"0016DA"),('1',X"002DB5"),('1',X"005B6A"),('0',X"00B6D6"),
                           ('1',X"016DAD"),('0',X"02DB5A"),('1',X"05B6A5"),('0',X"0B6D6A"),
                           ('1',X"16DAD5"),('0',X"2DB5AA"),('0',X"5B6A54"),('0',X"B6D6A8"));
begin
device1: Main port map (SCLK=>SCLK,CSn=>CSn, RSTn=>RSTn, SDI=>SDI, SPIreg=>SPIreg);
clock: process
begin
wait for offset;
genClk: loop 
    SCLK<='0';
    wait for period-(period*duty);
    SCLK<='1'; 
    wait for period-(period*duty);
end loop;
end process;
assign: process
    variable unit:testblk;
    begin
    wait for period;
    RSTn<='1';
    CSn<='1';
    wait for ChipSel;
    CSn<='0';
    for i in test'range loop
        unit := test(i);
        SDI<=unit.SDI;
        wait for period;
    --    assert SPIreg = unit.SPIreg
    --    report "Not working"
    --    severity note;
    --    wait for 5ns;
    end loop;
   -- assert false report "Test over" 
    --severity note;
   -- wait;
end process;
end SPI_tb;
