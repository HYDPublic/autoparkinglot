----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:06:02 06/12/2016 
-- Design Name: 
-- Module Name:    ram_state_machine - Behavioral 
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

entity ram_state_machine is
    Port ( clk, rst : in  STD_LOGIC;
			  ac_find_car, ac_find_empty_space, ac_read_addr, ac_write_data : in STD_LOGIC;
			  fin_find_car, fin_find_empty_space, fin_read_addr, fin_write_data : in STD_LOGIC;
			  find_car, find_empty_space, read_addr, write_data : out STD_LOGIC);
end ram_state_machine;

architecture Behavioral of ram_state_machine is
type state_type is (idle, sfind_car, sfind_empty_space, sread_addr, swrite_data);
signal curr_state, nxt_state : state_type;
begin
	process (rst, clk)
	begin
		if rst = '1' then
			curr_state <= idle;
		elsif rising_edge(clk) then
			curr_state <= nxt_state;
		end if;
	end process;
	
	process (curr_state, ac_find_car, ac_find_empty_space, ac_read_addr, ac_write_data, 
			   fin_find_car, fin_find_empty_space, fin_read_addr, fin_write_data)
	begin
		case curr_state is
			when idle =>
				if ac_find_car = '1' then
					nxt_state <= sfind_car;
				elsif ac_find_empty_space = '1' then
					nxt_state <= sfind_empty_space;
				elsif ac_read_addr = '1' then
					nxt_state <= sread_addr;
				elsif ac_write_data = '1' then
					nxt_state <= swrite_data;
				else
					nxt_state <= idle;
				end if;
			when sfind_car =>
				if fin_find_car = '1' then
					nxt_state <= idle;
				else
					nxt_state <= sfind_car;
				end if;				
			when sfind_empty_space =>
				if fin_find_empty_space = '1' then
					nxt_state <= idle;
				else
					nxt_state <= sfind_empty_space;
				end if;								
			when sread_addr =>
				if fin_read_addr = '1' then
					nxt_state <= idle;
				else
					nxt_state <= sread_addr;
				end if;		
			when swrite_data =>
				if fin_write_data = '1' then
					nxt_state <= idle;
				else
					nxt_state <= swrite_data;
				end if;
			when others =>
				nxt_state <= idle;
		end case;
	end process;
	process(curr_state)
	begin
		case curr_state is
			when idle =>
				find_car <= '0';
				find_empty_space <= '0';
				read_addr <= '0';
				write_data <= '0';
			when sfind_car =>
				find_car <= '1';
				find_empty_space <= '0';
				read_addr <= '0';
				write_data <= '0';
			when sfind_empty_space =>
				find_car <= '0';
				find_empty_space <= '1';
				read_addr <= '0';
				write_data <= '0';
			when sread_addr =>
				find_car <= '0';
				find_empty_space <= '0';
				read_addr <= '1';
				write_data <= '0';
			when swrite_data =>
				find_car <= '0';
				find_empty_space <= '0';
				read_addr <= '0';
				write_data <= '1';
			when others =>
				find_car <= '1';
				find_empty_space <= '1';
				read_addr <= '1';
				write_data <= '1';
		end case;		
	end process;
end Behavioral;

