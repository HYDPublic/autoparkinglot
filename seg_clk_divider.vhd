----------------------------------------------------------------------------------
-- Company: PDEC Lab.
-- Engineer: Daehee Kim
-- 
-- Create Date:    14:48:23 04/12/2016 
-- Design Name: 
-- Module Name:    clk_divider - Behavioral 
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

entity seg_clk_divider is
    Port ( clk, rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC
			 );
end seg_clk_divider;

architecture Behavioral of seg_clk_divider is

-- start signals
signal cnt_data : STD_LOGIC_VECTOR (15 downto 0);
--signal cnt_data : STD_LOGIC_VECTOR (23 downto 0);
-- end signals

begin

	process(clk, rst)
	begin
		if rst='1' then
			cnt_data <= (others=>'0');
			new_clk <= '0';
		elsif clk'event and clk = '1' then
			if cnt_data = x"2710" then
--			if cnt_data = x"ffffff" then
				cnt_data <= (others=>'0');			
				new_clk<='0';							
			elsif cnt_data=x"1388" then			
--			elsif cnt_data=x"7fffff" then			
				new_clk<='1';							
				cnt_data<=cnt_data+1;				
			else
				cnt_data<=cnt_data+1;
			end if;
		end if;
	end process;

end Behavioral;