----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:01:12 04/01/2015 
-- Design Name: 
-- Module Name:    reg - Behavioral 
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


-- entity --
entity reg is
	port ( input : in std_logic_vector (3 downto 0) ;
			 clk, reset, en : in std_logic ;
			 
			 output : out std_logic_vector (3 downto 0)
			);
end reg;
------------

-- architecture --
architecture Behavioral of reg is

	component dff
		port ( clk : in std_logic ;
				 reset : in std_logic ;
				 d, en : in std_logic ;
				 
				 q : out std_logic
				);
	end component;

begin
	reg0 : FOR n IN 3 downto 0 GENERATE
		reg : dff port map(  clk => clk,
									reset => reset,
									en => en,
									d => input(n),
									q => output(n)
								 );
	END GENERATE;

end Behavioral;
--------------------