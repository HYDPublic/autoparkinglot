----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:59:25 05/31/2016 
-- Design Name: 
-- Module Name:    top_module - Behavioral 
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

entity top_module is
    Port ( clk: in  STD_LOGIC;
			  --for keypad
           key_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           key_in : in  STD_LOGIC_VECTOR (3 downto 0);
			  --for led
           led_out : out  STD_LOGIC_VECTOR (23 downto 0);
			  --for segment
           dig : out  STD_LOGIC_VECTOR (5 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0);
			  --for push_button
           push_button : in  STD_LOGIC_VECTOR (3 downto 0);
			  --for dip_switch
           dip_switch : in  STD_LOGIC_VECTOR (7 downto 0);
			  --for display
			  RSTB : in  STD_LOGIC;
           de : out  STD_LOGIC;
           lcd_clk : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end top_module;

architecture Behavioral of top_module is
--component
	component ledcontroller is
		 Port ( parkinglot : in  STD_LOGIC_VECTOR (23 downto 0);
				  curr_address : in STD_LOGIC_VECTOR (4 downto 0);
				  rst, ena, clk, status : in  STD_LOGIC;      
				  led_out : out  STD_LOGIC_VECTOR (23 downto 0));	
	end component;
	
	component gate_controller is
	    Port ( clk, rst : in  STD_LOGIC;
           digit : out  STD_LOGIC_VECTOR (5 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0);
           key_data : in  STD_LOGIC_VECTOR (3 downto 0);
           key_event : in  STD_LOGIC;
           ac_add : out  STD_LOGIC;
           ac_rmv : out  STD_LOGIC;
           car_num : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component keypad_controller is
		port( reset : in STD_LOGIC;
				clk : in STD_LOGIC;
				key_in : in STD_LOGIC_VECTOR (3 downto 0);
					
				key_scan : out STD_LOGIC_VECTOR (3 downto 0);
				key_data : out STD_LOGIC_VECTOR (3 downto 0);
				key_event : out STD_LOGIC
				);
	end component;
	
	component lcd_25m_clk is
		port( clk, rst : in std_logic;
				dclk : out std_logic);
	end component;

	component seg_clk_divider is
		 Port ( clk, rst : in  STD_LOGIC;
				  new_clk : out  STD_LOGIC
				 );
	end component;
---lcd component---
	component TFT_LCD_image is
      port(CLK : in  STD_LOGIC;
           RSTB : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
			  current_time : in STD_LOGIC_VECTOR (15 downto 0);
			  info_car : in STD_LOGIC_VECTOR (31 downto 0);
           data_addr : out  STD_LOGIC_VECTOR (13 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           de : out  STD_LOGIC
      );
   end component;
   
	component digi_clk is
		port (clk1, rst : in std_logic;
   			freq : in std_logic_vector (2 downto 0);
		   	minstd : out std_logic_vector(15 downto 0));
	end component;
	
	component NumsRom is
      port (
      clka: in std_logic;
      addra: in std_logic_vector(13 downto 0);
      douta: out std_logic_vector(7 downto 0));
   end component;
	
--end component

--signals
	signal rst_inv : STD_LOGIC;
	signal status : STD_LOGIC;
	signal parkinglot : STD_LOGIC_VECTOR (23 downto 0);
	signal curr_address : STD_LOGIC_VECTOR (4 downto 0);
	signal freq : STD_LOGIC_VECTOR (2 downto 0);
	signal minutes : STD_LOGIC_VECTOR (15 downto 0);
	signal ac_add, ac_rmv, ac_show : STD_LOGIC;
	signal car_num : STD_LOGIC_VECTOR (15 downto 0);
	signal car_data_out : STD_LOGIC_VECTOR (31 downto 0);
	signal key_pad_out : STD_LOGIC_VECTOR (3 downto 0);
	signal key_event : STD_LOGIC;
	signal key_pad_clk : STD_LOGIC;
	
	--lcd-------------

   signal clk_25m : std_logic;
	
   signal imagedata : std_logic_vector (7 downto 0);
   signal data_addr : std_logic_vector(13 downto 0);
   signal lcd_den : std_logic;
	--end lcd-----------	
--end signals

begin

	status <= dip_switch(0);
	freq <= dip_switch(7 downto 5);
	
	
	led_ctrl : ledcontroller port map(parkinglot => parkinglot, curr_address => curr_address, rst => rst_inv, ena => '1', clk => clk, status => status, led_out => led_out);

	gate_ctrl : gate_controller port map(clk => clk, 
													 rst => rst_inv, 
													 digit => dig, 
													 segment => segment, 
													 key_data => key_pad_out,
													 key_event => key_event,
													 ac_add => ac_add, 
													 ac_rmv => ac_rmv, 
													 car_num => car_num);

	keypad_cntrller : keypad_controller port map(reset=>rst_inv,
																clk=>key_pad_clk,
																key_in=>key_in,
																key_scan=>key_scan,
																key_data=>key_pad_out,
																key_event=>key_event);
																  
	key_clk_dvd : seg_clk_divider port map(clk => clk, rst => rst_inv,
														new_clk =>  key_pad_clk );
													 
	---lcd----------------
	u_lcd_clk : lcd_25m_clk port map(clk=>clk, 
											 rst=>rst_inv,
											 dclk=>clk_25m);
	
	dig_clk : digi_clk port map(clk1=>clk, rst => rst_inv,
										 freq => freq, 
										 minstd => minutes);
		
		
   u_image_rom : NumsRom port map(clka => clk_25m,
											  addra => data_addr,
											  douta => imagedata);
										  
	u_tft_lcd : TFT_LCD_image port map(CLK =>clk_25m,
												  current_time => minutes,
												  info_car => "00010001000001110010000010000100",
												  RSTB => RSTB,
												  data_in => imagedata,
												  data_addr => data_addr,
												  data_out=>data_out,
												  de=>lcd_den);

   de<=lcd_den;
   lcd_clk<=clk_25m;										 							 
	rst_inv <= not RSTB;									 
end Behavioral;

