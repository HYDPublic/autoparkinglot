----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:26:41 04/25/2016 
-- Design Name: 
-- Module Name:    keypad_controller - Behavioral 
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

entity keypad_controller is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           key_in : in  STD_LOGIC_VECTOR (3 downto 0);
           key_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           key_data : out  STD_LOGIC_VECTOR (3 downto 0);
			  key_event : out STD_LOGIC
			  );
end keypad_controller;

architecture Behavioral of keypad_controller is

-- start components
component x4_clk_divider is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC);
end component;
-- end components

-- start signals
signal scan_cnt : STD_LOGIC_VECTOR (3 downto 0);
signal key_data_int : STD_LOGIC_VECTOR (3 downto 0);
signal key_in_int : STD_LOGIC_VECTOR (3 downto 0);
signal key_clk : STD_LOGIC;

signal key_temp0 : STD_LOGIC;
signal key_temp1 : STD_LOGIC;
signal key_temp2 : STD_LOGIC;
signal key_temp3 : STD_LOGIC;

-- ens signals

begin
	
	x4_DVD : x4_clk_divider port map ( clk => clk,
												  rst => reset,
												  new_clk => key_clk );

	-- process1 ()
	process(reset, key_clk)
	begin
		if reset = '1' then
			scan_cnt <= "1110";
		elsif rising_edge(key_clk) then
			scan_cnt <= scan_cnt (2 downto 0) & scan_cnt(3);
		end if;
	end process;
	
	-- process2 ()
	process(reset, key_in, clk)
	begin
		if reset='1' then
			key_in_int <= (others=>'1');
		elsif rising_edge(clk) then
			key_in_int <= key_in;
		end if;
		
	end process;

	-- process3 ()
	process(scan_cnt, key_in, key_clk)
	begin
		if rising_edge(key_clk) then
			case scan_cnt is
				when "1110" => if key_in_int = "1110" then
										key_data_int <= x"1";
									elsif key_in_int = "1101" then
										key_data_int <= x"4";	
									elsif key_in_int = "1011" then
										key_data_int <= x"7";
									elsif key_in_int = "0111" then
										key_data_int <= x"0";
									end if;
				when "1101" => if key_in_int = "1110" then
										key_data_int <= x"2";
									elsif key_in_int = "1101" then
										key_data_int <= x"5";	
									elsif key_in_int = "1011" then
										key_data_int <= x"8";
									elsif key_in_int = "0111" then
										key_data_int <= x"A";
									end if;
				when "1011" => if key_in_int = "1110" then
										key_data_int <= x"3";
									elsif key_in_int = "1101" then
										key_data_int <= x"6";	
									elsif key_in_int = "1011" then
										key_data_int <= x"9";
									elsif key_in_int = "0111" then
										key_data_int <= x"B";
									end if;
				when "0111" => if key_in_int = "1110" then
										key_data_int <= x"F";
									elsif key_in_int = "1101" then
										key_data_int <= x"E";	
									elsif key_in_int = "1011" then
										key_data_int <= x"D";
									elsif key_in_int = "0111" then
										key_data_int <= x"C";
									end if;
				when others => key_data_int <= key_data_int;
			end case;
		end if;				
	end process;
	--process()
	process (reset, key_in_int, scan_cnt, key_clk)
	begin
		if reset = '1' then
			key_temp0 <= '0';
			key_temp1 <= '0';
			key_temp2 <= '0';
			key_temp3 <= '0';
		elsif rising_edge(key_clk) then
			case scan_cnt is
				when "1110" => if key_in_int = "1111" then
										key_temp0 <= '0';
									else
										key_temp0 <= '1';
									end if;
				when "1101" => if key_in_int = "1111" then
										key_temp1 <= '0';
									else
										key_temp1 <= '1';
									end if;
				when "1011" => if key_in_int = "1111" then
										key_temp2 <= '0';
									else
										key_temp2 <= '1';
									end if;
				when "0111" => if key_in_int = "1111" then
										key_temp3 <= '0';
									else
										key_temp3 <= '1';
									end if;
				when others => key_temp1 <= key_temp1;
			end case;
		end if;
	end process;
	--process()
	process (key_temp0, key_temp1, key_temp2, key_temp3)
	begin
		if key_temp0 = '0' and key_temp1 = '0' and key_temp2 = '0' and key_temp3 = '0' then
			key_event <= '0';
		else
			key_event <= '1';
		end if;
	end process;
	key_scan <= scan_cnt;
	key_data <= key_data_int;
	
end Behavioral;

