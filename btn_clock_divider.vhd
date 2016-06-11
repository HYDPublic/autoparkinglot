----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:14:39 06/11/2016 
-- Design Name: 
-- Module Name:    btn_clock_divider - Behavioral 
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

entity btn_clock_divider is
    Port ( clk, rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC);
end btn_clock_divider;

architecture Behavioral of btn_clock_divider is
signal cnt : STD_LOGIC_VECTOR(15 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '1' then
			cnt <= (others => '0');
			new_clk <= '0';
		elsif rising_edge(clk) then
			if cnt = x"2710" then
				cnt <= (others => '0');
				new_clk <= '0';
			elsif cnt = x"1388" then
				new_clk <= '1';
				cnt <= cnt + 1;
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;

end Behavioral;

