--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:41:21 06/13/2016
-- Design Name:   
-- Module Name:   C:/Users/minchul/Documents/autoparkinglot/ram_controller_test.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram_controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ram_controller_test IS
END ram_controller_test;
 
ARCHITECTURE behavior OF ram_controller_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram_controller
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         find_car : IN  std_logic;
         find_empty_space : IN  std_logic;
         read_addr : IN  std_logic;
         write_data : IN  std_logic;
         car_num : IN  std_logic_vector(15 downto 0);
         addr_out : OUT  std_logic_vector(4 downto 0);
         car_data : OUT  std_logic_vector(31 downto 0);
         addr_in : IN  std_logic_vector(4 downto 0);
         prev : IN  std_logic;
         write_car_data : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal find_car : std_logic := '0';
   signal find_empty_space : std_logic := '0';
   signal read_addr : std_logic := '0';
   signal write_data : std_logic := '0';
   signal car_num : std_logic_vector(15 downto 0) := (others => '0');
   signal addr_in : std_logic_vector(4 downto 0) := (others => '0');
   signal prev : std_logic := '0';
   signal write_car_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal addr_out : std_logic_vector(4 downto 0);
   signal car_data : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram_controller PORT MAP (
          clk => clk,
          rst => rst,
          find_car => find_car,
          find_empty_space => find_empty_space,
          read_addr => read_addr,
          write_data => write_data,
          car_num => car_num,
          addr_out => addr_out,
          car_data => car_data,
          addr_in => addr_in,
          prev => prev,
          write_car_data => write_car_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		find_car <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
