library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity digi_clk is
port (clk1, rst : in std_logic;
		freq : in std_logic_vector (2 downto 0);
		minstd : out std_logic_vector(15 downto 0)
     );
end digi_clk;

architecture Behavioral of digi_clk is

signal sec : integer range 0 to 60 :=0;
signal count : integer :=1;
signal clk : std_logic :='0';

signal freqSec : integer :=50000000;

begin
	
	process(freq)
	begin
	-- 111 => 5, 110 => 14, 100 => 29 else 59=>
		if freq = "000" then
			freqSec <= 33750; --1600sec/1sec; 33750
		elsif freq = "100" then
			freqSec <= 67500; --800sec/1sec; 67500
		elsif freq = "110" then
			freqSec <= 125000; --400sec/1sec; 125000
		else
			freqSec <= 50000000; --1sec/1sec;50000000
		end if;
	end process;  
	 
	process(clk1)
	begin
		if(clk1'event and clk1='1') then
			count <=count+1;
			if(count >= freqSec) then
			--if(count = 2) then --for test
				clk <= not clk;
				count <=1;
			end if;
		end if;
	end process;


	process(rst, clk)   --period of clk is 1 second.
	
	type timee is array(0 to 3) of integer;
	variable zetime: timee:=(0,0,0,0);
	
	begin
	if rst = '1' then
		sec <= 0;
		zetime := (0,0,0,0);
	else
		if(clk'event and clk='1') then
			sec <= sec+ 1;
			if(sec = 59) then
				sec <= 0;
				zetime(0):= zetime(0)+1;
				if(zetime(0) = 10) then
					zetime(0):=0;
					zetime(1):= zetime(1)+1;
					if(zetime(1) = 6) then
						zetime(1):=0;
						zetime(2):= zetime(2)+1;
						if(zetime(2) = 10) then
							zetime(2):=0;
							zetime(3):= zetime(3)+1;
						elsif(zetime(3) = 2 and zetime(2) = 4) then
								zetime(3):=0;zetime(2):=0;
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;

	minstd <= conv_std_logic_vector(zetime(3), 4) & conv_std_logic_vector(zetime(2), 4) & conv_std_logic_vector(zetime(1), 4) & conv_std_logic_vector(zetime(0), 4);
	
	end process;


end Behavioral;