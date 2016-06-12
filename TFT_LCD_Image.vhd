----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:45 05/19/2016 
-- Design Name: 
-- Module Name:    TFT_LCD_Image - Behavioral 
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
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_arith.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TFT_LCD_Image is
    Port ( CLK : in  STD_LOGIC;
           RSTB : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
			  current_time : in  STD_LOGIC_VECTOR (15 downto 0);
			  
			  --inputData
			  info_car : in  STD_LOGIC_VECTOR (31 downto 0);
			  
           data_addr : out  STD_LOGIC_VECTOR (13 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           de : out  STD_LOGIC);
end TFT_LCD_Image;


architecture Behavioral of TFT_LCD_Image is

constant tHP  : integer := 1056;   -- Hsync Period
constant tHW  : integer := 1;   -- Hsync Pulse Width
constant tHBP : integer := 45;   -- Hsync Back Porch
constant tHV  : integer := 800;   -- Horizontal valid data width
constant tHFP : integer := (tHP-tHW-tHBP-tHV);   -- Horizontal Front Port
constant tVP  : integer := 635;   -- Vsync Period
constant tVW  : integer := 1;   -- Vsync Pulse Width
constant tVBP : integer := 22;   -- Vsync Back Portch
constant tW   : integer := 480;   -- Vertical valid data width
constant tVFP : integer := (tVP-tVW-tVBP-tW);   -- Vertical Front Porch

signal hsync_cnt  : std_logic_vector( 11 downto 0 );
signal vsync_cnt  : std_logic_vector( 10 downto 0 );
signal de_i: std_logic;

signal addrcnt : std_logic_vector(13 downto 0);

signal rgb_data : std_logic_vector(15 downto 0);
signal r_data : std_logic_vector(4 downto 0);
signal g_data : std_logic_vector(5 downto 0);
signal b_data : std_logic_vector(4 downto 0);

constant timePosX  : integer := 700;  
constant timePosY  : integer := 50;

constant infoPosX  : integer := 400;  
constant infoPosY  : integer := 200;  

constant feePosX  : integer := 400;  
constant feePosY  : integer := 300;  

signal min_thous : integer := 0;
signal min_hund : integer := 0;
signal min_ten : integer := 0;
signal min_one : integer := 0;

signal car_num_first : integer := 0;
signal car_num_second : integer := 0;
signal car_num_third : integer := 0;
signal car_num_fourth : integer := 0;

signal car_time_first : integer := 0;
signal car_time_second : integer := 0;
signal car_time_third : integer := 0;
signal car_time_fourth : integer := 0;

begin
   
	min_thous <= to_integer(unsigned(current_time(15 downto 12)));
	min_hund <= to_integer(unsigned(current_time(11 downto 8)));
	min_ten <= to_integer(unsigned(current_time(7 downto 4)));
	min_one <= to_integer(unsigned(current_time(3 downto 0)));
	
	car_num_first <= to_integer(unsigned(info_car(31 downto 28)));
	car_num_second <= to_integer(unsigned(info_car(27 downto 24)));
	car_num_third <= to_integer(unsigned(info_car(23 downto 20)));
	car_num_fourth <= to_integer(unsigned(info_car(19 downto 16)));	
	
	car_time_first <= to_integer(unsigned(info_car(15 downto 12)));
	car_time_second <= to_integer(unsigned(info_car(11 downto 8)));
	car_time_third <= to_integer(unsigned(info_car(7 downto 4)));
	car_time_fourth <= to_integer(unsigned(info_car(3 downto 0)));	
	
   process(CLK, RSTB)         --  sync 계산
   begin
      if(RSTB = '0')then
         hsync_cnt<= (others=>'0');
         vsync_cnt<= (others=>'0');
      elsif(rising_edge(CLK)) then
         if(hsync_cnt=tHP)then
            hsync_cnt<= (others=>'0');
         else
            hsync_cnt<= hsync_cnt + '1';
         end if;
         if(hsync_cnt=tHP)then
            if(vsync_cnt=tVP)then
               vsync_cnt<= (others=>'0');
            else
               vsync_cnt<= vsync_cnt + '1';
            end if;
         end if;
      end if;
   end process;
	
	process(CLK, RSTB,vsync_cnt,hsync_cnt)         --Data Enable
   begin
      if(RSTB = '0')then
         de_i<='0';
      elsif(rising_edge(CLK)) then
         if ((vsync_cnt >= (tVW + tVBP)) and (vsync_cnt <= (tVW + tVBP + tW ))) then
            if(hsync_cnt=(tHBP)) then
               de_i<='1';
            elsif(hsync_cnt=(tHV+tHBP)) then
               de_i<='0';
            else
               de_i<=de_i;
            end if;
         else
            de_i<='0';
         end if;
      end if;
    end process; 

	process(CLK, RSTB, vsync_cnt, hsync_cnt, data_in)
	begin
		if(RSTB ='0') then
			addrcnt <= (others =>'0');
			rgb_data <= (others =>'0');
		elsif (rising_edge(CLK)) then
				
			if (vsync_cnt = 0) then
				addrcnt <= (others =>'0');
			
			--time
			elsif ( (vsync_cnt >= (timePosY )) and (vsync_cnt < (timePosY + 40 )) ) then
				if ( (hsync_cnt >= (timePosX )) and (hsync_cnt <= (timePosX + 113 )) ) then
						
					if ( (hsync_cnt >= (timePosX)) and (hsync_cnt < (timePosX + 28 )) ) then
						--
						if(hsync_cnt = timePosX) then
							addrcnt <=	conv_std_logic_vector((min_thous * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - timePosY )), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
						
					elsif( (hsync_cnt >= (timePosX + 28)) and (hsync_cnt < (timePosX + 56 )) ) then	
						if(hsync_cnt = timePosX + 28) then
							addrcnt <=	conv_std_logic_vector((min_hund * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - timePosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
						
					elsif( (hsync_cnt >= (timePosX + 56)) and (hsync_cnt < (timePosX + 84 )) ) then	
						if(hsync_cnt = timePosX + 56) then
							addrcnt <=	conv_std_logic_vector((min_ten * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - timePosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
					
					elsif( (hsync_cnt >= (timePosX + 84)) and (hsync_cnt <= (timePosX + 113 )) ) then	
						if(hsync_cnt = timePosX + 84) then
							addrcnt <=	conv_std_logic_vector((min_one * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - timePosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
					end if;
											
				b_data <= data_in(7)&data_in(6)&data_in(5)&'0'&'0';
				g_data <= data_in(4)&data_in(3)&data_in(2)&'0'&'0'&'0';
				r_data <= data_in(1)&data_in(0)&'0'&'0'&'0';
				
				rgb_data <= b_data & g_data & r_data;
					
				else 	rgb_data <= "0010001100011000";-- 2b : 0010 1011 --테두리색 ->0010001000011000 2f : 0010 1111 -- 바탕색 ->0010001100011000
				end if;--end time
			--info
			elsif ( (vsync_cnt >= (infoPosY )) and (vsync_cnt < (infoPosY + 40 )) ) then			
				if ( (hsync_cnt >= (infoPosX )) and (hsync_cnt <= (infoPosX + 113 )) ) then
						
					if ( (hsync_cnt >= (infoPosX )) and (hsync_cnt < (infoPosX + 28 )) ) then
					--
						if(hsync_cnt = infoPosX) then
							addrcnt <=	conv_std_logic_vector((car_num_first * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - infoPosY )), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
						
					elsif( (hsync_cnt >= (infoPosX + 28)) and (hsync_cnt < (infoPosX + 56 )) ) then	
						if(hsync_cnt = infoPosX + 28) then
							addrcnt <=	conv_std_logic_vector((car_num_second * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - infoPosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
						
					elsif( (hsync_cnt >= (infoPosX + 56)) and (hsync_cnt < (infoPosX + 84 )) ) then	
						if(hsync_cnt = infoPosX + 56) then
							addrcnt <=	conv_std_logic_vector((car_num_third * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - infoPosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
					
					elsif( (hsync_cnt >= (infoPosX + 84)) and (hsync_cnt <= (infoPosX + 113 )) ) then	
						if(hsync_cnt = infoPosX + 84) then
							addrcnt <=	conv_std_logic_vector((car_num_fourth * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - infoPosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
					end if;
							
					b_data <= data_in(7)&data_in(6)&data_in(5)&'0'&'0';
					g_data <= data_in(4)&data_in(3)&data_in(2)&'0'&'0'&'0';
					r_data <= data_in(1)&data_in(0)&'0'&'0'&'0';
					
					rgb_data <= b_data & g_data & r_data;
					
				else 	rgb_data <= "0010001100011000";-- 2b : 0010 1011 --테두리색 ->0010001000011000 2f : 0010 1111 -- 바탕색 ->0010001100011000
				end if;--end info
				
			--fee
			elsif ( (vsync_cnt >= (feePosY )) and (vsync_cnt < (feePosY + 40 )) ) then			
				if ( (hsync_cnt >= (feePosX )) and (hsync_cnt <= (feePosX + 113 )) ) then
						
					if ( (hsync_cnt >= (feePosX )) and (hsync_cnt < (feePosX + 28 )) ) then
					--
						if(hsync_cnt = feePosX) then
							addrcnt <=	conv_std_logic_vector((car_time_first * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - feePosY )), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
						
					elsif( (hsync_cnt >= (infoPosX + 28)) and (hsync_cnt < (feePosX + 56 )) ) then	
						if(hsync_cnt = feePosX + 28) then
							addrcnt <=	conv_std_logic_vector((car_time_second * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - feePosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
						
					elsif( (hsync_cnt >= (infoPosX + 56)) and (hsync_cnt < (feePosX + 84 )) ) then	
						if(hsync_cnt = feePosX + 56) then
							addrcnt <=	conv_std_logic_vector((car_time_third * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - feePosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
					
					elsif( (hsync_cnt >= (infoPosX + 84)) and (hsync_cnt <= (feePosX + 113 )) ) then	
						if(hsync_cnt = feePosX + 84) then
							addrcnt <=	conv_std_logic_vector((car_time_fourth * 28 + 1 + 280*(to_integer(unsigned(vsync_cnt)) - feePosY)), 14);
						else 
							addrcnt <= addrcnt + '1';
						end if;
					end if;
							
					b_data <= data_in(7)&data_in(6)&data_in(5)&'0'&'0';
					g_data <= data_in(4)&data_in(3)&data_in(2)&'0'&'0'&'0';
					r_data <= data_in(1)&data_in(0)&'0'&'0'&'0';
					
					rgb_data <= b_data & g_data & r_data;
					
				else 	rgb_data <= "0010001100011000";-- 2b : 0010 1011 --테두리색 ->0010001000011000 2f : 0010 1111 -- 바탕색 ->0010001100011000
				end if;--end fee
				
			else--other display
				rgb_data <= "0010001100011000";-- 2b : 0010 1011 --테두리색 ->0010001000011000 2f : 0010 1111 -- 바탕색 ->0010001100011000
			end if;
		else
		end if;
	end process;
	
	data_addr <= addrcnt;
	data_out <= rgb_data;
	de <= de_i;
	
end Behavioral;