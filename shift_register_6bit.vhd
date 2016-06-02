----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:11:57 05/03/2016 
-- Design Name: 
-- Module Name:    shift_register_6bit - Behavioral 
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

entity shift_register_6bit is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (3 downto 0);
			  
           shreg0 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg1 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg2 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg3 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg4 : out  STD_LOGIC_VECTOR (3 downto 0);
           shreg5 : out  STD_LOGIC_VECTOR (3 downto 0)
	 );
end shift_register_6bit;

architecture Behavioral of shift_register_6bit is

-- start components
component reg is
	port ( input : in std_logic_vector (3 downto 0) ;
			 clk, reset, en : in std_logic ;
			 
			 output : out std_logic_vector (3 downto 0)
			);
end component;
-- end components

-- start signals
signal shift_reg0 : STD_LOGIC_VECTOR (3 downto 0);
signal shift_reg1 : STD_LOGIC_VECTOR (3 downto 0);
signal shift_reg2 : STD_LOGIC_VECTOR (3 downto 0);
signal shift_reg3 : STD_LOGIC_VECTOR (3 downto 0);
signal shift_reg4 : STD_LOGIC_VECTOR (3 downto 0);
signal shift_reg5 : STD_LOGIC_VECTOR (3 downto 0);
-- end signals

begin

	REG0 : reg port map (input=>input, clk=>clk, reset=>reset, en=>'1', output=>shift_reg0);
	REG1 : reg port map (input=>shift_reg0, clk=>clk, reset=>reset, en=>'1', output=>shift_reg1);
	REG2 : reg port map (input=>shift_reg1, clk=>clk, reset=>reset, en=>'1', output=>shift_reg2);
	REG3 : reg port map (input=>shift_reg2, clk=>clk, reset=>reset, en=>'1', output=>shift_reg3);
	--REG4 : reg port map (input=>shift_reg3, clk=>clk, reset=>reset, en=>'1', output=>shift_reg4);
	--REG5 : reg port map (input=>shift_reg4, clk=>clk, reset=>reset, en=>'1', output=>shift_reg5);

	shreg0<=shift_reg0;
	shreg1<=shift_reg1;
	shreg2<=shift_reg2;
	shreg3<=shift_reg3;
	shreg4<="0000";
	shreg5<="0000";

end Behavioral;

