--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:54:55 06/12/2016
-- Design Name:   
-- Module Name:   C:/Users/minchul/Documents/autoparkinglot/ramsmtest.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram_state_machine
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
 
ENTITY ramsmtest IS
END ramsmtest;
 
ARCHITECTURE behavior OF ramsmtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram_state_machine
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ac_show : IN  std_logic;
         ac_add : IN  std_logic;
         ac_rmv : IN  std_logic;
         find_car : OUT  std_logic;
         find_empty : OUT  std_logic;
         find_car_exist : IN  std_logic;
         find_car_null : IN  std_logic;
         find_empty_exist : IN  std_logic;
         find_empty_null : IN  std_logic;
         write_data : OUT  std_logic;
         write_finish : IN  std_logic;
         save_reg : OUT  std_logic;
         save_reg_finish : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ac_show : std_logic := '0';
   signal ac_add : std_logic := '0';
   signal ac_rmv : std_logic := '0';
   signal find_car_exist : std_logic := '0';
   signal find_car_null : std_logic := '0';
   signal find_empty_exist : std_logic := '0';
   signal find_empty_null : std_logic := '0';
   signal write_finish : std_logic := '0';
   signal save_reg_finish : std_logic := '0';

 	--Outputs
   signal find_car : std_logic;
   signal find_empty : std_logic;
   signal write_data : std_logic;
   signal save_reg : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram_state_machine PORT MAP (
          clk => clk,
          rst => rst,
          ac_show => ac_show,
          ac_add => ac_add,
          ac_rmv => ac_rmv,
          find_car => find_car,
          find_empty => find_empty,
          find_car_exist => find_car_exist,
          find_car_null => find_car_null,
          find_empty_exist => find_empty_exist,
          find_empty_null => find_empty_null,
          write_data => write_data,
          write_finish => write_finish,
          save_reg => save_reg,
          save_reg_finish => save_reg_finish
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
		ac_add <= '1';
		wait for 10 ns;
		ac_add <= '0';
		wait for 240 ns;
		find_car_null <= '1';
		wait for 240 ns;
		find_car_null <= '0';
		find_empty_exist <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
