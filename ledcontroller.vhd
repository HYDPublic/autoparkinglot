----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:56:48 05/11/2016 
-- Design Name: 
-- Module Name:    ledcontroller - Behavioral 
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

entity ledcontroller is
    Port ( parkinglot : in  STD_LOGIC_VECTOR (23 downto 0);
			  curr_address : in STD_LOGIC_VECTOR (4 downto 0);
			  rst, ena, clk, status : in  STD_LOGIC;      
           led_out : out  STD_LOGIC_VECTOR (23 downto 0));
end ledcontroller;

architecture Behavioral of ledcontroller is

component led_clock_divider is
	port( clk, rst : in std_logic;
			dclk : out std_logic);
end component;
component led_decoder is
     Port ( input : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

signal parkinglot_data : STD_LOGIC_VECTOR (23 downto 0);
signal curr_location : STD_LOGIC_VECTOR (23 downto 0);
signal div_clock : STD_LOGIC;
--for test

begin
	led_clk_div : led_clock_divider port map (clk => clk, rst => rst, dclk => div_clock);
	
	led_dec : led_decoder port map(input => curr_address, output => curr_location);
	
	process (ena, rst, parkinglot, status, div_clock, curr_location)
	variable curr_location_inv : STD_LOGIC_VECTOR (23 downto 0);
	begin
		if ena = '1' then
			if rst = '1' then
				parkinglot_data <= x"ffffff";
			else
				if status = '1' then
					parkinglot_data <= parkinglot;
				else
					if div_clock = '1' then
						parkinglot_data <= parkinglot;
					else
						curr_location_inv := not curr_location;
						parkinglot_data <= (parkinglot and curr_location_inv);
					end if;
				end if;
			end if;
		else
			parkinglot_data <= (others => '0');
		end if;
	
	end process;
	
	led_out <= parkinglot_data;

end Behavioral;

