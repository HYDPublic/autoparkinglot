----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:21:08 04/26/2016 
-- Design Name: 
-- Module Name:    x4_clk_divider - Behavioral 
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

entity x4_clk_divider is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC);
end x4_clk_divider;

architecture Behavioral of x4_clk_divider is

signal cnt_data : STD_LOGIC_VECTOR (1 downto 0);
signal d_clk : STD_LOGIC;

begin

	process(clk, rst)
	begin
		if rst='1' then
			cnt_data <= (others=>'0');
			d_clk <= '0';
		elsif clk'event and clk = '1' then
			if cnt_data = "11" then
				d_clk<=not d_clk;
			else
				cnt_data<=cnt_data+1;
			end if;
		end if;
	end process;
	
	new_clk<=d_clk;

end Behavioral;

