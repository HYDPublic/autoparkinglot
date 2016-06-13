----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:59 06/11/2016 
-- Design Name: 
-- Module Name:    ram_controller - Behavioral 
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

entity ram_controller is
    Port ( clk, rst : in  STD_LOGIC;
			  ac_put, ac_rmv, ac_show : in STD_LOGIC;
			  car_num : in STD_LOGIC_VECTOR(15 downto 0);
			  addr : in STD_LOGIC_VECTOR(4 downto 0);
			  car_data : out STD_LOGIC_VECTOR(31 downto 0);
			  parkinglot : out STD_LOGIC_VECTOR(23 downto 0));
end ram_controller;

architecture Behavioral of ram_controller is
	component car_reg_ram is
	  PORT (
		 clka : IN STD_LOGIC;
		 rsta : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	  );	
	end component;
	component counter0to23 IS
	  PORT (
		 clk : IN STD_LOGIC;
		 ce : IN STD_LOGIC;
		 sclr : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	  );
	end component;

------ end component
	signal ram_wea : STD_LOGIC_VECTOR (0 downto 0);
	signal ram_addr : STD_LOGIC_VECTOR (4 downto 0);
	signal ram_din, ram_dout : STD_LOGIC_VECTOR (31 downto 0);
	signal find_car, find_empty_space, write_data, read_data : STD_LOGIC;
	signal c_clk, ram_cnt_ce, ram_cnt_sclr : STD_LOGIC;
	signal addr_cnt : STD_LOGIC_VECTOR (4 downto 0);
begin
	c_clk <= '0' when rst = '1' else
			  not c_clk when falling_edge(clk) else
			  c_clk;
	car_ram : car_reg_ram port map (clka => clk, rsta => rst, wea => ram_wea, addra => ram_addr, dina => ram_din, douta => ram_dout);
	
	process(clk, ac_put, ac_rmv, ac_show)
	begin
		
	end process;
	
	process(find_car, find_empty_space, write_data, read_data)
	begin
		if find_car = '1' then
			
		end if;
	end process;
	
	process(clk, c_clk, ram_addr, ram_dout, find_car, find_empty_space)
	begin
		if find_car = '1' then
		elsif find_empty_space = '1' then
		end if;
	end process;
	ram_cnt_ce <= find_car or find_empty_space;
	ram_cnt_sclr <= not (find_car or find_empty_space);
	ram_addr <= addr_cnt when (find_car or find_empty_space) = '1' else "11000";
	ram_cnt : counter0to23 port map(clk => c_clk, ce => ram_cnt_ce, sclr => ram_cnt_sclr, q => addr_cnt);
end Behavioral;

