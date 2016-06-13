----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:41 06/12/2016 
-- Design Name: 
-- Module Name:    addrtolocation - Behavioral 
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

entity addrtolocation is
    Port ( addr : in  STD_LOGIC_VECTOR (4 downto 0);
           location : out  STD_LOGIC_VECTOR (23 downto 0));
end addrtolocation;

architecture Behavioral of addrtolocation is

begin
location <= "000000000000000000000001" when addr = "00000" else
			  "000000000000000000000010" when addr = "00001" else
			  "000000000000000000000100" when addr = "00010" else
			  "000000000000000000001000" when addr = "00011" else
			  "000000000000000000010000" when addr = "00100" else
			  "000000000000000000100000" when addr = "00101" else
			  "000000000000000001000000" when addr = "00110" else
			  "000000000000000010000000" when addr = "00111" else
			  "000000000000000100000000" when addr = "01000" else
			  "000000000000001000000000" when addr = "01001" else
			  "000000000000010000000000" when addr = "01010" else
			  "000000000000100000000000" when addr = "01011" else
			  "000000000001000000000000" when addr = "01100" else
			  "000000000010000000000000" when addr = "01101" else
			  "000000000100000000000000" when addr = "01110" else
			  "000000001000000000000000" when addr = "01111" else
			  "000000010000000000000000" when addr = "10000" else
			  "000000100000000000000000" when addr = "10001" else
			  "000001000000000000000000" when addr = "10010" else
			  "000010000000000000000000" when addr = "10011" else
			  "000100000000000000000000" when addr = "10100" else
			  "001000000000000000000000" when addr = "10101" else
			  "010000000000000000000000" when addr = "10110" else
			  "100000000000000000000000" when addr = "10111" else
			  "000000000000000000000000";

end Behavioral;

