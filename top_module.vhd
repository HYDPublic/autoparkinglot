----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:59:25 05/31/2016 
-- Design Name: 
-- Module Name:    top_module - Behavioral 
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

entity top_module is
    Port ( clk: in  STD_LOGIC;
			  --for keypad
           key_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           key_in : in  STD_LOGIC_VECTOR (3 downto 0);
			  --for led
           led_out : out  STD_LOGIC_VECTOR (23 downto 0);
			  --for segment
           dig : out  STD_LOGIC_VECTOR (5 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0);
			  --for push_button
           push_button : in  STD_LOGIC_VECTOR (3 downto 0);
			  --for dip_switch
           dip_switch : in  STD_LOGIC_VECTOR (7 downto 0);
			  --for display
           de : out  STD_LOGIC;
           lcd_clk : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end top_module;

architecture Behavioral of top_module is
--component
	component ledcontroller is
		 Port ( car_in : in  STD_LOGIC_VECTOR (23 downto 0);
				  curr_address : in STD_LOGIC_VECTOR (7 downto 0);
				  rst, ena, clk, status : in  STD_LOGIC;      
				  led_out : out  STD_LOGIC_VECTOR (23 downto 0));	
	end component;
	component digi_clk is
		port (clk1 : in std_logic;
   			freq : in std_logic_vector (2 downto 0);
		   	minutes : out std_logic_vector(7 downto 0));
	end component;
	component ram is
		Port ( clk, we, rst: in  STD_LOGIC;
			 address : in STD_LOGIC_VECTOR (7 downto 0);
			 data_in : in STD_LOGIC_VECTOR (27 downto 0);
			 data_out : out STD_LOGIC_VECTOR (27 downto 0));
	end component;
	component gate_controller is
	    Port ( clk, rst : in  STD_LOGIC;
           digit : out  STD_LOGIC_VECTOR (5 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0);
           key_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           key_in : in  STD_LOGIC_VECTOR (3 downto 0);
           ac_add : out  STD_LOGIC;
           ac_rmv : out  STD_LOGIC;
           car_num : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
--end component
	signal rst_inv : STD_LOGIC;
	signal status : STD_LOGIC;
	signal car_in : STD_LOGIC_VECTOR (23 downto 0);
	signal curr_address : STD_LOGIC_VECTOR (7 downto 0);
	signal freq : STD_LOGIC_VECTOR (2 downto 0);
	signal minutes : STD_LOGIC_VECTOR (7 downto 0);
	signal ac_add, ac_rmv : STD_LOGIC;
	signal car_num : STD_LOGIC_VECTOR (15 downto 0);
begin
	rst_inv <= not push_button(0);
	status <= dip_switch(0);
	freq <= dip_switch(7 downto 5);
	
	led_ctrl : ledcontroller port map(car_in => car_in, curr_address => curr_address, rst => rst_inv, ena => '1', clk => clk, status => status, led_out => led_out);
	dig_clk : digi_clk port map(clk1 => clk, freq => freq, minutes => minutes);
	gate_ctrl : gate_controller port map(clk => clk, 
													 rst => rst_inv, 
													 digit => dig, 
													 segment => segment, 
													 key_scan => key_scan, 
													 key_in => key_in, 
													 ac_add => ac_add, 
													 ac_rmv => ac_rmv, 
													 car_num => car_num);

	--car_ram : ram port map(clk => clk, we => , rst, address, data_in, data_out);
end Behavioral;

