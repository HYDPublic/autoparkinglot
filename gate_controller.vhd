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
           key_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           key_in : in  STD_LOGIC_VECTOR (3 downto 0);
           ac_add : out  STD_LOGIC;
           ac_rmv : out  STD_LOGIC;
           car_num : out  STD_LOGIC_VECTOR (15 downto 0));
end gate_controller;

architecture Behavioral of gate_controller is
--component
	component keypad_controller is
	    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           key_in : in  STD_LOGIC_VECTOR (3 downto 0);
			  
           key_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           key_data : out  STD_LOGIC_VECTOR (3 downto 0);
			  key_event : out STD_LOGIC);
	end component;
	component seg_controller is
		port ( clk, rst : in STD_LOGIC;
			 SEG_INPUT1, SEG_INPUT2, SEG_INPUT3,
			 SEG_INPUT4, SEG_INPUT5, SEG_INPUT6 : in STD_LOGIC_VECTOR(3 downto 0);
			 
			 segment : out STD_LOGIC_VECTOR(7 downto 0);
			 dig : out STD_LOGIC_VECTOR(5 downto 0)
			);
	end component;
	component seg_clk_divider is
	    Port ( clk, rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC
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
--end component
-- start signals
type seg_in is array  (0 to 5) of STD_LOGIC_VECTOR(3 downto 0);
signal seginput : seg_in;

signal rst_inv : STD_LOGIC;
signal seg_clk : STD_LOGIC;

type keydata is array (0 to 5) of STD_LOGIC_VECTOR(3 downto 0);

signal input_data : keydata;

signal key_pad_out : STD_LOGIC_VECTOR (3 downto 0);
signal number_out : STD_LOGIC_VECTOR (3 downto 0);
signal key_event, clear_event, add_event, input_event : STD_LOGIC;
signal rst_shift_reg, rst_input_reg : STD_LOGIC;
signal equal : STD_LOGIC;

-- end signals

begin

	
	
	seg_dvd : seg_clk_divider port map ( clk => clk, rst => rst_inv,
													 new_clk =>  seg_clk );
													 
	keypad_cntrller : keypad_controller port map ( reset=>rst_inv,
																  clk=>seg_clk,
																  key_in=>key_in,
																  key_scan=>key_scan,
																  key_data=>key_pad_out,
																  key_event=>key_event);
	rst_shift_reg <= rst_inv or event_clear;

	is_number <= '1' when key_pad_out >= x"0" and key_pad_out <= x"9" else '0';
	event_number <= key_event and is_number;
	
	is_clear <= '1' when key_pad_out = x"C" else '0';
	event_clear <= key_event and is_clear;
	
	is_add <= '1' when key_pad_out = x"A" else '0';
	event_add <= key_event and is_add;
	
	is_remove <= '1' when key_pad_out = x"B" else '0';
	event_remove <= key_event and is_remove;
	
	shift_reg : shift_register_6bit port map ( clk=>event_number, reset=>rst_shift_reg,
															 input=>key_pad_out,
															 shreg0=>input_data(0),
															 shreg1=>input_data(1),
															 shreg2=>input_data(2),
															 shreg3=>input_data(3),
															 shreg4=>input_data(4),
															 shreg5=>input_data(5));
															 

	seginput(0) <= input_data(0);
	seginput(1) <= input_data(1);
	seginput(2) <= input_data(2);
	seginput(3) <= input_data(3);
	seginput(4) <= input_data(4);
	seginput(5) <= input_data(5);
	
	seg_ctrller : seg_controller port map ( clk => seg_clk, rst => rst_inv,
														 SEG_INPUT1 => seginput(0), SEG_INPUT2 => seginput(1), SEG_INPUT3 => seginput(2),
														 SEG_INPUT4 => seginput(3), SEG_INPUT5 => seginput(4), SEG_INPUT6 => seginput(5),
			 
														 segment => segment, dig => dig);

end Behavioral;

