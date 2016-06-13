--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:15:13 06/12/2016
-- Design Name:   
-- Module Name:   C:/Users/minchul/Documents/autoparkinglot/countertest.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter0to23
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
 
ENTITY countertest IS
END countertest;
 
ARCHITECTURE behavior OF countertest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter0to23
    PORT(
         clk : IN  std_logic;
         ce : IN  std_logic;
         sclr : IN  std_logic;
         q : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ce : std_logic := '0';
   signal sclr : std_logic := '0';

 	--Outputs
   signal q : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter0to23 PORT MAP (
          clk => clk,
          ce => ce,
          sclr => sclr,
          q => q
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
		ce <= '1';
		wait for 100 ns;
		sclr <= '1';
		wait for 20 ns;
		sclr <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
