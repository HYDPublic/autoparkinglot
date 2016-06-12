----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:34 06/11/2016 
-- Design Name: 
-- Module Name:    empty_address_finder - Behavioral 
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

entity empty_address_finder is
    Port ( clk, rst, ena : in STD_LOGIC;
			  parkinglot : in  STD_LOGIC_VECTOR (23 downto 0);
			  find_event : out STD_LOGIC;
           address : out  STD_LOGIC_VECTOR (4 downto 0));
end empty_address_finder;

architecture Behavioral of empty_address_finder is
component counter_0_to_23 is
    Port ( clk, ena, rst : in  STD_LOGIC;
           cnt : out  STD_LOGIC_VECTOR (4 downto 0));
end component;
signal cnt : STD_LOGIC_VECTOR (4 downto 0);
signal mask : STD_LOGIC_VECTOR (23 downto 0);
signal addr_data, addr : STD_LOGIC_VECTOR (4 downto 0);
signal parkinglot_data : STD_LOGIC_VECTOR (23 downto 0);
signal parkinglot_change_event : STD_LOGIC;
signal cnt_rst : STD_LOGIC;
begin
	cnt_rst <= rst or parkinglot_change_event;
	process (cnt)
	begin
		if cnt = "10111" then
			find_event <= '1';
		else
			find_event <= '0';
		end if;
	end process;
	
	process (clk, parkinglot)
	begin
		if rising_edge(clk) then
			if parkinglot /= parkinglot_data then
				parkinglot_data <= parkinglot;
				parkinglot_change_event <= '1';
			else
				parkinglot_data <= parkinglot_Data;
				parkinglot_change_event <= '0';
			end if;
		end if;
	end process;
	
	
	
	addr_data <= "11000" when (rst = '1') else 
					 cnt when (mask and parkinglot) = x"000000" else 
					 addr_data;
					 
	addr <= "11000" when rst = '1' or (parkinglot_change_event = '1')  else
			  addr_data when addr="11000" else
			  addr;
			  
	conter : counter_0_to_23 port map(clk => clk, ena=>ena, rst => cnt_rst, cnt => cnt);
	mask <= "000000000000000000000001" when cnt = "00000" else
			  "000000000000000000000010" when cnt = "00001" else
			  "000000000000000000000100" when cnt = "00010" else
			  "000000000000000000001000" when cnt = "00011" else
			  "000000000000000000010000" when cnt = "00100" else
			  "000000000000000000100000" when cnt = "00101" else
			  "000000000000000001000000" when cnt = "00110" else
			  "000000000000000010000000" when cnt = "00111" else
			  "000000000000000100000000" when cnt = "01000" else
			  "000000000000001000000000" when cnt = "01001" else
			  "000000000000010000000000" when cnt = "01010" else
			  "000000000000100000000000" when cnt = "01011" else
			  "000000000001000000000000" when cnt = "01100" else
			  "000000000010000000000000" when cnt = "01101" else
			  "000000000100000000000000" when cnt = "01110" else
			  "000000001000000000000000" when cnt = "01111" else
			  "000000010000000000000000" when cnt = "10000" else
			  "000000100000000000000000" when cnt = "10001" else
			  "000001000000000000000000" when cnt = "10010" else
			  "000010000000000000000000" when cnt = "10011" else
			  "000100000000000000000000" when cnt = "10100" else
			  "001000000000000000000000" when cnt = "10101" else
			  "010000000000000000000000" when cnt = "10110" else
			  "100000000000000000000000" when cnt = "10111" else
			  "000000000000000000000000";
	address <= addr;
end Behavioral;

