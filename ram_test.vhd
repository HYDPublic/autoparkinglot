--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:51:22 05/31/2016
-- Design Name:   
-- Module Name:   D:/autoparkinglot/ram_test.vhd
-- Project Name:  autoparkinglot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram
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
 
ENTITY ram_test IS
END ram_test;
 
ARCHITECTURE behavior OF ram_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram
    PORT(
         clk : IN  std_logic;
         we : IN  std_logic;
         rst : IN  std_logic;
         address : IN  std_logic_vector(7 downto 0);
         data_in : IN  std_logic_vector(27 downto 0);
         data_out : OUT  std_logic_vector(27 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal we : std_logic := '0';
   signal rst : std_logic := '0';
   signal address : std_logic_vector(7 downto 0) := (others => '0');
   signal data_in : std_logic_vector(27 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(27 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram PORT MAP (
          clk => clk,
          we => we,
          rst => rst,
          address => address,
          data_in => data_in,
          data_out => data_out
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
		we <= '1';
		address <= x"10";
		data_in <= x"0005555";
		
		wait for 100 ns;
		address <= x"11";
		data_in <= x"0004444";		
		wait for 100 ns;
		we <= '0';
		address <= x"10";
		wait for 100 ns;
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		we <= '0';
		address <= x"10";
      -- insert stimulus here 

      wait;
   end process;

END;
