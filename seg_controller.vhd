----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:18:17 04/12/2016 
-- Design Name: 
-- Module Name:    seg_controller - Behavioral 
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

entity seg_controller is
	port ( clk, rst : in STD_LOGIC;
			 SEG_INPUT1, SEG_INPUT2, SEG_INPUT3,
			 SEG_INPUT4, SEG_INPUT5, SEG_INPUT6 : in STD_LOGIC_VECTOR(3 downto 0);
			 
			 segment : out STD_LOGIC_VECTOR(7 downto 0);
			 dig : out STD_LOGIC_VECTOR(5 downto 0)
			);
end seg_controller;

architecture Behavioral of seg_controller is

-- start componets
component count_0To5 is
	port ( clk, rst : in STD_LOGIC;
			 cnt : out STD_LOGIC_VECTOR (2 downto 0)
			);
end component;
-- end components

-- start signals
signal seg_int : STD_LOGIC_VECTOR (7 downto 0);
signal display_data : STD_LOGIC_VECTOR (3 downto 0);
signal clk_count : STD_LOGIC_VECTOR (2 downto 0);
signal digit : STD_LOGIC_VECTOR (5 downto 0);
-- end signals

begin

	Counter_0to5 : count_0To5 port map ( clk => clk,
													 rst => rst,
													 cnt => clk_count );	
													 
	-- process1 (seq logic)
	-- Selects digit with clock for sychronous and initialize digit.
	process (clk, rst)
	begin
		if rst = '1' then
			digit <= "000001";
		else
			if rising_edge(clk) then	-- Another grammar of edge triggering
				case clk_count is
					when "000" => digit <= "000001";
					when "001" => digit <= "000010";
					when "010" => digit <= "000100";
					when "011" => digit <= "001000";
					when "100" => digit <= "010000";
					when "101" => digit <= "100000";
					when others => digit <= "000000";
				end case;
			end if;
		end if;
	end process;
	-- end process1

	-- process2 (combi logic)
	-- According to digit, select data for display.
	process (digit, rst, SEG_INPUT1, SEG_INPUT2, SEG_INPUT3, SEG_INPUT4, SEG_INPUT5, SEG_INPUT6)
	begin
		case digit is
			when "000001" => display_data <= SEG_INPUT1;
			when "000010" => display_data <= SEG_INPUT2;
			when "000100" => display_data <= SEG_INPUT3;
			when "001000" => display_data <= SEG_INPUT4;
			when "010000" => display_data <= SEG_INPUT5;
			when "100000" => display_data <= SEG_INPUT6;
			when others => display_data <= "0000";
		end case;
	end process;
	-- end process2
	
	-- process3 (combi logic)
	-- According to digit, define 7segment bits.
	process(display_data)
	begin
		case display_data is
			when X"0" => seg_int <= "11111100";
			when X"1" => seg_int <= "01100000";
			when X"2" => seg_int <= "11011010";
			when X"3" => seg_int <= "11110010";
			when X"4" => seg_int <= "01100110";
			when X"5" => seg_int <= "10110110";
			when X"6" => seg_int <= "10111110";
			when X"7" => seg_int <= "11100100";
			when X"8" => seg_int <= "11111110";
			when X"9" => seg_int <= "11110110";
			when others => seg_int <= (others => '0');
		end case;
	end process;
	-- end process3
	
	dig <= digit;
	segment <= seg_int;


end Behavioral;

