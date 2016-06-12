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
    Port ( input : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (23 downto 0));
end led_decoder;

architecture Behavioral of led_decoder is

begin
with input select
output <= "000000000000000000000001" when "00000",
			 "000000000000000000000010" when "00001",
			 "000000000000000000000100" when "00010",
			 "000000000000000000001000" when "00011",
			 "000000000000000000010000" when "00100",
			 "000000000000000000100000" when "00101",
			 "000000000000000001000000" when "00110",
			 "000000000000000010000000" when "00111",
			 "000000000000000100000000" when "01000",
			 "000000000000001000000000" when "01001",
			 "000000000000010000000000" when "01010",
			 "000000000000100000000000" when "01011",
			 "000000000001000000000000" when "01100",
			 "000000000010000000000000" when "01101",
			 "000000000100000000000000" when "01110",
			 "000000001000000000000000" when "01111",
			 "000000010000000000000000" when "10000",
			 "000000100000000000000000" when "10001",
			 "000001000000000000000000" when "10010",
			 "000010000000000000000000" when "10011",
			 "000100000000000000000000" when "10100",
			 "001000000000000000000000" when "10101",
			 "010000000000000000000000" when "10110",
			 "100000000000000000000000" when "10111",
			 "000000000000000000000000" when others;
			 

end Behavioral;

