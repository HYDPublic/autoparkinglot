----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:08:48 06/11/2016 
-- Design Name: 
-- Module Name:    counter_0_to_23 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_0_to_23 is
    Port ( clk, ena, rst : in  STD_LOGIC;
           cnt : out  STD_LOGIC_VECTOR (4 downto 0));
end counter_0_to_23;

architecture Behavioral of counter_0_to_23 is
signal data : STD_LOGIC_VECTOR (4 downto 0);
begin
	process(clk)
	begin
		if rst = '1' then
			data <= (others => '0');
		elsif rising_edge(clk) and ena = '1' then
			if data = "10111" then
				data <= (others => '0');
			else
				data <= data + '1';
			end if;
		end if;
	end process;
	cnt <= data;
end Behavioral;

