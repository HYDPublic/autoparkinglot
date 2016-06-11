--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:25:50 06/11/2016
-- Design Name:   
-- Module Name:   C:/Users/minchul/Documents/autoparkinglot/addr_finder_test.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: empty_address_finder
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
 
ENTITY addr_finder_test IS
END addr_finder_test;
 
ARCHITECTURE behavior OF addr_finder_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT empty_address_finder
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         car_storage : IN  std_logic_vector(23 downto 0);
			find_event : out STD_LOGIC;
         address : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal car_storage : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
	signal find_event : STD_LOGIC;
   signal address : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: empty_address_finder PORT MAP (
          clk => clk,
          rst => rst,
			 find_event => find_event,
          car_storage => car_storage,
          address => address
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
		car_storage <= "101110110100111101101111";
      rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait for 300 ns;
		car_storage <= "101110110100111101111111";
      -- insert stimulus here 

      wait;
   end process;

END;
