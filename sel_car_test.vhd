--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:19:23 06/11/2016
-- Design Name:   
-- Module Name:   C:/Users/minchul/Documents/autoparkinglot/sel_car_test.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: select_car_controller
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
 
ENTITY sel_car_test IS
END sel_car_test;
 
ARCHITECTURE behavior OF sel_car_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT select_car_controller
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         car_storage : IN  std_logic_vector(23 downto 0);
         button_prev : IN  std_logic;
         button_next : IN  std_logic;
         current_addr : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal car_storage : std_logic_vector(23 downto 0) := (others => '0');
   signal button_prev : std_logic := '0';
   signal button_next : std_logic := '0';

 	--Outputs
   signal current_addr : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: select_car_controller PORT MAP (
          clk => clk,
          rst => rst,
          car_storage => car_storage,
          button_prev => button_prev,
          button_next => button_next,
          current_addr => current_addr
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
      wait for 10 ns;
		car_storage <= "110100001111000010101000";
		button_next <= '1';
		wait for 100 ns;
		button_next <= '0';
		wait for 300 ns;
		button_next <= '1';
		wait for 100 ns;
		button_next <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
