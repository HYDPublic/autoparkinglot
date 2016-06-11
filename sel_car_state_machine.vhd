----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:13:52 06/11/2016 
-- Design Name: 
-- Module Name:    sel_car_state_machine - Behavioral 
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

entity sel_car_state_machine is
    Port ( clk, rst : in  STD_LOGIC;
           btn_p, btn_n, finish : in  STD_LOGIC;
			  find_p, find_n : out STD_LOGIC);
end sel_car_state_machine;

architecture Behavioral of sel_car_state_machine is
type state_type is (idle, find_prev, find_next);
signal curr_state, next_state : state_type;

begin
	process (rst, clk)
	begin
		if rst = '1' then
			curr_state <= idle;
		elsif rising_edge(clk) then
			curr_state <= next_state;
		end if;
	end process;
	
	process (curr_state, btn_p, btn_n, finish)
	begin
		case curr_state is
			when idle =>
				if btn_p = '1' then
					next_state <= find_p;
				elsif btn_n = '1' then
					next_state <= find_n;
				else
					next_state <= idle;
				end if;
			when find_prev =>
				if finish = '1' then
					next_state <= idle;
				else
					next_state <= find_prev;
				end if;
			when find_next =>
				if finish = '1' then
					next_state <= idle;
				else
					next_state <= find_next;
				end if;
			when others =>
				nxt_state <= idle;
		end case;
	end process;
	
	process (curr_state)
	begin
		if curr_state = idle then
			find_p <= '0';
			find_n <= '0';
		elsif curr_state = find_prev then
			find_p <= '1';
			find_n <= '0';
		elsif curr_state = find_next  then
			find_p <= '0';
			find_n <= '1';
		else
			find_p <= '0';
			find_n <= '0';
		end if;
	end process;

end Behavioral;

