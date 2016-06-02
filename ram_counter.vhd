----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:40 05/31/2016 
-- Design Name: 
-- Module Name:    ram_counter - Behavioral 
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

entity ram_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           cnt : out  STD_LOGIC_VECTOR (7 downto 0));
end ram_counter;

architecture Behavioral of ram_counter is

-- start signals
signal cnt_data : STD_LOGIC_VECTOR (7 downto 0);
-- end signals

begin
	
	process(clk, rst)
	begin
	
		if rst='1' then
			cnt_data<=(others=>'0');
		elsif clk'event and clk='1' then
			if cnt_data = "00010111" then
				cnt_data<=(others=>'0');
			else
				cnt_data<=cnt_data+'1';
			end if;
		end if;
		
	end process;

	cnt <= cnt_data;	-- connect output in entity.

end Behavioral;

