----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:51 04/12/2016 
-- Design Name: 
-- Module Name:    count_0to5 - Behavioral 
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

entity count_0to5 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           cnt : out  STD_LOGIC_VECTOR (2 downto 0)
			 );
end count_0to5;

architecture Behavioral of count_0to5 is

-- start signals
signal cnt_data : STD_LOGIC_VECTOR (2 downto 0);
-- end signals

begin
	
	process(clk, rst)
	begin
	
		if rst='1' then
			cnt_data<=(others=>'0');
		elsif clk'event and clk='1' then
			if cnt_data = "101" then			-- when count to 5, initialze output data.
				cnt_data<=(others=>'0');
			else
				cnt_data<=cnt_data+'1';
			end if;
		end if;
		
	end process;

	cnt <= cnt_data;	-- connect output in entity.

end Behavioral;

