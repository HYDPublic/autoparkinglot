----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:42:13 05/11/2016 
-- Design Name: 
-- Module Name:    led_multiplexer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_decoder is
    Port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (23 downto 0));
end led_decoder;

architecture Behavioral of led_decoder is

begin
with input select
output <= "000000000000000000000001" when "00000000",
			 "000000000000000000000010" when "00000001",
			 "000000000000000000000100" when "00000010",
			 "000000000000000000001000" when "00000011",
			 "000000000000000000010000" when "00000100",
			 "000000000000000000100000" when "00000101",
			 "000000000000000001000000" when "00000110",
			 "000000000000000010000000" when "00000111",
			 "000000000000000100000000" when "00001000",
			 "000000000000001000000000" when "00001001",
			 "000000000000010000000000" when "00001010",
			 "000000000000100000000000" when "00001011",
			 "000000000001000000000000" when "00001100",
			 "000000000010000000000000" when "00001101",
			 "000000000100000000000000" when "00001110",
			 "000000001000000000000000" when "00001111",
			 "000000010000000000000000" when "00010000",
			 "000000100000000000000000" when "00010001",
			 "000001000000000000000000" when "00010010",
			 "000010000000000000000000" when "00010011",
			 "000100000000000000000000" when "00010100",
			 "001000000000000000000000" when "00010101",
			 "010000000000000000000000" when "00010110",
			 "100000000000000000000000" when "00010111",
			 "000000000000000000000000" when others;
			 

end Behavioral;

