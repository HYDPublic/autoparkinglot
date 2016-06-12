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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_controller is
    Port ( clk, rst : in  STD_LOGIC;
			  real_clk : in STD_LOGIC_VECTOR (15 downto 0);
           address : in  STD_LOGIC_VECTOR (4 downto 0);
			  car_num : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  parkinglot : out STD_LOGIC_VECTOR (23 downto 0);
           ac_show, ac_add, ac_rmv : in  STD_LOGIC);
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
	component empty_address_finder is
    Port ( clk, rst, ena : in STD_LOGIC;
			  parkinglot : in  STD_LOGIC_VECTOR (23 downto 0);
			  find_event : out STD_LOGIC;
           address : out  STD_LOGIC_VECTOR (4 downto 0));	
	end component;
	signal regi_data : STD_LOGIC_VECTOR (31 downto 0);
	signal ram_wea : STD_LOGIC_VECTOR (0 downto 0);
	signal ram_clk : STD_LOGIC;
	signal parkinglot_data : STD_LOGIC_VECTOR (23 downto 0);
	signal find_empty_event : STD_LOGIC;
	signal find_empty_address : STD_LOGIC_VECTOR (4 downto 0);
	signal find_empty_ena : STD_LOGIC;
	signal rst_inv : STD_LOGIC;
begin
	
	rst_inv <= not rst;
	ram_clk <= ac_show and ac_add;
	ram_wea <= "0" when ac_show = '1' else "1";
	
	car_ram : car_reg_ram port map (clka => ram_clk,
									rsta => rst_inv,
									wea => ram_wea,
									addra => address,
									dina => x"00000000",
									douta => data_out);
									
	empty_addr_finder : empty_address_finder port map (clk => clk, 
															  rst => rst, 
															  ena => find_empty_ena, 
															  parkinglot => parkinglot_data, 
															  find_event => find_empty_event, 
															  address => find_empty_address);
	
	process(find_empty_event)
	begin
		if rising_edge(find_empty_event) then
			
			--wea = 1
			--clk = 1
			--addra = find_empty_addr
			--din = din
			--dout = 따로 저장
		end if;
	end process;
	
	parkinglot <= parkinglot_data;
	
	
end Behavioral;

