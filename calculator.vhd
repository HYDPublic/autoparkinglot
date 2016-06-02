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
			  ac_add, ac_rmv, ac_input, ac_cancel : out STD_LOGIC);
end calculator;

architecture Behavioral of calculator is
signal output_data : STD_LOGIC_VECTOR (3 downto 0);
signal add, remove, number, cancel : STD_LOGIC;

begin
	add <= '1' when input = x"A" else '0';
	remove <= '1' when input = x"B" else '0';
	number <= '1' when input >= x"0" and input <= x"9" else '0';
	cancel <= '1' when input = x"C" else '0';
	
	
	ac_cancel <= key_event and cancel;
	ac_add <= key_event and add;
	ac_input <= key_event and number;
	ac_remove <= key_event and remove;
	
	output_data <= input when input >= x"0" and input <= x"9" else (others => '0');
	output <= output_data when (key_event and number) = '1' else (others => '0');
	
end Behavioral;

