----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:21:40 05/31/2016 
-- Design Name: 
-- Module Name:    ram_controller - Behavioral 
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

entity ram_controller is
	port(clk, rst : in STD_LOGIC;
		  ac_add, ac_rmv, ac_show : in STD_LOGIC;
		  address : in STD_LOGIC_VECTOR (7 downto 0);
		  car_num : in STD_LOGIC_VECTOR (15 downto 0);
		  car_data : out STD_LOGIC_VECTOR (27 downto 0));
end ram_controller;

architecture Behavioral of ram_controller is
component ram is
	Port ( clk, we, rst: in  STD_LOGIC;
			 address : in STD_LOGIC_VECTOR (7 downto 0);
			 data_in : in STD_LOGIC_VECTOR (27 downto 0);
			 data_out : out STD_LOGIC_VECTOR (27 downto 0));
end component;
component ram_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           cnt : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal address_cnt : STD_LOGIC_VECTOR (7 downto 0);

signal car_info : STD_LOGIC_VECTOR (27 downto 0);
signal we : STD_LOGIC;
signal data_in : STD_LOGIC_VECTOR (27 downto 0);
signal data_out : STD_LOGIC_VECTOR (27 downto 0);

begin

	ram_cnt : ram_counter port map(clk => clk, rst => rst, cnt => address_cnt);
	car_ram : ram port map(clk => clk, we => '0', rst => rst, address => address_cnt, data_in => data_in, data_out => data_out);

	process(ac_add) 
	begin
	
	
	end process;
	
--	process (data_out)
--	begin
--		if data_out = x"0000000" then
--			address_cnt
--		end if;
--	end process;
	
end Behavioral;

