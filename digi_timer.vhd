library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity digi_clk is
port (clk1 : in std_logic;
		freq : in std_logic_vector (2 downto 0);
      minutes : out std_logic_vector(7 downto 0)
     );
end digi_clk;

architecture Behavioral of digi_clk is
signal sec,min : integer range 0 to 60 :=0;
signal count : integer :=1;
signal clk : std_logic :='0';

signal freqSec : integer range 0 to 60 :=1;

begin
	minutes <= conv_std_logic_vector(min,8);

	 --clk generation.For 100 MHz clock this generates 1 Hz clock.
	 
	process(freq)
	begin
	-- 111 => 5, 110 => 14, 100 => 29 else 59=>
		if freq = "111" then
			freqSec <= 10;
		elsif freq = "110" then
			freqSec <= 5;
		elsif freq = "100" then
			freqSec <= 2;
		else
			freqSec <= 1;
		end if;
	end process; 
	 
	process(clk1)
	begin
		if(clk1'event and clk1='1') then
			count <=count+1;
			if(count = 50000000) then
			--if(count = 2) then --for test
				clk <= not clk;
				count <=1;
			end if;
		end if;
	end process;

	process(clk)   --period of clk is 1 second.
	begin

	if(clk'event and clk='1') then
		min <= min + freqSec;
		if(min >= 1440)then
			min <= 0;
		end if;
--		sec <= sec+ 1;
--		if(sec >= freqSec) then
--			sec<=0;
--			min <= min + 1;
--			if(min = 1400) then --24hours
--				min <= 0;
--			end if;
--		end if;
	end if;

	end process;

end Behavioral;