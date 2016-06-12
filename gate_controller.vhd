----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:03:56 05/31/2016 
-- Design Name: 
-- Module Name:    gate_controller - Behavioral 
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

entity gate_controller is
    Port ( clk, rst : in  STD_LOGIC;
           digit : out  STD_LOGIC_VECTOR (5 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0);
           key_data : in  STD_LOGIC_VECTOR (3 downto 0);
           key_event : in  STD_LOGIC;
           ac_add : out  STD_LOGIC;
           ac_rmv : out  STD_LOGIC;
           car_num : out  STD_LOGIC_VECTOR (15 downto 0));
end gate_controller;

architecture Behavioral of gate_controller is

component seg_clk_divider is
    Port ( clk, rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC
			 );
end component;

component seg_controller is
	port ( clk, rst : in STD_LOGIC;
			 SEG_INPUT1, SEG_INPUT2, SEG_INPUT3,
			 SEG_INPUT4, SEG_INPUT5, SEG_INPUT6 : in STD_LOGIC_VECTOR(3 downto 0);
			 
			 segment : out STD_LOGIC_VECTOR(7 downto 0);
			 dig : out STD_LOGIC_VECTOR(5 downto 0)
			);
end component;

component shift_register_6bit is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (3 downto 0);
			  
           shreg0 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg1 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg2 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg3 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg4 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg5 : out  STD_LOGIC_VECTOR (3 downto 0)
	 );
end component;

component calculator is
    Port ( rst : in  STD_LOGIC;
           clk, key_event : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (3 downto 0);
			  clear_event, input_event, remove_event, number_event : out STD_LOGIC);
end component;

-- end components

-- start signals
type seg_in is array  (0 to 5) of STD_LOGIC_VECTOR(3 downto 0);
signal seginput : seg_in;

signal seg_clk : STD_LOGIC;

signal number_out : STD_LOGIC_VECTOR (3 downto 0);
signal clear_event, input_event, remove_event, number_event : STD_LOGIC;
signal rst_shift_reg : STD_LOGIC;

-- end signals

begin

	
	rst_shift_reg <= rst or clear_event;
	
	calc : calculator port map(clk => clk, 
										key_event => key_event,
									   rst => rst, 
										input => key_data, 
										output=>number_out, 
										clear_event => clear_event, 
										number_event => number_event,
										input_event => input_event, 
										remove_event => remove_event);
	
	
	seg_dvd : seg_clk_divider port map ( clk => clk, rst => rst,
													 new_clk =>  seg_clk );
													 
 
	shift_reg : shift_register_6bit port map ( clk=>number_event, reset=>rst_shift_reg,
															 input=>number_out,
															 shreg0=>seginput(0),
															 shreg1=>seginput(1),
															 shreg2=>seginput(2),
															 shreg3=>seginput(3),
															 shreg4=>seginput(4),
															 shreg5=>seginput(5));
															 
	
	seg_ctrller : seg_controller port map ( clk => seg_clk, rst => rst,
														 SEG_INPUT1 => seginput(0), SEG_INPUT2 => seginput(1), SEG_INPUT3 => seginput(2),
														 SEG_INPUT4 => seginput(3), SEG_INPUT5 => seginput(4), SEG_INPUT6 => seginput(5),
			 
														 segment => segment, dig => digit);
end Behavioral;

