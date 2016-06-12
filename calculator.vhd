----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:26:29 05/25/2016 
-- Design Name: 
-- Module Name:    calculator - Behavioral 
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

entity calculator is
    Port ( rst, clk, key_event : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (3 downto 0);
			  clear_event, input_event, remove_event, number_event : out STD_LOGIC);
end calculator;

architecture Behavioral of calculator is
signal output_data : STD_LOGIC_VECTOR (3 downto 0);
signal clear, put, remove, number : STD_LOGIC;


begin
	clear <= '1' when input = x"C" else '0';
	put <= '1' when input = x"A" else '0';
	remove <= '1' when input = x"B" else '0';
	number <= '1' when input >= x"0" and input <= x"9" else '0';
	clear_event <= key_event and clear;
	input_event <= key_event and put;
	remove_event <= key_event and remove;
	number_event <= key_event and number;
	
	output_data <= input when input >= x"0" and input <= x"9" else (others => '0');
	output <= output_data when (key_event and number) = '1' else (others => '0');
	
end Behavioral;

