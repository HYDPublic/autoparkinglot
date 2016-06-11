----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:29:19 06/11/2016 
-- Design Name: 
-- Module Name:    select_car_controller - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity select_car_controller is
    Port ( clk, rst : in STD_LOGIC;
			  car_storage : in STD_LOGIC_VECTOR (23 downto 0);
			  button_prev, button_next : in  STD_LOGIC;
			  current_addr : out STD_LOGIC_VECTOR (4 downto 0));
end select_car_controller;

architecture Behavioral of select_car_controller is
component dff is
	port ( clk : in std_logic;
			 reset : in std_logic;
			 d, en : in std_logic;
			 q : out std_logic
			);
end component;
component btn_clock_divider is
    Port ( clk, rst : in  STD_LOGIC;
           new_clk : out  STD_LOGIC);
end component;
component sel_car_state_machine is
    Port ( clk, rst : in  STD_LOGIC;
           btn_p, btn_n, finish : in  STD_LOGIC;
			  find_p, find_n : out STD_LOGIC);
end component;

signal ac_prev, ac_next : STD_LOGIC;
signal btn_prev_inv, btn_next_inv : STD_LOGIC;
signal new_clk : STD_LOGIC;
signal c_addr : STD_LOGIC_VECTOR (4 downto 0);
signal exist_mask : STD_LOGIC_VECTOR (23 downto 0);

begin
	btn_prev_inv <= not button_prev;
	btn_next_inv <= not button_next;
	btn_clk_div : btn_clock_divider port map(clk => clk, rst => rst, new_clk => new_clk);
	btn_prev : dff port map(d => btn_prev_inv, clk => clk, reset => rst, en => '1', q => ac_prev);
	btn_next : dff port map(d => btn_next_inv, clk => clk, reset => rst, en => '1', q => ac_next);

	--scsm : sel_car_state_machine(clk => clk, rst => rst, btn_p =>ac_next, btn_n =>, finish =>, find_p =>, find_n =>);
	
--	process (car_storage)
--	begin
--		if exist_mask = x"111111";
--			
--		end if;
--	end process;
	
	process (clk, ac_next)
		variable temp_ac_next : STD_LOGIC;
		variable temp_mask : STD_LOGIC_VECTOR (23 downto 0);
	begin
		if rising_edge(clk) then
			if ac_next = '0' then
				temp_mask := x"000001";
				exist_mask <= x"111111";
			else
				temp_mask := temp_mask(22 downto 0) & temp_mask(23);
				if ((car_storage and temp_mask) = temp_mask ) and exist_mask = x"111111" then
					exist_mask <= temp_mask;
				end if;
			end if;
		end if;
	end process;
	
	c_addr <= "00000" when exist_mask = "000000000000000000000001" else
				 "00001" when exist_mask = "000000000000000000000010" else
				 "00010" when exist_mask = "000000000000000000000100" else
				 "00011" when exist_mask = "000000000000000000001000" else
				 "00100" when exist_mask = "000000000000000000010000" else
				 "00101" when exist_mask = "000000000000000000100000" else
				 "00110" when exist_mask = "000000000000000001000000" else
				 "00111" when exist_mask = "000000000000000010000000" else
				 "01000" when exist_mask = "000000000000000100000000" else
				 "01001" when exist_mask = "000000000000001000000000" else
				 "01010" when exist_mask = "000000000000010000000000" else
				 "01011" when exist_mask = "000000000000100000000000" else
				 "01100" when exist_mask = "000000000001000000000000" else
				 "01101" when exist_mask = "000000000010000000000000" else
				 "01110" when exist_mask = "000000000100000000000000" else
				 "01111" when exist_mask = "000000001000000000000000" else
				 "10000" when exist_mask = "000000010000000000000000" else
				 "10001" when exist_mask = "000000100000000000000000" else
				 "10010" when exist_mask = "000001000000000000000000" else
				 "10011" when exist_mask = "000010000000000000000000" else
				 "10100" when exist_mask = "000100000000000000000000" else
				 "10101" when exist_mask = "001000000000000000000000" else
				 "10110" when exist_mask = "010000000000000000000000" else
				 "10111" when exist_mask = "100000000000000000000000" else
				 "11000";

				  
	current_addr <= c_addr;
end Behavioral;

