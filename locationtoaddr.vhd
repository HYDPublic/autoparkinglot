----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:07 06/12/2016 
-- Design Name: 
-- Module Name:    locationtoaddr - Behavioral 
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

entity locationtoaddr is
    Port ( location : in  STD_LOGIC_VECTOR (23 downto 0);
           addr : out  STD_LOGIC_VECTOR (4 downto 0));
end locationtoaddr;

architecture Behavioral of locationtoaddr is

begin
addr <= "00000" when location = "000000000000000000000001" else
				 "00001" when location = "000000000000000000000010" else
				 "00010" when location = "000000000000000000000100" else
				 "00011" when location = "000000000000000000001000" else
				 "00100" when location = "000000000000000000010000" else
				 "00101" when location = "000000000000000000100000" else
				 "00110" when location = "000000000000000001000000" else
				 "00111" when location = "000000000000000010000000" else
				 "01000" when location = "000000000000000100000000" else
				 "01001" when location = "000000000000001000000000" else
				 "01010" when location = "000000000000010000000000" else
				 "01011" when location = "000000000000100000000000" else
				 "01100" when location = "000000000001000000000000" else
				 "01101" when location = "000000000010000000000000" else
				 "01110" when location = "000000000100000000000000" else
				 "01111" when location = "000000001000000000000000" else
				 "10000" when location = "000000010000000000000000" else
				 "10001" when location = "000000100000000000000000" else
				 "10010" when location = "000001000000000000000000" else
				 "10011" when location = "000010000000000000000000" else
				 "10100" when location = "000100000000000000000000" else
				 "10101" when location = "001000000000000000000000" else
				 "10110" when location = "010000000000000000000000" else
				 "10111" when location = "100000000000000000000000" else
				 "11000";

end Behavioral;

