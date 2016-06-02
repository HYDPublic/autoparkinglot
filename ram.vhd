----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:46:08 05/31/2016 
-- Design Name: 
-- Module Name:    ram - Behavioral 
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
use IEEE.Numeric_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram is
	Port ( clk, we, rst: in  STD_LOGIC;
			 address : in STD_LOGIC_VECTOR (7 downto 0);
			 data_in : in STD_LOGIC_VECTOR (27 downto 0);
			 data_out : out STD_LOGIC_VECTOR (27 downto 0));
end ram;

architecture Behavioral of ram is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(data_in'range);
   signal ram : ram_type;
   signal read_address : std_logic_vector(address'range);
	
begin
	
	RamProc: process(clk, rst) is

	begin
		if rst = '1' then
			ram <= (others => (others => '0'));
		else
			if rising_edge(clk) then
				if we = '1' then
					ram(to_integer(unsigned(address))) <= data_in;
				end if;
				read_address <= address;
			end if;
		end if;
	end process RamProc;

  data_out <= ram(to_integer(unsigned(read_address)));

end Behavioral;

