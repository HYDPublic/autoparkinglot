--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:42:03 05/31/2016
-- Design Name:   
-- Module Name:   D:/autoparkinglot/digi_clk_test.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: digi_clk
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
 
ENTITY digi_clk_test IS
END digi_clk_test;
 
ARCHITECTURE behavior OF digi_clk_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT digi_clk
    PORT(
         clk1 : IN  std_logic;
         freq : IN  std_logic_vector(2 downto 0);
         minutes : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk1 : std_logic := '0';
   signal freq : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal minutes : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk1_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: digi_clk PORT MAP (
          clk1 => clk1,
          freq => freq,
          minutes => minutes
        );

   -- Clock process definitions
   clk1_process :process
   begin
		clk1 <= '0';
		wait for clk1_period/2;
		clk1 <= '1';
		wait for clk1_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;	
		freq<= "100";
		wait for 100 ns;	
		freq<= "110";
		wait for 100 ns;	
		freq<= "111";
		
      
		
		
      -- insert stimulus here 

      wait;
   end process;

END;
