----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:27:08 05/11/2016 
-- Design Name: 
-- Module Name:    led_clock_divider - Behavioral 
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

entity lcd_25m_clk is
	port( clk, rst : in std_logic;
			dclk : out std_logic);
end lcd_25m_clk;

architecture Behavioral of lcd_25m_clk is
	
	signal cnt_data : STD_LOGIC_VECTOR(3 downto 0);
	
begin

	process(clk, rst)
	begin 
		if rst = '1' then 
			cnt_data <= (others=>'0');
			dclk<='0';
		elsif rising_edge(clk) then
			if cnt_data = x"5" then 
				cnt_data <=(others=>'0');
				dclk<='1';
			elsif cnt_data = x"2" then 
				dclk<='0';
				cnt_data <= cnt_data + '1';
			else
				cnt_data <= cnt_data + '1';
			end if;
		end if;
		end process;
end Behavioral;

