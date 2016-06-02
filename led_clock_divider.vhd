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

entity led_clock_divider is
	port( clk, rst : in std_logic;
			dclk : out std_logic);
end led_clock_divider;

architecture Behavioral of led_clock_divider is
	
	signal cnt_data : STD_LOGIC_VECTOR(25 downto 0);
begin

	process(clk, rst)
	begin 
		if rst = '1' then 
			cnt_data <= (others=>'0');
			dclk<='0';
		elsif clk'event and clk = '1' then 
			if cnt_data = x"3ffffff" then 
				cnt_data <=(others=>'0');
				dclk<='1';
			elsif cnt_data = x"1ffffff" then 
				dclk<='0';
			end if;
			cnt_data <= cnt_data + '1';
		end if;
		end process;
end Behavioral;

